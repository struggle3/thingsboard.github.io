清除消息发起者的现有活动告警。

## 配置

- **Alarm type（告警类型）**：要清除的告警类型（如「General Alarm」、「High Temperature」）。支持模板化。
- **Alarm details script（告警详情脚本）**：清除时生成告警 `details` 字段内容的脚本（TBEL 或 JavaScript）。脚本必须返回有效的 JSON 值，可以是：
    - 原始值（数字、布尔、字符串）
    - JSON 数组
    - JSON 对象

  脚本可访问以下变量：
    - `msg`：消息数据
    - `metadata`：消息元数据
    - `msgType`：消息类型
    - `metadata.prevAlarmDetails`：现有告警的先前详情（以 JSON 字符串提供）

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbClearAlarmNodeConfiguration",
  "type": "object",
  "properties": {
    "alarmType": {
      "type": "string",
      "description": "Alarm type"
    },
    "scriptLang": {
      "type": "string",
      "enum": [
        "TBEL",
        "JS"
      ],
      "description": "Script language for details builder"
    },
    "alarmDetailsBuildJs": {
      "type": "string",
      "description": "JavaScript details builder function"
    },
    "alarmDetailsBuildTbel": {
      "type": "string",
      "description": "TBEL details builder function"
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **确定告警类型**：处理配置的告警类型模式，用消息中的值替换占位符。

2. **搜索要清除的告警**：
    - **若消息发起者为 `ALARM`**：按其 ID 获取该告警
    - **否则**：查询满足以下条件的最新活动告警：
        - 与传入消息发起者相同
        - 告警类型与步骤 1 一致

3. **清除告警**：
    - **若告警存在且未清除**：
        - 将告警状态更改为已清除
        - 将清除时间设置为当前系统时间
        - 通过 `metadata.prevAlarmDetails` 访问先前告警详情并执行详情构建脚本
        - 用脚本结果更新 `details` 字段
        - 将 `isClearedAlarm: true` 放入元数据并路由至 `Cleared` 连接
        - 用已清除的告警对象替换消息数据
        - 将消息类型更改为 `ALARM`
        - 向发起者的根 Rule Chain 发送包含完整告警对象的 `ALARM_CLEAR` 生命周期事件

    - **若不存在活动告警或告警已清除**：
        - 将原始消息原样路由至 `False` 连接
        - 不进行任何告警修改

## 输出连接

- `Cleared`
    - 告警已成功清除
    - 消息数据替换为已清除的告警对象
    - 元数据包含 `isClearedAlarm: true`
    - 消息类型更改为 `ALARM`
- `False`
    - 未找到指定类型和发起者的活动告警
    - 告警已处于已清除状态

## 示例

### 示例 1 — 清除活动告警

**传入消息**

数据：

```json
{
  "temperature": 25.0
}
```

发起者：`DEVICE`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "alarmDetailsBuildTbel": "return {\n    clearedAt: msg.temperature\n};",
  "alarmType": "High Temperature"
}
```

**系统状态**

发起者设备存在活动「High Temperature」告警：

- 状态：`ACTIVE_UNACK`
- 详情：`{"temperature": 47.2}`
- 开始时间：1757429087063
- 结束时间：1757429195123

**传出消息**

数据：

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "f66e9b38-6f0e-4dc7-ad57-1cb4e014b6fc"
  },
  "createdTime": 1757429087089,
  "tenantId": {
    "entityType": "TENANT",
    "id": "9c4bad70-10ac-11f0-ad7c-897c5310f06b"
  },
  "customerId": null,
  "type": "High Temperature",
  "originator": {
    "entityType": "DEVICE",
    "id": "3bc2eb60-8d77-11f0-8a6c-59050cd4204f"
  },
  "severity": "CRITICAL",
  "acknowledged": false,
  "cleared": true,
  "assigneeId": null,
  "startTs": 1757429087063,
  "endTs": 1757429195123,
  "ackTs": 0,
  "clearTs": 1757429287456,
  "assignTs": 0,
  "propagate": false,
  "propagateToOwner": false,
  "propagateToTenant": false,
  "propagateRelationTypes": [],
  "originatorName": "device",
  "originatorLabel": "device",
  "assignee": null,
  "name": "High Temperature",
  "status": "CLEARED_UNACK",
  "details": {
    "clearedAt": 25.0
  }
}
```

元数据：

```json
{
  "isClearedAlarm": "true"
}
```

经 `Cleared` 连接路由。

**结果**

发生以下操作：

- **告警已清除**：活动「High Temperature」告警状态从 `ACTIVE_UNACK` 变为 `CLEARED_UNACK`。
- **清除时间戳已设置**：告警的 `clearTs` 设置为当前系统时间（1757429287456）。
- **详情已更新**：详情构建脚本通过 `metadata.prevAlarmDetails` 访问先前详情。添加 `clearedAt` 字段，结果为 `{"clearedAt": 25.0}`。
- **消息已转换**：原始遥测消息替换为包含已清除告警对象的 `ALARM` 消息。消息经 `Cleared` 连接路由，元数据标志为 `isClearedAlarm: true`。
- **已触发生命周期事件**：已清除告警的 `ALARM_CLEAR` 生命周期事件自动发送至设备的根 Rule Chain。

### 示例 2 — 无活动告警可清除

**传入消息**

发起者：`DEVICE`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "alarmDetailsBuildTbel": "return {};",
  "alarmType": "High Temperature"
}
```

**系统状态**

发起者设备不存在活动「High Temperature」告警（从未创建过告警或现有告警已清除）。

**传出消息**

传出消息与传入消息相同。经 `False` 连接路由。

**结果**

发生以下操作：

- **无告警修改**：由于不存在活动告警，不进行任何数据库更改。
- **保留原始消息**：传入遥测消息原样通过 `False` 连接传递。
- **无生命周期事件**：不触发任何告警生命周期事件。

### 示例 3 — 按告警 ID 清除告警

**传入消息**

发起者：ID 为 `f66e9b38-6f0e-4dc7-ad57-1cb4e014b6fc` 的 `ALARM`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "alarmDetailsBuildJs": "return {};",
  "alarmType": "High Temperature"
}
```

**系统状态**

ID 为 `f66e9b38-6f0e-4dc7-ad57-1cb4e014b6fc` 的告警存在，状态为 `ACTIVE_ACK`。

**传出消息**

按 ID 获取告警对象并清除，消息经 `Cleared` 连接路由，包含更新后的告警（`status: "CLEARED_ACK"`）。

**结果**

当消息发起者为告警实体时，节点直接按 ID 获取并清除该告警，与配置的告警类型无关。
