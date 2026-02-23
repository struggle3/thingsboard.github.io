
* TOC
{:toc}

点对点（P2P）通信是MQTT的核心模式之一，使设备能够以一对一方式直接交换消息。
该模式特别适用于需要可靠、定向消息的IoT场景，如私信、命令下发及其他直接交互用例。
我们旨在评估代理在P2P通信场景下配合[持久化DEVICE客户端](/docs/{{docsPrefix}}mqtt-broker/architecture/#persistent-device-client)的表现。
持久化DEVICE客户端适合P2P消息，因其使用共享Kafka主题，减轻[Kafka](/docs/{{docsPrefix}}mqtt-broker/architecture/#kafka-topics)负载，并借助[Redis](/docs/{{docsPrefix}}mqtt-broker/architecture/#redis)
在客户端临时离线时仍保证可靠投递。测试在逐步将负载从200,000提升至
 **1,000,000条/秒**的同时扩展基础设施，展示了TBMQ的可扩展性与稳定性能。

![image](/images/mqtt-broker/reference/p2p-test/tbmq-perf-test-diagram.png)

## 测试方法论

为评估TBMQ在大规模点对点通信下的能力，我们进行了五项测试，以衡量性能、效率和延迟，最大吞吐量为1M条/秒。
吞吐量指每秒消息总数，包含入站与出站消息。
我们在AWS EKS集群上部署性能测试环境，并随负载增加水平扩展。
借此可评估TBMQ在满足增长需求的同时保持可靠性能的能力。

每项测试运行10分钟，使用相同数量的发布者与订阅者。
发布者和订阅者均采用**QoS 1**，以确保可靠投递。
订阅者将`clean_session`设为`false`，
从而在离线期间保留所有消息，并在重连后投递。
发布者每秒向唯一主题`"europe/ua/kyiv/$number"`发送62字节消息，
订阅者订阅对应主题`"europe/ua/kyiv/$number/+"`。
其中`$number`用作每对发布者与订阅者的唯一标识符。

### 测试代理配置

[测试代理](/docs/{{docsPrefix}}mqtt-broker/reference/1m-throughput-p2p-performance-test/#how-to-repeat-the-1m-msgsec-throughput-test)
用于模拟发布者与订阅者，以便在消息流量增长下真实评估TBMQ性能。
它由性能测试 pod（runner）集群及负责监控的编排器 pod 组成。
共有两类 runner pod：发布者和订阅者。测试中，发布者 pod 数量始终与订阅者 pod 数量相等，
且用于发布者 pod 的实例数始终等于用于订阅者 pod 的实例数。下表列出各吞吐量水平下**单类 runner（发布者或订阅者）**的每实例 pod 数量及部署实例数。

| 吞吐量（条/秒） | 每实例 Pod 数 | EC2 实例数 |
|----------------------|---------------|-------------------------|
| 200k                 | 5             | 1                       |
| 400k                 | 5             | 1                       |
| 600k                 | 10            | 1                       |
| 800k                 | 5             | 2                       |
| 1M                   | 5             | 4                       |

编排器 pod 部署在独立 EC2 实例上，该实例还托管 [Kafka Redpanda console](https://www.redpanda.com/redpanda-console-kafka-ui) 和 [Redis Insight](https://redis.io/docs/latest/operate/redisinsight/) 等组件，便于监控与协调。
该灵活配置使测试代理能应对流量增长，同时处理端口限制等基础设施约束。

### 基础设施概览

为清晰呈现测试环境，本节详述所用服务的硬件规格及 EKS 集群 pod 在 AWS EC2 实例上的分布情况。

**硬件规格**

| 服务名称 | TBMQ | Kafka | Redis | AWS RDS (PostgreSQL) |
|---------------------------|-------------|-----------|-----------|----------------------|
| 实例类型 | c7a.4xlarge | c7a.large | c7a.large | db.m6i.large |
| vCPU | 16 | 2 | 2 | 2 |
| 内存 (GiB) | 32 | 4 | 4 | 8 |
| 存储 (GiB) | 20 | 30 | 8 | 20 |
| 网络带宽 (Gibps) | 12.5 | 12.5 | 12.5 | 12.5 |

> **注意：** 所有测试均仅使用 Redis 主节点、未启用副本，以降低负载测试成本。
  该配置便于在不过度配置资源的前提下达成目标吞吐量。

**EC2 实例与 Pod 分布**

以下图像展示本测试中的 AWS EC2 实例及 EKS 集群 pod 在其上的分布：

{% include images-gallery.html imageCollection="tbmq-p2p-test-aws-infrastructure" %}

> **注意：** 图中基础设施为最终测试（1M 条/秒吞吐量）的配置。

每次测试期间根据负载调整实例规模，详见下一节。

## 性能测试

TBMQ 性能分阶段测试，从 200k 条/秒起步，每次增加 200k，直至 1M 条/秒。
每阶段调整 TBMQ 代理及 Redis 节点数量。在 1M 条/秒测试中，还扩展 Kafka 节点数以应对相应负载。
下表汇总各项测试配置。

| Throughput (msg/sec) | Publishers/Subscribers | TBMQ Nodes | Redis Nodes | Kafka Nodes |
|----------------------|------------------------|------------|-------------|-------------|
| 200k                 | 100k                   | 1          | 3           | 3           |
| 400k                 | 200k                   | 2          | 5           | 3           |
| 600k                 | 300k                   | 3          | 7           | 3           |
| 800k                 | 400k                   | 4          | 9           | 3           |
| 1M                   | 500k                   | 5          | 11          | 5           |

**Key takeaways from the tests include:**

 - Scalability: TBMQ demonstrated linear scalability. By incrementally adding TBMQ nodes, Redis nodes, and Kafka nodes at higher workloads, we maintained reliable performance as the message throughput increased from 200k to 1M msg/sec.
 - Efficient Resource Utilization: CPU utilization on TBMQ nodes remained consistently around ~90% across all test phases, indicating that the system effectively used available resources without overconsumption.
 - Latency Management: The observed latency across all tests remained **within two-digit bounds**. This was predictable given the **QoS 1** level chosen for our test, applied to both publishers and **persistent** subscribers. 
   We also tracked the average acknowledgment latency for publishers, which stayed within **single-digit bounds** across all test phases.
 - High Performance: TBMQ's one-to-one communication pattern showed excellent efficiency, processing about **8900 msg/s per CPU core**. 
   We calculated this by dividing the total throughput by the total number of CPU cores used in the setup.

Additionally, the following table and screenshots provide a comprehensive summary of the key elements and results of the final 1M msg/sec test.

| QoS | Msg latency Avg | Pub Ack Avg | TBMQ CPU Avg | Payload(bytes) |
|-----|-----------------|-------------|--------------|----------------|
| 1   | ~75ms           | ~8ms        | 91%          | 62             |

Where,

 - TBMQ CPU Avg: The average CPU utilization across all TBMQ nodes.
 - Msg Latency Avg: The average duration from when a message is transmitted by the publisher to when it is received by the subscriber.
 - Pub Ack Avg: The average time elapsed between the message transmission by the publisher and the reception of the PUBACK acknowledgment.

{% include images-gallery.html imageCollection="tbmq-p2p-test-monitoring" %}

These results demonstrate TBMQ的ability to provide reliable and scalable point-to-point messaging with excellent performance.
Our focus remains on further optimization to enhance performance without compromising reliability. 
For more details on potential improvements, see the [Future optimizations](/docs/{{docsPrefix}}mqtt-broker/reference/1m-throughput-p2p-performance-test/#future-optimizations) section.

## How to repeat the 1M Msg/sec throughput test

We recommend referring to our [installation guide](/docs/{{docsPrefix}}mqtt-broker/install/cluster/aws-cluster-setup/), which provides step-by-step instructions on how to deploy TBMQ on AWS.
In addition, you may explore the [branch](https://github.com/thingsboard/tbmq/tree/p2p-perf-test/k8s/aws#readme) containing the scripts and parameters used for running TBMQ during this performance test,
enabling you to gain deeper insights into our configuration. For the practical execution of performance tests, we offer a dedicated [performance testing tool](https://github.com/thingsboard/tb-mqtt-perf-tests/tree/p2p-perf-test)
capable of generating MQTT clients and simulating the desired message load. Especially for the P2P scenario testing, we improved our testing tool to have the ability to autogenerate the configuration for publishers and subscribers instead of loading it from a JSON configuration file.
Please refer to the [README.md](https://github.com/thingsboard/tb-mqtt-perf-tests/tree/p2p-perf-test/k8s#readme) for more details about P2P testing configuration.

## Migrating from Jedis to Lettuce: Overcoming a Key Testing Challenge

One of the most significant challenges during performance testing was overcoming the limitations of the [Jedis](https://github.com/redis/jedis) library, whose synchronous nature became a bottleneck in high-throughput scenarios.
With Jedis, each Redis command is sent and processed sequentially, meaning the system has to wait for each command to complete before issuing the next one.
This approach significantly limited Redis's potential to handle concurrent operations and fully utilize available system resources.

To address this, we [migrated](https://github.com/thingsboard/tbmq/pull/174) to the [Lettuce](https://github.com/redis/lettuce) client, which leverages [Netty](https://github.com/netty/netty) under the hood for efficient asynchronous communication.
Unlike Jedis, Lettuce allows multiple commands to be sent in parallel without waiting for their completion, enabling non-blocking operations and better resource utilization.
This architecture made it possible to fully exploit Redis's performance capabilities, especially under high message loads. Migration to Lettuce, however, was not trivial. 
It required rewriting a substantial portion of the codebase to transition from synchronous to asynchronous workflows. This included restructuring how Redis commands were issued and handled. 
Careful planning and rigorous testing ensured that these changes maintained system reliability and correctness.

## Future optimizations

Currently, we use [Lua scripts](https://redis.io/docs/latest/develop/interact/programmability/eval-intro/) in Redis to process messages for DEVICE persistent clients.
These scripts ensure atomic operations for saving, updating, and deleting messages, which is crucial for maintaining data consistency.
However, we execute one script per client to comply with Redis Cluster constraints, where all keys accessed in a script must reside in the same hash slot.

To optimize performance, we are considering adjusting the hashing mechanism for client IDs to intentionally group more clients into the same Redis hash slots.
By doing so, we aim to increase the likelihood of batching operations into a single script execution per hash slot, allowing the Lua scripts to handle multiple clients simultaneously.
This approach could reduce overhead and improve Redis efficiency, while still adhering to the cluster's constraints.

## Conclusion

Across all five tests, TBMQ demonstrated linear scalability and efficient resource utilization. As the workload increased from 200,000 to 1,000,000 msg/sec, 
the system ensured reliable message delivery and maintained sufficiently low latency, remaining within efficient bounds for point-to-point messaging scenarios.

These capabilities make TBMQ a dependable solution for IoT use cases requiring high-performance one-to-one communication with guaranteed delivery. 
While we plan to explore further optimizations to enhance performance, TBMQ has proven its suitability for high-throughput scenarios.

We value your feedback and encourage you to stay connected with our project on [GitHub](https://github.com/thingsboard/tbmq) and [Twitter](https://twitter.com/thingsboard).
