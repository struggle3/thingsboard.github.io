ThingsBoard 目前支持两种用于存储消息的消息系统/代理：内存队列和基于 Kafka 的系统。

**In Memory** 队列实现不适用于任何类型的集群部署。

* **Kafka** 推荐用于生产部署，且为默认选项。该队列已在大多数 ThingsBoard 生产环境中使用。
  适用于本地和私有云部署。若希望与云厂商解耦，也可选用。
  部分云厂商也提供 Kafka 托管服务，例如 AWS [MSK](https://aws.amazon.com/msk/)。

* **Confluent Cloud** 是基于 Kafka 的全托管流平台，适用于云无关部署。

更多详情请参阅相应架构[页面](/docs/reference/#message-queues-are-awesome)和规则引擎[页面](/docs/user-guide/rule-engine-2-5/queues/)。