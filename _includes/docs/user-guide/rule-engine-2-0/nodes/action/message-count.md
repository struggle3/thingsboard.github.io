在指定时间间隔内对传入消息进行计数，并输出包含计数结果的消息。

## 配置

### 计数参数

- **Interval in seconds（间隔秒数）**：计数消息的时间间隔（秒）。节点在每个间隔输出消息计数并重置计数器。
- **Output time series key prefix（输出时序 key 前缀）**：用于创建输出消息中保存计数结果的属性名称的前缀。属性名称格式为 `{prefix}_{serviceId}`，其中 serviceId 是 ThingsBoard 服务实例的唯一标识符（如「tb-rule-engine1」）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgCountNodeConfiguration",
  "type": "object",
  "properties": {
    "interval": {
      "type": "integer",
      "description": "Time interval in seconds for counting messages"
    },
    "telemetryPrefix": {
      "type": "string",
      "description": "Prefix for the output telemetry key"
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **初始化计数器**：节点初始化时，创建设为 0 的计数器，并根据配置的间隔调度首次 tick 消息。
2. **处理传入消息**：
    - **常规消息**：将消息计数器加 1 并确认消息
    - **Tick 消息**：处理累积计数并生成遥测输出
3. **生成遥测输出**（tick 时）：
    - 将当前消息计数放入消息数据的 `{telemetryPrefix}_{serviceId}` 键下
    - 将消息计数器重置为 0 以准备下一间隔
    - 添加包含自上次调度 tick 以来实际时间差的 `delta` 元数据
    - 创建发起者为租户的 `POST_TELEMETRY_REQUEST` 消息
4. **调度下一 tick**：
    - 计算下一 tick 时间戳以保持间隔一致
    - 使用适当延迟调度下一内部 tick 消息

## 输出连接

- `Success`
    - 包含间隔内消息计数的生成结果消息

## 示例

### 示例 1 — 基本消息计数

**5 秒内的传入消息**

- t = 0s 时的消息 1
- t = 1s 时的消息 2
- t = 3s 时的消息 3

**节点配置**

```json
{
  "interval": 5,
  "telemetryPrefix": "msgCount"
}
```

**系统状态**

当前服务 ID 为 `tb-rule-engine1`。

**t = 5s 时的传出消息**

类型：`POST_TELEMETRY_REQUEST`

发起者：当前租户

数据：

```json
{
  "msgCount_tb-rule-engine1": 3
}
```

元数据：

```json
{
  "delta": "5000"
}
```

**结果**

5 秒后生成结果消息，显示该间隔内处理了 3 条消息。计数器重置为 0 以准备下一间隔。
