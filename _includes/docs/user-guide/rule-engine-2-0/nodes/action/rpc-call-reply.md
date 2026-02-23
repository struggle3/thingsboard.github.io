将传入消息数据作为[回复](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial)发送给设备的 [Remote Procedure Call (RPC)](/docs/{{docsPrefix}}user-guide/rpc){:target="_blank"}。
回复根据元数据属性路由回发起服务和会话。
消息路由至 `Success` 连接（成功时）或 `Failure` 连接（错误时）。

## 用法

处理设备 RPC 请求并发送回复的典型流程如下：

1. 当设备向平台发送 RPC 请求时，会自动创建类型为 `TO_SERVER_RPC_REQUEST` 的 Rule Engine 消息。消息数据包含设备的 RPC payload，元数据包含路由回复所需的服务 ID、会话 ID 和请求 ID。

2. 在 Rule Chain 中处理该消息以准备响应。可能涉及用附加数据丰富消息、转换 payload、调用外部系统或生成适当回复所需的任何其他业务逻辑。

3. 一旦消息数据中准备好响应，将消息路由至 RPC call reply 节点。节点将使用元数据将回复发送回发起设备。

4. **重要**：确保在消息处理过程中保留服务 ID、会话 ID 和请求 ID 元数据属性。若这些值丢失或被覆盖，回复无法路由回设备。

## 配置

配置参数指定用于识别服务、会话和请求的元数据键名，以便发送回复。

- **Service Id** - 服务标识符的元数据键名。默认值为 `serviceId`。标识应接收回复的发起服务。
- **Session Id** - 会话标识符的元数据键名。默认值为 `sessionId`。标识服务内的具体会话。
- **Request Id** - 请求标识符的元数据键名。默认值为 `requestId`。标识要回复的具体 RPC 请求。

{% capture reasonable_defaults_note %}
这些参数可为高级用例自定义，但默认值在大多数场景下工作良好，通常无需更改。RPC 消息的元数据中已包含路由参数（服务 ID、会话 ID、请求 ID）。
{% endcapture %}
{% include templates/info-banner.md content=reasonable_defaults_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSendRpcReplyNodeConfiguration",
  "type": "object",
  "properties": {
    "serviceIdMetaDataAttribute": {
      "type": "string",
      "description": "Metadata key name for the service identifier."
    },
    "sessionIdMetaDataAttribute": {
      "type": "string",
      "description": "Metadata key name for the session identifier."
    },
    "requestIdMetaDataAttribute": {
      "type": "string",
      "description": "Metadata key name for the request identifier."
    }
  },
  "required": [
    "serviceIdMetaDataAttribute",
    "sessionIdMetaDataAttribute",
    "requestIdMetaDataAttribute"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点验证消息发起者为 `DEVICE`。若验证失败，处理失败。
2. 节点使用配置的键名从消息元数据中提取服务 ID、会话 ID 和请求 ID。若任一值缺失，处理失败。
3. 节点验证消息数据（回复体）非空。若为空，处理失败。
4. 节点通过检查元数据中是否存在 `edgeId` 判断消息是否来自 Edge 设备：
    - 若存在 edge ID：将回复保存到 Edge 事件队列以便异步投递给 Edge。
    - 若不存在 edge ID：使用 RPC 服务直接将回复发送给设备。
5. 成功完成处理后，消息经 `Success` 连接转发。

## 输出连接

- `Success`
    - RPC 回复已成功发送（直接发送或加入 Edge 投递队列）。传出消息与传入消息相同。
- `Failure`
    - 处理过程中发生错误，例如：
        - 发起者不是 `DEVICE`
        - 元数据中缺少服务 ID
        - 元数据中缺少会话 ID
        - 元数据中缺少请求 ID
        - 消息数据（回复体）为空
        - 无法从元数据解析 edge ID 或设备 ID
        - 保存 Edge 事件失败

## 示例

### 示例 1 — 简单 RPC 回复

**传入消息**

发起者：`DEVICE`。

数据：

```json
{
  "timestamp": 1727712000000
}
```

元数据：

```json
{
  "serviceId": "monolith",
  "sessionId": "550e8400-e29b-41d4-a716-446655440000",
  "requestId": "12345"
}
```

**节点配置**

```json
{
  "serviceIdMetaDataAttribute": "serviceId",
  "sessionIdMetaDataAttribute": "sessionId",
  "requestIdMetaDataAttribute": "requestId"
}
```

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

设备请求当前服务器时间，服务器以当前 UNIX 时间戳（毫秒）回复。RPC 回复发送回服务 `monolith`、会话 `550e8400-e29b-41d4-a716-446655440000`，对应请求 ID `12345`。
