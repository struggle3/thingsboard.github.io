TBMQ 依赖 **Valkey** 存储[设备持久化客户端](/docs/{{docsPrefix}}mqtt-broker/architecture/#persistent-device-client)的消息。
缓存还能减少直接数据库读取次数，提升性能，尤其是在启用认证且多客户端同时连接时。
若不使用缓存，每次新连接都会触发数据库查询以验证 MQTT 客户端凭据，在高连接率下可能导致不必要的负载。

在 Google Cloud 中配置 Valkey，请参阅 Valkey 的 Google Memorystore 文档：

* **创建 Memorystore for Valkey 实例**：
  预配**启用集群模式**和**禁用集群模式**实例的说明，包括服务连接策略和网络配置等前置条件。
  ([Google Cloud][1])

* **概述**：
  托管 Valkey 服务的详细信息、架构及分片、端点和支持的 Valkey 版本（含 8.0）等核心概念。
  ([Google Cloud][2])

* **网络要求**：
  Private Service Connect 及服务连接策略设置的相关指导，用于建立安全连接。
  ([Google Cloud][3])

* **实例和节点 sizing**：
  根据工作负载（如 `standard-small`、`highmem-medium`）选择节点类型的建议、内存容量及性能特点。
  ([Google Cloud][4])

* **集群 vs 单机（启用 vs 禁用集群模式）**：
  水平扩展、吞吐量和功能支持的对比，有助于根据使用场景选择合适模式。
  ([Google Cloud][5])

* **高可用与副本**：
  多可用区部署、副本用于读扩展及生产环境弹性相关的最佳实践。
  ([Google Cloud][6])

* **最佳实践与扩展指南**：
  内存管理、淘汰策略、何时扩展及如何应对增长负载的建议。
  ([Google Cloud][7])

Valkey 集群就绪后，在 `tbmq-cache-configmap.yml` 中更新缓存配置，填入正确的端点值：

* **Valkey 单机**：
  取消注释并设置以下值。请确保 `REDIS_HOST` 的值**不**包含端口（`:6379`）。

  ```yaml
  REDIS_CONNECTION_TYPE: "standalone"
  REDIS_HOST: "YOUR_VALKEY_ENDPOINT_URL_WITHOUT_PORT"
  #REDIS_PASSWORD: "YOUR_REDIS_PASSWORD"
  ```

* **Valkey 集群**：
  提供以逗号分隔的 "host:port" 节点端点列表，用于引导。

  ```yaml
  REDIS_CONNECTION_TYPE: "cluster"
  REDIS_NODES: "COMMA_SEPARATED_LIST_OF_NODES"
  #REDIS_PASSWORD: "YOUR_REDIS_PASSWORD"
  # Kubernetes 中处理动态 IP 和故障转移时建议启用：
  #REDIS_LETTUCE_CLUSTER_TOPOLOGY_REFRESH_ENABLED: "true"
  #REDIS_JEDIS_CLUSTER_TOPOLOGY_REFRESH_ENABLED: "true"
  ```

[1]: https://cloud.google.com/memorystore/docs/valkey/create-instances "Create instances | Memorystore for Valkey | Google Cloud"
[2]: https://cloud.google.com/memorystore/docs/valkey/product-overview "Memorystore for Valkey overview - Google Cloud"
[3]: https://cloud.google.com/memorystore/docs/valkey/networking "Networking | Memorystore for Valkey | Google Cloud"
[4]: https://cloud.google.com/memorystore/docs/valkey/instance-node-specification "Instance and node specification | Memorystore for Valkey | Google Cloud"
[5]: https://cloud.google.com/memorystore/docs/valkey/cluster-mode-enabled-and-disabled "Enable and disable cluster mode | Memorystore for Valkey - Google Cloud"
[6]: https://cloud.google.com/memorystore/docs/valkey/ha-and-replicas "High availability and replicas | Memorystore for Valkey | Google Cloud"
[7]: https://cloud.google.com/memorystore/docs/valkey/general-best-practices "Best practices for Memorystore for Valkey - Google Cloud"
