使用 Cassandra 为可选步骤。
如计划每秒插入超过 5K 数据点或希望优化存储空间，建议使用 Cassandra。

#### 预置附加节点池

预置将托管 Cassandra 实例的附加节点池。
您可以更改机器类型。建议至少 4 个 vCPU 和 16GB 内存。

我们将在三个可用区各创建 **3** 个独立节点池，每个 zone **1** 个节点。
由于计划使用区域磁盘，我们不希望 k8s 在对应磁盘不可用的节点上启动 Pod。
这些 zone 将具有相同的节点标签。我们将使用此标签来定位 StatefulSet 的部署。

因此，为您所在位置在三个 zone 中定义 **3** 个节点池：

```bash
az aks nodepool add --resource-group $AKS_RESOURCE_GROUP --cluster-name $TB_CLUSTER_NAME --name tbcassandra1 --node-count 1 --zones 1 --labels role=cassandra
az aks nodepool add --resource-group $AKS_RESOURCE_GROUP --cluster-name $TB_CLUSTER_NAME --name tbcassandra2 --node-count 1 --zones 2 --labels role=cassandra
az aks nodepool add --resource-group $AKS_RESOURCE_GROUP --cluster-name $TB_CLUSTER_NAME --name tbcassandra3 --node-count 1 --zones 3 --labels role=cassandra
```
{: .copy-code}

{% assign tbCassandraRegion = "dc1" %}
{% include templates/install/azure/cassandra-k8s-common.md %}
