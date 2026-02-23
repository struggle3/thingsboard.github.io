
* TOC
{:toc}

TBMQ MQTT 集成支持将消息转发至**外部 MQTT 代理**，实现与第三方平台的实时数据投递。适用于以下场景：

- 需将 TBMQ 数据**转发**至外部 MQTT 代理或IoT平台。
- 将 TBMQ 用作**内部源与外部基于 MQTT 的系统**之间的路由中间层。

## 数据流概述

MQTT 集成按以下步骤处理消息并转发至外部 MQTT 代理或系统：

1. **设备（客户端）发布 MQTT 消息**到匹配集成**主题过滤器**的主题。
2. **TBMQ 代理接收消息**并转发至 TBMQ Integration Executor。
3. **TBMQ Integration Executor 处理消息**，按需格式化并转发至外部 MQTT 代理或系统。
4. **外部系统接收消息**并按需处理数据。

![image](/images/mqtt-broker/integrations/tbmq-mqtt-integration.png)

## 前置条件

设置集成前，请确保：

- 有正在运行的 **[TBMQ](/docs/{{docsPrefix}}mqtt-broker/install/installation-options/) 实例**。
- 有可发布 MQTT 消息的客户端（如 **TBMQ WebSocket Client**）。
- 有可接收 MQTT 消息的客户端（如 **TBMQ WebSocket Client**）。

## 创建 TBMQ MQTT 集成

1. 进入**集成**页面，点击 **"+"** 创建新集成。
2. 选择 **MQTT** 作为集成类型，点击**下一步**。
3. 在**主题过滤器**中订阅主题 `tbmq/mqtt-integration`，点击**下一步**。
4. 在**配置**步骤：
   * 输入 **Host**（`localhost`）；
   * 输入 **Port**（`1883`）；
   * 将“动态主题名”设为 `false`，“主题名”设为 `sensors/mqtt-integration`；
   * 将“凭证”类型设为 `Basic`，“用户名”设为 `tbmq_websockets_username`；
5. 点击**添加**保存集成。

{% include images-gallery.html imageCollection="add-mqtt-integration" %}

{% capture mqtt_integration_localhost_dynamic_topic %}
**Important: When configuring an integration to publish messages back to TBMQ, make sure to disable "Dynamic topic name" and ensure that the publish topic does not overlap with the integration's topic filter, to prevent creating an infinite message loop**.
{% endcapture %}
{% include templates/warn-banner.md content=mqtt_integration_localhost_dynamic_topic %}

> You can test the connectivity to the configured MQTT broker by using the 'Check connection' button. 
> This will create an MQTT client that attempts to connect to the broker and then immediately disconnects.

### Topic Filters

{% include templates/mqtt-broker/user-guide/integrations/topic-filters.md %}

### 配置

|**字段**|**描述**|
|:-|:-|-
| **仅发送消息负载** | 启用时，传入消息的负载按原样转发。禁用时，发送包含负载及其他属性的 JSON 对象。 |
| **Host** | MQTT 代理主机。 |
| **Port** | MQTT 代理端口。 |
| **Client ID** | Client identifier used for connecting to the external broker. |
| **Dynamic topic name** | If enabled, the message will be forwarded with the topic name from the incoming message. |
| **Topic name** | If **Dynamic topic name** is disabled, this Topic name is used to send message. |
| **Credentials** | Supported authentication options: |
| | **Anonymous** – No authentication. |
| | **Basic Authentication** – Uses `Username` and `Password` for authentication. |
| | **PEM-based authentication** – Uses PEM certificate to authenticate. |
| | **Enable SSL** – Enables a secure connection using SSL/TLS. |
| **Keep alive (seconds)** | Indicates the duration for which the broker and client can remain without communication before the session is closed. |
| **Connect timeout (seconds)** | Time to wait before a 'CONNACK' is received. |
| **Reconnect period (seconds)** | Defines how often TBMQ should attempt to reconnect if the connection is lost. |
| **Dynamic QoS** | If enabled, the message will be forwarded with QoS from the incoming message. |
| **QoS** | If **Dynamic QoS** is disabled, you can set the desired QoS. |
| **Dynamic retain** | If enabled, the message will be forwarded with the Retain flag from the incoming message. |
| **Retain** | If **Dynamic retain** is disabled, you can set the desired Retain as "true" or "false". |
| **Metadata** | Custom metadata that can be used for additional processing. |
|---

### Events

{% include templates/mqtt-broker/user-guide/integrations/events.md %}

## Sending an Uplink Message

To send a message, follow these steps:

1. Navigate to the **WebSocket Client** page.
2. Select 'WebSocket Default Connection' or any other available working connection, then click **Connect**. Make sure the 'Connection status' is shown as `Connected`.
3. Set the 'Topic' field to `tbmq/mqtt-integration` to match the Integration's 'Topic Filter'. 
4. Click the **Send** icon to publish the message. 
5. If successful, two new messages should appear in the 'Messages' table:

* One sent by the **WebSocket Client**.
* One received from the **MQTT Integration** with message payload similar to:
```json
{
   "payload": "eyJ0ZW1wZXJhdHVyZSI6MjV9",
   "topicName": "tbmq/mqtt-integration",
   "clientId": "tbmq_7QUvZzow",
   "eventType": "PUBLISH_MSG",
   "qos": 1,
   "retain": false,
   "tbmqIeNode": "tbmq_ie_node",
   "tbmqNode": "tbmq_node",
   "ts": 1742554969254,
   "props": {},
   "metadata": {
      "integrationName": "MQTT integration"
   }
}
```

Message description:

- **payload**: Base64-encoded content of the MQTT message (e.g., `"eyJ0ZW1wZXJhdHVyZSI6MjV9"` is a JSON object `{"temperature": 25}`).
- **topicName**: The MQTT topic to which the message was published.
- **clientId**: The ID of the MQTT client that published the message.
- **eventType**: Type of MQTT event, here it's a published message (the only supported type for now).
- **qos**: Quality of Service level used for the incoming message.
- **retain**: Indicates if the message is a retained MQTT message.
- **tbmqIeNode**: Node ID of the Integration Executor service that handled the message.
- **tbmqNode**: Node ID of the TBMQ broker that received the message.
- **ts**: Timestamp (in milliseconds) when the message was received.
- **props**: MQTT 5.0 user properties or other MQTT properties.
- **metadata**: Additional metadata added from integration configuration, e.g., the name of the integration that handled the message, added by default.

{% include images-gallery.html imageCollection="send-uplink-message" %}
