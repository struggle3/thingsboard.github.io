集群创建后，可使用以下命令将 kubectl 连接到该集群：

```bash
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

为验证连接，可执行以下命令：

```bash
kubectl get nodes
```
{: .copy-code}

您应能看到集群节点列表。
