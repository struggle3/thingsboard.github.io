将消息发布到 [Google Cloud Pub/Sub](https://cloud.google.com/pubsub){:target="_blank"} 主题，入站消息数据作为消息体发送。
节点将 Pub/Sub 响应 metadata 作为出站消息的一部分返回。

## 配置

### GCP project ID

Pub/Sub 主题所在的 Google Cloud 项目 ID。

可在 Google Cloud 控制台或服务账户凭据文件中找到项目 ID。

### Topic name

要发布消息的 Pub/Sub 主题名称。

仅指定主题名，不要包含完整资源路径。节点会自动构建完整路径，格式为：`projects/{projectId}/topics/{topicName}`

主题名可包含模板，以根据消息数据动态选择主题：

- `${topicName}` — 使用消息 metadata 中的值替换
- `$[severity]` — 使用消息 data 中的值替换
- `notifications-$[severity]` — 与静态文本组合

### Message attributes

定义附加到每条 Pub/Sub 消息的自定义属性。消息属性可在不修改消息体的情况下提供结构化 metadata。

属性名和值均支持模板：

- `${key}` — 使用消息 metadata 中的值替换
- `$[key]` — 使用消息 data 中的值替换

所有消息属性以字符串键值对形式发送。

### GCP credentials（服务账户密钥文件）

以 JSON 格式提供 Google Cloud 服务账户密钥。对应账户须具备向 Pub/Sub 主题发布消息的权限。

{% capture credentials_note %}
**注意**：若使用 Professional Edition，建议使用 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 安全存储服务账户密钥。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### Timeout and retries（超时与重试）

节点对 Google Cloud Pub/Sub 操作使用固定超时和重试设置：
- **Total timeout**: 10 seconds for the entire publish operation
- **Initial retry delay**: 50 milliseconds
- **Maximum retry delay**: 2 seconds
- **Retry delay multiplier**: 1.1
- **RPC timeout**: 2-10 seconds (starts at 2s, can grow to 10s)

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbPubSubNodeConfiguration",
  "type": "object",
  "properties": {
    "projectId": {
      "type": "string",
      "minLength": 1,
      "description": "Google Cloud project ID where the Pub/Sub topic is deployed."
    },
    "topicName": {
      "type": "string",
      "minLength": 1,
      "description": "Name of the Pub/Sub topic to publish to (supports templatization)."
    },
    "messageAttributes": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "Custom message attributes to attach to each message."
    },
    "serviceAccountKey": {
      "type": "string",
      "minLength": 1,
      "description": "GCP service account key in JSON format for authentication."
    },
    "serviceAccountKeyFileName": {
      "type": "string",
      "description": "Name of the service account key file (for UI display purposes)."
    }
  },
  "required": [
    "projectId",
    "topicName",
    "messageAttributes",
    "serviceAccountKey"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## Output message format

The node transforms the incoming message by adding Google Cloud Pub/Sub response information to the outgoing message metadata while preserving the original message data.

### Success case

When a message is successfully published to Pub/Sub, the following field is added to the outgoing message metadata:

- `messageId` – Unique identifier assigned by Google Cloud Pub/Sub to the message. This server-assigned ID can be used to track and identify the message in the Pub/Sub system.

**Example:**

Original message metadata:

```json
{
  "deviceType": "sensor"
}
```

After successful publish, metadata becomes:

```json
{
  "deviceType": "sensor",
  "messageId": "1234567890"
}
```

The message data remains unchanged.

### Failure case

When publishing fails, the following field is added to the outgoing message metadata:

- `error` – Contains the exception class name and error message in the format: `class <ExceptionClass>: <error message>`

**Example:**

Original message metadata:

```json
{
  "deviceType": "sensor"
}
```

After a failure (e.g., topic not found), metadata becomes:

```json
{
  "deviceType": "sensor",
  "error": "class com.google.api.gax.rpc.NotFoundException: Topic not found"
}
```

The message data remains unchanged.

## Message acknowledgement behavior

The node's message acknowledgement behavior is controlled by the `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` environment variable:

- **When set to `true`** – The incoming message is acknowledged and marked as successfully processed immediately upon receipt. A new message is created with the updated metadata
  and is enqueued for processing by the next node.
- **When set to `false`** (default) – The incoming message remains in an in-processing state throughout the entire Pub/Sub publish operation. The message is transformed in place,
  its metadata is updated with the Pub/Sub response fields, and the modified message is passed to the next node after the publish completes.

## Message processing algorithm

1. The node constructs a Pub/Sub message:
    - The **topic name** is processed, replacing templates with values from the incoming message data and metadata.
    - The incoming message data is set as the Pub/Sub message body.
    - **Message attributes** are processed: each attribute name and value is evaluated for templates and added to the Pub/Sub message as string key-value pairs.
2. The publish request is executed asynchronously with the configured retry settings.
3. When Pub/Sub responds successfully:
    - The message ID assigned by Pub/Sub is added to the outgoing message metadata.
    - The resulting message is forwarded via the `Success` connection.
4. If an error occurs during publishing:
    - Error details are added to the outgoing message metadata under the `error` key.
    - The message is forwarded via the `Failure` connection.

## Output connections

- **Success**
    - The message was successfully published to the Pub/Sub topic.
    - Pub/Sub message ID is included in the outgoing message metadata.
- **Failure**
    - **Timeout**: Failed to publish the message within the configured timeout period (10 seconds total).
    - **Pub/Sub error**: The Google Cloud Pub/Sub service returned an error, such as invalid credentials, insufficient permissions, non-existent topic, or invalid topic name
      format.
    - **Unexpected error**: An unexpected error occurred during message processing.

## Examples

### Example 1 — Basic message to Pub/Sub topic

Publish a telemetry message to a Pub/Sub topic with custom attributes.

**Incoming message**

Data:

```json
{
  "temperature": 25.5,
  "humidity": 60.2
}
```

Metadata:

```json
{
  "deviceType": "TH-Sensor",
  "deviceName": "Sensor-001"
}
```

**Node configuration**

```json
{
  "projectId": "my-iot-project",
  "topicName": "telemetry-events",
  "messageAttributes": {
    "deviceType": "${deviceType}",
    "deviceName": "${deviceName}"
  },
  "serviceAccountKey": "{\"type\":\"service_account\",\"project_id\":\"my-iot-project\",...}"
}
```

**Outgoing message**

Data: unchanged.

Metadata (only added fields shown):

```json
{
  "messageId": "1234567890"
}
```

Routed via the `Success` connection.

**Result**

The telemetry data was successfully published to the `telemetry-events` topic with custom attributes indicating the device type and name.

### Example 2 — Dynamic topic selection

Publish alarm messages to different topics based on alarm severity using templates.

**Incoming message**

Data:

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "bfb13620-7737-400b-9c89-d569a0835de6"
  },
  "createdTime": 1755173119647,
  "type": "Overheating",
  "severity": "CRITICAL",
  "status": "ACTIVE_UNACK"
}
```

Metadata:

```json
{
  "tenantId": "888e6780-78f5-11f0-8e01-57f51829cedc"
}
```

**Node configuration**

```json
{
  "projectId": "my-iot-project",
  "topicName": "alarms-$[severity]",
  "messageAttributes": {
    "tenantId": "${tenantId}",
    "alarmType": "$[type]"
  },
  "serviceAccountKey": "{\"type\":\"service_account\",\"project_id\":\"my-iot-project\",...}"
}
```

**Outgoing message**

Data: unchanged.

Metadata (only added fields shown):

```json
{
  "messageId": "2345678901"
}
```

Routed via the `Success` connection.

**Result**

The alarm was dynamically routed to the `alarms-CRITICAL` topic based on the severity level in the message data. The message includes attributes for tenant ID and alarm type.

### Example 3 — Error handling for invalid topic

Attempt to publish to a non-existent Pub/Sub topic, resulting in a failure.

**Incoming message**

Data:

```json
{
  "temperature": 25.5,
  "humidity": 60.2
}
```

**Node configuration**

```json
{
  "projectId": "my-iot-project",
  "topicName": "non-existent-topic",
  "messageAttributes": {},
  "serviceAccountKey": "{\"type\":\"service_account\",\"project_id\":\"my-iot-project\",...}"
}
```

**Outgoing message**

Data: unchanged.

Metadata (only added fields shown):

```json
{
  "error": "class com.google.api.gax.rpc.NotFoundException: Topic projects/my-iot-project/topics/non-existent-topic not found"
}
```

Routed via the `Failure` connection.

**Result**

The Pub/Sub publish operation failed because the specified topic does not exist. The error details were captured in the message metadata and routed to the `Failure` connection.
