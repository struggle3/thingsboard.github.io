通过将传入消息转换为 cloud event 并存储到 cloud queue，将消息从 Edge 推送到云端。消息路由至 `Success` 连接（cloud event 成功推送到持久存储时）或 `Failure` 连接（处理期间发生错误或消息类型不支持时）。

## 用法

此节点专门用于 Edge 实例，以同步 Edge 到云端的数据。Edge 实例上的大多数配置更改（如更新设备名称或关系）会自动与云端同步。但某些类型的数据同步若自动执行会消耗大量资源——例如将所有本地遥测数据流式传输到云端。此节点支持 selectively 同步此类数据，让您显式控制哪些消息推送到云端。

当消息到达此节点时，会转换为 cloud event 并保存到本地 Edge 数据库的 cloud queue。实际投递到云端是异步进行的——Edge 同步服务从队列检索这些事件并传输到云端。

将消息推送到云端的典型流程如下：

1. 消息到达 Edge 实例上的「push to cloud」节点，包含需要同步到云端的数据（遥测、属性、告警等）。

2. 节点根据消息类型将消息转换为 cloud event，并存储到持久存储（cloud queue）。

3. Edge 同步服务从队列检索待处理的 cloud events 并传输到云端平台。

4. 若 cloud event 成功推送到持久存储，消息经 `Success` 连接路由。若发生错误，经 `Failure` 连接路由。

{% capture async_note %}
**异步处理**：`Success` 连接表示 cloud event 已成功推送到 Edge 上的持久存储，而非已投递到云端。实际投递到云端通过 Edge 同步过程异步进行。
{% endcapture %}
{% include templates/warn-banner.md content=async_note %}

## 配置

配置指定属性相关消息的默认属性作用域。

- **Attributes scope（属性作用域）** - 属性的默认作用域（`SERVER_SCOPE`、`CLIENT_SCOPE` 或 `SHARED_SCOPE`）。可通过在消息元数据中包含 `scope` 键动态覆盖此值。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgPushToCloudNodeConfiguration",
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
- `TIMESERIES_UPDATED` - 时序数据已更新
- `TIMESERIES_DELETED` - 时序数据已删除
- `POST_ATTRIBUTES_REQUEST` - 发布给设备的属性数据
- `ATTRIBUTES_UPDATED` - 设备属性已更新
- `ATTRIBUTES_DELETED` - 设备属性已删除

## 消息处理算法

1. 节点验证消息类型是否受支持。若不受支持，消息经 `Failure` 连接路由。

2. 根据消息类型，节点构建适当的 cloud event。

3. cloud event 保存到持久存储。

4. 若 cloud event 成功推送到持久存储，消息经 `Success` 连接路由；若发生任何错误，经 `Failure` 连接路由。

## 输出连接

- `Success`
    - cloud event 已成功推送到 Edge 上的持久存储。传出消息与传入消息相同。
- `Failure`
    - 处理过程中发生错误，例如：
        - 不支持的消息类型
        - 意外错误

## 示例

### 示例 1 — 将设备时序数据推送到云端

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

创建 cloud event 并推送到 Edge cloud queue 的持久存储。事件包含遥测数据和时间戳。Edge 同步服务检索此事件时，将传输到云端平台并处理。
