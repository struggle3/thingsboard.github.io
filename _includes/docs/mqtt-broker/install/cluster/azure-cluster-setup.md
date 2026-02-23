{% if docsPrefix == null %}
{% assign valkey_from_version = "v2.3.0" %}
{% else %}
{% assign valkey_from_version = "v2.2.0" %}
{% endif %}

* TOC
{:toc}

本指南将帮助你在 AKS 中部署 TBMQ {{tbmqSuffix}}。

## 前置要求

{% include templates/mqtt-broker/install/azure/aks-prerequisites.md %}

{% if docsPrefix == null %}
## 克隆 TBMQ 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/azure
```
{: .copy-code}

{% else %}
## 克隆 TBMQ PE K8S 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq-pe-k8s.git
cd tbmq-pe-k8s/azure
```
{: .copy-code}
{% endif %}

## 定义环境变量

{% include templates/mqtt-broker/install/azure/aks-define-env-variables.md %}

## 配置并创建 AKS 集群

{% include templates/mqtt-broker/install/azure/aks-configure-and-create-cluster.md %}

## 更新 kubectl 上下文

{% include templates/mqtt-broker/install/azure/aks-update-kubectl-ctx.md %}

## Provision PostgreSQL DB

You’ll need to set up PostgreSQL on Azure. You may follow [this](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/quickstart-create-server-portal) guide,
but take into account the following requirements:

* Keep your postgresql password in a safe place. We will refer to it later in this guide using **YOUR_AZURE_POSTGRES_PASSWORD**;
* Make sure your Azure Database for PostgreSQL version is 17.x;
* Make sure your Azure Database for PostgreSQL instance is accessible from the TBMQ cluster;
* Make sure you use "thingsboard_mqtt_broker" as the initial database name.

**Note**: Use "High availability" enabled. It enables a lot of useful settings by default.

Another way by which you can create Azure Database for PostgreSQL is using az tool (don’t forget to replace ‘POSTGRESS_USER’ and ‘POSTGRESS_PASS’ with your username and password):

```bash
az postgres flexible-server create --location $AKS_LOCATION --resource-group $AKS_RESOURCE_GROUP \
  --name $TB_DATABASE_NAME --admin-user POSTGRESS_USER --admin-password POSTGRESS_PASS \
  --public-access 0.0.0.0 --storage-size 32 \
  --version 17 -d thingsboard_mqtt_broker
```
{: .copy-code}

`az postgres flexible-server create` has a lot of parameters, a few of them are:

* **location** — Location. Values from: `az account list-locations`;
* **resource-group (or -g)** — Name of the resource group;
* **name** — Name of the server. The name can contain only lowercase letters, numbers, and the hyphen (-) character. Minimum 3 characters and maximum 63 characters;
* **admin-user** — Administrator username for the server. Once set, it cannot be changed;
* **admin-password** — The password of the administrator. Minimum 8 characters and maximum 128 characters. Password must contain characters from three of the following categories: English uppercase letters, English lowercase letters, numbers, and non-alphanumeric characters;
* **public-access** — Determines the public access. Enter single or range of IP addresses to be included in the allowed list of IPs. IP address ranges must be dash-separated and not contain any spaces. Specifying 0.0.0.0 allows public access from any resources deployed within Azure to access your server. Setting it to “None” sets the server in public access mode but does not create a firewall rule;
* **storage-size** — The storage capacity of the server. Minimum is 32 GiB and maximum is 16 TiB;
* **version** — Server major version;
* **high-availability** — enable or disable high-availability feature. High availability can only be set during flexible server creation (accepted values: Disabled, Enabled. Default value: Disabled);
* **database-name (or -d)** — The name of the database to be created when provisioning the database server.

You can see the full parameters list [here](https://learn.microsoft.com/en-us/cli/azure/postgres/flexible-server?view=azure-cli-latest#az_postgres_flexible_server_create).

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
  "version": "17"
}
```

记下命令输出中的 host 值（本示例为 **tbmq-db.postgres.database.azure.com**）以及用户名和密码（**postgres**）。

编辑数据库配置文件，将 **YOUR_AZURE_POSTGRES_ENDPOINT_URL** 替换为 host 值，**YOUR_AZURE_POSTGRES_USER** 和 **YOUR_AZURE_POSTGRES_PASSWORD** 替换为正确凭据：

```bash
nano tbmq-db-configmap.yml
```
{: .copy-code}

## Create Namespace

Let’s create a dedicated namespace for our TBMQ cluster deployment to ensure better resource isolation and management.

```bash
kubectl apply -f tbmq-namespace.yml
kubectl config set-context $(kubectl config current-context) --namespace=thingsboard-mqtt-broker
```
{: .copy-code}

## Azure Cache for Valkey

TBMQ {{tbmqSuffix}} 依赖 **Valkey** 存储 [DEVICE 持久客户端](/docs/{{docsPrefix}}mqtt-broker/architecture/#persistent-device-client) 的消息。
缓存还能减少直接数据库读取，提升性能，尤其在启用认证且多客户端并发连接时。
若无缓存，每次新连接都会触发数据库查询以验证 MQTT 客户端凭据，在高连接率下可能造成不必要的负载。

{% capture valkey-azure-version %}
**Note:** Starting from **TBMQ {{tbmqSuffix}} {{valkey_from_version}}**, [Valkey](https://valkey.io/) **8.0** is officially supported.
Azure currently does **not** provide a managed Valkey service. However, Valkey is fully compatible with **Redis 7.2.x**, which is supported on Azure **Cache for Redis Enterprise** and **Enterprise Flash** SKUs.
The Basic, Standard, and Premium SKUs only support up to **Redis 6.x**, and are therefore **not recommended** for TBMQ deployments.
To ensure compatibility with TBMQ {{tbmqSuffix}} {{valkey_from_version}} and later, deploy your own Valkey cluster or use an Enterprise-tier SKU.
{% endcapture %}
{% include templates/info-banner.md content=valkey-azure-version %}

可根据环境选择下列路径之一：

- [在 AKS 上部署 Valkey 集群](https://learn.microsoft.com/en-us/azure/aks/valkey-overview)**（推荐）**
- [快速入门：创建 Redis Enterprise 缓存](https://learn.microsoft.com/en-us/azure/redis/quickstart-create-managed-redis)

Azure Cache 就绪后，在 `tbmq-cache-configmap.yml` 中填入正确的 endpoint 配置：

* **独立 Redis**：
  取消注释并设置下列值。确保 `REDIS_HOST` **不**包含端口（`:6379`）。

  ```yaml
  REDIS_CONNECTION_TYPE: "standalone"
  REDIS_HOST: "YOUR_VALKEY_ENDPOINT_URL_WITHOUT_PORT"
  #REDIS_PASSWORD: "YOUR_REDIS_PASSWORD"
  ```

* **Valkey 集群**：
  提供以逗号分隔的 "host:port" 节点 endpoint 列表以进行引导。

  ```yaml
  REDIS_CONNECTION_TYPE: "cluster"
  REDIS_NODES: "COMMA_SEPARATED_LIST_OF_NODES"
  #REDIS_PASSWORD: "YOUR_REDIS_PASSWORD"
  # Recommended in Kubernetes for handling dynamic IPs and failover:
  #REDIS_LETTUCE_CLUSTER_TOPOLOGY_REFRESH_ENABLED: "true"
  #REDIS_JEDIS_CLUSTER_TOPOLOGY_REFRESH_ENABLED: "true"
  ```

**Valkey 集群创建提示**

官方 Azure 文档假设从全新环境创建 Valkey 集群。由于你已按本指南完成前期资源创建，需按下列方式调整：

* **跳过基础设施创建**：Resource Group 和 AKS 集群已创建，可跳过 `az group create` 和 `az aks create` 相关步骤。
* **可选服务**：可选择不创建 **Azure Key Vault (AKV)** 和 **Azure Container Registry (ACR)** 以简化部署。
* **节点池**：为 Valkey 创建专用节点池为可选。专用池隔离更好，也可使用现有节点池。
* **命名空间**：建议将 Valkey 集群部署到与 TBMQ 相同的命名空间（如 `thingsboard-mqtt-broker`），而非单独的 `valkey` 命名空间，便于统一管理。

#### 创建 Secret

若不使用 Azure Key Vault，需手动创建 generic Kubernetes secret。格式必须与 Valkey 容器期望的一致（含特定 key 与换行）。

<details markdown="1">
<summary>
Example: Manual Secret Creation
</summary>

```bash
# 1. Generate a random password (or set your own)
VALKEY_PASSWORD=$(openssl rand -base64 32)
echo "Generated Password: $VALKEY_PASSWORD"

# 2. Create the secret directly in Kubernetes
# We format it exactly how the container expects: 'requirepass' on line 1, 'primaryauth' on line 2
kubectl create secret generic valkey-password \
  --namespace thingsboard-mqtt-broker \
  --from-literal=valkey-password-file.conf=$'requirepass '"$VALKEY_PASSWORD"$'\nprimaryauth '"$VALKEY_PASSWORD"
```
{: .copy-code}
</details>

#### Deploying StatefulSets (Primaries and Replicas)

Proceed with creating the ConfigMap, Primary cluster pods, and Replica cluster pods. You will need to modify the Azure documentation examples to fit your environment:

* **Namespace:** Ensure all resources point to your defined namespace (e.g., `thingsboard-mqtt-broker`).
* **Affinity:** Update the `affinity` section. If you are using a shared node pool, remove the specific `nodeSelector` or `nodeAffinity` requirements. Instead, use `podAntiAffinity` to spread pods across nodes where possible.
* **Image:** If skipping ACR, use the public Docker image: `image: "valkey/valkey:8.0"`. **Note:** Avoid using the `:latest` tag for production stability; stick to a specific version.
* **Secret Volume:** Update the volume configuration to use the standard Kubernetes secret created in the previous step, replacing the CSI/Key Vault driver configuration.

<details markdown="1">
<summary>
Example: Modified StatefulSet for Primary pods
</summary>

```yaml
kubectl apply -f - <<EOF
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: valkey-masters
  namespace: thingsboard-mqtt-broker
spec:
  serviceName: "valkey-masters"
  replicas: 3
  selector:
    matchLabels:
      app: valkey
  template:
    metadata:
      labels:
        app: valkey
        appCluster: valkey-masters
    spec:
      terminationGracePeriodSeconds: 20
      affinity:
        # Removed nodeAffinity (dedicated pool requirement)
        # Soft Anti-Affinity to prefer spreading pods but allow scheduling on available nodes
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - valkey
              topologyKey: kubernetes.io/hostname
      containers:
      - name: role-master-checker
        image: "valkey/valkey:8.0"
        command:
          - "/bin/bash"
          - "-c"
        args:
          [
            "while true; do role=\$(valkey-cli --pass \$(cat /etc/valkey-password/valkey-password-file.conf | awk '{print \$2; exit}') role | awk '{print \$1; exit}');     if [ \"\$role\" = \"slave\" ]; then valkey-cli --pass \$(cat /etc/valkey-password/valkey-password-file.conf | awk '{print \$2; exit}') cluster failover; fi; sleep 30; done"
          ]
        volumeMounts:
        - name: valkey-password
          mountPath: /etc/valkey-password
          readOnly: true
      - name: valkey
        image: "valkey/valkey:8.0"
        env:
        - name: VALKEY_PASSWORD_FILE
          value: "/etc/valkey-password/valkey-password-file.conf"
        - name: MY_POD_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        command:
          - "valkey-server"
        args:
          - "/conf/valkey.conf"
          - "--cluster-announce-ip"
          - "\$(MY_POD_IP)"
        resources:
          requests:
            cpu: "100m"
            memory: "100Mi"
        ports:
            - name: valkey
              containerPort: 6379
              protocol: "TCP"
            - name: cluster
              containerPort: 16379
              protocol: "TCP"
        volumeMounts:
        - name: conf
          mountPath: /conf
          readOnly: false
        - name: data
          mountPath: /data
          readOnly: false
        - name: valkey-password
          mountPath: /etc/valkey-password
          readOnly: true
      volumes:
      - name: valkey-password
        # Replaced CSI/KeyVault with standard Kubernetes Secret
        secret:
          secretName: valkey-password
      - name: conf
        configMap:
          name: valkey-cluster
          defaultMode: 0755
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: managed-csi
      resources:
        requests:
          storage: 20Gi
EOF
```
{: .copy-code}
</details>

#### Finalizing the Setup

1.  **Services & PDB:** Create the headless services and the Pod Disruption Budget (PDB) as outlined in the documentation.
2.  **Initialization:** Run the Valkey cluster creation commands to join the nodes.
3.  **Verification:** Verify the roles of the pods and the replication status to ensure the cluster is healthy.

#### TBMQ Configuration

Once the cluster is verified, update your TBMQ configuration values:

* **REDIS_NODES:** Set this to the headless service DNS, e.g., `valkey-cluster:6379`.
* **REDIS_PASSWORD:** Use the password you generated during secret creation (or the value of `$VALKEY_PASSWORD`).

## Installation

Execute the following command to run the initial setup of the database.
This command will launch a short-living TBMQ pod to provision necessary DB tables, indexes, etc.

```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

After this command is finished, you should see the next line in the console:

```text
INFO  o.t.m.b.i.ThingsboardMqttBrokerInstallService - Installation finished successfully!
```

{% capture aws-rds %}

Otherwise, please check if you set the PostgreSQL URL and PostgreSQL password in the `tbmq-db-configmap.yml` correctly.

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}

{% include templates/mqtt-broker/install/cluster-common/configure-license-key.md %}

## Provision Kafka

{% include templates/mqtt-broker/install/cluster-common/provision-kafka-new.md %}

## Starting

{% include templates/mqtt-broker/install/cluster-common/starting.md %}

## Configure Load Balancers

### Configure HTTP(S) Load Balancer

Configure HTTP(S) Load Balancer to access the web interface of your TBMQ {{tbmqSuffix}} instance. Basically, you have 2 possible options of configuration:

* http — Load Balancer without HTTPS support. Recommended for **development**. The only advantage is simple configuration and minimum costs. May be a good option for development server but definitely not suitable for production.
* https — Load Balancer with HTTPS support. Recommended for **production**. Acts as an SSL termination point. You may easily configure it to issue and maintain a valid SSL certificate. Automatically redirects all non-secure (HTTP) traffic to secure (HTTPS) port.

See links/instructions below on how to configure each of the suggested options.

#### HTTP Load Balancer

{% include templates/mqtt-broker/install/cluster-common/configure-http-load-balancer.md %}

#### HTTPS Load Balancer

For using ssl certificates, we can add our certificate directly in Azure ApplicationGateway using the following command:

```bash
az network application-gateway ssl-cert create \
   --resource-group $(az aks show --name $TB_CLUSTER_NAME --resource-group $AKS_RESOURCE_GROUP --query nodeResourceGroup | tr -d '"') \
   --gateway-name $AKS_GATEWAY\
   --name TBMQHTTPSCert \
   --cert-file YOUR_CERT \
   --cert-password YOUR_CERT_PASS
```
{: .copy-code}

Execute the following command to deploy plain https load balancer:

```bash
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

### Configure MQTT Load Balancer

{% include templates/mqtt-broker/install/cluster-common/configure-mqtt-load-balancer.md %}

## Validate the setup

{% include templates/mqtt-broker/install/cluster-common/validate-the-setup.md %}

### Validate MQTT access

{% include templates/mqtt-broker/install/cluster-common/validate-mqtt-access.md %}

### Troubleshooting

{% include templates/mqtt-broker/install/cluster-common/troubleshooting.md %}

## Upgrading

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### Backup and restore (Optional)

While backing up your PostgreSQL database is highly recommended, it is optional before proceeding with the upgrade.
For further guidance, follow the [next instructions](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-backup-restore).

{% if docsPrefix == null %}

### Upgrade to 2.2.0

In this release, the MQTT authentication mechanism was migrated from YAML/env configuration into the database.
During upgrade, TBMQ needs to know which authentication providers are enabled in your deployment.
This information is provided through environment variables passed to the **upgrade pod**.

The upgrade script requires a file named **`database-setup.yml`** that explicitly defines these variables.
Environment variables from your `tb-broker.yml` file are not applied during the upgrade — only the values in `database-setup.yml` will be used.

> **Tips**
> If you use only Basic authentication, set `SECURITY_MQTT_SSL_ENABLED=false`.
> If you use only X.509 authentication, set `SECURITY_MQTT_BASIC_ENABLED=false` and `SECURITY_MQTT_SSL_ENABLED=true`.

**Supported variables**

* `SECURITY_MQTT_BASIC_ENABLED` (`true|false`)
* `SECURITY_MQTT_SSL_ENABLED` (`true|false`)
* `SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT` (`true|false`) — usually `false`.

Once the file is prepared and the values verified, proceed with the [upgrade process](#run-upgrade).

### Upgrade to 2.1.0

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release-cluster.md %}

### Upgrade to 2.0.0

For the TBMQ v2.0.0 upgrade, if you haven't installed Redis yet, please follow [step 6](#step-6-azure-cache-for-valkey) to complete the installation.
Only then you can proceed with the [upgrade](#run-upgrade).

### Run upgrade

In case you would like to upgrade, please pull the recent changes from the latest release branch:

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

{% include templates/mqtt-broker/upgrade/upgrade-to-custom-release.md %}

**Note**: Make sure custom changes of yours if available are not lost during the merge process.

{% include templates/mqtt-broker/install/upgrade-hint.md %}

After that, execute the following command:

{% capture tabspec %}tbmq-upgrade
tbmq-upgrade-without-from-version,Since v2.1.0,shell,resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh,/docs/{{docsPrefix}}mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh
tbmq-upgrade-with-from-version,Before v2.1.0,markdown,resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md,/docs/{{docsPrefix}}mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md{% endcapture %}
{% include tabs.html %}

{% include templates/mqtt-broker/upgrade/stop-tbmq-pods-before-upgrade.md %}

{% else %}

{% include templates/mqtt-broker/install/cluster-common/k8s-type-upgrade-ce-to-pe.md %}

{% endif %}

## Cluster deletion

Execute the following command to delete TBMQ nodes:

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

Execute the following command to delete all TBMQ nodes and configmaps, load balancers, etc.:

```bash
./k8s-delete-all.sh
```
{: .copy-code}

Execute the following command to delete the AKS cluster:

```bash
az aks delete --resource-group $AKS_RESOURCE_GROUP --name $TB_CLUSTER_NAME
```
{: .copy-code}

## Next steps

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
