有时规则引擎内消息处理延迟会逐渐增大。可按以下步骤排查原因：
- 检查 [Rule Engine Statistics Dashboard](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics) 是否存在超时。规则节点超时会拖慢队列处理并导致延迟。

- [检查 CPU 使用情况](#cpumemory-usage)，关注以下服务：
    - ThingsBoard 服务（tb-nodes、tb-rule-engine、tb-core 节点、transport 节点）。某服务 CPU 负载过高时，需要对该部分进行扩容。
    - PostgreSQL 与 pgpool（若为 <b>high-availability</b> 模式）。Postgres 负载过高会导致所有相关规则节点（保存属性、读取属性等）及整体系统处理变慢。
    - Cassandra（若用作时序数据存储）。Cassandra 负载过高会导致所有相关规则节点（保存时序等）处理变慢。
    - Queue。无论使用何种 queue 类型，请确保资源充足。

- 若使用 Kafka 作为 queue，检查 [consumer-group lag](#consumer-group-message-lag-for-kafka-queue)。

- 启用 [Message Pack Processing Log](#message-pack-processing-log)，可查看最慢规则节点名称。

- 按不同队列拆分用例。若某些设备需要独立于其他设备处理，应为该组[配置](/docs/{{docsPrefix}}user-guide/device-profiles/#queue-name)独立规则引擎队列。也可在 Root 规则引擎内，根据逻辑将消息分发到不同队列。这样可保证一个用例的慢速处理不会影响其他用例。

