创建 AKS 集群前，需先创建 Azure 资源组。使用 Azure CLI 操作：

```bash
az group create --name $AKS_RESOURCE_GROUP --location $AKS_LOCATION
```
{: .copy-code}

有关 `az group` 的更多信息请参阅[此链接](https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest)。

资源组创建后，可使用以下命令创建 AKS 集群：

```bash
az aks create --resource-group $AKS_RESOURCE_GROUP \
    --name $TB_CLUSTER_NAME \
    --generate-ssh-keys \
    --enable-addons ingress-appgw \
    --appgw-name $AKS_GATEWAY \
    --appgw-subnet-cidr "10.225.0.0/24" \
    --node-vm-size Standard_D4s_v6 \
    --node-count 3
```
{: .copy-code}

`az aks create` 有两个必填参数：`name` 和 `resource-group`（使用先前设置的变量），
以及多个可选参数（未设置时使用默认值）。其中部分参数如下：

* **node-count** - Kubernetes 节点池中的节点数量。创建集群后，可用 `az aks scale` 调整节点池大小（默认值为 3）；
* **enable-addons** - 以逗号分隔的 Kubernetes 附加组件列表（使用 `az aks addon list` 查看可用附加组件）；
* **node-osdisk-size** - 给定代理池中机器的 OS 磁盘类型：临时或托管。在 VM 大小和 OS 磁盘大小满足条件时默认为 "Ephemeral"。创建后可能无法更改；
* **node-vm-size**（或 -s） - 创建为 Kubernetes 节点的虚拟机大小（默认值为 Standard_DS2_v2）；
* **generate-ssh-keys** - 若缺失则生成 SSH 公钥和私钥文件。密钥将存储在 ~/.ssh 目录中。

上述命令中添加了 [ApplicationGateway](https://learn.microsoft.com/en-us/azure/application-gateway/) 的 AKS 附加组件。
将使用该网关作为 TBMQ 的基于路径的负载均衡器。

`az aks create` 的完整选项请参阅[此处](https://learn.microsoft.com/en-us/azure/aks?view=azure-cli-latest#az_aks_create)。

您也可参考此[指南](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-portal?tabs=azure-cli)进行自定义集群配置。
