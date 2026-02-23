您需要在 Azure 上设置 PostgreSQL。ThingsBoard 将使用其作为主数据库来存储设备、仪表板、规则链和设备遥测数据。

您可以按照[此](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/quickstart-create-server-portal)指南操作，但需注意以下要求：
   * 请妥善保管 postgresql 密码。本指南后续将使用 YOUR_RDS_PASSWORD 引用；
   * 确保 Azure Database for PostgreSQL 版本为最新 16.x；
   * 确保 Azure Database for PostgreSQL 实例可从 ThingsBoard 集群访问；
   * 确保使用 "thingsboard" 作为初始数据库名称；
    
以及建议：
   * 启用"高可用性"。默认启用多项有用设置；

另一种创建 Azure Database for PostgreSQL 的方式是使用 az 工具
（别忘了将 'POSTGRESS_USER' 和 'POSTGRESS_PASS' 替换为您的用户名和密码）：

```bash
az postgres flexible-server create --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP \
  --name $TB_DATABASE_NAME --admin-user POSTGRESS_USER --admin-password POSTGRESS_PASS \
  --public-access 0.0.0.0 --storage-size 32 \
  --version 12 -d thingsboard
```
{: .copy-code}

`az postgres flexible-server create` 有许多参数，其中部分为：

  - ***location***  - 位置。值来自：az account list-locations；
  - ***resource-group***（或 -g）- 资源组名称；
  - ***name*** - 服务器名称。名称只能包含小写字母、数字和连字符 (-)。最少 3 个字符，最多 63 个字符；
  - ***admin-user*** - 服务器管理员用户名。设置后无法更改；
  - ***admin-password***  - 管理员密码。最少 8 个字符，最多 128 个字符。密码必须包含以下四类字符中的三类：英文字母大写、英文字母小写、数字和非字母数字字符；
  - ***public-access*** - 确定公共访问。输入单个或 IP 地址范围以加入允许的 IP 列表。IP 地址范围必须以破折号分隔且不含空格。指定 0.0.0.0 允许 Azure 内部署的任何资源访问您的服务器。设置为 "None" 会将服务器置于公共访问模式但不创建防火墙规则；
  - ***storage-size*** - 服务器存储容量。最小 32 GiB，最大 16 TiB；
  - ***version*** - 服务器主版本。
  - ***high-availability*** - 启用或禁用高可用性功能。默认值为 Disabled。高可用性只能在灵活服务器创建时设置（接受值：Disabled、Enabled。默认值：Disabled）；
  - ***database-name***（或 -d）- 配置数据库服务器时要创建的数据库名称。

完整参数列表请参阅[此处](https://docs.microsoft.com/en-us/cli/azure/postgres/flexible-server?view=azure-cli-latest#az_postgres_flexible_server_create)。

响应示例：
```
{
  "connectionString": "postgresql://postgres:postgres@$tb-db.postgres.database.azure.com/postgres?sslmode=require",
  "databaseName": "thingsboard",
  "firewallName": "AllowAllAzureServicesAndResourcesWithinAzureIps_2021-11-17_15-45-6",
  "host": "tb-db.postgres.database.azure.com",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.DBforPostgreSQL/flexibleServers/thingsboard",
  "location": "East US",
  "password": "postgres",
  "resourceGroup": "myResourceGroup",
  "skuname": "Standard_D2s_v3",
  "username": "postgres",
  "version": "12"
}
```


请记下命令输出中的 **host** 值（本例中为 *tb-db.postgres.database.azure.com*）。
同时记下用户名和密码（*postgres*）。

编辑数据库设置文件，将 *YOUR_AZURE_POSTGRES_ENDPOINT_URL* 替换为 **host** 值，
*YOUR_AZURE_POSTGRES_USER* 和 *YOUR_AZURE_POSTGRES_PASSWORD* 替换为正确的值：

```bash
nano tb-node-db-configmap.yml
```


