在 3 个可用区内创建分布式的区域集群，使用您偏好的机器类型。
以下示例在每个可用区预置 **1** 个 **e2-standard-4** 节点（**共三个节点**），但您可以根据工作负载需求修改 `--machine-type` 和 `--num-nodes`。
有关可用机器类型及其规格的完整列表，请参阅 [GCP 机器类型文档](https://cloud.google.com/compute/docs/machine-resource)。

执行以下命令（推荐）：

```bash
gcloud container clusters create $TB_CLUSTER_NAME \
--release-channel stable \
--region $GCP_REGION \
--network=$GCP_NETWORK \
--node-locations $GCP_ZONE1,$GCP_ZONE2,$GCP_ZONE3 \
--enable-ip-alias \
--num-nodes=1 \
--node-labels=role=main \
--machine-type=e2-standard-4
```
{: .copy-code}

或者，您可以使用[此](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-regional-cluster)指南进行自定义集群设置。
