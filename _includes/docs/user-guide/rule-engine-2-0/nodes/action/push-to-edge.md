通过将传入消息转换为 edge event 并存储到 edge queue，将消息从云端推送到 Edge。消息路由至 `Success` 连接（edge event 成功推送到持久存储时）或 `Failure` 连接（处理期间发生错误或消息类型不支持时）。

## 用法

此节点支持 selective 将数据从云端同步到 Edge 实例。适用于自动同步全部数据会消耗大量资源或不必要的场景。例如 Edge 实例通常不需要所有设备的完整历史遥测——只需与本地操作相关的特定数据。使用此节点可显式控制哪些消息同步到哪些 Edge，避免传输不会使用的大量数据。

将消息推送到 Edge 的典型流程如下：

1. 消息到达「push to edge」节点，包含需要同步到 Edge 实例的数据（遥测、属性、告警等）。

2. 节点根据消息类型将消息转换为 edge event，并存储到持久存储（edge queue）。

3. Edge 实例从队列检索待处理的 edge events 以进行同步。

4. 若 edge event 成功推送到持久存储，消息经 `Success` 连接路由。若发生错误，经 `Failure` 连接路由。

{% capture async_note %}
**异步处理**：`Success` 连接表示 edge event 已成功推送到持久存储，而非已投递到 Edge。实际投递到 Edge 是异步进行的。
{% endcapture %}
{% include templates/warn-banner.md content=async_note %}

{% capture originator_note %}
**消息发起者要求**：消息发起者必须已分配给特定 Edge 实例，或为 `EDGE` 实体本身。若发起者为 `EDGE` 实体，事件仅推送到该 Edge。若发起者为其他实体类型（如 `DEVICE`、`ASSET`），事件推送到实体分配到的所有 Edge。
{% endcapture %}
{% include templates/info-banner.md content=originator_note %}

## 配置

配置指定属性相关消息的默认属性作用域。

- **Attributes scope（属性作用域）** - 属性的默认作用域（`SERVER_SCOPE`、`CLIENT_SCOPE` 或 `SHARED_SCOPE`）。可通过在消息元数据中包含 `scope` 键动态覆盖此值。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgPushToEdgeNodeConfiguration",
  "type": "object",
  "properties": {
    "scope": {
      "type": "string",
      "description": "The default attribute scope for attribute-related messages.",
      "enum": [
        "SERVER_SCOPE",
        "CLIENT_SCOPE",
        "SHARED_SCOPE"
      ]
    }
  },
  "required": [
    "scope"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 支持的消息类型

节点支持以下消息类型：

- `POST_TELEMETRY_REQUEST` - 发布给设备的时序数据
- `POST_ATTRIBUTES_REQUEST` - 发布给设备的属性数据
- `ATTRIBUTES_UPDATED` - 设备属性已更新
- `ATTRIBUTES_DELETED` - 设备属性已删除
- `TIMESERIES_UPDATED` - 时序数据已更新
- `ALARM` - 告警创建、更新或清除
- `ALARM_ACK` - 告警已确认
- `ALARM_CLEAR` - 告警已清除
- `CONNECT_EVENT` - 设备已连接
- `DISCONNECT_EVENT` - 设备已断开
- `ACTIVITY_EVENT` - 检测到设备活动
- `INACTIVITY_EVENT` - 检测到设备非活动
- `TO_SERVER_RPC_REQUEST` - 设备到服务器的 RPC 请求

## 消息处理算法

1. 节点验证消息类型是否受支持。若不受支持，消息经 `Failure` 连接路由。

2. 根据消息类型，节点构建适当的 edge event。

3. 若消息发起者为 `EDGE` 实体：
    - 将 edge event 推送到该特定 Edge 实例的持久存储

4. 若消息发起者为其他实体类型：
    - 节点查找发起者实体分配到的所有 Edge
    - 为每个 Edge 将 edge event 推送到持久存储
    - 若实体未分配给任何 Edge，消息被确认且不进行进一步处理

5. 若所有 edge events 成功推送到持久存储，消息经 `Success` 连接路由；若发生任何错误，经 `Failure` 连接路由。

## 输出连接

- `Success`
    - edge event(s) 已成功推送到持久存储。传出消息与传入消息相同。
- `Failure`
    - 处理过程中发生错误，例如：
        - 不支持的消息类型
        - 意外错误

## 示例

### 示例 1 — 将设备遥测推送到 Edge

**传入消息**

发起者：`DEVICE`。

类型：`POST_TELEMETRY_REQUEST`。

数据：

```json
{
  "temperature": 22.5,
  "humidity": 65.3
}
```

元数据：

```json
{
  "ts": "1609459200000"
}
```

**节点配置**

```json
{
  "scope": "SERVER_SCOPE"
}
```

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

创建 edge event 并推送到发起者设备分配到的所有 Edge 的持久存储。edge event 包含遥测数据和时间戳。
Edge 实例检索此事件时将相应处理。
