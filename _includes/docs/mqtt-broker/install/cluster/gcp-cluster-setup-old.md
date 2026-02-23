* TOC
{:toc}

本指南将帮助您在 GKE 中以微服务模式部署 TBMQ。

## 前置条件

{% include templates/install/gcp/gke-prerequisites.md %}

## 步骤 1. 克隆 TBMQ K8S 脚本仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/gcp
```
{: .copy-code}

## 步骤 2. 定义环境变量

{% assign tbClusterName = "tbmq-cluster" %}
{% assign tbDbClusterName = "tbmq-db" %}
{% include templates/mqtt-broker/install/gcp/env-variables.md %}

## 步骤 3. 配置并创建 GKE 集群

{% include templates/install/gcp/regional-gke-cluster.md %}

## 步骤 4. 更新 kubectl 上下文

{% include templates/install/gcp/update-kubectl-region.md %}

## 步骤 5. 配置 Google Cloud SQL (PostgreSQL) 实例

{% assign tbDbName = "thingsboard_mqtt_broker" %}
{% include templates/install/gcp/provision-postgresql.md %}

#### 5.5 编辑数据库设置

将 **YOUR_DB_IP_ADDRESS**、**YOUR_DB_PASSWORD** 和 **YOUR_DB_NAME** 替换为正确的值：

```bash
nano tb-broker-db-configmap.yml
```
{: .copy-code}

## 步骤 6. 创建 Namespace

为 TBMQ 集群部署创建专用命名空间，以确保更好的资源隔离和管理。

```bash
kubectl apply -f tb-broker-namespace.yml
kubectl config set-context $(kubectl config current-context) --namespace=thingsboard-mqtt-broker
```
{: .copy-code}

## 步骤 7. 配置 Redis 集群

我们建议使用 Helm 部署 Bitnami Redis Cluster。请查看 `redis` 文件夹。

```bash
ls redis/
```
{: .copy-code}

您可以找到 _default-values-redis.yml_ 文件（从 [Bitnami artifactHub](https://artifacthub.io/packages/helm/bitnami/redis-cluster) 下载的默认值）和带有修改值的 _values-redis.yml_ 文件。
我们建议保持第一个文件不变，仅修改第二个文件。这样，升级到下一版本的过程会更顺利，因为可以查看 diff。

添加 Bitnami Helm 仓库：

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```
{: .copy-code}

安装 Bitnami Redis 集群，执行以下命令：

```bash
helm install redis -f redis/values-redis.yml bitnami/redis-cluster --version 10.2.5
```
{: .copy-code}

部署完成后，您将看到部署状态信息，随后是获取 REDIS_PASSWORD 的命令：

```text
NAME: redis
LAST DEPLOYED: Tue Apr  8 11:22:44 2025
NAMESPACE: thingsboard-mqtt-broker
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: redis-cluster
CHART VERSION: 10.2.5
APP VERSION: 7.2.5** 请在图表部署期间耐心等待 **


获取密码请运行：
    export REDIS_PASSWORD=$(kubectl get secret --namespace "thingsboard-mqtt-broker" redis-redis-cluster -o jsonpath="{.data.redis-password}" | base64 -d)
```

修改此命令以在终端打印密码：

```bash
echo $(kubectl get secret --namespace "thingsboard-mqtt-broker" redis-redis-cluster -o jsonpath="{.data.redis-password}" | base64 -d)
```
{: .copy-code}

您需要复制输出并将其粘贴到 _tb-broker-cache-configmap.yml_ 文件中，替换 `YOUR_REDIS_PASSWORD`。

```bash
nano tb-broker-cache-configmap.yml
```
{: .copy-code}

{% capture redis-nodes %}

_tb-broker-cache-configmap.yml_ 中 `REDIS_NODES` 的值默认为 `"redis-redis-cluster-headless:6379"`。
主机名基于 release 名称 (redis) 和 Bitnami 图表的默认命名约定。
如果您在 Redis values 文件中修改了 `nameOverride` 或 `fullnameOverride` 字段，或在安装期间更改了 release 名称，
则必须相应地更新此值以匹配图表创建的实际 headless 服务名称。

{% endcapture %}
{% include templates/info-banner.md content=redis-nodes %}

## 步骤 8. 安装

{% include templates/mqtt-broker/install/gcp/install.md %}

{% capture aws-rds %}

否则，请检查您是否在 `tb-broker-db-configmap.yml` 中正确设置了 PostgreSQL URL 和 PostgreSQL 密码。

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}

## 步骤 9. 配置 Kafka

{% include templates/mqtt-broker/install/cluster-common/provision-kafka.md %}

## 步骤 10. 启动

执行以下命令部署 broker：

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

几分钟后，您可以执行下一个命令检查所有 pod 的状态。

```bash
kubectl get pods
```
{: .copy-code}

如果一切正常，您应该能看到 `tb-broker-0` 和 `tb-broker-1` pod。每个 pod 应处于 `READY` 状态。

## 步骤 11. 配置负载均衡器

### 11.1 配置 HTTP(S) 负载均衡器

配置 HTTP(S) 负载均衡器以访问 TBMQ 实例的 Web 界面。基本上，您有两种配置选项：

* http - 不支持 HTTPS 的负载均衡器。推荐用于**开发**。唯一优点是配置简单、成本最低。可能适合开发服务器，但绝对不适合生产环境。
* https - 支持 HTTPS 的负载均衡器。推荐用于**生产**。作为 SSL 终止点。您可以轻松配置它来颁发和维护有效的 SSL 证书。自动将所有非安全 (HTTP) 流量重定向到安全 (HTTPS) 端口。

请参阅以下链接/说明了解如何配置每种建议选项。

#### HTTP 负载均衡器

执行以下命令部署纯 http 负载均衡器：

```bash
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

负载均衡器配置过程可能需要一些时间。您可以使用以下命令定期检查负载均衡器状态：

```bash
kubectl get ingress
```
{: .copy-code}

配置完成后，您应该看到类似输出：

```text
NAME                          CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       34.111.24.134   80      7m25s
```

#### HTTPS 负载均衡器

{% assign staticIP = "tbmq-http-lb-address" %}
使用 Google 托管 SSL 证书配置负载均衡器的过程在官方[文档页面](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs)中有描述。
以下说明摘自官方文档。在继续之前，请务必仔细阅读[前置条件](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#prerequisites)。

```bash
gcloud compute addresses create {{staticIP}} --global
```
{: .copy-code}

在 *https-load-balancer.yml* 文件中将 *PUT_YOUR_DOMAIN_HERE* 替换为有效域名：

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

执行以下命令部署安全 http 负载均衡器：

```bash
 kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

负载均衡器配置过程可能需要一些时间。您可以使用以下命令定期检查负载均衡器状态：

```bash
kubectl get ingress
```
{: .copy-code}

配置完成后，您应该看到类似输出：

```text
NAME                           CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-https-loadbalancer   gce      *       34.111.24.134   80      7m25s
```

现在，**将您使用的域名**分配给负载均衡器 IP 地址（命令输出中 34.111.24.134 的替代地址）。

使用 dig 检查域名配置是否正确：

```bash
dig YOUR_DOMAIN_NAME
```
{: .copy-code}

示例输出：

```text

; <<>> DiG 9.11.3-1ubuntu1.16-Ubuntu <<>> YOUR_DOMAIN_NAME
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12513
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;YOUR_DOMAIN_NAME.	IN	A

;; ANSWER SECTION:
YOUR_DOMAIN_NAME. 36 IN	A	34.111.24.134

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Fri Nov 19 13:00:00 EET 2021
;; MSG SIZE  rcvd: 74

```

分配后，等待 Google 托管证书完成配置。这可能需要长达 60 分钟。您可以使用以下命令检查证书状态：

```bash
kubectl describe managedcertificate managed-cert
```
{: .copy-code}

如果您正确配置了域名记录，证书最终会被配置完成。
配置完成后，您可以使用域名通过 https 访问 Web UI。

### 11.2 配置 MQTT 负载均衡器

配置 MQTT 负载均衡器以便使用 MQTT 协议连接设备。

使用以下命令创建 TCP 负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

负载均衡器将转发端口 1883 和 8883 的所有 TCP 流量。

#### MQTT over SSL

按照[本指南](https://thingsboard.io/docs/user-guide/mqtt-over-ssl/)创建带 SSL 证书的 .pem 文件。将文件保存为工作目录中的 _server.pem_。

您需要创建带有 PEM 文件的 config-map，可以通过调用以下命令完成：

```bash
kubectl create configmap tbmq-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* 其中 **YOUR_PEM_FILENAME** 是您的**服务器证书文件**名称。
* 其中 **YOUR_PEM_KEY_FILENAME** 是您的**服务器证书私钥文件**名称。

然后，取消注释 'tb-broker.yml' 文件中标记为"Uncomment the following lines to enable two-way MQTTS"的所有部分。

执行命令应用更改：

```bash
kubectl apply -f tb-broker.yml
```
{: .copy-code}

## 步骤 12. 验证配置

现在您可以在浏览器中使用负载均衡器的 DNS 名称打开 TBMQ Web 界面。

您可以使用以下命令获取负载均衡器的 DNS 名称：

```bash
kubectl get ingress
```
{: .copy-code}

您应该看到类似画面：

```text
NAME                          CLASS    HOSTS   ADDRESS         PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       34.111.24.134   80      3d1h
```

使用 tb-broker-http-loadbalancer 的 `ADDRESS` 字段连接到集群。

{% include templates/mqtt-broker/login.md %}

### 验证 MQTT 访问

要通过 MQTT 连接到集群，您需要获取相应的服务 IP。您可以使用以下命令执行此操作：

```bash
kubectl get services
```
{: .copy-code}

您应该看到类似画面：

```text
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP              PORT(S)                         AGE
tb-broker-mqtt-loadbalancer   LoadBalancer   10.100.119.170   *******                  1883:30308/TCP,8883:31609/TCP   6m58s
```

使用负载均衡器的 `EXTERNAL-IP` 字段通过 MQTT 协议连接到集群。

### 故障排除

如有任何问题，您可以检查服务日志以查找错误。例如，要查看 TBMQ 日志，执行以下命令：

```bash
kubectl logs -f tb-broker-0
```
{: .copy-code}

使用以下命令查看所有 statefulset 的状态。
```bash
kubectl get statefulsets
```
{: .copy-code}

有关更多详细信息，请参阅 [kubectl 速查表](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)命令参考。

## 升级

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### 备份和恢复（可选）

强烈建议备份 PostgreSQL 数据库，但在进行升级之前这是可选的。
有关进一步指导，请遵循[以下说明](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-backup-restore)。

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

### 升级到 2.0.0

对于 TBMQ v2.0.0 升级，如果您尚未安装 Redis，请按照[步骤 7](#step-7-provision-redis-cluster) 完成安装。
然后才能继续[升级](#run-upgrade)。

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

## 删除集群

执行以下命令删除 TBMQ 节点：

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

执行以下命令删除所有 TBMQ 节点和 configmap、负载均衡器等：

```bash
./k8s-delete-all.sh
```
{: .copy-code}

执行以下命令删除 GKE 集群：

```bash
gcloud container clusters delete $TB_CLUSTER_NAME --region=$GCP_REGION
```
{: .copy-code}

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
