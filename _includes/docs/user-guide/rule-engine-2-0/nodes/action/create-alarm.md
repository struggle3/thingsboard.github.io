创建新告警或更新现有活动告警。

## 配置

### 基本设置

- **Use message alarm data（使用消息告警数据）**：启用时，将消息数据解析为 ThingsBoard Alarm 对象，并从解析后的消息中提取告警配置而非使用节点配置。若消息无法解析为有效 Alarm 对象，消息经 `Failure` 连接路由。
- **Overwrite alarm details（覆盖告警详情）**：与 **Use message alarm data** 同时启用时，将执行详情脚本以生成告警 `details` 字段的值。

### 告警配置

- **Alarm type（告警类型）**：告警类型（如「General Alarm」、「High Temperature」）。支持模板化。
- **Use alarm severity pattern（使用告警严重性模式）**：基于消息数据启用动态严重性，而非固定值。
    - **启用** 时：
        - **Alarm severity pattern（告警严重性模式）**：必须解析为以下有效严重性之一的模式：`CRITICAL`、`MAJOR`、`MINOR`、`WARNING` 或 `INDETERMINATE`
    - **禁用** 时：
        - **Alarm severity（告警严重性）**：固定严重性等级。可选：*Critical*、*Major*、*Minor*、*Warning* 或 *Indeterminate*

### 告警详情脚本

用于生成告警 `details` 字段内容的脚本（TBEL 或 JavaScript）。脚本必须返回有效的 JSON 值，可以是：

- 原始值（数字、布尔、字符串）
- JSON 数组
- JSON 对象

脚本可访问以下变量：

- `msg`：消息数据
- `metadata`：消息元数据
- `msgType`：消息类型
- `metadata.prevAlarmDetails`：更新现有告警时的先前告警详情（以 JSON 字符串提供）

### 传播设置

- **Propagate alarm to related entities（向相关实体传播告警）**：通过配置的关系向父实体传播告警
    - 启用后会出现 **Relation types to propagate（要传播的关系类型）** 字段
    - 选择特定关系类型以限制传播路径，或留空以通过所有关系传播
- **Propagate alarm to entity owner (Customer or Tenant)（向实体所有者传播告警）**：向实体的直接所有者传播告警
- **Propagate alarm to entity owners hierarchy（向实体所有者层级传播告警）**：沿所有权链的所有层级向上传播告警
- **Propagate alarm to Tenant（向租户传播告警）**：直接向租户级别传播告警，不考虑中间所有权

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbCreateAlarmNodeConfiguration",
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
    },
    "severity": {
      "type": "string",
      "enum": [
        "CRITICAL",
        "MAJOR",
        "MINOR",
        "WARNING",
        "INDETERMINATE"
      ]
    },
    "propagate": {
      "type": "boolean",
      "description": "Whether to propagate to related entities"
    },
    "propagateToOwner": {
      "type": "boolean",
      "description": "Whether to propagate to entity owner"
    },
    "propagateToOwnerHierarchy": {
      "type": "boolean",
      "description": "Whether to propagate to owner hierarchy"
    },
    "propagateToTenant": {
      "type": "boolean",
      "description": "Whether to propagate to tenant"
    },
    "useMessageAlarmData": {
      "type": "boolean",
      "description": "Read alarm config from message"
    },
    "overwriteAlarmDetails": {
      "type": "boolean",
      "description": "Whether to execute details builder when using message data"
    },
    "dynamicSeverity": {
      "type": "boolean",
      "description": "Whether to use severity pattern"
    },
    "relationTypes": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Relation types for propagation"
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

节点行为取决于 **Use message alarm data** 设置：

### 使用节点配置时（Use message alarm data = 禁用）

1. **确定告警类型**：处理配置的告警类型模式，用消息中的值替换占位符。

2. **搜索现有告警**：查询满足以下条件的活动（未清除）告警：
    - 与传入消息发起者相同
    - 告警类型与步骤 1 一致

3. **创建或更新告警**：
    - **若不存在活动告警**（新告警）：
        - 创建状态为 `ACTIVE_UNACK` 的告警
        - 从节点配置设置严重性（或启用 **Use alarm severity pattern** 时从模式设置）
        - 应用节点配置中的传播设置
        - 执行详情构建脚本生成 `details` 字段
        - 将告警开始时间和结束时间均设为元数据中 `ts` 属性的值。若 `ts` 不存在，则设为消息创建时间戳。
        - 将 `isNewAlarm: true` 放入元数据并路由至 `Created` 连接
        - 向发起者的根 Rule Chain 发送包含完整告警对象的 `ENTITY_CREATED` 生命周期事件

    - **若存在活动告警**（更新）：
        - 保持现有告警状态不变
        - 从节点配置设置严重性（或启用 **Use alarm severity pattern** 时从模式设置）
        - 用节点配置中的值更新现有传播设置
        - 执行详情构建脚本生成 `details` 字段的值
        - 将告警结束时间更新为当前服务器时间
        - 将 `isExistingAlarm: true` 放入元数据并路由至 `Updated` 连接
        - 向发起者的根 Rule Chain 发送包含完整告警对象的 `ENTITY_UPDATED` 生命周期事件

### 使用消息告警数据时（Use message alarm data = 启用）

1. **将消息解析为告警**：尝试将消息数据反序列化为 ThingsBoard Alarm 对象
    - 若解析失败，路由至 `Failure` 连接
    - 用当前租户 ID 覆盖解析后告警中的 `tenantId`
    - 若解析后告警中 `originator` 为 null，默认使用消息发起者

2. **提取告警类型**：使用解析后告警的 `type` 字段

3. **搜索现有告警**：同上，使用解析后的告警类型

4. **创建或更新告警**：
    - **若不存在活动告警**（新告警）：
        - 使用解析后告警的所有字段（严重性、传播设置等）
        - 详情处理取决于 **Overwrite alarm details**：
            - 启用：执行详情构建脚本，替换解析后的详情
            - 禁用：直接使用解析后告警的 `details` 字段
        - 路由至 `Created` 连接
        - 向发起者的根 Rule Chain 发送包含完整告警对象的 `ENTITY_CREATED` 生命周期事件

    - **若存在活动告警**（更新）：
        - 用解析后消息中的值更新现有告警：
            - `severity`
            - `propagate`
            - `propagateToOwner`
            - `propagateToOwnerHierarchy`
            - `propagateToTenant`
            - `propagateRelationTypes`
        - 详情处理取决于 **Overwrite alarm details**：
            - 启用：使用 `prevAlarmDetails` 执行详情构建脚本
            - 禁用：用解析后告警的 `details` 替换
        - 将告警结束时间更新为当前服务器时间
        - 路由至 `Updated` 连接
        - 向发起者的根 Rule Chain 发送包含完整告警对象的 `ENTITY_UPDATED` 生命周期事件

## 输出连接

- `Created`
    - 新告警已成功创建
    - 消息数据替换为已创建的告警对象
    - 元数据包含 `isNewAlarm: true`
    - 消息类型更改为 `ALARM`
- `Updated`
    - 现有告警已成功更新
    - 消息数据替换为已更新的告警对象
    - 元数据包含 `isExistingAlarm: true`
    - 消息类型更改为 `ALARM`
- `Failure`
    - 告警严重性模式解析为无效值
    - 脚本执行错误
    - 消息解析错误（使用消息告警数据时）

## 示例

### 示例 1 — 创建新告警

**传入消息**

类型：`POST_TELEMETRY_REQUEST`

数据：

```json
{
  "temperature": 45.5
}
```

元数据：

```json
{}
```

发起者：`DEVICE`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "alarmDetailsBuildTbel": "return {\n    temperature: msg.temperature\n};",
  "alarmType": "High Temperature",
  "severity": "CRITICAL"
}
```

**系统状态**

发起者设备不存在活动「High Temperature」告警。

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
  "cleared": false,
  "assigneeId": null,
  "startTs": 1757429087063,
  "endTs": 1757429087063,
  "ackTs": 0,
  "clearTs": 0,
  "assignTs": 0,
  "propagate": false,
  "propagateToOwner": false,
  "propagateToTenant": false,
  "propagateRelationTypes": [],
  "originatorName": "device",
  "originatorLabel": "device",
  "assignee": null,
  "name": "High Temperature",
  "status": "ACTIVE_UNACK",
  "details": {
    "temperature": 45.5
  }
}
```

元数据：

```json
{
  "isNewAlarm": "true"
}
```

经 `Created` 连接路由。

**结果**

发生以下操作：

- 新告警已创建：为设备在数据库中创建了严重性为 CRITICAL 的「High Temperature」告警。
- 详情已生成：详情构建脚本执行并将 `{"temperature": 45.5}` 存入告警的 `details` 字段。
- 消息已转换：原始遥测消息替换为包含完整告警对象的 `ALARM` 消息。消息经 `Created` 连接路由，元数据标志为 `isNewAlarm: true`。
- 已触发生命周期事件：新告警的 `ENTITY_CREATED` 生命周期事件自动发送至设备的根 Rule Chain。

### 示例 2 — 更新现有告警

**传入消息**

类型：`POST_TELEMETRY_REQUEST`

数据：

```json
{
  "temperature": 47.2
}
```

元数据：

```json
{}
```

发起者：`DEVICE`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "alarmDetailsBuildTbel": "return {\n    temperature: msg.temperature\n};",
  "alarmType": "High Temperature",
  "severity": "CRITICAL"
}
```

**系统状态**

发起者设备存在活动「High Temperature」告警：

- 状态：`ACTIVE_UNACK`
- 详情：`{"temperature": 45.5}`
- 开始时间：1757429087063
- 结束时间：1757429087063

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
  "cleared": false,
  "assigneeId": null,
  "startTs": 1757429087063,
  "endTs": 1757429195123,
  "ackTs": 0,
  "clearTs": 0,
  "assignTs": 0,
  "propagate": false,
  "propagateToOwner": false,
  "propagateToTenant": false,
  "propagateRelationTypes": [],
  "originatorName": "device",
  "originatorLabel": "device",
  "assignee": null,
  "name": "High Temperature",
  "status": "ACTIVE_UNACK",
  "details": {
    "temperature": 47.2
  }
}
```

元数据：

```json
{
  "isExistingAlarm": "true"
}
```

经 `Updated` 连接路由。

**结果**

发生以下操作：

- **现有告警已更新**：数据库中的活动「High Temperature」告警已更新。告警状态保持 `ACTIVE_UNACK`（未变）。
- **详情已重新生成**：详情构建脚本通过 `metadata.prevAlarmDetails` 访问先前详情后执行。更新温度读数，结果为 `{"temperature": 47.2}`。
- **结束时间已更新**：告警的 `endTs` 更新为当前系统时间（1757429195123），时间戳保持原始创建时间。
- **消息已转换**：原始遥测消息替换为包含已更新告警对象的 `ALARM` 消息。消息经 `Updated` 连接路由，元数据标志为 `isExistingAlarm: true`。
- **已触发生命周期事件**：已更新告警的 `ENTITY_UPDATED` 生命周期事件自动发送至设备的根 Rule Chain。
