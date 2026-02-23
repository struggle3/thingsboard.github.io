定义本指南后续命令中将使用的环境变量。

假设您使用 Linux。执行以下命令：

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

其中：

* TBMQResources — Azure 资源部署和管理的逻辑组。本指南后续将用 **AKS_RESOURCE_GROUP** 表示；
* eastus — 创建资源组的位置。本指南后续将用 **AKS_LOCATION** 表示。执行 `az account list-locations` 可查看所有可用位置；
* tbmq-gateway — Azure 应用程序网关名称；
* tbmq-cluster — 集群名称。本指南后续将用 **TB_CLUSTER_NAME** 表示；
* tbmq-db — 数据库服务器名称。可输入不同名称。本指南后续将用 **TB_DATABASE_NAME** 表示。
