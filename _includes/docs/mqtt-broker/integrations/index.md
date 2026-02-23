
* TOC
{:toc}

{% if docsPrefix != "pe/" %}
{% assign sinceVersion = "2.1.0" %}
{% include templates/mqtt-broker/since.md %}
{% endif %}

## 概述

TBMQ 中的**集成**是数据桥梁，可将连接客户端发出的 MQTT 消息转发至外部系统，如 HTTP 端点、Kafka 代理或其他 MQTT 代理。
这使 IoT 设备与更广泛的数据基础设施之间的数据流动顺畅，让 MQTT 代理成为架构中的中心集成点。

### 为何使用集成？

集成使 MQTT 数据在代理之外可用。它们帮助您：

- 将 MQTT 消息桥接至外部系统以便处理、存储或分析。
- 实现 MQTT 与其他协议之间的互操作性。
- 在不同平台间构建复杂的事件驱动工作流。
- 保持 IoT 架构的模块化与可扩展性。

### 高层设计

从高层看，TBMQ 的集成流程如下：

1. **MQTT 客户端**使用 **MQTT** 或 **MQTTS** 连接至 **TBMQ** 代理并发布消息。
2. 当消息匹配集成的[主题过滤器](#integration-entity)（MQTT 订阅）时，**TBMQ** 通过 **Kafka** 将消息发送至 [TBMQ Integration Executor](#new-microservice)。
3. **Integration Executor** 接收消息、进行处理，并转发至正确的外部系统，例如：
- 通过 **HTTP 或 HTTPS** 至 **HTTP 端点**。
- 通过 **MQTT 或 MQTTS** 至其他 **MQTT 代理**。
- 通过 **Kafka 二进制协议（TCP 或 TLS）** 至 **Kafka 代理**。

![image](/images/mqtt-broker/integrations/tbmq-ie-main.png)

### 新微服务

TBMQ 使用名为 **TBMQ Integration Executor**（简写为 “TBMQ IE”）的专用微服务来管理与运行集成。

该功能下，TBMQ 支持由 `TB_SERVICE_TYPE` 环境变量定义的两种服务类型：

* **tbmq** – 核心 MQTT 代理服务；
* **tbmq-integration-executor** – 集成执行服务（tbmq-ie）。

Integration Executor 服务监听来自 TBMQ（经 Kafka）的集成事件与消息，根据集成配置处理它们，并将数据转发至外部系统。
您可在 TBMQ 集群内部署多个 Integration Executor 微服务，以实现可扩展性与故障隔离。

> 该架构确保了职责清晰、高可用，并提升了可扩展性与系统性能。

### 部署选项

在 TBMQ 中，集成只能通过 Integration Executor 微服务部署。

> 为何不嵌入 TBMQ？

我们**有意不将集成逻辑嵌入** TBMQ 代理内部。该设计带来以下好处：

- **隔离**：外部系统（如 HTTP 端点）的故障或慢响应不会影响代理中的 MQTT 消息处理。
- **可扩展性**：`tbmq-ie` 实例可根据负载独立扩展，不影响代理性能。
- **弹性**：每个 Integration Executor 可独立重启或失败，而不中断核心 MQTT 服务。
- **可扩展性**：可在 Integration Executor 中添加新的集成类型或改进，而不修改代理本身。
- **职责清晰**：代理负责 MQTT 协议逻辑，Integration Executor 负责向外部系统投递数据。

## 架构

本节介绍 TBMQ 与 Integration Executor 如何内部通信、数据如何在组件间流动，以及系统如何在负载下保持可扩展与容错。

### 集成实体

集成对象在 TBMQ 的 PostgreSQL 数据库中对应实体。
主要用于 TBMQ Web UI——查看和管理集成。每个集成实体包含基本字段，例如：

- **Type** – HTTP、Kafka 或 MQTT。
- **Name** – 可读名称。
- **Enabled** – 集成是否启用或禁用。
- **Status** – 集成的实际状态：
  - **Disabled**：未激活。
  - **Active**：运行中并处理消息。
  - **Failed**：发生连接失败。
  - **Pending**：等待验证和激活。
- **Configuration** – 包含外部系统的连接详情与参数。
- **Topic filters** – 定义基于 MQTT 的订阅并作为触发器。当代理收到匹配主题过滤器的消息时，触发集成并将其转发至配置的外部系统。

您可以为不同类型、主题过滤器和目标系统配置多个集成。每个集成独立运行，可随时启用或禁用。

MQTT 集成配置示例（部分）：

```json
{
  "id": "3e3abdb2-12f9-4850-a654-50a0c8dbbed6",
  "name":"MQTT integration",
  "type":"MQTT",
  "enabled":true,
  "configuration":{
    "topicFilters":[
      "tbmq/#"
    ],
    "clientConfiguration":{
      "host":"10.7.3.148",
      "port":1883
    }
  },
  "status":{
    "success":true
  }
}
```

### TBMQ（MQTT 代理）组件

核心 TBMQ 服务（`TB_SERVICE_TYPE=tbmq`）负责 MQTT 协议逻辑，包括客户端连接、订阅与消息路由。
还通过处理创建、更新和删除请求来管理集成实体，并将其存储于数据库。
此外，向 TBMQ IE 发送集成验证请求（用于验证配置或连接检查），并向 TBMQ IE 发布集成配置事件。
最后，将收到的 MQTT 消息与集成订阅匹配，并在适用时转发至 TBMQ IE。

代理相对于 Integration Executor 无状态，可水平扩展以应对增加的 MQTT 流量。

### TBMQ Integration Executor 组件

Integration Executor（`TB_SERVICE_TYPE=tbmq-integration-executor`）是独立微服务，负责接收并处理来自 TBMQ 的验证请求，然后返回响应。
根据配置事件（创建、更新或删除）管理完整集成生命周期。
此外，执行集成逻辑，包括重试机制、超时处理与背压控制。
将 MQTT 消息投递至配置的外部系统，如 HTTP、Kafka 或 MQTT。
向 TBMQ 发回生命周期、错误与统计集成事件。

该组件独立于代理运行，可单独扩展。
确保外部系统的延迟或故障不会影响代理处理 MQTT 流量的能力。

### Kafka（内部通信层）

Kafka 在 TBMQ 代理与 Integration Executor 之间充当**桥梁**。
支持服务之间可靠投递集成相关事件。
在组件宕机、处理延迟或负载激增时提供消息缓冲。
通过允许多个代理与执行器实例并发工作，实现可扩展与并行处理。

![image](/images/mqtt-broker/integrations/tbmq-ie-communication.png)

TBMQ 与其 Integration Executor 微服务通过 Kafka 在多个**专用**主题上异步通信。
每个主题服务于特定目的，支持组件间解耦、可靠且可扩展的数据流。

* **tbmq.ie.downlink.$integrationType** — 用于将集成配置和验证请求从 TBMQ 发送至 IE 的 [Compact](https://docs.confluent.io/kafka/design/log_compaction.html) 主题（$integrationType 可为 'http'、'mqtt' 或 'kafka'）。
* **tbmq.ie.uplink** — 用于将生命周期事件、统计与错误从 IE 发回 TBMQ 的主题。
* **tbmq.ie.uplink.notifications.$serviceId** — 用于将验证响应及其他一次性回复发送至正确的 TBMQ 节点（由 $serviceId 标识）的主题。
* **tbmq.msg.ie.$integrationId** — 用于将 MQTT 消息从 TBMQ 转发至 IE 的按集成消息处理主题（$integrationId 为集成实体的 UUID）。

### 下行主题

TBMQ 对下行通信使用 **Kafka compact 主题**。每种集成类型有各自的专用主题：

- `tbmq.ie.downlink.http`
- `tbmq.ie.downlink.mqtt`
- `tbmq.ie.downlink.kafka`

这些主题用于在集成**创建、更新或删除**时投递集成配置数据。
也用于触发**连接和验证请求**，以在激活前测试外部系统连通性并验证配置。

#### 工作方式

- 集成生命周期事件（创建、更新、删除）根据集成类型发布至相应的**下行 compact 主题**（例如 HTTP 集成使用 `tbmq.ie.downlink.http`）。
- Kafka 的 **log compaction** 机制仅保留每个集成 ID 的最新配置，丢弃过时消息。
- 启动或分区重新分配时，`tbmq-ie` 实例进入**恢复模式**：
  1. **Seek 至**所分配主题分区的**起始位置**。
  2. 从 compact 记录**恢复**所有相关集成的最新状态。
  3. **跳过**所有验证请求（因其已过去处理）。
  4. 到达**分区末端**后恢复完成，切换至**实时模式**并开始正常运行。
- 集成仅在从 Kafka 完全恢复其最新配置后才初始化。
- 在实时模式下，新的集成事件立即处理。验证请求即时处理。
- 关闭或分区回收时，`tbmq-ie` 实例停止受影响的集成并清理底层资源（如协议客户端与连接）。

#### 该方式的优势

**弹性**确保 TBMQ IE 可在重启后完全恢复，无需外部配置存储。
**一致性**保证始终使用最新有效配置，避免陈旧或冲突状态。
**可扩展性**通过无状态服务设计实现，所有配置状态持久化于 Kafka。
**降低负载**意味着仅写入变更的配置，无需重复发送完整配置集。

该模式提供由 Kafka 支持的**持久化、分布式配置源**，使多个 TBMQ IE 实例上的集成执行可靠且可扩展。

#### 为何使用独立主题？

尽管下行主题不用于消息处理（对并行处理有益），按集成类型分离它们带来以下好处：

- **执行器专业化**：可使用 `TB_SERVICE_INTEGRATIONS_SUPPORTED` 和 `TB_SERVICE_INTEGRATIONS_EXCLUDED` [环境变量](/docs/{{docsPrefix}}mqtt-broker/install/ie-config/#service-parameters) 让特定 Integration Executor 实例仅处理某些集成类型。
- **定向消费**：执行器仅订阅其配置为处理的主题。
- **更好隔离**：不同集成类型常有不同配置负载与验证逻辑。专用主题确保每个执行器仅收到相关消息。
- **运维简洁**：便于按集成类型调试和监控流量。
- **灵活扩展**：可根据每种集成类型的负载特性单独调优每个主题（如分区、保留期）。

该设计使管理员能部署**专业化执行器实例**——例如在一个池中仅运行 HTTP 集成，在另一个池中运行 Kafka——在规模上提供灵活性、隔离与效率。

### 上行主题

该主题供 Integration Executor 向 TBMQ 代理发送重要事件，包括：

- **生命周期事件**（例如集成启动或停止）。
- **错误**（报告向外部系统投递失败）。
- **统计**（如成功/失败处理计数）。

该主题收到的所有消息作为 Event 实体存储于 TBMQ 数据库，用于内部跟踪、诊断与管理可见性。

### 上行通知主题

这些按节点划分的主题供 Integration Executor **向特定 TBMQ 节点发送直接回复**，
通常针对一次性操作。
主题使用目标节点的服务 ID 动态构建。
例如，用于回复**“检查连接”**请求，并向发起 TBMQ 节点返回**验证结果或错误详情**。

该机制确保在集群环境中将响应路由至正确实例，并保持准确的请求-响应关联。

### 集成生命周期

TBMQ 中集成的生命周期包括**创建、更新、删除、执行、监控**和**错误处理**。
集成可通过 **TBMQ Web UI** 或 **REST API** 管理。

收到创建或更新请求时，TBMQ 向 Integration Executor 发送**验证请求**。
IE 根据集成类型验证配置并返回结果。

该验证过程确保在保存并激活集成前配置正确。
也可使用 UI 上的**“检查连接”**按钮或 REST API 手动测试与外部系统的集成连通性。

#### 验证场景

**场景 1：Integration Executor 未运行 — 超时**

![image](/images/mqtt-broker/integrations/tbmq-ie-admin-timeout.png)

Integration Executor 未运行，代理会等待响应直至超时。结果：**超时异常**。
集成不会被保存。

**场景 2：Integration Executor 运行中 — 配置错误**

![image](/images/mqtt-broker/integrations/tbmq-ie-admin-error.png)

Integration Executor 运行中，但集成配置无效。结果：**失败**。
集成不会被保存。

**场景 3：Integration Executor 运行中 — 成功**

![image](/images/mqtt-broker/integrations/tbmq-ie-admin-ok.png)

Integration Executor 运行且配置有效。结果：**成功**。
验证成功后，集成实体保存至数据库，集成订阅持久化至 [Subscription Trie](/docs/{{docsPrefix}}mqtt-broker/architecture/#subscriptions-trie)，
并发送集成配置事件至 Integration Executor 处理。

### 集成消息处理主题

![image](/images/mqtt-broker/integrations/tbmq-ie-msg-processing.png)

TBMQ 为每个集成使用**专用 Kafka 主题**向 Integration Executor（`tbmq-ie`）投递 MQTT 消息。

当 MQTT 客户端发布消息时，TBMQ 代理首先检查是否有集成在 Subscription Trie 中有匹配消息主题的主题过滤器。
若匹配，TBMQ 通过序列化消息创建集成事件，并发布至该集成的 Kafka 主题
（`tbmq.msg.ie.$integrationId`）。管理该集成并订阅该 Kafka 主题的 Integration Executor
消费消息、处理并转发至配置的外部系统。
执行器也可能记录结果或向 TBMQ 反馈以用于监控。

该解耦、事件驱动的流程使 TBMQ 将集成消息处理完全交给执行器服务。
因此，代理不会等待外部响应，即使在外部系统缓慢或不可用时也能保持低延迟的 MQTT 性能。

每个集成拥有各自的 Kafka 主题，实现消息流的完全隔离。
不同集成的消息在独立线程（Kafka 消费者）中独立处理，支持并行执行与细粒度错误控制。

即使集成被禁用，TBMQ 仍会继续将匹配消息发布至其 Kafka 主题。
这确保无消息丢失，执行器在集成重新启用后可恢复处理。
Kafka 的保留策略与缓冲能力在高负载或临时故障场景下提供额外弹性。

该架构确保可靠、可扩展且容错的消息处理，而不影响核心代理性能。
主要优势：

- 高吞吐与非阻塞的代理性能。
- 消息路由与消息投递之间的职责清晰分离。
- 按集成对重试、背压与错误处理的完整控制。

#### 若集成长时间禁用会发生什么？

为避免未使用主题无限占用存储，TBMQ 包含自动**清理机制**。

若集成在较长时间内保持**禁用**，其专用 Kafka 消息主题将**自动删除**，
连同其中未送达的消息。

但无需手动操作——当集成**重新启用**时，
TBMQ 将**自动重建主题**并恢复正常消息处理。

可使用以下环境变量控制清理行为。
默认情况下，清理任务每 3 小时运行一次，并移除与不活动超过 1 周的集成关联的主题。

```yaml
cleanup:
  # The parameter to specify the period of execution cleanup task for disconnected integrations. Value set in seconds. Default value corresponds to three hours
  period: "${INTEGRATIONS_CLEANUP_PERIOD_SEC:10800}"
  # Administration TTL (in seconds) for cleaning up disconnected integrations.
  # The cleanup removes integration topics that persist messages.
  # The current value is set to one week. A value of 0 or negative disables this TTL
  ttl: "${INTEGRATIONS_CLEANUP_TTL_SEC:604800}"
```

该方法确保不活动集成不会浪费资源，同时仍允许在重新激活时自动恢复。
此外，可自定义 Kafka 主题保留设置以微调存储限制并控制每主题消息保留时间。

### 消息投递错误处理与重试机制

当集成消息处理失败时（例如因超时、外部系统不可达或格式错误的请求），
Integration Executor 根据 `tbmq.msg.ie.$integrationId` 主题配置的**确认与重试策略**处理错误。

这些行为由以下配置块控制：

```yaml
integration-msg:
  # Interval in milliseconds to poll messages from 'tbmq.msg.ie' topics
  poll-interval: "${TB_IE_MSG_POLL_INTERVAL:1000}"
  # Timeout in milliseconds for processing the pack of messages
  pack-processing-timeout: "${TB_IE_MSG_PACK_PROCESSING_TIMEOUT:30000}"
  ack-strategy:
    # Processing strategy for 'tbmq.msg.ie' topics. Can be: SKIP_ALL, RETRY_ALL
    type: "${TB_IE_MSG_ACK_STRATEGY_TYPE:SKIP_ALL}"
    # Number of retries, 0 is unlimited. Use for RETRY_ALL processing strategy
    retries: "${TB_IE_MSG_ACK_STRATEGY_RETRIES:5}"
    # Time in seconds to wait in consumer thread before retries
    pause-between-retries: "${TB_IE_MSG_ACK_STRATEGY_PAUSE_BETWEEN_RETRIES:1}"
```

#### 策略选项

- **SKIP_ALL**（默认）：
  - 若处理期间消息失败或超时，记录错误后跳过。
  - 保证高吞吐并避免重试延迟，但牺牲向外部系统的保证投递。

- **RETRY_ALL**：
  - 执行器在配置次数（`retries`）内就地重试失败和超时消息。
  - 强制重试间隔（`pause-between-retries`）以避免紧循环重试。
  - 若 `retries` 设为 `0`，执行器将无限重试该消息。

#### 超时控制

每批消息（“包”）有**处理超时**（`pack-processing-timeout`），防止长时间任务阻塞整个消费者线程。
这在高负载或外部目标缓慢时保证系统响应。

该方法在性能与投递保证之间取得灵活平衡，让管理员能控制重试行为、故障容忍度与系统弹性。

### 失败集成的热重新初始化

除消息级重试外，TBMQ 支持通过定期后台检查**自动重新初始化**失败集成。

```yaml
reinit:
  # Enable/disable integrations hot reinitialization. This process is done for integrations with state 'FAILED'
  enabled: "${INTEGRATIONS_REINIT_ENABLED:true}"
  # Checking interval in milliseconds for reinit integrations. Defaults to 5 minutes
  frequency: "${INTEGRATIONS_REINIT_FREQUENCY_MS:300000}"
```

若集成进入 `FAILED` 状态（例如因连接中断或配置问题），Integration Executor 将定期**尝试重新初始化**。
该过程每 `frequency` 毫秒检查所有失败集成。
若问题已解决（如远程系统恢复可达），集成将自动恢复，无需人工干预。

该功能确保长时间运行的集成在动态环境中保持自愈与健壮。

### 集成指标概述

**Integration Executor**（`tbmq-ie`）收集并报告详细指标，用于监控所有已配置集成的健康状况、性能与行为。
这些指标定期记录，并可由 **Prometheus** 或 **Grafana** 等外部监控系统导出，用于告警、仪表板和历史分析。

以下是日志中记录的主要指标类别：

**1. 当前集成活动**

本节记录**按集成类型的计数器**，对应当前报告周期。

示例：
```
IntegrationStatisticsKey(integrationStatisticsMetricName=START, success=true, integrationType=HTTP) = [0]
```

**说明：**
- `START`：集成启动尝试次数。
- `success=true | false`：尝试是否成功或失败。
- `integrationType`：集成类型（如 HTTP、MQTT、Kafka）。

可能出现的其他指标类型：
- `integrationStatisticsMetricName=STOP`：集成关闭触发次数。
- `integrationStatisticsMetricName=MSGS_UPLINK`：从执行器转发至外部系统的消息数。

示例：
```
MSGS_UPLINK, success=true, integrationType=MQTT = [38]
```
-> 38 条消息成功转发至外部 MQTT 代理。

**2. 集成状态摘要**

本节跟踪执行器管理的所有集成的**当前状态**。

示例：
```
START, success=true, integrationType=MQTT = [1]
```
-> 当前有**一个活跃的 MQTT 集成**处于 `STARTED` 状态。

**要点：**
- `success=true`：处于 `STARTED` 状态的集成数。
- `success=false`：处于 `FAILED` 状态的集成数。

这些值在任何集成状态变化时更新。帮助管理员了解**所有运行集成的实时健康状况**，按类型汇总。

**3. 集成上行队列统计**

这些指标汇总用于执行器向 TBMQ 发送错误、统计和生命周期事件的**上行 Kafka 主题**状态。

示例：
```
queueSize = [0]
totalMsgs = [1]
successfulMsgs = [1]
failedMsgs = [0]
```

**指标说明：**
- `queueSize`：上行 Kafka 队列中当前等待的消息数。
- `totalMsgs`：发送至上行主题的消息总数。
- `successfulMsgs`：成功发布的消息数。
- `failedMsgs`：发布失败的消息数。

这些值有助于监控执行器与代理服务之间的**内部通信可靠性与健康状况**。

**4. 集成消息处理统计**

这些是**按集成实例的指标**，反映消息如何被处理并投递至外部系统。

示例：
```
[integrationProcessor][f6e82897-dd18-4c6f-ac31-5f19ce75e2db]
totalMsgs = [38]
successfulMsgs = [38]
tmpTimeout = [0]
tmpFailed = [0]
timeoutMsgs = [0]
failedMsgs = [0]
successfulIterations = [38]
failedIterations = [0]
```

**指标说明：**
- `[integrationProcessor][<UUID>]`：特定集成实例的指标组。
- `totalMsgs`：接收待处理的消息总数。
- `successfulMsgs`：成功投递的消息数。
- `tmpTimeout`：超出处理超时但将重试的消息数。
- `tmpFailed`：失败但将重试的消息数。
- `timeoutMsgs`：超出处理超时且不再重试的消息数。
- `failedMsgs`：重试后永久失败的消息数。
- `successfulIterations`：成功消息批次执行次数（批次中所有消息无错误处理）。
- `failedIterations`：导致一个或多个处理失败的消息批次执行次数。

这些指标对监控**消息级可靠性**、排查集成问题及确保及时投递至外部目标至关重要。

## 可扩展性与容错

- **执行器扩展**：可并行运行多个 `tbmq-ie` 服务实例。Kafka 处理分区并在执行器间自动分布集成消息，支持水平扩展。
- **故障隔离**：外部系统的问题（如缓慢或不可达的 HTTP 端点）仅影响 Integration Executor。TBMQ 代理继续正常运行，无延迟或消息丢失。
- **背压管理**：Kafka 充当消息缓冲。若执行器变慢或暂时过载，Kafka 按其配置的保留策略保留消息，直至执行器准备好处理。
- **弹性**：执行器实例可独立重启或失败。集成通过 compact 配置主题自动恢复，无需人工干预。

该架构支持现代云原生部署模式，确保 TBMQ 在高负载或部分系统故障下仍保持健壮与响应迅速。

## 支持的集成类型

TBMQ 目前支持三种出站集成类型，分别面向特定用例：

- [**HTTP 集成**](/docs/{{docsPrefix}}mqtt-broker/integrations/http/) – 通过 HTTP(S) 将 MQTT 消息发送至 REST API 或 Webhook。
- [**MQTT 集成**](/docs/{{docsPrefix}}mqtt-broker/integrations/mqtt/) – 通过 MQTT(S) 将消息转发至外部 MQTT 代理，实现跨代理通信。
- [**Kafka 集成**](/docs/{{docsPrefix}}mqtt-broker/integrations/kafka/) – 通过 TCP(TLS) 将消息流式写入 Kafka 主题，支持实时处理。

## 路线图

我们正在积极扩展 TBMQ 的集成能力。后续计划包括：

- **新的出站集成类型**，如 Redis、PostgreSQL、RabbitMQ 等。
- **入站（源）集成**，使 TBMQ 能从外部系统接收消息——例如 Kafka 集成（作为消费者）或 MQTT 集成（作为订阅者）。
- **消息转换与过滤**，在向外部目标转发数据前支持动态处理。

这些增强将为构建事件驱动和双向 IoT 架构提供更大灵活性。

**敬请关注后续更新！**
