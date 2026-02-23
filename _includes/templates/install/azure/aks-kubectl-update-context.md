集群创建后，可使用以下命令将 kubectl 连接到集群：
```
az aks get-credentials --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

进行验证可执行命令
```
kubectl get nodes
```
{: .copy-code}

您应看到集群节点列表
