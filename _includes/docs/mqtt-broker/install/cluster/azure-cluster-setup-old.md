* TOC
{:toc}

本指南将帮助您在 Azure AKS 上部署 TBMQ。

## 前置条件

{% include templates/mqtt-broker/install/azure/aks-prerequisites.md %}

## 步骤 1. 打开 TBMQ K8S 脚本仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/azure
```
{: .copy-code}

## 步骤 2. 定义环境变量

定义本指南后续命令中将用到的环境变量。

假设您使用 Linux，请执行：

```bash
export AKS_RESOURCE_GROUP=TBMQResources
export AKS_LOCATION=eastus
export AKS_GATEWAY=tbmq-gateway
export TB_CLUSTER_NAME=tbmq-cluster
export TB_DATABASE_NAME=tbmq-db
export TB_REDIS_NAME=tbmq-redis
echo "You variables ready to create resource group $AKS_RESOURCE_GROUP in location $AKS_LOCATION 
and cluster in it $TB_CLUSTER_NAME with database $TB_DATABASE_NAME"
```
{: .copy-code}

其中：

* TBMQResources - 用于部署和管理 Azure 资源的逻辑组，下文中以 **AKS_RESOURCE_GROUP** 表示；
* eastus - 创建资源组所在区域，下文中以 **AKS_LOCATION** 表示，可执行 `az account list-locations` 查看所有区域；
* tbmq-gateway - Azure 应用程序网关名称；
* tbmq-cluster - 集群名称，下文中以 **TB_CLUSTER_NAME** 表示；
* tbmq-db - 数据库服务器名称，可自定义，下文中以 **TB_DATABASE_NAME** 表示。

## Step 3. Configure and create AKS cluster

{% include templates/mqtt-broker/install/azure/aks-configure-and-create-cluster.md %}

## Step 4. Update the context of kubectl

{% include templates/mqtt-broker/install/azure/aks-update-kubectl-ctx.md %}

## Step 5. Provision PostgreSQL DB

You’ll need to set up PostgreSQL on Azure. You may follow [this](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/quickstart-create-server-portal) guide,
but take into account the following requirements:

* Keep your postgresql password in a safe place. We will refer to it later in this guide using YOUR_AZURE_POSTGRES_PASSWORD;
* Make sure your Azure Database for PostgreSQL version is 16.x;
* Make sure your Azure Database for PostgreSQL instance is accessible from the TBMQ cluster;
* Make sure you use "thingsboard_mqtt_broker" as the initial database name.

**Note**: Use "High availability" enabled. It enables a lot of useful settings by default.

Another way by which you can create Azure Database for PostgreSQL is using az tool (don’t forget to replace ‘POSTGRESS_USER’ and ‘POSTGRESS_PASS’ with your username and password):

```bash
az postgres flexible-server create --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP \
  --name $TB_DATABASE_NAME --admin-user POSTGRESS_USER --admin-password POSTGRESS_PASS \
  --public-access 0.0.0.0 --storage-size 32 \
  --version 16 -d thingsboard_mqtt_broker
```
{: .copy-code}

`az postgres flexible-server create` has a lot of parameters, a few of them are:

* **location** - Location. Values from: `az account list-locations`;
* **resource-group (or -g)** - Name of resource group;
* **name** - Name of the server. The name can contain only lowercase letters, numbers, and the hyphen (-) character. Minimum 3 characters and maximum 63 characters;
* **admin-user** - Administrator username for the server. Once set, it cannot be changed;
* **admin-password** - The password of the administrator. Minimum 8 characters and maximum 128 characters. Password must contain characters from three of the following categories: English uppercase letters, English lowercase letters, numbers, and non-alphanumeric characters;
* **public-access** - Determines the public access. Enter single or range of IP addresses to be included in the allowed list of IPs. IP address ranges must be dash-separated and not contain any spaces. Specifying 0.0.0.0 allows public access from any resources deployed within Azure to access your server. Setting it to “None” sets the server in public access mode but does not create a firewall rule;
* **storage-size** - The storage capacity of the server. Minimum is 32 GiB and maximum is 16 TiB;
* **version** - Server major version;
* **high-availability** - enable or disable high availability feature. High availability can only be set during flexible server creation (accepted values: Disabled, Enabled. Default value: Disabled);
* **database-name (or -d)** - The name of the database to be created when provisioning the database server.

You can see full parameters list [here](https://learn.microsoft.com/en-us/cli/azure/postgres/flexible-server?view=azure-cli-latest#az_postgres_flexible_server_create).

Example of response:

```text
{
  "connectionString": "postgresql://postgres:postgres@$tbmq-db.postgres.database.azure.com/postgres?sslmode=require",
  "databaseName": "thingsboard_mqtt_broker",
  "firewallName": "AllowAllAzureServicesAndResourcesWithinAzureIps_2021-11-17_15-45-6",
  "host": "tbmq-db.postgres.database.azure.com",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.DBforPostgreSQL/flexibleServers/thingsboard_mqtt_broker",
  "location": "East US",
  "password": "postgres",
  "resourceGroup": "TBMQResources",
  "skuname": "Standard_D2s_v3",
  "username": "postgres",
  "version": "16"
}
```

请记下命令输出中的 host 值（本例为 **tbmq-db.postgres.database.azure.com**），以及用户名和密码（**postgres**）。

编辑数据库配置文件，将 YOUR_AZURE_POSTGRES_ENDPOINT_URL 替换为 host 值，YOUR_AZURE_POSTGRES_USER 和 YOUR_AZURE_POSTGRES_PASSWORD 替换为正确值：

```bash
nano tb-broker-db-configmap.yml
```
{: .copy-code}

## 步骤 6. Azure Cache for Redis

您需要配置 Azure Cache for Redis。TBMQ 使用缓存为 [设备持久化客户端](/docs/mqtt-broker/architecture/#persistent-device-client) 存储消息，
以提升性能并减少频繁读库（详见下文）。

在启用认证且客户端连接 TBMQ 时，每次连接都会请求查找可认证该客户端的 MQTT 客户端凭据，
因此大量客户端同时连接时可能产生大量请求。

{% capture redis-azure-version %}
**注意：** 自 **TBMQ v2.1.0** 起，第三方 Redis 部署的官方支持版本为 Redis 7.2.5。
目前仅 Azure Cache for Redis 的 **Enterprise** 和 **Enterprise Flash** SKU 支持 Redis 7.2.x。
Basic、Standard 和 Premium SKU 仍仅支持至 **Redis 6.x**。为确保完全兼容，建议使用 Enterprise 级 SKU，以与 TBMQ 所需的 Redis 7.2.5 特性与行为一致。
{% endcapture %}
{% include templates/info-banner.md content=redis-azure-version %}

要配置 Redis，请参考以下任一指南：

- [快速入门：创建 Redis Enterprise 缓存（推荐）](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/quickstart-create-redis-enterprise)
- [快速入门：创建开源 Redis 缓存](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/quickstart-create-redis)

针对开源（传统）Redis 缓存，我们提供基于官方 Azure 文档、使用 `az` 工具的替代步骤：

```bash
az redis create --name $TB_REDIS_NAME --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP --sku basic --vm-size C0 --enable-non-ssl-port
```
{: .copy-code}

`az redis create` 的常用选项包括：

* **name**（或 -n）- Redis 缓存名称；
* **resource-group**（或 -g）- 资源组名称；
* **sku** - Redis 缓存类型（取值：Basic、Premium、Standard）；
* **vm-size** - 要部署的 Redis 缓存规格，Basic/Standard 以 C 开头，Premium 以 P 开头（如 c0–c6、p1–p5）；
* **location**（或 -l）- 区域，取值参见：`az account list-locations`。

完整参数列表见 [此页](https://learn.microsoft.com/en-us/cli/azure/redis?view=azure-cli-latest)。

响应示例：

```text
{
  "accessKeys": null,
  "enableNonSslPort": true,
  "hostName": "tbmq-redis.redis.cache.windows.net",
  "id": "/subscriptions/daff3288-1d5d-47c7-abf0-bfb7b738a18c/resourceGroups/myResourceGroup/providers/Microsoft.Cache/Redis/tbmq-redis",
  "instances": [
    {
      "isMaster": false,
      "isPrimary": false,
      "nonSslPort": 13000,
      "shardId": null,
      "sslPort": 15000,
      "zone": null
    }
  ],
  "linkedServers": [],
  "location": "East US",
  "minimumTlsVersion": null,
  "name": "tbmq-redis",
  "port": 6379,
  "privateEndpointConnections": null,
  "provisioningState": "Creating",
  "publicNetworkAccess": "Enabled",
  "redisConfiguration": {
    "maxclients": "256",
    "maxfragmentationmemory-reserved": "12",
    "maxmemory-delta": "2",
    "maxmemory-reserved": "2"
  },
  "redisVersion": "6.0.20",
  "replicasPerMaster": null,
  "replicasPerPrimary": null,
  "resourceGroup": "myResourceGroup",
  "shardCount": null,
  "sku": {
    "capacity": 0,
    "family": "C",
    "name": "Basic"
  },
  "sslPort": 6380,
  "staticIp": null,
  "subnetId": null,
  "tags": {},
  "tenantSettings": {},
  "type": "Microsoft.Cache/Redis",
  "zones": null
}
```

请取 `hostName` 参数，在 _tb-broker-cache-configmap.yml_ 文件中将 `YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT` 替换为该值。

然后获取 Redis 连接密钥，执行：

```bash
az redis list-keys --name $TB_REDIS_NAME --resource-group $AKS_RESOURCE_GROUP
```
{: .copy-code}

将 "primary" 复制到 _tb-broker-cache-configmap.yml_ 中，替换 `YOUR_REDIS_PASSWORD`。

更多说明请参阅 [此脚本](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/scripts/create-manage-cache#run-the-script)。

## 步骤 7. 安装

执行以下命令完成数据库的初始配置。
该命令会启动短期运行的 TBMQ pod，以创建所需数据库表、索引等。

```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

命令结束后，控制台应出现：

```text
INFO  o.t.m.b.i.ThingsboardMqttBrokerInstallService - Installation finished successfully!
```

{% capture aws-rds %}

否则请检查是否在 `tb-broker-db-configmap.yml` 中正确设置了 PostgreSQL URL 和 PostgreSQL 密码。

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}

## 步骤 8. 配置 Kafka

{% include templates/mqtt-broker/install/cluster-common/provision-kafka.md %}

## 步骤 9. 启动

执行以下命令部署 Broker：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

数分钟后可执行以下命令查看所有 Pod 状态：

```bash
kubectl get pods
```
{: .copy-code}

若一切正常，应能看到 `tb-broker-0` 和 `tb-broker-1`，且均为 `READY` 状态。

## 步骤 10. 配置负载均衡器

### 10.1 配置 HTTP(S) 负载均衡器

配置 HTTP(S) 负载均衡器以访问 TBMQ 实例的 Web 界面。主要有两种配置方式：

* http - 不支持 HTTPS 的负载均衡器，建议用于 **开发**，配置简单、成本低，适合开发环境，不适合生产。
* https - 支持 HTTPS 的负载均衡器，建议用于 **生产**，作为 SSL 终止点，可方便配置与维护有效 SSL 证书，并将非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。

请按下方链接/说明配置相应选项。

#### HTTP 负载均衡器

执行以下命令部署纯 HTTP 负载均衡器：

```bash
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

负载均衡器创建可能需一定时间，可用以下命令定期查看状态：

```bash
kubectl get ingress
```
{: .copy-code}

创建完成后，输出应类似：

```text
NAME                          CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```

#### HTTPS 负载均衡器

要使用 SSL 证书，可在 Azure Application Gateway 中直接添加证书，执行：

```bash
az network application-gateway ssl-cert create \
   --resource-group $(az aks show --name $TB_CLUSTER_NAME --resource-group $AKS_RESOURCE_GROUP --query nodeResourceGroup | tr -d '"') \
   --gateway-name $AKS_GATEWAY\
   --name TBMQHTTPSCert \
   --cert-file YOUR_CERT \
   --cert-password YOUR_CERT_PASS
```
{: .copy-code}

执行以下命令部署纯 HTTPS 负载均衡器：

```bash
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

### 10.2 配置 MQTT 负载均衡器

配置 MQTT 负载均衡器以支持使用 MQTT 协议连接设备。

Create TCP load balancer using following command:

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

The load balancer will forward all TCP traffic for ports 1883 and 8883.

#### MQTT over SSL

按 [本指南](https://thingsboard.io/docs/user-guide/mqtt-over-ssl/) 创建包含 SSL 证书的 .pem 文件，并以 _server.pem_ 保存到工作目录。

您需要创建包含 PEM 文件的 config-map，可执行：

```bash
kubectl create configmap tbmq-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* **YOUR_PEM_FILENAME** 为 **服务器证书文件** 名称。
* **YOUR_PEM_KEY_FILENAME** 为 **服务器证书私钥文件** 名称。

然后，取消注释 'tb-broker.yml' 文件中所有标有「Uncomment the following lines to enable two-way MQTTS」的段落。

执行以下命令使更改生效：

```bash
kubectl apply -f tb-broker.yml
```
{: .copy-code}

## 步骤 11. 验证部署

现在可使用负载均衡器的 DNS 名称在浏览器中打开 TBMQ Web 界面。

获取负载均衡器 DNS 名称可执行：

```bash
kubectl get ingress
```
{: .copy-code}

输出应类似：

```text
NAME                          CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       34.111.24.134   80      3d1h
```

使用 tb-broker-http-loadbalancer 的 `ADDRESS` 字段连接集群。

{% include templates/mqtt-broker/login.md %}

### 验证 MQTT 访问

要通过 MQTT 连接集群，需获取对应服务 IP，可执行：

```bash
kubectl get services
```
{: .copy-code}

输出应类似：

```text
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP              PORT(S)                         AGE
tb-broker-mqtt-loadbalancer   LoadBalancer   10.100.119.170   *******                  1883:30308/TCP,8883:31609/TCP   6m58s
```

使用负载均衡器的 `EXTERNAL-IP` 字段通过 MQTT 协议连接集群。

### 故障排除

若遇问题可查看服务日志。例如查看 TBMQ 日志可执行：

```bash
kubectl logs -f tb-broker-0
```
{: .copy-code}

使用以下命令查看所有 StatefulSet 状态：
```bash
kubectl get statefulsets
```
{: .copy-code}

更多命令说明请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)。

## 升级

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### 备份与恢复（可选）

强烈建议在升级前备份 PostgreSQL 数据库，但此为可选步骤。
更多说明请参阅 [后续说明](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-backup-restore)。

### 升级至 2.2.0

在此版本中，MQTT 认证机制已从 YAML/环境变量配置迁移到数据库。
升级时，TBMQ 需要知道当前部署启用了哪些认证提供方。
该信息通过传入 **升级 pod** 的环境变量提供。

升级脚本要求存在名为 **`database-setup.yml`** 的文件并在此文件中显式定义这些变量。
升级过程中不会使用 `tb-broker.yml` 中的环境变量，仅使用 `database-setup.yml` 中的值。

> **提示**
> 若仅使用 Basic 认证，请设置 `SECURITY_MQTT_SSL_ENABLED=false`。
> 若仅使用 X.509 认证，请设置 `SECURITY_MQTT_BASIC_ENABLED=false` 和 `SECURITY_MQTT_SSL_ENABLED=true`。

**支持的变量**

* `SECURITY_MQTT_BASIC_ENABLED`（`true|false`）
* `SECURITY_MQTT_SSL_ENABLED`（`true|false`）
* `SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT`（`true|false`）— 通常为 `false`。

准备好该文件并确认取值后，请按 [升级流程](#run-upgrade) 执行。

### 升级至 2.1.0

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release-cluster.md %}

### 升级至 2.0.0

升级到 TBMQ v2.0.0 时，若尚未安装 Redis，请先按 [步骤 6](#step-6-azure-cache-for-redis) 完成安装后再执行 [升级](#run-upgrade)。

### 执行升级

若要升级，请从最新发布分支拉取最近更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

{% include templates/mqtt-broker/upgrade/upgrade-to-custom-release.md %}

**注意**：请确保在合并过程中不丢失您的自定义修改。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

然后执行以下命令：

{% capture tabspec %}tbmq-upgrade
tbmq-upgrade-without-from-version,Since v2.1.0,shell,resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh,/docs/mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh
tbmq-upgrade-with-from-version,Before v2.1.0,markdown,resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md,/docs/mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md{% endcapture %}
{% include tabs.html %}

{% include templates/mqtt-broker/upgrade/stop-tbmq-pods-before-upgrade.md %}

## 删除集群

执行以下命令删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令删除所有 TBMQ 节点及 configmap、负载均衡器等：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令删除 AKS 集群：

```bash
az aks delete --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
