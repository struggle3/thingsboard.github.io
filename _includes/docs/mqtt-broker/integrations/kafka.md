
* TOC 
{:toc}

TBMQ Kafka 集成实现与 **Apache Kafka** 的无缝通信，使 TBMQ 能向外部 Kafka 集群**发布消息**。适用于以下场景：

- **流式 IoT 数据** – 将设备遥测、日志或事件转发至 Kafka 进行处理与存储。
- **事件驱动架构** – 向 Kafka 主题发布消息以进行实时分析与监控。
- **解耦系统通信** – 将 Kafka 作为 TBMQ 与下游应用之间的缓冲。

## 数据流概述

TBMQ Kafka 集成按以下步骤处理消息并转发至外部 Kafka 集群：

1. **设备（客户端）发布 MQTT 消息**到匹配集成**主题过滤器**的主题。
2. **TBMQ 代理接收消息**并转发至 TBMQ Integration Executor。
3. **TBMQ Integration Executor 处理消息**，按需格式化并发送至已配置的 **Kafka 主题**。
4. **Kafka 消费者**在下游系统中处理消息。

![image](/images/mqtt-broker/integrations/tbmq-kafka-integration.png)

## 前置条件

设置集成前，请确保：

- 有正在运行的 **[TBMQ](/docs/{{docsPrefix}}mqtt-broker/install/installation-options/) 实例**。
- 有可接收 Kafka 消息的外部服务（如 **Confluent Cloud**）。
- 有可发布 MQTT 消息的客户端（如 **TBMQ WebSocket Client**）。

## 创建 TBMQ Kafka 集成

1. Navigate to the **Integrations** page and click the **"+"** button to create a new integration.
2. Select **Kafka** as the integration type and click **Next**.
3. On the **Topic Filters** page click **Next** to subscribe to the default topic `tbmq/#`.

{% include images-gallery.html imageCollection="add-kafka-integration" %}

<ol start="4">
  <li>In the <strong>Configuration</strong> step enter the <strong>Bootstrap servers</strong> (Kafka broker addresses).</li>
</ol>
{% capture integrationTypes %}
Kafka<br><small>Common/Docker </small>%,%common%,%templates/mqtt-broker/user-guide/integrations/kafka/kafka-common-and-docker-integration%br%
Confluent Cloud<br><small>Cloud solution</small>%,%confluent%,%/templates/mqtt-broker/user-guide/integrations/kafka/kafka-confluent-integration{% endcapture %}
{% include content-toggle.liquid content-toggle-id="integrationTypes" toggle-spec=integrationTypes %}
<ol start="5">
  <li>Click <strong>Add</strong> to save the integration.</li>
</ol>

> You can test the connectivity to the configured Kafka brokers by using the 'Check connection' button. 
> This action creates an admin client that connects to the Kafka cluster and verifies whether the specified topic exists on the target brokers.
> Even if the topic is missing, you can still proceed with creating the integration. 
> If the Kafka cluster has `auto.create.topics.enable` set to `true`, the topic will be automatically created when the first message is published.

### Topic Filters

{% include templates/mqtt-broker/user-guide/integrations/topic-filters.md %}

### 配置

|**字段**|**描述**|
|:-|:-|-
| **仅发送消息负载** | 启用时，仅转发原始消息负载。禁用时，TBMQ 将负载包装为包含额外元数据的 JSON 对象。 |
| **Bootstrap servers** | Kafka 代理地址（逗号分隔的主机名/IP 和端口列表）。 |
| **Topic** | 发布消息的 Kafka 主题。 |
| **Key** | （可选）用于消息分区。若指定，Kafka 根据 key 哈希将消息分配至同一分区。 |
| **Client ID prefix** | （可选）定义 Kafka 客户端 ID 前缀。未设置时使用默认 `tbmq-ie-kafka-producer`。 |
| **Automatically retry times if fails** | 标记消息为失败前的重试次数。 |
| **Produces batch size in bytes** | 发送至 Kafka 前的最大批次大小（字节）。 |
| **Time to buffer locally (ms)** | 本地缓冲消息的毫秒数。 |
| **Client buffer max size in bytes** | 发送至 Kafka 前用于缓冲消息的最大内存（字节）。 |
| **Number of acknowledgments** | 指定 Kafka 确认模式：`all`、`1`、`0`。 |
| **Compression** | 定义消息压缩算法：`none`、`gzip`、`snappy`、`lz4`、`zstd`。 |
| **Other properties** | 用于 Kafka producer 额外配置的键值对集合。 |
| **Kafka headers** | 添加到 Kafka 消息的自定义头。 |
| **Metadata** | 用于处理与追踪的自定义元数据。 |
|---

### Events

{% include templates/mqtt-broker/user-guide/integrations/events.md %}

## Sending an Uplink Message

To send a message, follow these steps:

1. Navigate to the **WebSocket Client** page.
2. Select 'WebSocket Default Connection' or any other available working connection, then click **Connect**. Make sure the 'Connection status' is shown as `Connected`.
3. Set the 'Topic' field to `tbmq/kafka-integration` to match the Integration's 'Topic Filter' `tbmq/#`.
4. Click the **Send** icon to publish the message.
5. If successful, the message should be available in your Kafka service under the topic `tbmq.messages`.

{% include images-gallery.html imageCollection="send-uplink-message-kafka" %}
