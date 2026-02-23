* TOC
{:toc}

本指南将帮助你在 Minikube 集群模式下部署 TBMQ {{tbmqSuffix}}。

## 前置要求

需具备 Kubernetes 集群，且 `kubectl` 命令行工具已配置为可与集群通信。
若未安装 Minikube，请按[此说明](https://kubernetes.io/docs/setup/learning-environment/minikube/)操作。

{% if docsPrefix == null %}
## 克隆 TBMQ 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/minikube
```
{: .copy-code}

{% else %}
## 克隆 TBMQ PE K8S 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq-pe-k8s.git
cd tbmq-pe-k8s/minikube
```
{: .copy-code}
{% endif %}

## 安装

要安装 TBMQ {{tbmqSuffix}}，执行以下命令：

```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

{% include templates/mqtt-broker/install/cluster-common/configure-license-key.md %}

## 运行

执行以下命令部署 TBMQ {{tbmqSuffix}}：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

所有资源成功启动后，可在浏览器中打开 `http://{your-cluster-ip}:30001`（例如 **http://192.168.49.2:30001**）。
可使用以下命令查看集群 IP：

```bash
minikube ip
```
{: .copy-code}

{% include templates/mqtt-broker/login.md %}

## 日志、删除 StatefulSet 和服务

遇到问题时，可查看服务日志排查错误。
例如，查看 TBMQ 节点日志：

1) 获取运行中的 tbmq pod 列表：

```bash
kubectl get pods -l app=tbmq
```
{: .copy-code}

2) 获取 tbmq pod 的日志：

```bash
kubectl logs -f TBMQ_POD_NAME
```
{: .copy-code}

Where:

- `TBMQ_POD_NAME` - tbmq pod name obtained from the list of the running tbmq pods.

Or use the next command to see the state of all the pods.

```bash
kubectl get pods
```
{: .copy-code}

Use the next command to see the state of all the services.

```bash
kubectl get services
```
{: .copy-code}

Use the next command to see the state of all the deployments.

```bash
kubectl get deployments
```
{: .copy-code}

Use the next command to see the state of all the statefulsets.

```bash
kubectl get statefulsets
```
{: .copy-code}

See [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) command reference for more details.

Execute the following command to delete TBMQ nodes:

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

Execute the following command to delete all resources (including the databases):

```bash
./k8s-delete-all.sh
```
{: .copy-code}

## Upgrading

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### Backup and restore (Optional)

While backing up your PostgreSQL database is highly recommended, it is optional before proceeding with the upgrade.
{% if docsPrefix == null %} For further guidance, follow the [next instructions](https://github.com/thingsboard/tbmq/blob/main/k8s/minikube/backup-restore/README.md).
{% else %} For further guidance, follow the [next instructions](https://github.com/thingsboard/tbmq-pe-k8s/blob/master/minikube/backup-restore/README.md).
{% endif %}

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

## Next steps

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
