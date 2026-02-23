向 AWS Simple Queue Service (SQS) 队列发布消息，入站消息 data 作为消息体发送。节点支持 Standard 和 FIFO 两种队列类型，并将 SQS 响应 metadata 作为出站消息的一部分返回。

## 配置

### Queue configuration（队列配置）

定义目标 SQS 队列及其行为。

#### Queue type

发布消息的 SQS 队列类型：**Standard** 或 **FIFO**。

#### Queue URL pattern

要发布到的 SQS 队列的完整 URL。

You can specify the queue URL in the standard AWS format:

- **Full URL**: `https://sqs.us-east-1.amazonaws.com/123456789012/my-queue-name`
- **FIFO queue**: `https://sqs.us-east-1.amazonaws.com/123456789012/my-queue-name.fifo`

The URL can include templates to dynamically select queues based on message data:

- `https://sqs.${region}.amazonaws.com/123456789012/${queueName}`
- `https://sqs.us-east-1.amazonaws.com/123456789012/notifications-$[severity]`

#### Delay seconds (Standard queues only)

The number of seconds to delay message delivery (0-900 seconds).

Specifies how long messages will be delayed before becoming available for processing. A value of 0 means no delay.

### FIFO queue behavior

For FIFO queues, the node automatically configures message deduplication and grouping:

- **Message Deduplication ID** – Set to the ThingsBoard message ID to ensure exactly-once processing.
- **Message Group ID** – Set to the message originator ID to maintain message ordering per originator.

### Message attributes

Define custom attributes to attach to each SQS message. Message attributes allow you to provide structured metadata about the message without modifying the message body.

Both attribute names and values support templates:

- `${key}` – Substitutes values from message metadata
- `$[key]` – Substitutes values from message data

All message attributes are sent with data type "String".

### AWS Credentials

Provide authentication credentials to access your AWS SQS service.

- **AWS Access Key ID** - The access key ID for your AWS account. This credential is used to sign requests to AWS SQS.
- **AWS Secret Access Key** - The secret access key corresponding to your access key ID.

{% capture credentials_note %}
**注意**：若使用 Professional Edition，建议使用 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 安全存储私密密钥。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

#### AWS Region

The AWS region where your SQS queue is deployed. The region must match the location of your SQS queue.

{% capture timeout_note %}
**注意**：节点对 AWS SQS 操作使用固定超时：建立连接 10 秒，SQS 服务处理并响应请求 5 秒。
{% endcapture %}
{% include templates/info-banner.md content=timeout_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSqsNodeConfiguration",
  "type": "object",
  "properties": {
    "queueType": {
      "type": "string",
      "enum": [
        "STANDARD",
        "FIFO"
      ],
      "description": "Type of SQS queue (Standard or FIFO)."
    },
    "queueUrlPattern": {
      "type": "string",
      "minLength": 1,
      "description": "URL of the SQS queue to publish to (supports templatization)."
    },
    "delaySeconds": {
      "type": "integer",
      "minimum": 0,
      "maximum": 900,
      "description": "Number of seconds to delay message delivery (Standard queues only)."
    },
    "messageAttributes": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "Custom message attributes to attach to each message."
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
      "description": "AWS region where the SQS queue is deployed."
    }
  },
  "required": [
    "queueType",
    "queueUrlPattern",
    "delaySeconds",
    "messageAttributes",
    "accessKeyId",
    "secretAccessKey",
    "region"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点通过将 AWS SQS 响应信息添加到出站消息 metadata 来转换入站消息，同时保留原始消息 data。

### Success case（成功时）

消息成功发布到 SQS 时，以下字段会添加到出站消息 metadata：

- `messageId` – Unique identifier assigned by AWS SQS to the message. This ID can be used to track and identify the message.
- `requestId` – Unique identifier for the API request to AWS. Useful for troubleshooting.
- `messageBodyMd5` – MD5 hash of the message data. Can be used to verify message integrity.
- `messageAttributesMd5` – MD5 hash of the message attributes. Present only if message attributes were included in the request.
- `sequenceNumber` – Large, non-consecutive number assigned to each message. Present only for FIFO queues.

**Example:**

Original message metadata:

```json
{
  "deviceType": "sensor"
}
```

After successful publish to a FIFO queue, metadata becomes:

```json
{
  "deviceType": "sensor",
  "messageId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "requestId": "12345678-1234-1234-1234-123456789012",
  "messageBodyMd5": "5d41402abc4b2a76b9719d911017c592",
  "messageAttributesMd5": "3e5f0e8c3f3d0c5f6a7b8c9d0e1f2a3b",
  "sequenceNumber": "18849450012345678901234567890"
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

After a failure (e.g., queue not found), metadata becomes:

```json
{
  "deviceType": "sensor",
  "error": "class com.amazonaws.services.sqs.model.QueueDoesNotExistException: The specified queue does not exist"
}
```

The message data remains unchanged.

## Message acknowledgement behavior

The node's message acknowledgement behavior is controlled by the `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` environment variable:

- **When set to `true`** – The incoming message is acknowledged and marked as successfully processed immediately upon receipt. A new message is created with the updated metadata
  and is enqueued for processing by the next node.
- **When set to `false`** (default) – The incoming message remains in an in-processing state throughout the entire SQS publish operation. The message is transformed in place, its
  metadata is updated with the SQS response fields, and the modified message is passed to the next node after the publish completes.

## 消息处理算法

1. 节点构建 SQS 发送消息请求：
    - The **queue URL pattern** is processed, replacing templates with values from the incoming message data and metadata.
    - A `SendMessageRequest` is created with the message data as the message body and the resolved queue URL as the destination.
    - **Message attributes** are processed: each attribute name and value is evaluated for templates and added to the request with data type "String".
2. For **FIFO queues**, the node sets the message deduplication ID and message group ID as described in the FIFO queue behavior section.
3. For **Standard queues**, the node sets the delay seconds to the configured value.
4. The send message request is executed asynchronously with the configured timeouts:
    - **Connection timeout** (10 seconds) applies to establishing the connection to AWS SQS.
    - **Request timeout** (5 seconds) applies to waiting for the SQS service to accept the message and return a response.
5. When SQS responds successfully:
    - SQS response metadata is added to the outgoing message metadata.
    - The resulting message is forwarded via the `Success` connection.
6. If an error occurs during publishing:
    - Error details are added to the outgoing message metadata under the `error` key.
    - The message is forwarded via the `Failure` connection.

## 输出连接

- **Success**
    - The message was successfully published to the SQS queue.
    - SQS response metadata is included in the outgoing message metadata.
- **Failure**
    - **Timeout**: Failed to establish a connection to AWS SQS or the SQS service did not respond within the configured timeout periods (10 seconds for connection, 5 seconds for
      request).
    - **SQS error**: The AWS SQS service returned an error, such as invalid credentials, insufficient permissions, non-existent queue, or invalid queue URL format.
    - **Unexpected error**: An unexpected error occurred during message processing.

## 示例

### 示例 1 — 向 Standard 队列发送基本消息

将带自定义属性和延迟的 telemetry 消息发布到 Standard SQS 队列。

**入站消息**

Data：

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

**节点配置**

```json
{
  "queueType": "STANDARD",
  "queueUrlPattern": "https://sqs.us-east-1.amazonaws.com/123456789012/telemetry-queue",
  "delaySeconds": 30,
  "messageAttributes": {
    "deviceType": "${deviceType}",
    "deviceName": "${deviceName}"
  },
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
  "requestId": "12345678-1234-1234-1234-123456789012",
  "messageBodyMd5": "5d41402abc4b2a76b9719d911017c592",
  "messageAttributesMd5": "3e5f0e8c3f3d0c5f6a7b8c9d0e1f2a3b"
}
```

Routed via the `Success` connection.

**结果**

telemetry 数据已成功发布到带自定义属性的 SQS Standard 队列。消息将在 30 秒延迟后可供处理。

### 示例 2 — 带消息顺序的 FIFO 队列

Publish an alarm message to a FIFO queue, ensuring message ordering and exactly-once processing per device.

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
    "summary": "The temperature has persistently exceeded 85 °C for at least 10 minutes."
  }
}
```

**节点配置**

```json
{
  "queueType": "FIFO",
  "queueUrlPattern": "https://sqs.us-east-1.amazonaws.com/123456789012/alarms-queue.fifo",
  "delaySeconds": 0,
  "messageAttributes": {
    "tenantId": "$[tenantId.id]"
  },
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
  "requestId": "12345678-1234-1234-1234-123456789012",
  "messageBodyMd5": "5d41402abc4b2a76b9719d911017c592",
  "messageAttributesMd5": "3e5f0e8c3f3d0c5f6a7b8c9d0e1f2a3b",
  "sequenceNumber": "18849450012345678901234567890"
}
```

Routed via the `Success` connection.

**结果**

alarm 已成功发布到 FIFO 队列。同一设备（originator）的 alarm 保证消息顺序，消息去重 ID 防止重复处理。

### 示例 3 — 动态队列选择

Publish messages to different queues based on alarm severity using templates.

**Incoming message**

Data:

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "cf4a2b30-8848-511f-9d12-68g62930dfed"
  },
  "type": "HighTemperature",
  "severity": "CRITICAL",
  "status": "ACTIVE_UNACK"
}
```

Metadata:

```json
{
  "queueRegion": "us-west-2"
}
```

**节点配置**

```json
{
  "queueType": "STANDARD",
  "queueUrlPattern": "https://sqs.${queueRegion}.amazonaws.com/123456789012/alarms-$[severity]",
  "delaySeconds": 0,
  "messageAttributes": {},
  "accessKeyId": "AKIAIOSFODNN7EXAMPLE",
  "secretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
  "region": "us-west-2"
}
```

**出站消息**

Data：未更改。

Metadata（仅显示新增字段）：

```json
{
  "messageId": "c2d3e4f5-g6h7-8901-bcde-fg2345678901",
  "requestId": "23456789-2345-2345-2345-234567890123",
  "messageBodyMd5": "6e52502bcd5c5d6c8a8c0d1e2f3a4b5c"
}
```

Routed via the `Success` connection.

**结果**

消息根据严重程度和区域动态路由到 `https://sqs.us-west-2.amazonaws.com/123456789012/alarms-CRITICAL`。

### 示例 4 — 无效队列的错误处理

Attempt to publish to a non-existent SQS queue, resulting in a failure.

**Incoming message**

Data:

```json
{
  "temperature": 25.5,
  "humidity": 60.2
}
```

**节点配置**

```json
{
  "queueType": "STANDARD",
  "queueUrlPattern": "https://sqs.us-east-1.amazonaws.com/123456789012/non-existent-queue",
  "delaySeconds": 0,
  "messageAttributes": {},
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
  "error": "class com.amazonaws.services.sqs.model.QueueDoesNotExistException: The specified queue does not exist"
}
```

Routed via the `Failure` connection.

**结果**

SQS 发布操作失败，因为指定的队列不存在。错误详情已记录到消息 metadata 并经 `Failure` 连接路由。
