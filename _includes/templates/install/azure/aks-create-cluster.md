创建 AKS 集群之前，我们需要先创建 Azure 资源组，将使用 Azure CLI 完成此操作：
```
az group create --name $AKS_RESOURCE_GROUP --location $AKS_LOCATION
```
{: .copy-code}

有关 `az group` 的更多信息，请参阅[此文档](https://docs.microsoft.com/en-us/cli/azure/group)。

创建资源组后，可使用以下命令在其中创建 AKS 集群：
```
az aks create --resource-group $AKS_RESOURCE_GROUP \
    --name $TB_CLUSTER_NAME \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --appgw-name $AKS_GATEWAY \
    --appgw-subnet-cidr "10.2.0.0/16" \
    --node-vm-size Standard_DS3_v2 \
    --node-count {{nodeCount}}
```
{: .copy-code}

`az aks create` 有两个必需参数：`name` 和 `resource-group`（使用之前设置的变量），以及多个可选参数（将使用默认值），其中部分为：

  - ***node-count*** - Kubernetes 节点池中的节点数量。创建集群后，可使用 az aks scale 更改节点池大小（默认值为 3）；
  - ***enable-addons*** - 以逗号分隔列表启用 Kubernetes 附加组件（使用 az aks addon list 获取可用附加组件列表）；
  - ***node-osdisk-size*** - 给定代理池中机器使用的 OS 磁盘类型：Ephemeral 或 Managed。在 VM 大小和 OS 磁盘大小允许的情况下默认为 'Ephemeral'。创建后可能无法更改；
  - ***node-vm-size（或 -s）*** - 作为 Kubernetes 节点创建的虚拟机大小（默认值为 Standard_DS2_v2）；
  - ***generate-ssh-keys*** - 如缺少则生成 SSH 公钥和私钥文件。密钥将存储在 ~/.ssh 目录。

上述命令中我们添加了 [ApplicationGateway](https://docs.microsoft.com/en-us/azure/application-gateway/) 的 AKS 附加组件。我们将使用此网关作为 ThingsBoard 基础设施的基于路径的负载均衡器。

`az aks create` 的完整选项列表请参阅[此处](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az_aks_create)。


您也可以按照[此](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal)指南进行自定义集群设置。
