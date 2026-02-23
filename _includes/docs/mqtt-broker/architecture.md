* TOC
{:toc}

## 简介

本文介绍 TBMQ 的架构结构，说明数据在各组件间的流转及核心架构决策。
TBMQ 经精心设计，具备以下特性：

* **可扩展性**：采用先进开源技术构建的水平可扩展平台；
* **容错性**：无单点故障，集群内每个 broker（节点）在功能上相同；
* **健壮高效**：可管理数百万客户端，每秒处理数百万条消息；
* **持久性**：提供高消息持久性，确保数据不丢失。

### 架构图

下图展示 broker 的核心部分及消息传输路径。

![image](/images/mqtt-broker/architecture/tbmq-architecture.png)

## 设计动机

在 ThingsBoard，我们积累了丰富的可扩展 IoT 应用构建经验，从而识别出基于 MQTT 解决方案的三大主要场景。

* 第一种场景中，大量设备产生海量消息，由特定应用消费，形成 **扇入（fan-in）** 模式。 
通常由少数应用处理这些海量入站数据，必须确保不丢失任何一条消息。

* 第二种场景中，大量设备订阅需送达的特定更新或通知。
少量入站请求引发大量出站数据。
此场景称为 **扇出（广播，fan-out）** 模式。

* 第三种场景为 **点对点（P2P）** 通信，针对性强的一对一 messaging 模型。
适用于私信或命令-响应交互等用例，消息通过唯一定义的主题在单个发布者与特定订阅者之间路由。

> 在上述所有场景中，通常使用将服务质量（QoS）设为 1 或 2 的持久客户端，以确保可靠的消息投递，即便因重启或升级而暂时离线亦然。

基于上述场景，我们有意将 TBMQ 设计为对三者均表现优异。

Our design principles focused on ensuring the broker’s fault tolerance and high availability. 
Thus, we deliberately avoided reliance on master or coordinated processes. 
We ensured the same functionality across all nodes within the cluster.

We prioritized supporting distributed processing, allowing for effortless horizontal scalability as our operations grow. 
We wanted our broker to support high-throughput and guarantee low-latency delivery of messages to clients. 
Ensuring data durability and replication was crucial in our design. 
We aimed for a system where once the broker acknowledges receiving a message, it remains safe and won’t be lost.

为确保满足上述要求，并防止在客户端或部分 broker 实例故障时丢失消息，TBMQ 采用 [Kafka](https://kafka.apache.org/) 作为底层基础设施。

## TBMQ 工作原理概览

Kafka 在 MQTT 消息处理的各个阶段扮演关键角色。所有未处理的已发布消息、客户端会话和订阅均存储在专用 Kafka 主题中。TBMQ 使用的 Kafka 主题完整列表见[此处](#kafka-topics)。所有 broker 节点均可通过这些主题访问最新的客户端会话和订阅状态，并在本地维护副本以高效处理与投递消息。当客户端与某 broker 节点断开时，其它节点可基于最新状态无缝继续运作。此外，新加入集群的 broker 节点在启动时即可获得这些关键信息。

Client subscriptions hold significant importance within the MQTT publish/subscribe pattern. 
TBMQ employs the [Trie](#subscriptions-trie) data structure to optimize performance, 
enabling efficient persistence of client subscriptions in memory and facilitating swift access to relevant topic patterns.

Upon a publisher client sending a _PUBLISH_ message, it is stored in the initial Kafka topic, **tbmq.msg.all**. 
Once Kafka acknowledges the message’s persistence, 
the broker promptly responds to the publisher with either a _PUBACK/PUBREC_ message or no response at all, depending on the chosen QoS level.

Subsequently, separate threads, functioning as Kafka consumers, retrieve messages from the mentioned Kafka topic and 
utilize the Subscription Trie data structure to identify the intended recipients. 
Depending on the client type (**DEVICE** or **APPLICATION**) and the persistence options described below, 
the broker either redirects the message to another specific Kafka topic or directly delivers it to the recipient.

### 非持久客户端

![image](/images/mqtt-broker/architecture/tbmq-non-persistent-dev.png)

当 _CONNECT_ 包满足以下条件时，客户端被归类为非持久客户端：

对于 **MQTT v3.x**：
* 将 `clean_session` 标志设为 _true_。

对于 **MQTT v5**：
* 将 `clean_start` 标志设为 _true_，且 `sessionExpiryInterval` 为 _0_ 或未指定。

对于非持久客户端，发往它们的消息直接发布，无需额外持久化。
需注意的是，非持久客户端仅能为 **DEVICE** 类型。

**集群模式下的非持久 DEVICE 处理**

![image](/images/mqtt-broker/architecture/tbmq-non-persist-dev-cluster.png)

在集群模式下，多个 TBMQ 节点可协同运行，各自在 **tbmq.msg.all** 主题的同一消费者组中运行 Kafka 消费者。
该方式实现节点间的负载均衡和消息分发。
但可能出现消息由某一 TBMQ 节点处理，而目标订阅者连接在另一节点的场景。
为此，使用 **downlink.basic** Kafka 主题在 TBMQ 节点间通信。
确保处理消息的节点将消息转发给目标节点，再由其通过已建立连接投递给订阅者。

### 持久客户端

不满足上述非持久条件的 MQTT 客户端归类为持久客户端。持久客户端的条件如下：

对于 **MQTT v3.x**：
* 将 `clean_session` 标志设为 _false_。

对于 **MQTT v5 客户端**：
* `sessionExpiryInterval` 大于 _0_（无论 `clean_start` 为何）。
* 将 `clean_start` 标志设为 _false_，且 `sessionExpiryInterval` 为 _0_ 或未指定。

基于我们在 IoT 生态中的实践及大量用例的成功落地，我们将 MQTT 客户端划分为两类：

* _DEVICE_ 客户端：主要大量发布消息，订阅的 topic 数量有限、消息速率较低，通常对应 IoT 设备或传感器。

* _APPLICATION_ 客户端：专注于订阅高消息速率的 topic，通常需要离线时持久化消息并在稍后投递，确保关键数据不丢失，常用于实时分析、数据处理等应用层功能。

因此，我们通过为这两类客户端分离处理流程来优化性能。

#### 持久 DEVICE 客户端

![image](/images/mqtt-broker/architecture/tbmq-persistent-dev.png)

对于持久 DEVICE 客户端，我们使用 **tbmq.msg.persisted** Kafka 主题处理从 **tbmq.msg.all** 提取的已发布消息。该设计将持久消息与其他类型消息分离处理，保证流程清晰高效。作为 Kafka 消费者的专用线程拉取这些消息并存入用于持久化的 [Redis](#redis)。此方法尤其适合 DEVICE 客户端，因其通常不需要接收大量消息，在客户端重连时可顺畅恢复已存消息，同时在中等到达速率场景下保持良好性能。

关于 Redis 作为 DEVICE 客户端持久消息存储的详细说明见[此处](/docs/{{docsPrefix}}mqtt-broker/architecture-details/persistent-device-client/)。

**集群模式下的持久 DEVICE 处理**

![image](/images/mqtt-broker/architecture/tbmq-persist-dev-cluster.png)

与非持久客户端类似，集群模式下 TBMQ 节点协同运行，在 **tbmq.msg.persisted** 主题的同一消费者组中运行 Kafka 消费者。若消息由一节点处理而订阅者连接在另一节点，则通过 **downlink.persisted** Kafka 主题将消息转发到目标节点，确保通过已建立连接将消息无缝投递给订阅者。

#### 持久 APPLICATION 客户端

![image](/images/mqtt-broker/architecture/tbmq-app.png)

APPLICATION 客户端数量与所用 Kafka 主题数量一一对应。最新版 Kafka 可支持数百万主题，使该设计即使面对最大规模企业用例仍适用。

从 **tbmq.msg.all** 主题中读取的、发往特定 APPLICATION 客户端的消息会存入对应 Kafka 主题。每个 APPLICATION 客户端分配一个独立线程（Kafka 消费者），这些线程从对应 Kafka 主题拉取消息并投递给相应客户端。该方式通过高效投递显著提升性能。此外，Kafka 消费者组的特性使 [MQTT 5 共享订阅](/docs/{{docsPrefix}}mqtt-broker/user-guide/shared-subscriptions/#application-client-type) 对 APPLICATION 客户端极为高效。

APPLICATION 客户端可处理大量接收消息，可达每秒数百万条。需注意，APPLICATION 客户端仅能归类为[持久客户端](#persistent-client)。

> For both types of clients, we provide configurable instruments to control the persistence of messages per client and the duration for which they are stored.
> You can refer to the following environment variables to adjust these settings:
>* TB_KAFKA_APP_PERSISTED_MSG_TOPIC_PROPERTIES;
>* MQTT_PERSISTENT_SESSION_DEVICE_PERSISTED_MESSAGES_LIMIT;
>* MQTT_PERSISTENT_SESSION_DEVICE_PERSISTED_MESSAGES_TTL.
> 
> For more detailed information, please refer to the configurations provided in the following [documentation](/docs/{{docsPrefix}}mqtt-broker/install/config/).

**Persistent APPLICATION processing in cluster mode**

![image](/images/mqtt-broker/architecture/tbmq-app-cluster.png)

APPLICATION clients function the same way in cluster mode as in standalone setup, eliminating the need for internode communication. 
The processing of the message occurs directly on the target node, as a dedicated consumer for the APPLICATION client is created there once the client connects.
This design ensures seamless and rapid message delivery.
By avoiding additional message transmission steps, this approach ensures significantly improved performance, even as the system scales horizontally.

### Kafka 主题

以下是 TBMQ 使用的 Kafka 主题及说明。

* **tbmq.msg.all** - 存储来自 MQTT 客户端的全部已发布消息的主题。
* **tbmq.msg.app. + ${client_id}** - 存储 APPLICATION 客户端根据其订阅应接收的消息。
* **tbmq.msg.app.shared. + ${topic_filter}** - 存储 APPLICATION 客户端根据共同共享订阅应接收的消息。
* **tbmq.msg.persisted** - 存储 DEVICE 持久客户端根据订阅应接收的消息。
* **tbmq.msg.retained** - 存储所有保留消息，与 MQTT 保留消息功能相关。
* **tbmq.client.session** - 存储所有客户端会话。
* **tbmq.client.subscriptions** - 存储所有客户端订阅。
* **tbmq.client.session.event.request** - 存储客户端会话事件，如 _CONNECTION_REQUEST_、_DISCONNECTION_REQUEST_、_CLEAR_SESSION_REQUEST_ 等。
* **tbmq.client.session.event.response. + ${service_id}** - 存储对上一主题事件的响应，发往目标客户端所连接的 broker 节点。
* **tbmq.client.disconnect. + ${service_id}** - 存储强制断开客户端连接事件（由 UI/API 管理员请求或会话冲突触发）。
* **tbmq.msg.downlink.basic. + ${service_id}** - 用于在 broker 节点间转发消息至 DEVICE 订阅者当前所连节点。
* **tbmq.msg.downlink.persisted. + ${service_id}** - 用于在 broker 节点间转发消息至 DEVICE 持久订阅者当前所连节点。
* **tbmq.sys.app.removed** - 处理 APPLICATION 客户端主题移除的事件，在客户端从 APPLICATION 转为 DEVICE 时使用。
* **tbmq.sys.historical.data** - 存储各 broker 节点发布的集群历史统计（如入站/出站消息数等）以计算集群总值。
* **tbmq.client.blocked** - 存储和分发已封禁客户端列表，阻止其连接 broker。
* **tbmq.sys.internode.notifications + ${service_id}** - broker 节点间系统通知，用于同步认证提供方设置、认证管理员设置，并触发本地客户端会话缓存清理。

### Redis

[Redis](https://redis.io/) 是强大的内存数据存储，在需要低延迟与高吞吐数据访问的场景中表现优异，是存储实时数据的理想选择。

TBMQ 使用 Redis 存储 DEVICE 持久客户端的消息，为这些客户端实现高效的持久化与投递。Redis 能以极快读写在内存中管理大数据集，结合 Redis Cluster 的可扩展性，确保持久消息在存储量增长、系统需求提升时仍能高效检索与投递。该可扩展性使 Redis 可通过多节点分发数据，无缝处理更大工作负载，保持高性能与可靠性。

{% capture tbmq-redis-postgresql %}
TBMQ v2.0 之前使用 PostgreSQL 存储 DEVICE 持久客户端的消息。因 PostgreSQL 在大量写入场景下存在局限，v2.0 迁至 Redis 以提供更具可扩展性和性能的持久化方案。该迁移使我们能处理更高吞吐，同时为 DEVICE 持久客户端提供快速可靠的消息存储与投递。
{% endcapture %}
{% include templates/info-banner.md content=tbmq-redis-postgresql %}

### PostgreSQL 数据库

TBMQ 使用 [PostgreSQL](https://www.postgresql.org/) 存储用户、用户凭据、MQTT 客户端凭据、统计数据、WebSocket 连接、WebSocket 订阅等各类实体。

PostgreSQL 以可靠、健壮、灵活著称，是确保数据完整性并支持高事务吞吐的强大开源关系型数据库。在 TBMQ 中，PostgreSQL 作为系统关键元数据的主存储层。鉴于 MQTT 应用的高消息量与频繁读写特性，PostgreSQL 的事务管理与 ACID 合规提供强一致性保证，确保重要数据在任何场景下都能安全存储与检索。

### Web UI

TBMQ 提供轻量友好的图形界面（GUI），以直观高效的方式简化 broker 管理。该 GUI 具备以下核心功能：

* MQTT 客户端凭据管理：用户可通过 GUI 创建、修改和删除 MQTT 客户端凭据。
* 客户端会话与订阅控制：管理员可监控和控制客户端会话状态，包括终止和管理活跃连接，并管理客户端订阅（添加、移除、修改）。
* 共享订阅管理：管理员可创建和管理 Application 共享订阅实体，实现向多个 APPLICATION 类型订阅客户端的消息高效分发。
* 保留消息管理：管理员可管理 broker 保存并投递给新订阅者的保留消息。
* WebSocket 客户端：GUI 支持 WebSocket 客户端，管理员可建立、监控和管理 WebSocket 连接，用户可通过 MQTT over WebSocket 与 TBMQ 交互，实时调试和测试连接与消息流。

除上述管理功能外，GUI 还提供监控仪表板，展示 broker 性能的全面统计与洞察，帮助管理员更好理解系统健康与性能。

### Netty

为采用成熟高效的技术，我们选择 [Netty](https://netty.io/) 实现支持 MQTT 协议的 TCP 服务端。

Netty 是高性能异步事件驱动网络框架，适用于构建可扩展、健壮的网络应用，非常适合 TBMQ 处理 MQTT 流量。选择 Netty 的重要原因之一是其高效处理大量并发连接的能力——在成千上万甚至数百万设备持续连接并交换数据的 IoT 环境中，Netty 以较低资源消耗处理并发连接的能力非常关键。

Netty 使用非阻塞 I/O（NIO），无需为每个连接分配独立线程即可高效管理资源，显著降低开销。该方式在重负载下仍能保证高吞吐与低延迟，适合 TBMQ 这类 MQTT broker 的高要求场景。Netty 具备高度灵活性，支持按协议需求定制网络栈；其模块化设计便于实现协议处理、消息解析和连接管理，并提供 TLS 加密选项，满足安全性与未来扩展需求。

### Actor 系统

TBMQ 使用 Actor 系统作为底层机制，实现负责处理 MQTT 客户端的 Actor。采用 Actor 模型可实现客户端消息的高效并发处理，确保高性能运行。

broker 使用专为 TBMQ 定制的 Actor 系统实现。系统中存在两类 Actor：

* **Client Actors**：为每个连接的 MQTT 客户端创建对应的 Client Actor，负责处理 _CONNECT_、_SUBSCRIBE_、_UNSUBSCRIBE_、_PUBLISH_ 等主要消息类型，处理与 MQTT 客户端的交互并执行相关消息操作。
* **Persisted Device Actors**：除 Client Actor 外，为所有持久类型的 DEVICE 客户端额外创建 Persisted Device Actor，专门管理持久化相关操作及持久 DEVICE 客户端的消息存储与检索。

凭借 Actor 系统与多种 Actor 类型，TBMQ 高效并发处理消息，在与客户端交互时保持最优性能与快速响应。更多关于 Actor 模型的介绍见[链接](https://en.wikipedia.org/wiki/Actor_model)。

### 消息分发服务

消息分发服务（Message dispatcher service）是 TBMQ 架构的另一核心组件，负责管理发布客户端与 Kafka 之间的消息流，确保安全处理、持久化及向正确订阅者的高效投递。

消息分发服务在通过 Actor 系统收到发布者的消息后开始工作。服务将消息发布到 Kafka，保证其持久存储以安全处理与持久化。该步骤保证即便节点故障或临时断开，消息也不会丢失，使 Kafka 成为处理大量 MQTT 流量的可靠骨干。

Kafka 确认消息已存储后，消息分发服务拉取消息并利用 [Subscription Trie](#subscriptions-trie) 分析哪些订阅者有资格接收。确定订阅者后，根据订阅者类型决定处理方式：

* [DEVICE 非持久客户端](#non-persistent-client)：消息可立即投递给客户端。
* [DEVICE 持久客户端](#persistent-device-client)：消息发布到 DEVICE 客户端 Kafka 主题，随后存入 Redis。
* [APPLICATION 持久客户端](#persistent-application-client)：消息发布到专用 Application Kafka 主题。

为每个订阅者确定并完成处理路由后，消息交给 Netty 进行实际网络传输，投递给相应的在线客户端。

### 订阅 Trie

Trie 数据结构因其层次化组织与基于前缀的匹配，非常利于快速查找。仅存储一次共同前缀即可快速匹配 topic，减少搜索空间与内存占用。其时间复杂度取决于 topic 长度而非 topic 数量，即便在有数百万订阅的大规模环境中仍能保持稳定快速的查找。

在 TBMQ 中，所有客户端订阅从 Kafka 主题消费，并存入内存中的 Trie 数据结构。Trie 按层级组织 topic 过滤器，每个节点代表 topic 过滤器的一级。

从 Kafka 读取 _PUBLISH_ 消息时，broker 需识别所有与消息 topic 匹配的订阅客户端并确保其收到消息。Trie 可根据 topic 名称高效检索客户端订阅。一旦确定相关订阅，消息副本将转发给各对应客户端。

该方式可实现高性能消息处理，快速精确确定需接收特定消息的客户端。需注意的是，因 Trie 存储在内存中，该方法会增加 broker 的内存占用。更多 Trie 数据结构信息见[链接](https://en.wikipedia.org/wiki/Trie)。

## 单机模式与集群模式

TBMQ 设计为可水平扩展，支持自动向集群添加新的 broker 节点。集群内所有节点功能相同，共同承担整体负载，实现客户端连接与消息处理的均衡分布。

broker 设计无需「主节点」或「协调进程」，无层级或中央节点管理其他节点。该去中心化设计消除了单点故障，提升系统整体健壮性与容错能力。

处理客户端连接请求时，可使用自选的负载均衡器，将入站连接分发到所有可用 TBMQ 节点，均衡工作负载并提高资源利用率。

若客户端与某 broker 节点断开（如节点关闭、移除或网络故障），可轻松重连至集群内任意健康节点。该无缝重连能力确保持续运行与不中断服务，客户端可与集群内任意可用节点建立连接。

通过水平扩展、负载均衡与新节点自动发现，TBMQ 为大规模部署中的 MQTT 通信提供可扩展且 resilient 的架构。

## 编程语言

TBMQ 后端使用 Java 17 实现，前端以 Angular 19 框架开发为 SPA。