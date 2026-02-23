
* TOC
{:toc}

对于 MQTT broker，高负载下的最佳性能至关重要。
本文介绍 TBMQ 的一项性能测试，我们验证了其能够以单位数毫秒延迟处理**每秒 300 万条消息**的吞吐量。
仅使用单节点，我们便达到了 TBMQ 的能力极限。

![image](/images/mqtt-broker/reference/single-node-test/tbmq-perf-test-diagram.png)

## 测试方法

我们在 [EKS](https://aws.amazon.com/eks/) 集群中部署单个 TBMQ 节点，配合 3 个 [Kafka](https://kafka.apache.org/) 节点和 [RDS](https://aws.amazon.com/rds/) 实例，建立了性能测试环境。该配置为我们的性能测试提供了基础。

在本测试中，我们引入了 100 个发布者，每个负责每秒发布 10 条消息。
重要的是，每个发布者在其各自的 topic 上发布消息，遵循 `"CountryCode/City/ID"` 格式，其中 "ID" 为每个发布者的唯一标识符。
单条 "publish" 消息大小约为 66 字节。该方法使我们能够模拟不同的数据源。

为评估 TBMQ 高效分发消息的能力，我们引入了 3,000 个订阅者组成的网络。
每个订阅者订阅 topic 过滤器 `"CountryCode/City/#"`，表示接收所有发布者发布的所有消息。
这种广泛的消息分发考验了 broker 的能力。

在 30 分钟的性能测试期间，我们验证 TBMQ 是否能够稳定处理大量消息负载，
而不会出现性能下降或资源耗尽。

## 使用的硬件

| 服务名称               | **TBMQ**    | **AWS RDS (PostgreSQL)** | **Kafka** |
|------------------------|-------------|--------------------------|-----------|
| 实例类型               | m7a.8xlarge | db.m6i.large             | m7a.large |
| vCPU                   | 32          | 2                        | 2         |
| 内存 (GiB)             | 128         | 8                        | 8         |
| 存储 (GiB)             | 10          | 30                       | 50        |
| 网络带宽 (Gibps)       | 12.5        | 12.5                     | 12.5      |

[comment]: <> ( To format table as markdown, please use the online table generator https://www.tablesgenerator.com/markdown_tables )

## 测试总结

在单节点上运行的 TBMQ 成功处理了每秒 300 万条消息的吞吐量，展现出出色的性能。
这一显著成果彰显了 TBMQ 在实际场景中的可靠性。

同样令人瞩目的是 broker 的平均消息延迟仅为 **7.4 毫秒**。
该低延迟证明了 TBMQ 在高负载下仍能保证消息及时送达。

| 消息延迟 平均值 | 消息延迟 95 分位 |
|-----------------|------------------|
| 7.4 ms          | 11 ms            |

以下表格总结了测试的关键要素和结果，便于查阅。

| 发布者数量 | 订阅者数量 | 消息/秒 | 吞吐量 | QoS | 有效载荷  | TBMQ CPU | TBMQ 内存 |
|------------|-------------|---------|--------|-----|----------|----------|-----------|
| 100        | 3000        | 10      | 3M msg/s | 0 | 66 bytes | 54 %     | 75 GiB    |

**经验总结**

我们的测试凸显了为可靠性和可扩展性优化 TBMQ 的重要性。
结果表明 broker 能够轻松处理大量消息负载，是消息分发关键场景的理想选择。

我们观察到 TBMQ 的资源管理能力及其在高负载下保持稳定的能力。
这些观察可帮助用户配置以获得最佳性能。

**重要说明：** 在本性能测试过程中，我们对多种实例类型进行了实验。
尽管我们为 TBMQ 选用了 AWS `m7a.8xlarge` 实例类型，但需强调的是，在 `m7a.4xlarge`（16 vCPU，64 GiB RAM）实例上也取得了不俗的成绩。
该配置实现了 **14.2 ms** 的平均消息延迟，同时保持 **90% 的 CPU 使用率**。
这些结果表明 TBMQ 在不同实例类型上都具有良好的灵活性和性能潜力，
使用户可以根据自身需求选择最合适的配置。

## 运行测试

测试 agent 由性能测试节点（runner）集群和监督这些 runner 的编排器组成。
为实现各自角色，我们部署了 1 个发布者和 6 个订阅者 Kubernetes pod，另有一个 pod 作为编排器。
值得注意的是，每个发布者和订阅者 pod 分配在不同的 AWS EC2 实例上。

有关我们测试配置中使用的 AWS EC2 实例的完整视图，请参阅以下图片：

{% include images-gallery.html imageCollection="tbmq-3m-single-node-test-aws-instances" %}

测试开始涉及在客户端与 TBMQ 之间建立连接。订阅者客户端迅速建立订阅，而发布者客户端开始预热阶段。
当所有 runner 就绪后，编排器通知集群已就绪，消息发布随即开始。

经过一段时间的处理后，我们可以通过 JMX、htop、Kafka UI 以及 AWS CloudWatch 等监控工具进行更全面的评估。

监控工具显示平均 CPU 负载约为 **54%**。
这表明 TBMQ 具备较大的处理能力，能够高效处理更高的消息负载并应对消息投递峰值。

{% include images-gallery.html imageCollection="tbmq-3m-single-node-test-monitoring" %}

## 如何复现测试

我们建议参阅我们的[安装指南](/docs/{{docsPrefix}}mqtt-broker/install/cluster/aws-cluster-setup/)，其中包含在 AWS 上部署 TBMQ 的逐步说明。
此外，您可以查看包含本性能测试期间运行 TBMQ 所用脚本和参数的 [branch](https://github.com/thingsboard/tbmq/tree/3M-single-node-perf-test/k8s/aws#readme)，
以深入了解我们的配置。
对于实际执行性能测试，我们提供专用的[性能测试工具](https://github.com/thingsboard/tb-mqtt-perf-tests/tree/3M-single-node-perf-test)，
可生成 MQTT 客户端并模拟所需的消息负载。
配置性能测试时，您可以根据具体需求查看并修改
[发布者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/3M-single-node-perf-test/k8s/broker-tests-publishers-config.yml) 和
[订阅者](https://github.com/thingsboard/tb-mqtt-perf-tests/blob/3M-single-node-perf-test/k8s/broker-tests-subscribers-config.yml) 的配置文件。

## 结论

TBMQ 在单节点上成功以每秒 300 万条消息、平均延迟仅 7.4 毫秒的性能运行，再次印证其作为稳健且可扩展的 MQTT broker 的地位。
该成果表明 TBMQ 已准备好应对高要求工作负载，是依赖高效消息分发的应用的可靠选择。

我们将继续探索 TBMQ 的能力，持续提升性能和可靠性。
期待在未来分享更多 insights 和性能结果。

如有反馈，欢迎在 [GitHub](https://github.com/thingsboard/tbmq) 关注我们以了解最新动态。
