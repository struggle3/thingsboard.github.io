* TOC
{:toc}

### 概述

在 **ThingsBoard** 中，**queues（队列）** 保证消息处理、应对偶发峰值，并在极端负载下保持系统运行。
**Edge Queues** 与 **Platform (Cloud) Queues** 设计相同。
详细说明请参阅 [Platform Queues documentation](/docs/{{peDocsPrefix}}user-guide/rule-engine-2-5/queues/){: target="_blank"}。

**租户管理员** 可在 **Edge Rule Chain** 中使用任意 **queue**，与 **Platform Rule Chain** 相同。
**Queues** 可用于 [checkpoint node](/docs/user-guide/rule-engine-2-0/nodes/flow/checkpoint/){: target="_blank"}
或任意 [analytics nodes](/docs/user-guide/rule-engine-2-0/nodes/analytics/){: target="_blank"}（Professional Edition）。

从 **Edge 3.9** 起，Edge 支持 **Kafka** 和 **in-memory** 类型的消息队列：
* **In-Memory：** 内置且默认的队列实现。适用于开发或概念验证（PoC）环境，但不建议用于生产或任何类型的集群部署，因可扩展性有限。
* **Kafka：** 广泛使用的分布式、持久化消息队列系统，专为处理大批量数据而设计。适用于高吞吐量、容错和可扩展性至关重要的生产环境。

所有 **queues** 均在 **Platform** 上创建，并自动传播到每个连接到 **Platform** 的 **Edge** 实例。
只有 **system administrator** 用户可以配置队列。配置后，新更改将立即生效。
**租户管理员** 或 **用户** 无需执行额外的分配操作。

当前版本中，您无法在 **Edge** 上创建、修改或删除 **queues**。

### 下一步

{% include templates/edge/guides-banner-edge.md %}
