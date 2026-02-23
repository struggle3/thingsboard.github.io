使用 Cassandra 为可选步骤。
若计划每秒插入超过 5K 数据点或需优化存储空间，建议使用 Cassandra。

#### 配置额外节点组

配置用于承载 Cassandra 实例的额外节点组。
可修改机型，建议至少 4 vCPU 和 16GB 内存。

将创建 **3** 个独立节点池，每个可用区 **1** 个节点。
因使用 EBS 磁盘，需避免 k8s 在对应磁盘不可用的可用区启动 pod。
这些可用区使用相同节点标签，我们将用该标签指定 StatefulSet 的部署目标。

在不同可用区部署 **3** 个 **m5.xlarge** 节点。可根据您的区域调整可用区：

```bash
eksctl create nodegroup --config-file=<path> --include='cassandra-*'
```
{: .copy-code}

{% assign tbCassandraRegionComments = ". Don't forget to replace *YOUR_AWS_REGION* with the name of your AWS region. " %}
{% assign tbCassandraRegion = "YOUR_AWS_REGION" %}
{% include templates/install/cassandra-k8s-common.md %}