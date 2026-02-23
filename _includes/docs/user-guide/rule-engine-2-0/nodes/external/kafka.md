向 [Apache Kafka](https://kafka.apache.org/){:target="_blank"} 主题发布消息，入站消息 data 作为 record value 发送。

## 配置

### Topic and key configuration（主题与 key 配置）

定义目标 Kafka 主题及可选的分区 key 以路由消息。

- **Topic pattern** — 发布消息的 Kafka 主题名称。支持 [templates](/docs/{{docsPrefix}}user-guide/templatization/)。
- **Key pattern** — 用于决定消息写入分区的 partition key。支持模板。若无需特定分区，可留空。

### Producer configuration（Producer 配置）

配置 Kafka producer 的消息投递、批处理和可靠性行为。

- **Automatically retry times if fails** — record 发送失败时 Kafka producer 的重试次数（`retries`）。producer 会重试因临时错误失败的 record。设为 `0` 禁用重试。

- **Produces batch size in bytes** — Kafka producer 的 batch 大小（`batch.size`）。向同一分区发送多条 record 时，producer 会尝试合并为更少的请求以提高吞吐量。batch 大小为 `0` 时禁用批处理。

- **Time to buffer locally (ms)** — Kafka producer 的 linger 时间（`linger.ms`）。producer 在发送 batch 前等待以积累更多 record 的时间。设大于 `0` 会增加延迟，但有助于批处理。

- **Client buffer max size in bytes** — Kafka producer 的 buffer 内存（`buffer.memory`）。producer 可用于缓冲待发送 record 的总字节数。

- **Number of acknowledgments** — producer 认为请求完成前 broker 需收到的确认数（`acks`）。
  可用选项：
    - **-1 (all)** — producer 等待所有 in-sync 副本确认 record。持久性最强，但延迟最高。
    - **0** — producer 不等待 broker 确认。broker 故障时可能丢消息，但延迟最低。
    - **1** — producer 等待 leader 将 record 写入本地 log，但不等待 follower 的完整确认。在持久性和延迟之间取得平衡。

### Connection configuration（连接配置）

配置与 Kafka 集群的连接。

- **Bootstrap servers** — Kafka broker 地址列表，逗号分隔，格式为 `host:port`。producer 使用这些地址建立与集群的连接。

### Advanced settings（高级设置）

配置额外 Kafka producer 属性、消息头和字符编码。

- **Other properties** — 高级 Kafka producer 配置的自定义键值对。这些属性直接传递给 Kafka producer 客户端。常见用途包括 SSL/TLS 配置（如 `ssl.keystore.location`、`ssl.truststore.location`）。

- **Add Message metadata key-value pairs to Kafka record headers** — 启用时，所有消息 metadata 键值对会以 `tb_msg_md_` 为前缀添加到 Kafka record headers。

- **Charset encoding** — 将消息 metadata 值转换为 Kafka headers 的字节数组时使用的字符编码。仅当启用 **Add Message metadata key-value pairs to Kafka record headers** 时生效。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbKafkaNodeConfiguration",
  "type": "object",
  "properties": {
    "topicPattern": {
      "type": "string",
      "description": "Name of the Kafka topic (supports templatization)."
    },
    "keyPattern": {
      "type": [
        "string",
        "null"
      ],
      "description": "Partition key for message routing (supports templatization)."
    },
    "bootstrapServers": {
      "type": "string",
      "minLength": 1,
      "description": "Comma-separated list of Kafka broker addresses (host:port)."
    },
    "retries": {
      "type": "integer",
      "minimum": 0,
      "description": "Number of retries if record send fails."
    },
    "batchSize": {
      "type": "integer",
      "minimum": 0,
      "description": "Producer batch size in bytes."
    },
    "linger": {
      "type": "integer",
      "minimum": 0,
      "description": "Time to buffer records locally in milliseconds."
    },
    "bufferMemory": {
      "type": "integer",
      "minimum": 0,
      "description": "Total bytes of memory for buffering records."
    },
    "acks": {
      "type": "string",
      "enum": [
        "-1",
        "0",
        "1",
        "all"
      ],
      "description": "Number of acknowledgments required from broker."
    },
    "otherProperties": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "Additional Kafka producer properties as key-value pairs."
    },
    "addMetadataKeyValuesAsKafkaHeaders": {
      "type": "boolean",
      "description": "Add message metadata as Kafka record headers."
    },
    "kafkaHeadersCharset": {
      "type": "string",
      "description": "Character encoding for metadata values in headers."
    }
  },
  "required": [
    "topicPattern",
    "bootstrapServers"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

无论成功或失败，节点均保留原始消息 data。Metadata 会更新为 Kafka 相关信息或错误详情。

### Success case（成功时）

消息成功发布到 Kafka 时，以下字段会添加到出站消息 metadata：

- `offset` — record 在 Kafka 分区中的 offset，表示 record 在分区 log 中的位置。
- `partition` — 存储 record 的分区号。
- `topic` — 发布 record 的主题名。

原始消息 data 保持不变。

**示例：**

原始消息 metadata：

```json
{
  "deviceType": "sensor",
  "deviceName": "Sensor-001"
}
```

成功发布后（例如到主题 "telemetry" 的分区 2、offset 12345），metadata 变为：

```json
{
  "deviceType": "sensor",
  "deviceName": "Sensor-001",
  "offset": "12345",
  "partition": "2",
  "topic": "telemetry"
}
```

### Failure case（失败时）

发布失败时，在出站消息 metadata 中添加以下字段：

- `error` — 以 `class <ExceptionClass>: <error message>` 格式包含异常类名和错误信息

**示例：**

原始消息 metadata：

```json
{
  "deviceType": "sensor"
}
```

失败后（如连接超时），metadata 变为：

```json
{
  "deviceType": "sensor",
  "error": "class org.apache.kafka.common.errors.TimeoutException: Expiring 1 record(s) for telemetry-0: 30000 ms has passed since batch creation"
}
```

消息 data 保持不变。

## 消息确认行为

节点的消息确认行为由环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 控制：

- **设为 `true`** — 入站消息在接收后立即被确认并标记为已成功处理。创建包含更新 metadata 的新消息并加入队列供下一节点处理。
- **设为 `false`**（默认）— 入站消息在整个 Kafka 发布操作期间保持处理中状态。消息就地转换，发布完成后更新 metadata，修改后的消息传递至下一节点。

## 消息处理算法

1. The node constructs a Kafka producer record:
    - If the **topic pattern** is configured, templates are resolved using values from the incoming message data and metadata to determine the target topic.
    - If the **key pattern** is configured, templates are resolved using values from the incoming message data and metadata to determine the partition key. If empty, no key is
      specified.
    - If **Add Message metadata key-value pairs to Kafka record headers** is enabled, all metadata entries are added as headers with the prefix `tb_msg_md_`, encoded using the
      specified charset.
2. The message data is used as the record value (sent as a UTF-8 string).
3. The publish operation is executed asynchronously using the Kafka producer:
    - The record is sent to the specified topic with the resolved key (if provided).
    - The Kafka client determines the partition based on the key (if provided) or uses default distribution.
4. When the Kafka broker acknowledges the record successfully:
    - The offset, partition, and topic are added to the message metadata.
    - The resulting message is forwarded via the `Success` connection.
5. If an error occurs during publishing:
    - Error details are added to the outgoing message metadata under the `error` key.
    - The message is forwarded via the `Failure` connection.

## 输出连接

- **Success**
    - 消息已成功发布到 Kafka。
    - 消息 metadata 包含 `offset`、`partition` 和 `topic` 字段。
- **Failure**
    - **Publishing error**：Kafka broker 拒绝消息、主题不存在或 producer 超时。
    - **Initialization error**：Kafka producer 初始化失败（如配置无效、SSL 证书问题）。
    - **Unexpected error**：消息处理过程中发生意外错误。

## 示例

### 示例 1 — 基本 telemetry 发布

将 telemetry 数据发布到专用 telemetry 主题，不指定 partition key。

**入站消息**

Data：

```json
{
  "temperature": 25.5,
  "humidity": 60.2
}
```

Metadata：

```json
{
  "deviceType": "TH-Sensor",
  "deviceName": "Sensor-001"
}
```

**节点配置**

```json
{
  "topicPattern": "telemetry",
  "keyPattern": "",
  "bootstrapServers": "kafka.example.com:9092",
  "retries": 3,
  "batchSize": 16384,
  "linger": 10,
  "bufferMemory": 33554432,
  "acks": "-1",
  "otherProperties": {},
  "addMetadataKeyValuesAsKafkaHeaders": false,
  "kafkaHeadersCharset": "UTF-8"
}
```

**出站消息**

Data：未更改。

Metadata：

```json
{
  "deviceType": "TH-Sensor",
  "deviceName": "Sensor-001",
  "offset": "12345",
  "partition": "2",
  "topic": "telemetry"
}
```

经 `Success` 连接路由。

**结果**

telemetry 数据已成功发布到 "telemetry" 主题。Kafka broker 将 record 分配到分区 2、offset 12345。因未指定 key，Kafka 客户端使用默认分区分布。producer 等待所有 in-sync 副本确认 record（acks=-1），确保持久性。
