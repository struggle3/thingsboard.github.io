将传入消息数据作为对 Rule Engine 的 REST API 调用的回复发送。回复根据元数据属性路由回发起服务和请求。
消息路由至 `Success` 连接（成功时）或 `Failure` 连接（错误时）。

## 用法

### 向 Rule Engine 发起 REST API 调用

要通过 REST API 向 Rule Engine 提交消息，使用以下 POST 端点之一：

- `POST /api/rule-engine/` — 将消息推送到 Rule Engine。
- `POST /api/rule-engine/{entityType}/{entityId}` — 将消息推送到特定实体（如设备、资产）。
- `POST /api/rule-engine/{entityType}/{entityId}/{timeout}` — 使用自定义超时值（毫秒）推送实体消息。
- `POST /api/rule-engine/{entityType}/{entityId}/{queueName}/{timeout}` — 将实体消息推送到特定队列并指定自定义超时值。

请求体应以 JSON 格式包含消息 payload。
当端点中未指定实体时，消息发起者为发起请求的用户。
当指定实体时，消息发起者为该实体。
平台会自动将服务 ID 和请求 ID 添加到消息元数据，用于将回复路由回调用客户端。

### 流程

处理 Rule Engine REST API 调用并发送回复的典型流程如下：

1. 当外部系统或用户发送 REST API 调用向 ThingsBoard Rule Engine 提交消息时，会自动创建类型为 `REST_API_REQUEST` 的 Rule Engine 消息。
   消息数据包含 API 调用的 payload，元数据包含将回复作为 HTTP 响应路由回所需的服务 ID 和请求 ID。

2. 在 Rule Chain 中处理该消息以准备响应。可能涉及用附加数据丰富消息、转换 payload、调用外部系统或生成适当回复所需的任何其他业务逻辑。

3. 一旦消息数据中准备好响应，将消息路由至「rest call reply」节点。节点将使用元数据将回复发送回发起服务，作为对初始 REST API 调用的 HTTP 响应返回。

4. **重要**：确保在消息处理过程中保留 `serviceId` 和 `requestId` 元数据属性。若这些值丢失或被覆盖，回复无法路由回，API 调用将超时。

{% capture timeout_warning %}
**超时处理**：若 REST API 调用在收到回复前超时，平台将返回 `408 REQUEST TIMEOUT`。
若 Rule Chain 中较早节点发生故障并阻止消息到达回复节点，即使存在「rest call reply」节点也可能发生此情况。
从浏览器发起此类超时请求时，浏览器可能会静默重试调用，导致同一请求的多次 Rule Engine 执行。
为避免此问题，请确保 Rule Chain 适当处理错误，且回复在超时前返回。
在原始 REST API 调用上设置足够的超时值，以允许完整处理。
{% endcapture %}
{% include templates/warn-banner.md content=timeout_warning %}

## 配置

配置参数指定用于识别服务和请求的元数据键名，以便发送回复。

- **Service Id** - 服务标识符的元数据键名。默认值为 `serviceId`。标识应接收回复的发起服务。
- **Request Id** - 请求标识符的元数据键名。默认值为 `requestUUID`。标识要回复的具体 REST API 请求。

{% capture reasonable_defaults_note %}
这些参数可为高级用例自定义，但默认值在大多数场景下工作良好，通常无需更改。REST API 消息的元数据中已包含路由参数（服务 ID 和请求 ID）。
{% endcapture %}
{% include templates/info-banner.md content=reasonable_defaults_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSendRestApiCallReplyNodeConfiguration",
  "type": "object",
  "properties": {
    "serviceIdMetaDataAttribute": {
      "type": "string",
      "description": "Metadata key name for the service identifier."
    },
    "requestIdMetaDataAttribute": {
      "type": "string",
      "description": "Metadata key name for the request identifier."
    }
  },
  "required": [
    "serviceIdMetaDataAttribute",
    "requestIdMetaDataAttribute"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点使用配置的键名从消息元数据中提取服务 ID 和请求 ID。若请求 ID 缺失，处理失败。
2. 节点验证元数据中存在服务 ID。若缺失，处理失败。
3. 节点验证消息数据（回复体）非空。若为空，处理失败。
4. 节点将回复作为 HTTP 响应发送回发起的 REST API 调用。
5. 成功完成处理后，消息经 `Success` 连接转发。

## 输出连接

- `Success`
    - REST API 回复已成功发送。传出消息与传入消息相同。
- `Failure`
    - 处理过程中发生错误，例如：
        - 元数据中缺少请求 ID
        - 元数据中缺少服务 ID
        - 消息数据（回复体）为空
        - 无法将请求 ID 解析为 UUID

## 示例

### 示例 1 — 简单 REST API 回复

**传入消息**

发起者：`DEVICE`。

数据：

```json
{
  "status": "completed",
  "fileName": "sensor_data_2024_10_02.csv",
  "fileSize": 15360,
  "recordsProcessed": 1250
}
```

元数据：

```json
{
  "serviceId": "monolith",
  "requestUUID": "a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6"
}
```

**节点配置**

```json
{
  "serviceIdMetaDataAttribute": "serviceId",
  "requestIdMetaDataAttribute": "requestUUID"
}
```

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

用户向 Rule Engine 发起 REST API 调用以触发电外部 FTP 服务器下载数据文件。
Rule Chain 通过连接 FTP 服务器、下载文件、处理记录并准备包含操作结果的响应来处理该请求。
「rest api reply」节点将此数据作为 HTTP 响应体发送回对服务 `monolith`、请求 ID `a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6` 的原始 REST API 调用。
