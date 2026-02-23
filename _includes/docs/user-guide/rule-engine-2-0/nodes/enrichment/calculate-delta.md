计算入站消息中当前值与来自同一来源的上一值之间的差值，以及两者之间经过的时间。

## 配置

节点配置允许定义用于计算的键、结果的存储位置以及如何处理特定条件（如仪表复位）。

- **Input value key** — 入站消息 data 中包含累计值的键（如 `fuelLevel`）。值必须为数字或可解析为数字的字符串。
- **Output value key** — 计算得到的差值将以此键添加到消息 data（如 `consumption`）。
- **Number of digits after floating point** — 整数，指定将计算得到的差值四舍五入到的小数位数。未指定时不进行四舍五入。
- **Tell Failure if delta is negative** — 若启用，任何产生负差值的消息将经 `Failure` 连接路由。
- **Use caching** — 若启用，节点在内存中保留每个来源实体的最后已知值。通过避免数据库查询提升性能。若不勾选，节点从数据库获取每条消息的最后存储时序值。**注意**：缓存仅对此规则节点本地有效，节点重启后会清除。
- **Add the time difference between readings** — 若启用，节点还将计算来源实体当前消息与上一条消息之间的时间差（毫秒）。
- **Period value key** — 以毫秒为单位计算的时间差的键（如 `periodInMs`）。启用 **Add the time difference between readings** 时此字段必填。
- **Exclude zero deltas from outbound message** — 若启用，差值为零的消息将经 `Success` 连接透传，且不向消息 data 添加 output 键值对。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "CalculateDeltaNodeConfiguration",
  "type": "object",
  "properties": {
    "inputValueKey": {
      "type": "string",
      "description": "The key from the incoming message's data to use for calculations."
    },
    "outputValueKey": {
      "type": "string",
      "description": "The key under which the calculated delta will be added to the message data."
    },
    "useCache": {
      "type": "boolean",
      "description": "If true, the node caches the last message from each originator in memory for faster calculations."
    },
    "addPeriodBetweenMsgs": {
      "type": "boolean",
      "description": "If true, the node will also calculate the time difference (in milliseconds) between the current and previous messages."
    },
    "periodValueKey": {
      "type": "string",
      "description": "The key for the calculated time difference. Required if 'addPeriodBetweenMsgs' is true."
    },
    "round": {
      "type": "integer",
      "description": "The number of decimal places to round the delta to."
    },
    "tellFailureIfDeltaIsNegative": {
      "type": "boolean",
      "description": "If true, messages with a negative delta will be routed to the 'Failure' connection."
    },
    "excludeZeroDeltas": {
      "type": "boolean",
      "description": "If true, messages with a delta of zero will not be modified."
    }
  },
  "required": [
    "inputValueKey",
    "outputValueKey"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点首先检查入站消息类型是否为 `POST_TELEMETRY_REQUEST` 且其 data 是否包含指定的 **Input value key**。若不是，消息经 `Other` 连接传递。
2. 获取该消息来源实体的前一个值和时间戳。若**Use caching**已启用，先检查内部缓存。若缓存中无该值，从数据库获取 **Input value key** 的最新时序值。若未找到前一个值，假定为 `0`。
3. 节点计算差值：`delta = currentValue - previousValue`。
4. 若**Tell Failure if delta is negative**已启用且计算得到的差值小于零，原始消息立即经 `Failure` 连接路由。
5. 若**Exclude zero deltas from outbound message**已启用且差值恰好为零，原始消息经 `Success` 连接路由，不做任何修改。
6. 若配置了 **Number of digits after floating point** 值，将差值四舍五入到指定小数位。
7. 使用 **Output value key** 将计算得到的差值添加到消息 data。
8. 若**Add period between messages**已启用，还将计算自上一条消息以来的经过时间（毫秒）并以 **Period value key** 添加到 data。
9. 丰富后的消息随后经 `Success` 连接转发。

## 输出连接

- `Success`：
    - 差值计算成功，消息已丰富。
- `Failure`：
    - 发生错误。最常见原因是**Tell Failure if delta is negative**已启用时计算出负差值。
- `Other`：
    - 入站消息不是 `POST_TELEMETRY_REQUEST` 或其 data 不包含所需的 **Input value key**。

## 示例

### 示例 1 — 基本仪表用量

本示例展示如何从累计计数器计算用量。

**场景**：水表通过 `pulseCounter` 键上报其总累计读数。需计算自上次上报以来的用水量并以 `waterConsumption` 添加到消息。

**入站消息**

Data:

```json
{
  "pulseCounter": 1500
}
```

该来源实体在缓存或数据库中 `pulseCounter` 键的前一个值为 `1450`。

**节点配置**

```json
{
  "inputValueKey": "pulseCounter",
  "outputValueKey": "waterConsumption",
  "useCache": true,
  "addPeriodBetweenMsgs": false,
  "tellFailureIfDeltaIsNegative": false,
  "excludeZeroDeltas": false
}
```

**出站消息**

消息经 `Success` 连接路由，已添加 `waterConsumption` 字段。

Data:

```json
{
  "pulseCounter": 1500,
  "waterConsumption": 50
}
```

**说明**：节点计算差值：`1500 - 1450 = 50`，并将此结果添加到消息 data。

### 示例 2 — 计算速率并处理仪表复位

本示例展示节点如何处理负差值。

**场景**：仪表复位导致其累计计数器下降。已配置检测此情况。

**入站消息**

Data:

```json
{
  "pulseCounter": 10
}
```

该来源实体 `pulseCounter` 键的前一个值为 `1680`。

**节点配置**

```json
{
  "inputValueKey": "pulseCounter",
  "outputValueKey": "waterConsumption",
  "useCache": true,
  "addPeriodBetweenMsgs": false,
  "tellFailureIfDeltaIsNegative": true,
  "excludeZeroDeltas": false
}
```

**出站消息**

**原始消息**经 `Failure` 连接路由。

Data:

```json
{
  "pulseCounter": 10
}
```

**说明**：计算得到的差值为 `10 - 1680 = -1670`。因差值为负且**Tell failure if delta is negative**已启用，节点将消息路由至 `Failure`。
