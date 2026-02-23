ThingsBoard 平台目前支持两种消息 broker 用于存储消息及 ThingsBoard 服务间通信：In-memory 和基于 Kafka 的 broker。

 * **In Memory** queue 实现为内置且默认。
适用于开发（PoC）环境，不适合生产部署或任何集群部署。

 * **Kafka** 推荐用于生产部署。该 queue 现已在多数 ThingsBoard 生产环境中使用。
适用于本地部署和私有云部署。若希望独立于云提供商，同样适用。
部分云提供商也提供 Kafka 托管服务，如 AWS [MSK](https://aws.amazon.com/msk/)。

* **Confluent Cloud** 是基于 Kafka 的全托管流平台。适用于云无关部署。

详见对应架构 [页面](/docs/reference/#message-queues-are-awesome) 和规则引擎 [页面](/docs/user-guide/rule-engine-2-5/queues/)。