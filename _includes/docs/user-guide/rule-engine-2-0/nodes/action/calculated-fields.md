对 incoming time series 或 attributes 触发计算字段处理，但不将数据持久化到数据库。

## 前置条件

消息类型和数据结构需与 incoming 数据类型一致：

- **Time series 数据**：使用 `POST_TELEMETRY_REQUEST`，[格式见此处](/docs/user-guide/rule-engine-2-0/nodes/action/save-timeseries)
- **Attributes 数据**：使用 `POST_ATTRIBUTES_REQUEST`，[格式见此处](/docs/user-guide/rule-engine-2-0/nodes/action/save-attributes)

## 配置

该节点无配置选项。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "EmptyNodeConfiguration",
  "type": "object",
  "properties": {},
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点检查入站消息的**类型**。
2. 对于 `POST_TELEMETRY_REQUEST` 或 `POST_ATTRIBUTES_REQUEST` 消息：
    - 从消息 data 解析时序或属性数据（适用时包含 metadata 中的属性 scope）
    - 触发使用该数据的计算字段的评估
    - 入站时序或属性数据本身**不会**持久化到数据库
3. 当计算字段被评估时：
    - 生成一条以计算字段状态已更新的来源实体为来源的新消息
    - 该新消息被推入来源实体的根规则链
4. 触发计算字段处理后，原始消息经 `Success` 连接转发
5. 若收到不支持的消息类型或发生错误，消息经 `Failure` 连接路由

{% capture persistence_note %}
**注意**：计算结果包含在新生成的消息中（步骤 3）。要将这些结果持久化到数据库，仍需在规则链中使用「save time series」或「save attributes」节点。
{% endcapture %}
{% include templates/info-banner.md content=persistence_note %}

## 输出连接

- `Success`
    - 消息 data 包含有效的时序或属性数据且已触发计算字段处理
    - 消息 data 为空（无需处理）
- `Failure`
    - 入站消息类型不是 `POST_TELEMETRY_REQUEST` 或 `POST_ATTRIBUTES_REQUEST`
    - 入站消息 data 无法解析为时序数据或属性数据
    - 消息处理过程中发生意外错误

## 示例

### 示例 1 — 为计算字段处理时序

**入站消息**

Type: `POST_TELEMETRY_REQUEST`

Data:

```json
{
  "temperature": 25.5,
  "humidity": 60
}
```

Originator: `DEVICE`.

**节点配置**

```json
{}
```

**系统状态**

The device has a calculated field "heatIndex" defined that uses the formula: `temperature + 0.5 * humidity`

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

使用入站温度和湿度值评估计算字段「heatIndex」(25.5 + 0.5 * 60 = 55.5)。生成包含计算值、以设备为来源实体的新消息并推入根规则链。原始时序数据（temperature 和 humidity）**不会**存储到数据库。

### 示例 2 — 为计算字段处理属性

**入站消息**

Type: `POST_ATTRIBUTES_REQUEST`

Data:

```json
{
  "maxSpeed": 100,
  "currentSpeed": 75
}
```

Metadata:

```json
{
  "scope": "SERVER_SCOPE"
}
```

Originator: `DEVICE`.

**节点配置**

```json
{}
```

**系统状态**

The device has a calculated field "speedPercentage" defined that calculates: `(currentSpeed / maxSpeed) * 100`

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

评估计算字段「speedPercentage」(75 / 100 * 100 = 75%)。生成包含计算值的新消息并推入根规则链。原始属性**不会**持久化到数据库。

### 示例 3 — 空负载处理

**入站消息**

Type: `POST_TELEMETRY_REQUEST`

Data: `{}`

**节点配置**

```json
{}
```

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

因 data 为空，未触发任何计算字段。消息成功透传，无任何处理。

### 示例 4 — 不支持的消息类型

**入站消息**

Type: `ENTITY_CREATED`

**节点配置**

```json
{}
```

**出站消息**

出站消息与入站消息相同。经 `Failure` 连接路由。

**结果**

处理失败，因为该节点仅支持 `POST_TELEMETRY_REQUEST` 和 `POST_ATTRIBUTES_REQUEST` 消息类型。`ENTITY_CREATED` 生命周期事件无法触发计算字段处理。
