向 AWS Simple Notification Service (SNS) 主题发布消息，入站消息 data 作为通知 payload 发送。节点将 SNS 响应 metadata 作为出站消息的一部分返回。

## 配置

### Topic configuration（主题配置）

定义要发布消息的目标 SNS 主题。

#### Topic ARN pattern

要发布到的 SNS 主题的 Amazon Resource Name (ARN)。

可使用标准 AWS 格式指定 topic ARN：

- **Full ARN**：`arn:aws:sns:us-east-1:123456789012:MyNewTopic`

ARN 可包含模板表达式，以根据消息数据动态选择主题：

- `arn:aws:sns:${metadata.region}:123456789012:${topicName}`
- `arn:aws:sns:us-east-1:123456789012:notifications-$[severity]`

### AWS Credentials

Provide authentication credentials to access your AWS SNS service.

#### AWS Access Key ID

The access key ID for your AWS account. This credential is used to sign requests to AWS SNS.

#### AWS Secret Access Key

The secret access key corresponding to your access key ID.

{% capture credentials_note %}
**注意**：若使用 Professional Edition，建议使用 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 安全存储私密密钥。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

#### AWS Region

The AWS region where your SNS topic is deployed. The region must match the location of your SNS topic.

{% capture timeout_note %}
**注意**：节点对 AWS SNS 操作使用固定超时：建立连接 10 秒，SNS 服务处理并响应请求 5 秒。
{% endcapture %}
{% include templates/info-banner.md content=timeout_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSnsNodeConfiguration",
  "type": "object",
  "properties": {
    "topicArnPattern": {
      "type": "string",
      "minLength": 1,
      "description": "ARN of the SNS topic to publish to (supports templatization)."
    },
    "accessKeyId": {
      "type": "string",
      "minLength": 1,
      "description": "AWS Access Key ID for authentication."
    },
    "secretAccessKey": {
      "type": "string",
      "minLength": 1,
      "description": "AWS Secret Access Key for authentication."
    },
    "region": {
      "type": "string",
      "minLength": 1,
      "description": "AWS region where the SNS topic is deployed."
    }
  },
  "required": [
    "topicArnPattern",
    "accessKeyId",
    "secretAccessKey",
    "region"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点通过将 AWS SNS 响应信息添加到消息 metadata 来转换入站消息，同时保留原始消息 data。

### Success case（成功时）

消息成功发布到 SNS 时，以下字段会添加到消息 metadata：

- **messageId** – Unique identifier assigned by AWS SNS to the published message. This ID can be used to track the message delivery status.
- **requestId** – Unique identifier for the API request to AWS. Useful for troubleshooting and correlating with AWS CloudTrail logs.

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
  "messageId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "requestId": "12345678-1234-1234-1234-123456789012"
}
```

The message data remains unchanged.

### Failure case

When publishing fails, the following field is added to the message metadata:

- **error** – Contains the exception class name and error message in the format: `class <ExceptionClass>: <error message>`

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
  "error": "class com.amazonaws.services.sns.model.NotFoundException: Topic does not exist"
}
```

The message data remains unchanged.

## Message acknowledgement behavior

The node's message acknowledgement behavior is controlled by the `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` environment variable:

- **When set to `true`** – The incoming message is acknowledged and marked as successfully processed immediately upon receipt.
  A new message is created with the updated metadata and is enqueued for processing by the next node.
- **When set to `false`** (default) – The incoming message remains in an in-processing state throughout the entire SNS publish operation.
  The message is transformed in place, its metadata is updated with the SNS response fields, and the modified message is passed to the next node after the publish completes.

## 消息处理算法

1. 节点构建 SNS 发布请求：
    - The **topic ARN pattern** is processed, replacing templates with values from the incoming message data and metadata.
    - A `PublishRequest` is created with the message data as the notification payload and the resolved topic ARN as the destination.
2. The publish request is sent asynchronously to AWS SNS with the configured timeouts:
    - **Connection timeout** (10 seconds) applies to establishing the connection to AWS SNS.
    - **Request timeout** (5 seconds) applies to waiting for the SNS service to accept the message and return a response.
3. When SNS responds successfully:
    - The message ID from AWS (unique identifier for the published message) is added to the message metadata as `messageId`.
    - The request ID from AWS (unique identifier for the API request) is added to the message metadata as `requestId`.
    - The resulting message is forwarded via the `Success` connection.
4. If an error occurs during publishing:
    - Error details are added to the message metadata under the `error` key.
    - The message is forwarded via the `Failure` connection.

## 输出连接

- **Success**
    - The message was successfully published to the SNS topic.
    - The SNS service accepted the message and returned a message ID.
    - Response metadata (`messageId` and `requestId`) is included in the outgoing message metadata.
- **Failure**
    - **Timeout**: Failed to establish a connection to AWS SNS or the SNS service did not respond within the configured timeout periods (10 seconds for connection, 5 seconds for
      request).
    - **SNS error**: The AWS SNS service returned an error, such as invalid credentials, insufficient permissions, non-existent topic, or invalid topic ARN format.
    - **Unexpected error**: An unexpected error occurred during message processing.

## 示例

### 示例 1 — 基本通知

向 SNS 主题发布简单通知消息以分发告警。

**入站消息**

Data：

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "bfb13620-7737-400b-9c89-d569a0835de6"
  },
  "createdTime": 1755173119647,
  "tenantId": {
    "entityType": "TENANT",
    "id": "888e6780-78f5-11f0-8e01-57f51829cedc"
  },
  "type": "Overheating",
  "originator": {
    "entityType": "DEVICE",
    "id": "b3e86d40-78f5-11f0-8e01-57f51829cedc"
  },
  "severity": "CRITICAL",
  "acknowledged": false,
  "cleared": false,
  "startTs": 1755173119647,
  "endTs": 1755173119647,
  "name": "Overheating",
  "status": "ACTIVE_UNACK",
  "details": {
    "summary": "The temperature has persistently exceeded 85 °C for at least 10 minutes, while vibration (3.8–4.1 mm/s) and acoustic deviation (9–10.5%) remain normal. Immediate attention is required to prevent possible thermal damage."
  }
}
```

**节点配置**

```json
{
  "topicArnPattern": "arn:aws:sns:us-east-1:123456789012:device-alerts",
  "accessKeyId": "AKIAIOSFODNN7EXAMPLE",
  "secretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
  "region": "us-east-1"
}
```

**出站消息**

Data：未更改。

Metadata（仅显示新增字段）：

```json
{
  "messageId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "requestId": "12345678-1234-1234-1234-123456789012"
}
```

Routed via the `Success` connection.

**结果**

alarm 通知已成功发布到 SNS 主题。AWS 消息 ID 和请求 ID 已添加到 metadata。

### 示例 2 — 无效主题的错误处理

Attempt to publish to a non-existent SNS topic, resulting in a failure.

**Incoming message**

Data:

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "bfb13620-7737-400b-9c89-d569a0835de6"
  },
  "createdTime": 1755173119647,
  "tenantId": {
    "entityType": "TENANT",
    "id": "888e6780-78f5-11f0-8e01-57f51829cedc"
  },
  "type": "Overheating",
  "originator": {
    "entityType": "DEVICE",
    "id": "b3e86d40-78f5-11f0-8e01-57f51829cedc"
  },
  "severity": "CRITICAL",
  "acknowledged": false,
  "cleared": false,
  "startTs": 1755173119647,
  "endTs": 1755173119647,
  "name": "Overheating",
  "status": "ACTIVE_UNACK",
  "details": {
    "summary": "The temperature has persistently exceeded 85 °C for at least 10 minutes, while vibration (3.8–4.1 mm/s) and acoustic deviation (9–10.5%) remain normal. Immediate attention is required to prevent possible thermal damage."
  }
}
```

**节点配置**

```json
{
  "topicArnPattern": "arn:aws:sns:us-east-1:123456789012:non-existent-topic",
  "accessKeyId": "AKIAIOSFODNN7EXAMPLE",
  "secretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
  "region": "us-east-1"
}
```

**出站消息**

Data：未更改。

Metadata（仅显示新增字段）：

```json
{
  "error": "class com.amazonaws.services.sns.model.NotFoundException: Topic does not exist"
}
```

Routed via the `Failure` connection.

**结果**

SNS 发布操作失败，因为指定的主题不存在。错误详情已记录到消息 metadata 并经 `Failure` 连接路由。
