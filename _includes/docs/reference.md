* TOC
{:toc}

## ThingsBoard services

ThingsBoard is designed to be:

* **scalable**: horizontally scalable platform, build using leading open-source technologies.
* **fault-tolerant**: no single-point-of-failure, every node in the cluster is identical.
* **robust and efficient**: single server node can handle tens or even hundreds thousands of devices depending on use-case. 
ThingsBoard cluster can handle millions of devices.
* **durable**: never lose your data. ThingsBoard supports various queue implementations to provide extremely high message durability.
* **customizable**: adding new functionality is easy with customizable widgets and rule engine nodes.


The diagram below shows key system components and interfaces they provide. Let's walk through them.


{% if docsPrefix == null %}
<object width="100%" data="/images/reference/thingsboard-architecture.svg"></object>
{% endif %}
{% if docsPrefix == "pe/" %}
<object width="100%" data="/images/reference/thingsboard-architecture-pe.svg"></object>
{% endif %}


**ThingsBoard 传输层**
 
ThingsBoard 提供基于 [MQTT](/docs/{{docsPrefix}}reference/mqtt-api/)、[HTTP](/docs/{{docsPrefix}}reference/http-api/)、[CoAP](/docs/{{docsPrefix}}reference/coap-api/) 和 [LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api/) 的 API，供设备应用或固件使用。 
各协议 API 由独立服务组件实现，共同构成 ThingsBoard「传输层」。 
MQTT 传输还提供 [Gateway APIs](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)，供代表多台设备/传感器的网关使用。

传输层收到设备消息后解析，并推入持久化 [消息队列](/docs/{{docsPrefix}}reference/#thingsboard-message-queues)。 
仅在消息队列确认处理该消息后，才会向设备确认消息投递。

**ThingsBoard Core**

ThingsBoard Core 负责处理 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 调用和 WebSocket [订阅](/docs/{{docsPrefix}}user-guide/telemetry/#websocket-api)。
还负责存储活跃设备会话的最新信息，并监控设备 [连接状态](/docs/{{docsPrefix}}user-guide/device-connectivity-status/)。
ThingsBoard Core 底层采用 Actor 模型，为租户、设备等主要实体实现 Actor。 
平台节点可加入集群，每个节点负责处理部分消息分区。

**ThingsBoard 规则引擎**

ThingsBoard 规则引擎是核心，负责处理入站 [消息](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-message)。
规则引擎底层采用 Actor 模型，为规则链和规则节点等实体实现 Actor。
规则引擎节点可加入集群，每个节点负责处理部分消息分区。

规则引擎订阅队列的数据流，仅在处理完成后才确认消息。 
可通过多种策略控制消息处理顺序及确认条件，详见 [提交策略](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-submit-strategy) 和 [处理策略](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-processing-strategy)。

ThingsBoard 规则引擎支持两种模式：共享与隔离。共享模式下处理多租户消息。
隔离模式下，可仅处理特定租户配置集中租户的消息。 

**ThingsBoard Web UI**

ThingsBoard 提供基于 Express.js 的轻量组件，用于托管静态 Web UI。 
该组件完全无状态，配置较少。 
静态 Web UI 包含应用包。加载后会通过 ThingsBoard Core 提供的 REST API 和 WebSockets API 与平台通信。  
 
## ThingsBoard 消息队列

ThingsBoard 支持两种消息队列：**Kafka** 和 **In-Memory**。
- **Kafka**：广泛使用的分布式持久化消息队列，适合大数据量场景，适用于需要高吞吐、高可用和可扩展性的生产环境。
- **In-Memory**：轻量、快速的队列实现，适用于测试、小规模或开发环境，消息存于内存，优先考虑速度而非持久化。

使用持久化、可扩展的 Kafka 队列可实现背压和负载均衡。峰值负载下背压尤为重要。 
我们在具体队列实现之上提供抽象层，并维护两个核心概念：topic 与 topic partition。 
单个 topic 可有可配置数量的分区。因多数队列实现不支持分区，我们采用 *topic + "." + partition* 模式。
  
ThingsBoard 消息生产者根据实体 id 的哈希选择分区。 
因此，同一实体的所有消息始终写入同一分区。
消息消费者通过 Zookeeper 协调，使用一致性哈希确定每个消费者订阅的分区列表。
微服务模式下，各服务还拥有基于唯一服务 id 的专用「Notifications」topic，且仅有一个分区。      
   
ThingsBoard 使用以下 topics：

 * **tb_transport.api.requests**：传输层向 Core 发送通用 API 调用以校验设备凭据。
 * **tb_transport.api.responses**：传输层从 Core 接收设备凭据校验结果。
 * **tb_core**：将传输层或规则引擎的消息推送给 Core，包括会话生命周期、属性与 RPC 订阅等。
 * **tb_rule_engine**：将传输层或 Core 的消息推送给规则引擎，包括遥测、设备状态、实体生命周期等。

{% capture difference %}
**注意：** 所有 topic 属性（含名称与分区数）可通过 thingsboard.yml 或环境变量 [配置](/docs/user-guide/install/{{docsPrefix}}config/){:target="_blank"}。
自 ThingsBoard 3.4 起，可在 UI 中配置规则引擎队列，详见[文档](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture difference %}
**注意：** 自 2.5 版本起，ThingsBoard 组件间通信已从 [gRPC](https://grpc.io/){:target="_blank"} 改为 [消息队列](/docs/{{docsPrefix}}reference/#thingsboard-message-queues)。
主要目的是在略微牺牲性能/延迟的前提下，实现持久可靠的消息投递和自动负载均衡。  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 本地部署与云部署

ThingsBoard 支持本地和云部署。 
全球有超过 5000 台 ThingsBoard 服务器在生产环境运行，包括 AWS、Azure、GCE 及私有数据中心。
可在完全无互联网访问的私有网络中部署 ThingsBoard。

## 单体与集群模式

平台支持水平扩展，并支持自动发现新的 ThingsBoard 节点。 
集群内各节点等同，共同分担负载。 
因节点相同，不存在「主节点」或「协调进程」，也无单点故障。 
负载均衡器可将设备、应用和用户的请求转发到任意 ThingsBoard 节点。

## 单体与微服务架构

自 ThingsBoard v2.2 起，平台可以单体应用或微服务组形式运行。 
兼顾两种模式需要额外开发，但为保证与既有部署的兼容性，这是必要的。

约 80% 的部署仍使用单体模式，因其对运维、知识和硬件要求较低，维护简单。

若需高可用或要扩展到数百万设备，建议采用微服务架构。
微服务还能应对更复杂部署和使用场景中的问题，例如多租户部署中需要更细粒度隔离以应对：

* 不可预知的负载峰值；
* 不可预知的规则链配置错误；
* 因固件缺陷导致单设备建立数千并发连接；
* 以及其他类似情况。
 
请参考以下链接选择合适架构与部署方式：

* [**单体架构**](/docs/{{docsPrefix}}reference/monolithic)：了解在单体模式下部署、配置与运行 ThingsBoard。
* [**微服务架构**](/docs/{{docsPrefix}}reference/msa)：了解在微服务模式下部署、配置与运行 ThingsBoard。
 

## SQL、NoSQL 与混合数据库方案

ThingsBoard 使用数据库存储 
[实体](/docs/{{docsPrefix}}user-guide/entities-and-relations/)（设备、资产、客户、仪表盘等）及 
[遥测](/docs/{{docsPrefix}}user-guide/telemetry/)数据（属性、时序、统计、事件）。 
平台当前支持三种数据库方案：

* **SQL**：将实体与遥测均存储于 SQL 数据库。推荐使用 PostgreSQL，这是 ThingsBoard 主要支持的 SQL 数据库。 
本地开发可使用 HSQLDB。**不建议**将 HSQLDB 用于测试和极低负载开发实例以外的场景。
* **Hybrid（PostgreSQL + Cassandra）**：实体存于 PostgreSQL，时序数据存于 Cassandra。
* **Hybrid（PostgreSQL + TimescaleDB）**：实体存于 PostgreSQL，时序数据存于 Timescale。

可通过 **thingsboard.yml** 配置上述选项，详见数据库[配置](/docs/user-guide/install/{{docsPrefix}}config/)页面。

```yaml
database:
  ts_max_intervals: "${DATABASE_TS_MAX_INTERVALS:700}" # Max number of DB queries generated by single API call to fetch telemetry records
  ts:
    type: "${DATABASE_TS_TYPE:sql}" # cassandra, sql, or timescale (for hybrid mode, DATABASE_TS_TYPE value should be cassandra, or timescale)
  ts_latest:
    type: "${DATABASE_TS_LATEST_TYPE:sql}" # cassandra, sql, or timescale (for hybrid mode, DATABASE_TS_TYPE value should be cassandra, or timescale)

```

## 编程语言与第三方组件

ThingsBoard 后端采用 Java 编写，部分微服务基于 Node.js。前端为基于 Angular 的 SPA。 
第三方组件的详细信息请参阅 [单体架构](/docs/{{docsPrefix}}reference/monolithic) 和 [微服务架构](/docs/{{docsPrefix}}reference/msa) 页面。  