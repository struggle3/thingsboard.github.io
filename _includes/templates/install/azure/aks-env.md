定义您将在本指南后续命令中使用的环境变量。

假设您使用 Linux。执行以下命令：

```bash
export AKS_RESOURCE_GROUP=ThingsBoardResources
export AKS_LOCATION=eastus
export AKS_GATEWAY=tb-gateway
export TB_CLUSTER_NAME=tb-cluster
export TB_DATABASE_NAME=tb-db
export TB_REDIS_NAME=tb-redis
echo "您的变量已就绪，可在 $AKS_LOCATION 创建资源组 $AKS_RESOURCE_GROUP，以及其中的集群 $TB_CLUSTER_NAME 和数据库 $TB_DATABASE_NAME"
```
{: .copy-code}

其中：
   - myResourceGroup - 用于部署和管理 Azure 资源的逻辑组。本指南后续将使用 ***AKS_RESOURCE_GROUP*** 引用；
   - *eastus* - 要创建资源组的位置。本指南后续将使用 ***AKS_LOCATION*** 引用；
    执行 *az account list-locations* 可查看所有位置列表；
   - *tb-gateway* - Azure 应用程序网关名称；
   - *tb-cluster* - 集群名称。本指南后续将使用 ***TB_CLUSTER_NAME*** 引用；
   - *tb-db* - 数据库服务器名称。您可输入不同名称。本指南后续将使用 TB_DATABASE_NAME 引用；
