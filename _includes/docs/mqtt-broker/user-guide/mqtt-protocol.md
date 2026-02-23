
* TOC
{:toc}

## MQTT 简介

在讨论 IoT 与实时通信时，首要问题之一便是：
<a href="/products/mqtt-broker/" target="_blank" style="color: inherit; text-decoration: none;">什么是 MQTT？</a>

MQTT 是一种为受限设备及低带宽、高延迟或不可靠网络设计的轻量级消息协议。
它采用发布/订阅消息模型，使设备能在资源受限的环境中高效通信，
如 IoT（物联网）系统、移动应用和嵌入式系统。
MQTT 以简洁为目标，保证最小开销，便于从微型传感器到大型工业系统等各种设备的实现。

### MQTT 协议格式

MQTT 协议旨在最小化数据传输开销。消息由固定头、可选可变头和负载组成。
格式如下：

1. **固定头(Fixed Header)**：
   - 存在于每条 MQTT 消息中，由控制字节和标志组成。
   - 表明消息类型（如 CONNECT、PUBLISH、SUBSCRIBE）及具体控制信息。

2. **可变头(Variable Header)**：
   - 根据消息类型包含附加信息。
   - 例如报文标识符或特定消息中的主题名。

3. **负载(Payload)**：
   - 承载实际应用数据或消息内容。
   - 对发布消息而言为传输的数据；对订阅消息而言为主题过滤器。

固定头与可变头的简单格式使 MQTT 能保持消息体积小并优化网络使用。

### 与其他协议对比

相比广泛使用的消息与通信协议，MQTT 以简洁及对低带宽环境的专注见长。简要对比如下：

- **MQTT vs HTTP**：
   - **HTTP** 是常用于 Web 应用的请求/响应协议。需要更高带宽和更多开销，对资源受限设备不太适合。HTTP 为无状态，即客户端每次请求都须包含全部必要信息，增加数据负载。
   - **MQTT** 在持久连接上工作，在客户端与 broker 间维持轻量、有状态的会话，支持以最小开销进行持续数据交换，适合低功耗与带宽消耗优先的 IoT 应用。

- **MQTT vs CoAP（受限应用协议）**：
   - **CoAP** 是另一为受限设备设计的协议。与 HTTP 类似，基于 UDP 采用请求/响应模型，但为 IoT 减少了开销。
   - **MQTT** 则使用 TCP 保证可靠投递，支持发布/订阅模型，更适合设备需收发消息而无需发送方与接收方直接通信的场景。

- **MQTT vs AMQP（高级消息队列协议）**：
   - **AMQP** 功能更丰富，支持复杂消息模式，常用于企业消息系统。
   - **MQTT** 侧重简洁与最小开销，**AMQP** 在消息保证（如消息队列、路由）上提供更多控制，但复杂度和资源需求更高。

简言之，MQTT 在简洁、低带宽与能效关键的场景中优势明显，
而 HTTP、CoAP、AMQP 等协议更适合需要更丰富特性、更复杂通信模式或更高网络带宽的应用。

### MQTT 协议的用途

MQTT 的主要目标是在设备间提供灵活高效的数据传输，尤其适用于：
- **低带宽**受限的环境。
- **功耗**需尽可能降低。
- **网络可靠性**不稳定。

通过小消息体积和轻量通信，MQTT 使处理能力和内存受限的设备也能参与数据交换。
在 IoT 应用中尤其流行，使设备能以最小开销相互通信、与云平台或数据处理系统通信。

MQTT 的典型用例包括：
- **智能家居自动化**（照明、HVAC、安防系统）。
- **可穿戴设备**（健身追踪、健康监测）。
- **车联网**（车辆遥测、车队管理）。
- **工业监控与控制**（工厂设备传感器）。

### 核心原则

MQTT 基于以下核心原则工作：

1. **发布/订阅模型**：
    - **发布者**向特定主题发送消息，无需知道接收者（订阅者）是谁。
    - **订阅者**对特定主题表示兴趣，仅接收与其订阅匹配的消息。
该模型解耦了消息生产者与消费者，支持更可扩展、更灵活的通信模式。

2. **基于 broker 的通信**：
    - MQTT broker 作为中心中介，在发布者与订阅者之间路由消息。
    - broker 负责管理连接、分发消息，并根据请求的服务质量(QoS)级别确保可靠投递。
    - 多个客户端可对同一主题发布和订阅，broker 确保消息投递给所有 相关订阅者。

## MQTT 架构

MQTT 协议的核心是简洁而强大的架构，实现设备间可扩展、高效的通信。
架构基于三大组件：Client、Broker 和 Topic，各自在保障消息投递与通信顺畅中发挥不同作用。

1. **Client（客户端）**：
    - 在 MQTT 中，**client** 可以是参与通信的任何设备或系统。它可**发布**数据或**订阅**以接收数据。客户端多为传感器、移动设备或嵌入式系统等受限设备。
    - **Publisher（发布者）**：向特定**主题**发送或「发布」消息的客户端。
    - **Subscriber（订阅者）**：监听或「订阅」感兴趣主题以接收已发布数据的客户端。
    - 客户端无需相互了解，仅与 **broker** 交互。使 MQTT 可扩展且高效，尤其在设备数量显著增长时。

2. **Broker**：
    - **broker** 作为中心服务器，负责在客户端间路由消息。保证由某客户端发布的消息送达所有订阅相关主题的客户端。
    - broker 还管理客户端连接，根据指定 **QoS**（服务质量）处理消息投递，并可为离线客户端持久化消息。
    - broker 解耦发布者与订阅者，使二者可独立运行，从而构建更可扩展的系统，客户端无需直接了解彼此。

3. **Topic（主题）**：
    - **topic** 本质上是传输数据的通道。发布者向特定主题发送消息，broker 将该消息投递给该主题的所有订阅者。
    - 主题以层级结构组织，订阅者可监听特定主题或使用通配符(`+`、`#`)一次订阅多个主题。
    - 示例：主题可为 `/home/livingroom/temperature`，客户端在此发布温度数据，该主题的任意订阅者都会收到该数据。

## MQTT message flow

In MQTT, messages are exchanged using the **publish/subscribe** pattern, which decouples message producers (publishers) from consumers (subscribers). This allows for flexible, scalable communication across numerous devices. The key to this flow is the **broker**, which handles routing messages between publishers and subscribers.

1. **How Messages Are Exchanged:**
    - **Publishers** send messages to specific **topics** on the broker, which acts as the central message handler.
    - **Subscribers** express interest in certain topics by subscribing to them. When a message is published to a topic, all clients subscribed to that topic will receive the message via the broker.
    - The system allows multiple publishers and subscribers to operate independently, simplifying communication management and enabling robust, many-to-many communication patterns.

2. **Description of Message Types:**
   MQTT defines several packet types, also known as **Control Packets**, that govern communication between clients and the broker:

### CONNECT

- **Purpose:** Establishes a connection between the client and the broker.
- **Packet Format:**
    - **Fixed Header:** Includes packet type and flags.
    - **Variable Header:** Contains important connection information such as protocol name, protocol level, clean session flag, and more.
    - **Payload:** Contains client-specific data such as the `clientId`, `username`, `password`, and optionally the Will topic and message.
- **Description:**
    - Sent by the client to request a connection to the broker.
    - Includes authentication details (username, password) and connection options (keep-alive time, clean session).
    - May include the Last Will and Testament (LWT) to notify other clients if the client disconnects unexpectedly.

### CONNACK

- **Purpose:** Acknowledges a client's connection request.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains a `return code` indicating whether the connection was successful or not.
- **Description:**
    - Sent by the broker in response to a CONNECT packet.
    - Indicates whether the connection was accepted or rejected (e.g., due to authentication failure).

### PUBLISH

- **Purpose:** Delivers an application message from a publisher to the broker (and eventually to subscribers).
- **Packet Format:**
    - **Fixed Header:** Packet type, DUP flag (for duplicate messages), QoS level, Retain flag.
    - **Variable Header:** Contains the topic name and, in case of QoS levels 1 or 2, the packet identifier.
    - **Payload:** Contains the actual message to be delivered.
- **Description:**
    - The PUBLISH packet is sent by the publisher to the broker and contains the message being sent to the subscribed clients.
    - Includes the QoS level to define how the message is delivered and whether acknowledgments are required.
    - The message can be marked as retained, so future subscribers receive it upon subscription.

### PUBACK

- **Purpose:** Acknowledges receipt of a PUBLISH packet when QoS 1 is used.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier corresponding to the original PUBLISH packet.
- **Description:**
    - Sent by the subscriber or broker to acknowledge a QoS 1 message received from the publisher.
    - Ensures the message is delivered exactly once when using QoS 1.

### PUBREC

- **Purpose:** Acknowledges the receipt of a PUBLISH packet when QoS 2 is used.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier of the PUBLISH packet.
- **Description:**
    - The first step in ensuring that a QoS 2 message is delivered exactly once.
    - Sent by the subscriber or broker after receiving a QoS 2 PUBLISH message to begin the handshake process.

### PUBREL

- **Purpose:** Confirms the receipt of a PUBREC packet in QoS 2 communication.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier of the PUBREC packet.
- **Description:**
    - Sent by the publisher after receiving a PUBREC, indicating that the publisher is ready to complete the message delivery.
    - Part of the handshake in QoS 2 communication.

### PUBCOMP

- **Purpose:** Acknowledges the completion of a QoS 2 message delivery.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier.
- **Description:**
    - Sent by the subscriber to confirm that a QoS 2 message has been completely processed.
    - This concludes the four-step handshake for QoS 2 delivery.

### SUBSCRIBE

- **Purpose:** Subscribes a client to one or more topics.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier.
    - **Payload:** Contains a list of topic filters and their associated QoS levels.
- **Description:**
    - Sent by a client to the broker to subscribe to specific topics.
    - Each topic can be associated with a different QoS level, depending on how the client wants to receive messages.

### SUBACK

- **Purpose:** Acknowledges a SUBSCRIBE packet.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier from the SUBSCRIBE packet.
    - **Payload:** Contains a list of return codes indicating the success or failure of the subscription for each topic.
- **Description:**
    - Sent by the broker to confirm or deny the client's subscription to each requested topic.

### UNSUBSCRIBE

- **Purpose:** Unsubscribes a client from one or more topics.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier.
    - **Payload:** Contains a list of topics to unsubscribe from.
- **Description:**
    - Sent by a client to the broker to remove its subscription to specific topics.

### UNSUBACK

- **Purpose:** Acknowledges an UNSUBSCRIBE packet.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains the packet identifier from the UNSUBSCRIBE packet.
- **Description:**
    - Sent by the broker to confirm that the client has been unsubscribed from the specified topics.

### PINGREQ

- **Purpose:** Sent by the client to check if the broker is still available.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags (this packet does not have a variable header or payload).
- **Description:**
    - Sent periodically by the client if it doesn't have any data to send but needs to maintain the connection with the broker.
    - This is used to ensure the connection is still alive, especially when long periods of inactivity are expected.

### PINGRESP

- **Purpose:** Acknowledges a PINGREQ packet.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags (this packet does not have a variable header or payload).
- **Description:**
    - Sent by the broker to confirm that it is still connected to the client after receiving a PINGREQ packet.

### DISCONNECT

- **Purpose:** Sent by the client to cleanly disconnect from the broker and optionally provide a reason for the disconnection.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header** (MQTT 5.0 only): Contains an optional `Reason Code` (e.g., normal disconnection, session expiry) and optional `Session Expiry Interval` or `User Properties`.
- **Description:**
    - The client sends this to indicate it is disconnecting intentionally, allowing the broker to clear the session state if needed.

### AUTH

- **Purpose:** Used for authentication during an MQTT session, specifically in MQTT 5.0, to continue or complete the authentication process after the initial connection.
- **Packet Format:**
    - **Fixed Header:** Packet type and flags.
    - **Variable Header:** Contains `Auth Method` and `Auth Data`, as well as an optional `Reason Code` and `User Properties`.
    - **Payload:** The content of the `Auth Data`, which depends on the authentication method being used (e.g., SASL mechanisms, OAuth tokens).

- **Description:**
    - The **AUTH** packet is introduced in MQTT 5.0 to support enhanced authentication flows. It allows for complex authentication methods that require multiple exchanges between the client and the broker.
    - After a CONNECT packet, if the broker requires additional authentication steps, it may send an AUTH packet, and the client can respond with another AUTH packet until the authentication process is complete.
    - This mechanism allows for more secure, pluggable authentication mechanisms compared to previous MQTT versions.

## Quality of Service (QoS) levels

MQTT defines three **Quality of Service (QoS)** levels that control message delivery reliability between the client and broker:

- **QoS 0 (At most once):** The message is delivered at most once, without acknowledgment. It’s also known as "fire and forget." There is no guarantee of delivery.
- **QoS 1 (At least once):** The message is guaranteed to be delivered at least once, but it may be delivered multiple times if acknowledgments are lost.
- **QoS 2 (Exactly once):** The message is guaranteed to be delivered exactly once, ensuring no duplicates in delivery through a four-step handshake process.

These levels provide flexibility based on the reliability requirements of the application.

## Session management

Session management in MQTT defines how the broker maintains the state of the client’s connection over time. It impacts message delivery, subscriptions, and other session data.

- **Persistent Session:**
    - The broker stores session information, such as subscriptions and undelivered messages, even when the client disconnects. When the client reconnects, it can resume where it left off, receiving any messages it missed while offline.

- **Clean Session:**
    - With a clean session, all session data (subscriptions, undelivered messages) is cleared when the client disconnects. When the client reconnects, it starts fresh, with no history of its previous session.

### Reconnecting clients and message redelivery:

- When a client reconnects after a disconnect, the broker can redeliver any missed messages if a persistent session was used.
- If using QoS 1 or 2, the broker ensures that messages are redelivered until they are acknowledged by the client, ensuring message reliability.

This session flexibility allows clients to maintain continuous operation, even with intermittent connectivity.

## MQTT protocol versions

### Differences between MQTT 3.1.1 and MQTT 5.0:

- **MQTT 3.1.1:** This version is widely adopted and provides core functionalities like the publish/subscribe model, QoS levels, and simple session management. It is known for its lightweight nature and ease of implementation.
- **MQTT 5.0:** Introduced more advanced features to enhance scalability, flexibility, and control, building on the foundation of MQTT 3.1.1.

### New features in MQTT 5.0:

1. **Reason Codes:**
   Provides detailed feedback for both successful operations and errors, enabling better diagnostics and error handling between clients and brokers.

2. **User Properties:**
   Allows clients and brokers to attach custom key-value pairs to MQTT packets, giving more flexibility for transmitting metadata or application-specific information.

3. **Session Expiry:**
   Clients can specify how long their session data (such as subscriptions or undelivered messages) should be retained by the broker after disconnecting, offering better control over session persistence.

4. **Message Expiry Interval:**
   Messages can have an expiration time, allowing brokers to discard undelivered messages that exceed this timeframe, preventing outdated messages from being delivered.

5. **Shared Subscriptions:**
   Allows multiple clients to share the load of receiving messages from the same topic, which is useful for load balancing in high-traffic environments.

6. **Topic Alias:**
   Reduces message size by allowing clients to replace frequently used topic names with aliases, optimizing performance in bandwidth-constrained networks.

7. **Enhanced Authentication (AUTH Packet):**
   Adds support for more complex, multi-step authentication mechanisms, making it easier to integrate advanced security protocols like OAuth.

8. **Flow Control:**
   Introduces the ability for clients to control the rate at which messages are sent to them, preventing message flooding and managing traffic more effectively.

9. **Request-Response Pattern:**
   Facilitates asynchronous communication by enabling clients to send a request and receive a response on a different topic, improving interaction between devices.

10. **Payload Format Indicator and Content Type:**
    Enables clients to indicate the format of the payload (e.g., JSON, XML) and specify the content type, which enhances the interpretation and parsing of message data.

11. **Subscription Options:**
    Provides clients with additional controls over how they receive messages, allowing for more customized subscription behavior.
    Clients can enable features like **Retain As Published** (to receive messages with the original retain flag), **No Local** (to avoid receiving messages they themselves published), **Retain Handling** (to control whether retained messages should be delivered immediately upon subscribing), and **Maximum QoS** (to limit the QoS level for received messages).

12. **Subscription Identifier:**
    Allows the broker to assign a unique identifier to each subscription, which can then be included in the PUBLISH packet to help clients track which subscription a message corresponds to.

These features collectively enhance MQTT 5.0’s scalability, performance, security, and flexibility for complex use cases, especially in IoT and enterprise systems.

## Best practices

1. **Optimizing Performance:**
    - **Reducing latency:** To minimize latency, ensure that the broker and clients are running on optimized hardware and network infrastructure. Keep messages small and use appropriate **QoS levels** to balance reliability with performance. Avoid excessive use of retained messages and carefully manage topic hierarchies to prevent message flooding.
    - **Managing QoS:** Use the right **Quality of Service (QoS)** level based on the application’s needs. For most scenarios, **QoS 0** (fire-and-forget) provides the lowest latency but offers no guarantee of delivery. **QoS 1** and **QoS 2** provide delivery guarantees but introduce additional overhead, so use them only when necessary.

2. **Security Considerations:**
    - **Use of TLS/SSL:** Always use TLS/SSL to secure communication between clients and broker. This ensures that messages are encrypted, protecting against data interception and unauthorized access.
    - **Authentication:** Implement robust authentication mechanisms, such as username/password, certificates, or enhanced authentication methods like SCRAM in MQTT 5.0. This prevents unauthorized devices from connecting to the broker.
    - **Access Control:** Enforce access control at the broker level to limit what topics clients can publish to or subscribe to, reducing the risk of unauthorized data access.

3. **Scalability:**
    - **Horizontally scaling brokers:** To support large-scale systems with many clients, scale brokers horizontally by clustering them or using load balancers. Distribute client connections across multiple brokers to handle high traffic efficiently. Shared subscriptions can also help distribute the load across clients.
    - **Monitoring and metrics:** Use monitoring tools to track broker performance and health, and capture important metrics such as connection counts, message throughput, and system resource usage. This helps in identifying bottlenecks and planning for scaling.

