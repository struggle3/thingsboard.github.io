* TOC
{:toc}

本指南将帮助您使用 Minikube 以集群模式部署 TBMQ。

## 前置条件

您需要拥有 Kubernetes 集群，并且 `kubectl` 命令行工具必须配置为与您的集群通信。
如果尚未安装 Minikube，请遵循[这些说明](https://kubernetes.io/docs/setup/learning-environment/minikube/)。
此外，您需要安装 [helm](https://helm.sh/docs/intro/install/)。

## 步骤 1. 克隆 TBMQ 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/minikube
```
{: .copy-code}

## 步骤 2. 安装

要安装 TBMQ，执行以下命令：

```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

## 步骤 3. 运行

执行以下命令部署 TBMQ：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

当所有资源成功启动后，您可以在浏览器中打开 `http://{your-cluster-ip}:30001`（例如 **http://192.168.49.2:30001**）。
您可以使用以下命令检查集群 IP：
```bash
minikube ip
```
{: .copy-code}

{% include templates/mqtt-broker/login.md %}

## 步骤 4. 日志、删除 statefulset 和服务

如有任何问题，您可以检查服务日志以查找错误。
例如，要查看 TBMQ 节点日志，执行以下命令：

1) 获取正在运行的 tb-broker pod 列表：

```bash
kubectl get pods -l app=tb-broker
```
{: .copy-code}

2) 获取 tb-broker pod 的日志：

```bash
kubectl logs -f TB_BROKER_POD_NAME
```
{: .copy-code}

其中：

- `TB_BROKER_POD_NAME` - 从正在运行的 tb-broker pod 列表中获取的 tb-broker pod 名称。

或使用以下命令查看所有 pod 的状态。
```bash
kubectl get pods
```
{: .copy-code}

使用以下命令查看所有服务的状态。
```bash
kubectl get services
```
{: .copy-code}

使用以下命令查看所有 deployment 的状态。
```bash
kubectl get deployments
```
{: .copy-code}

使用以下命令查看所有 statefulset 的状态。
```bash
kubectl get statefulsets
```
{: .copy-code}

有关更多详细信息，请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)命令参考。

执行以下命令删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令删除所有资源（包括数据库）：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

## 升级

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### 备份和恢复（可选）

强烈建议备份 PostgreSQL 数据库，但在进行升级之前这是可选的。
有关进一步指导，请遵循[以下说明](https://github.com/thingsboard/tbmq/blob/main/k8s/minikube/backup-restore/README.md)。

### 升级到 2.2.0

在此版本中，MQTT 认证机制已从 YAML/env 配置迁移到数据库。
升级期间，TBMQ 需要了解部署中启用了哪些认证提供程序。
此信息通过传递给 **upgrade pod** 的环境变量提供。

升级脚本需要一个名为 **`database-setup.yml`** 的文件，该文件明确定义这些变量。
您的 `tb-broker.yml` 文件中的环境变量在升级期间不会应用——仅使用 `database-setup.yml` 中的值。

> **提示**
> 如果仅使用 Basic 认证，请设置 `SECURITY_MQTT_SSL_ENABLED=false`。
> 如果仅使用 X.509 认证，请设置 `SECURITY_MQTT_BASIC_ENABLED=false` 和 `SECURITY_MQTT_SSL_ENABLED=true`。

**支持的变量**

* `SECURITY_MQTT_BASIC_ENABLED` (`true|false`)
* `SECURITY_MQTT_SSL_ENABLED` (`true|false`)
* `SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT` (`true|false`) — 通常为 `false`。

准备好文件并验证值后，继续[升级过程](#run-upgrade)。

### 升级到 2.1.0

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release-cluster.md %}

### 执行升级

如果您想升级，请从最新 release 分支拉取最新更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

{% include templates/mqtt-broker/upgrade/upgrade-to-custom-release.md %}

**注意**：确保您的自定义更改（如有）在合并过程中不会丢失。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

之后，执行以下命令：

{% capture tabspec %}tbmq-upgrade
tbmq-upgrade-without-from-version,Since v2.1.0,shell,resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh,/docs/mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh
tbmq-upgrade-with-from-version,Before v2.1.0,markdown,resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md,/docs/mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md{% endcapture %}
{% include tabs.html %}

{% include templates/mqtt-broker/upgrade/stop-tbmq-pods-before-upgrade.md %}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
