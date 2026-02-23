
* TOC
{:toc}

MQTT broker 的一项重要能力是接收客户端发布的消息、基于 topic 进行过滤，并将消息分发给订阅者。
这一过程在高负载下尤为重要。
本文将介绍为确保 TBMQ 能够可靠处理约 **1 亿**连接客户端并有效管理**每秒 600 万条 MQTT 发布消息**吞吐量所采取的措施。

![image](/images/mqtt-broker/reference/perf-tests/mqtt-broker-perf-tests.png)

## 测试方法

我们选择 Amazon Web Services (AWS) 作为执行性能测试的云提供商。
在 [EKS](https://aws.amazon.com/eks/) 集群中部署了 25 节点的 TBMQ 集群（每个 EC2 实例/节点部署 1 个 broker pod），并连接 [RDS](https://aws.amazon.com/rds/) 和 [Kafka](https://kafka.apache.org/)。
有关 TBMQ 架构的全面了解，请参阅后续[页面](/docs/{{docsPrefix}}mqtt-broker/architecture/)。
RDS 以单实例部署，Kafka 由 9 个 broker 组成，分布在 3 个可用区 (AZ) 中。

不同 IoT 设备配置文件在产生的消息数量和每条消息大小上各不相同。
我们模拟了发送含五个数据点的消息的智能追踪器设备。单条 "publish" 消息大小约为 **114 字节**。
以下是模拟消息结构，与真实测试用例略有不同，因为测试 agent 会生成有效载荷值。
```json
{ "lat": 40.761894, "long": -73.970455, "speed": 55.5, "fuel": 92, "batLvl": 81 }
```

发布者分为 500 个组，总计 20 万个发布者，每组 6k msg/s。
每组负责向其指定的 topic 模式传输数据，格式为 `CountryCode/RandomString/GroupId/ClientId`。
因此，发布者使用了约 **1 亿**个不同 topic 的广泛范围。
同时配置了 500 个订阅者组，每组包含一个 `APPLICATION` 订阅者。
这些订阅者使用的 topic 过滤器与各自发布者组的 topic 模式对应（即 `CountryCode/RandomString/GroupId/+`）。
因此，每个订阅者每秒可接收 6k 条消息，确保高效处理入站数据。

在上述场景中，TBMQ 集群稳定维持 100,000,500 个连接，有效处理每秒 600 万条消息的吞吐量。
吞吐量指每秒消息总数，包括入站和出站消息。
每秒处理 300 万条入站消息，在 1 小时测试运行中总计 108 亿条消息。

[测试 agent](#how-to-repeat-the-tests) 协调 MQTT 客户端的配置和建立，支持灵活配置其数量。
这些客户端持续运行，不断通过 MQTT 向指定 topic 发布时序数据。
此外，agent 还负责配置通过 topic 过滤器订阅以接收上述客户端发布的消息的 MQTT 客户端。

考虑到客户端的预热阶段，值得注意的是进行了 6 轮发布者各发送单条消息的操作。
因此，约 7 分钟内生成了总计 6 亿条预热消息。
这些预热消息用于准备系统并启动数据流。
除预热阶段外，整个测试共处理了 114 亿条消息。
该数字涵盖预热消息及完整测试期间产生和处理的后继消息。

该数据量约为 1TB，存储在标记为 `tbmq.msg.all` 的初始 Kafka topic 中。
每个配置为 APPLICATION 订阅者的订阅者在 Kafka 中都有专用 topic，
接收累计 2280 万条消息以供进一步处理和分析。
值得注意的是，在 500 个订阅者的配置下，数据收集仅依赖 Kafka，Postgres 不参与。
因为当前配置仅包含归类为 `APPLICATION` 的持久客户端。

**提示**：如需规划和管理 Kafka 磁盘空间，请调整 [大小保留策略](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes) 和 [时长保留策略](https://www.baeldung.com/kafka-message-retention)。
有关各 topic 相关配置的详细信息，请参阅[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/)文档。

每个 MQTT 客户端与 broker 建立独立连接。
该方法确保每个客户端独立运行并保持与 broker 的专用连接以实现无缝通信。

## 使用的硬件

| 服务名称               | **TBMQ**  | **AWS RDS (PostgreSQL)** | **Kafka**   |
|------------------------|-----------|--------------------------|-------------|
| 实例类型               | m6g.metal | db.m6i.large             | m6a.2xlarge |
| 内存 (GiB)              | 256       | 8                        | 32          |
| vCPU                    | 64        | 2                        | 8           |
| 存储 (GiB)             | 10        | 100                      | 500         |
| 网络带宽 (Gibps)       | 25        | 12.5                     | 12.5        |

[comment]: <> ( To format table as markdown, please use the online table generator https://www.tablesgenerator.com/markdown_tables )

## 测试总结

客户端连接速率达到了约 22k 连接/秒的显著水平，表明配置高效。
为确保无资源泄漏或随时间性能下降，测试执行了 1 小时，以便进行充分观察和分析。

以每秒 300 万条发布消息的速率（含预热消息），整个测试共处理了 114 亿条消息，实现约 1TB 的入站和出站吞吐量。
该数据量展示了 TBMQ 的可扩展性和处理能力。
为保持高可靠性和消息投递保障，发布者和订阅者均采用 **1** 级 MQTT 服务质量 (QoS)，即 `AT_LEAST_ONCE`。
该 QoS 级别确保消息至少投递一次，保证数据完整性和一致性。

考虑到测试的全面性，下表总结了关键要素和结果，便于查阅。

| 设备数 | 吞吐量 (msg/秒) | Broker CPU | Broker 内存 | Kafka CPU | Kafka 读写吞吐量 | PostgreSQL CPU | PostgreSQL 读写 IOPS |
|--------|-----------------|------------|-------------|-----------|------------------|----------------|---------------------|
| 100M   | 6M              | 45%        | 160GiB      | 58%       | 7k / 80k KiB/s   | 2%             | 小于 1 / 小于 3      |

以下统计提供了测试期间使用的 Kafka topic 的洞察
（即 `publish_msg`，[Kafka topic 重命名 [1]](https://github.com/thingsboard/tbmq/commit/8871403fcfdce3489ee2a49c1505b998ceb46c3c#diff-85b2fafc998caf1c7d67f51c40f5639ac9ee0ee68379e07ad2f63b083f010f13) 后为 `tbmq.msg.all`，
是存储所有消息的主 Kafka topic，以及若干接收数据的 APPLICATION 订阅者的应用 topic 示例）。

{% include images-gallery.html imageCollection="broker-topics-monitoring" %}

需要强调的是，所提供信息显示处理所有消息的成功率为 100%。
`publish_msg` 和应用 topic 包含压缩数据，因为生产者发送压缩数据且 Kafka broker 保留生产者设置的原始压缩编解码器（`compression.type` 属性）。
该方法在保持消息完整性和原始压缩设置的同时，确保高效的数据存储和传输。

接下来关注消息处理延迟。
下表包含关键统计，阐明该评估方面：

| 消息延迟 平均值 | 消息延迟 95 分位 | 发布确认 平均值 | 发布确认 95 分位 |
|-----------------|------------------|-----------------|------------------|
| 195 ms          | 295 ms           | 23 ms           | 55 ms            |

其中 "消息延迟 平均值" 表示从发布者发送消息到订阅者接收的平均时长，
"发布确认 平均值" 表示从发布者发送消息到收到 `PUBACK` 确认的平均时间，
95 分位为相应延迟统计的 95 百分位。

**经验总结**

当前配置下的 TBMQ 集群具备处理更大负载的能力。Kafka 提供可靠且高可用的消息处理。
在此场景中，`APPLICATION` 订阅者的使用以及测试性质导致 PostgreSQL 负载最小，每秒仅执行少量操作。
TBMQ 节点之间无直接通信，有助于水平扩展以达到上述结果。
尽管采用 QoS 0 可进一步提高消息速率，我们的目的是以更实际的配置展示 TBMQ 的处理能力。
一般而言，QoS 1 因在消息投递速度与可靠性之间取得平衡而广受欢迎。
TBMQ 适合低消息速率和高消息速率场景。
在 fan-in、p2p 和 fan-out 等多种处理场景中表现优异，同样适用于不同规模的部署。
凭借其固有的垂直和水平可扩展能力，broker 可适应小规模或大规模部署的需求。

**测试期间遇到的挑战**

在追求如此大规模的连接和数据流过程中，我们遇到了一些需要投入精力进行代码优化的场景。

例如，解决 Kafka 生产者断开连接问题，该问题会带来消息丢失的不利后果。
为解决此问题，我们实现了专用于处理 [Kafka 生产者的发布回调 [2]](https://github.com/thingsboard/tbmq/commit/4e8e6d8a2f9855c7df88074efc935cb7d19f593d) 的独立 executor 服务。
该措施有效解决了上述断开连接问题。

为进一步提升性能，我们通过利用 Kafka 生产者固有的线程安全特性，[消除了对专用发布队列的需求 [3]](https://github.com/thingsboard/tbmq/commit/443e260924e214ae89b0158a6369b06f38801bd0)。
该调整以另一种方式实现了消息排序保证，从而在整体系统效率方面带来额外收益。

引入了额外调整以提高处理速率，如与 [消息包处理、UUID 生成 [4]](https://github.com/thingsboard/tbmq/commit/47e674589269bb45291f471528c54370ebdaf7ed) 改进相关的提交，
以及采用 [无需显式刷新即可发送消息 [5]](https://github.com/thingsboard/tbmq/commit/3ec317072dead5cb5355d29dd7319ccde3403d04) 的机制。

为优化内存利用率并减少不必要的垃圾产生，我们进行了大量工作以改进整体内存使用。
这些增强 [6](https://github.com/thingsboard/tbmq/commit/56ede8e5ebbaa8deafd24b7a0d4050401835ebc0)、
[7](https://github.com/thingsboard/tbmq/commit/395d48917be0186fafbdfa12c0a9b145b66f31d2)、
[8](https://github.com/thingsboard/tbmq/commit/fa424ffc32837b4d4aa48b890eb3bc06908a7476)
不仅提升了 Garbage Collector 性能，还减少了 stop-the-world 暂停，从而改善了整体系统响应性。

在后期的大规模测试阶段，我们观察到客户端在 broker 节点之间分布不均。
这导致特定 broker 节点负载 disproportionate，对发布者影响较小，但对 APPLICATION 客户端影响显著，需要更多资源。
结果是一个 broker 节点处理的请求远多于其他节点。
为解决此问题，我们设计了一种机制，确保 [broker 节点间的客户端均匀分布 [9]](https://github.com/thingsboard/tb-mqtt-perf-tests/commit/bd7649a9321f56f68303b380e634617fa0abc098)，
并伴随其他小幅性能改进。

通过这些努力，我们成功解决了沿途的各种挑战，优化了代码性能，确保了系统的平稳高效运行。

## TCO 计算

以下为使用 AWS 部署 TBMQ 的总拥有成本 (TCO) 计算。

**重要说明**：以下所有计算和价格均为近似值，仅供说明用途。
要获取精确的价格信息，强烈建议咨询您的云服务提供商。
例如，AWS 提供多种成本节省机会，如 [Savings Plans](https://aws.amazon.com/savingsplans/)（最高 72% 折扣）、
[RDS Reserved Instances](https://aws.amazon.com/rds/reserved-instances/)（最高 69%）、
[MSK Tiered Storage](https://aws.amazon.com/about-aws/whats-new/2022/10/amazon-msk-offers-low-cost-storage-tier-scales-virtually-unlimited-storage/)（50% 或更多），
以及多种其他选项。

us-east-1 区域的 AWS EKS 集群。约 73 美元/月。

AWS 实例类型：25 x m6g.metal 实例（64 vCPU AWS Graviton2 处理器，256 GiB，EBS GP3 10GiB）托管 25 个 TBMQ 节点。约 23,800 美元/月。

AWS RDS：db.m6i.large（2 vCPU，8 GiB），100GiB 存储。约 100 美元/月。

AWS MSK：9 个 broker（每 AZ 3 个 broker）x m6a.2xlarge（8 vCPU，32 GiB），4,500GiB 总存储。约 2,600 美元/月。

**TCO**：约 26,573 美元/月或每设备每月 0.0003 美元。

## 运行测试

**负载配置：**

* 1 亿个发布 MQTT 客户端（智能追踪器设备）；
* 500 个持久订阅 MQTT 客户端（消费数据的特定应用，如用于分析/图表）；
* 通过 MQTT 每秒 600 万条消息吞吐量，每条 MQTT 消息包含 5 个数据点，消息大小 114 字节；
* PostgreSQL 数据库存储 MQTT 客户端凭证、客户端会话状态；
* Kafka 队列持久化消息。

如前所述，上述消息速率和消息大小在初始 Kafka topic 中每小时产生约 **~1TB** 数据，
每个订阅者 topic 每小时约 **~1.6GB** 数据。

但是，出于可视化、分析等目的，不必长期存储数据。
TBMQ 负责接收消息、在订阅者之间分发，并可选择为离线客户端临时存储。
因此，建议根据您的具体需求配置适当的存储大小。
此外，提醒您务必配置 Kafka topic 的大小保留策略和时长保留策略。

测试 agent 由性能测试节点（runner）集群和监督这些 runner 的编排器组成。
为实现 runner 角色，我们部署了 2000 个发布者和 500 个订阅者 Kubernetes pod，另有一个 pod 作为编排器。

通过利用 JSON 配置，我们可以分别指定发布者和订阅者，将其组织成组以便灵活控制。
下面查看发布者和订阅者的配置。

发布者组：
```json
{
    "id":1,
    "publishers":200000,
    "topicPrefix":"usa/ydwvv/1/",
    "clientIdPrefix":null
}
```
{: .copy-code}
其中
* _id_ - 发布者组标识符；
* _publishers_ - 组中发布者客户端数量；
* _topicPrefix_ - 发布消息的 topic 前缀；
* _clientIdPrefix_ - 发布者的客户端 ID 前缀。

订阅者组：
```json
{
    "id":1,
    "subscribers":1,
    "topicFilter":"usa/ydwvv/1/+",
    "expectedPublisherGroups":[1],
    "persistentSessionInfo":{
        "clientType":"APPLICATION"
    },
    "clientIdPrefix":null
}
```
{: .copy-code}
其中
* _id_ - 订阅者组标识符；
* _subscribers_ - 组中订阅者客户端数量；
* _topicFilter_ - 订阅的 topic 过滤器；
* _expectedPublisherGroups_ - 当前订阅者将接收其消息的发布者组 id 列表（该参数用于调试和统计目的）；
* _persistentSessionInfo_ - 包含[客户端类型](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/)的持久化信息对象；
* _clientIdPrefix_ - 订阅者的客户端 ID 前缀。

**测试运行**

测试从客户端与集群建立连接开始。`APPLICATION` 客户端订阅相关 topic，发布者进入预热阶段。
100,000,500 个客户端在性能测试 pod 之间均匀分布，便于与 broker 并行连接。

一段时间后，所有客户端成功建立连接，每个性能测试 pod 通知编排器其就绪状态。

为评估进度，我们可以查看 `client_session`（[Kafka topic 重命名 [1]](https://github.com/thingsboard/tbmq/commit/8871403fcfdce3489ee2a49c1505b998ceb46c3c#diff-85b2fafc998caf1c7d67f51c40f5639ac9ee0ee68379e07ad2f63b083f010f13) 后为 `tbmq.client.session`）
Kafka topic。该 topic 提供连接会话的近似计数。

![image](/images/mqtt-broker/reference/topics/100m-mqtt-clients.png)

当所有 runner 就绪后，编排器通知集群已就绪，消息发布开始。

```text
09:12:35.407 [main] INFO  o.t.m.b.tests.MqttPerformanceTest - Start msg publishing.
```

经过一段时间的处理后，我们可以评估测试期间使用的 JMX、Grafana 和 [Kafka UI](https://github.com/redpanda-data/console) 等监控工具，以及 AWS CloudWatch 以获取更全面的洞察。
经检查，我们观察到良好结果。发布和消费的消息正在处理，无明显延迟。
应用处理器高效将消息投递给订阅者，确保平稳不中断的流。
此外，所有 100,000,500 个客户端与 broker 保持稳定连接。

{% include images-gallery.html imageCollection="broker-grafana-monitoring" %}

AWS 实例（部署 TBMQ 节点的位置）监控显示平均 CPU 负载约 45%。
另一方面，AWS RDS 资源未被利用，因为没有 DEVICE 持久客户端，每秒仅发送少量请求。
同时，Kafka 监控表明还有更多可用资源，暗示必要时可处理更高负载。

{% include images-gallery.html imageCollection="broker-aws-monitoring" %}

最后，让我们检查 TBMQ 的 JVM 状态。为此，我们必须转发 JMX 端口以建立连接并监控 Java 应用。

```bash
kubectl port-forward tb-broker-0 9999:9999
```
{: .copy-code}

请打开 [VisualVM](https://visualvm.github.io/) 并添加本地应用。
添加后打开它并让数据收集几分钟。
以下是 TBMQ 的 JMX 监控。Broker 节点运行平稳，无明显问题。

{% include images-gallery.html imageCollection="broker-jmx-monitoring" %}

## 如何复现测试

请参阅后续[安装指南](/docs/{{docsPrefix}}mqtt-broker/install/cluster/aws-cluster-setup/)了解如何在 AWS 上部署 TBMQ。
此外，您可以查看包含本性能测试期间运行 TBMQ 所用脚本和参数的 [branch](https://github.com/thingsboard/tbmq/tree/100M/k8s/aws#readme)。
最后，[性能测试工具](https://github.com/thingsboard/tb-mqtt-perf-tests/tree/100M)可用于执行性能测试，
该工具可生成 MQTT 客户端并产生负载。
配置性能测试时，您可以查看并修改
[发布者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/100M/k8s/broker-tests-publishers-config.yml) 和
[订阅者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/100M/k8s/broker-tests-subscribers-config.yml)
的配置文件以模拟所需负载。

## 结论

本性能测试展示了 TBMQ 集群能够高效处理来自不同设备的每秒 600 万条消息吞吐量，并同时处理 1 亿个并发连接。
我们致力于持续改进，将进行进一步工作以提升性能。
因此，我们预计在不久的将来发布 TBMQ 集群的更新性能结果。
我们真诚希望本文对评估 TBMQ 的人员以及希望在自己环境中进行性能测试的人员有所帮助。

如有反馈，欢迎在 [GitHub](https://github.com/thingsboard/tbmq) 和 [Twitter](https://twitter.com/thingsboard) 关注我们。

## 参考提交

[1] - [Kafka topic 重命名](https://github.com/thingsboard/tbmq/commit/8871403fcfdce3489ee2a49c1505b998ceb46c3c#diff-85b2fafc998caf1c7d67f51c40f5639ac9ee0ee68379e07ad2f63b083f010f13)。

[2] - [Kafka 生产者回调](https://github.com/thingsboard/tbmq/commit/4e8e6d8a2f9855c7df88074efc935cb7d19f593d)。

[3] - [停止将发布消息加入队列](https://github.com/thingsboard/tbmq/commit/443e260924e214ae89b0158a6369b06f38801bd0)。

[4] - [消息包处理、UUID 生成改进](https://github.com/thingsboard/tbmq/commit/47e674589269bb45291f471528c54370ebdaf7ed)。

[5] - [无需刷新发送消息](https://github.com/thingsboard/tbmq/commit/3ec317072dead5cb5355d29dd7319ccde3403d04)。

[6] - [ClientSessionInfo 对象复用](https://github.com/thingsboard/tbmq/commit/56ede8e5ebbaa8deafd24b7a0d4050401835ebc0)。

[7] - [移除应用发布消息副本](https://github.com/thingsboard/tbmq/commit/395d48917be0186fafbdfa12c0a9b145b66f31d2)。

[8] - [发布消息中的 Bytebuf](https://github.com/thingsboard/tbmq/commit/fa424ffc32837b4d4aa48b890eb3bc06908a7476)。

[9] - [broker 节点间 MQTT 客户端均匀分布](https://github.com/thingsboard/tb-mqtt-perf-tests/commit/bd7649a9321f56f68303b380e634617fa0abc098)。
