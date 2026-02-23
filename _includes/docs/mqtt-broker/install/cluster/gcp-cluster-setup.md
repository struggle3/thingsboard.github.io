* TOC
{:toc}

本指南将帮助你在 GKE 中部署 TBMQ {{tbmqSuffix}}。

## 前置要求

{% include templates/mqtt-broker/install/gcp/gke-prerequisites.md %}

{% if docsPrefix == null %}
## 克隆 TBMQ 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/gcp
```
{: .copy-code}

{% else %}
## 克隆 TBMQ PE K8S 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq-pe-k8s.git
cd tbmq-pe-k8s/gcp
```
{: .copy-code}
{% endif %}

## 定义环境变量

{% assign tbClusterName = "tbmq-cluster" %}
{% assign tbDbClusterName = "tbmq-db" %}
{% include templates/mqtt-broker/install/gcp/env-variables.md %}

## 配置并创建 GKE 集群

{% include templates/mqtt-broker/install/gcp/regional-gke-cluster.md %}

## 更新 kubectl 上下文

{% include templates/mqtt-broker/install/gcp/update-kubectl-region.md %}

## 配置 Google Cloud SQL（PostgreSQL）实例

{% assign tbDbName = "thingsboard_mqtt_broker" %}
{% include templates/mqtt-broker/install/gcp/provision-postgresql.md %}

#### 编辑数据库配置

将 **YOUR_DB_IP_ADDRESS**、**YOUR_DB_PASSWORD** 和 **YOUR_DB_NAME** 替换为正确值：

```bash
nano tbmq-db-configmap.yml
```
{: .copy-code}

## 创建命名空间

为 TBMQ 集群部署创建专用命名空间，以提升资源隔离与管理效果。

```bash
kubectl apply -f tbmq-namespace.yml
kubectl config set-context $(kubectl config current-context) --namespace=thingsboard-mqtt-broker
```
{: .copy-code}

## 配置 Valkey 集群

{% include templates/mqtt-broker/install/cluster-common/provision-redis-cluster.md %}

## Installation

{% include templates/mqtt-broker/install/gcp/install.md %}

{% capture gcp-psql %}

Otherwise, please check if you set the PostgreSQL URL and PostgreSQL password in the `tbmq-db-configmap.yml` correctly.

{% endcapture %}
{% include templates/info-banner.md content=gcp-psql %}

{% include templates/mqtt-broker/install/cluster-common/configure-license-key.md %}

## Provision Kafka

{% include templates/mqtt-broker/install/cluster-common/provision-kafka-new.md %}

## Starting

{% include templates/mqtt-broker/install/cluster-common/starting.md %}

## Configure Load Balancers

### 配置 HTTP(S) 负载均衡器

配置 HTTP(S) 负载均衡器以访问 TBMQ 实例的 Web 界面。主要有两种配置方式：

* http —— 不支持 HTTPS 的负载均衡器。适用于**开发**。优点是配置简单、成本最低。适合开发服务器，但不适合生产环境。
* https —— 支持 HTTPS 的负载均衡器。适用于**生产**。作为 SSL 终端，可方便地签发与维护有效 SSL 证书，自动将 HTTP 流量重定向到 HTTPS。

下面提供各选项的配置链接/说明。

#### HTTP Load Balancer

{% include templates/mqtt-broker/install/cluster-common/configure-http-load-balancer.md %}

#### HTTPS Load Balancer

{% assign staticIP = "tbmq-http-lb-address" %}
{% include templates/mqtt-broker/install/gcp/configure-https-load-balancer.md %}
配置完成后，可通过域名访问 Web UI（https）。

### 配置 MQTT 负载均衡器

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

For the TBMQ v2.0.0 upgrade, if you haven't installed Redis yet, please follow [step 7](#step-7-provision-valkey-cluster) to complete the installation.
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

## 删除集群

执行以下命令删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令删除所有 TBMQ 节点、ConfigMap、负载均衡器等：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令删除 GKE 集群：

```bash
gcloud container clusters delete $TB_CLUSTER_NAME --region=$GCP_REGION
```
{: .copy-code}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
