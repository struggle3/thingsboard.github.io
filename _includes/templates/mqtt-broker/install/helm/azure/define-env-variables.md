定义本指南后续命令中将使用的环境变量。

假设您使用 Linux，请执行以下命令：

```bash
export AKS_RESOURCE_GROUP=TBMQResources
export AKS_LOCATION=eastus
export AKS_GATEWAY=tbmq-gateway
export TB_CLUSTER_NAME=tbmq-cluster
export TB_DATABASE_NAME=tbmq-db
echo "You variables ready to create resource group $AKS_RESOURCE_GROUP in location $AKS_LOCATION 
and cluster in it $TB_CLUSTER_NAME with database $TB_DATABASE_NAME"
```
{: .copy-code}

参数说明：

* TBMQResources - 用于部署和管理 Azure 资源的逻辑组，本指南后续以 **$AKS_RESOURCE_GROUP** 引用；
* eastus - 创建资源组的区域，本指南后续以 **$AKS_LOCATION** 引用。执行 `az account list-locations` 可查看所有区域列表；
* tbmq-gateway - Azure Application Gateway 的名称；
* tbmq-cluster - 集群名称，本指南后续以 **$TB_CLUSTER_NAME** 引用；
