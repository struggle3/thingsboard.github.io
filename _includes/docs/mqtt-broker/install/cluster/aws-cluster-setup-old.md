* TOC
{:toc}

本指南将帮助您在 AWS EKS 上部署 TBMQ。

## 前置条件

{% include templates/mqtt-broker/install/aws/eks-prerequisites.md %}

## 步骤 1. 获取 TBMQ K8S 脚本仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/k8s/aws
```
{: .copy-code}

## 步骤 2. 配置并创建 EKS 集群

可在 `cluster.yml` 中查看建议的集群配置。
可根据需要修改以下字段：
- `region` - 集群所在 AWS 区域（默认 `us-east-1`）
- `availabilityZones` - 区域可用区 ID 列表（默认 `[us-east-1a,us-east-1b,us-east-1c]`）
- `instanceType` - TBMQ 节点实例类型（默认 `m7a.large`）

**注意**：若不修改 `instanceType` 和 `desiredCapacity`，EKS 将部署 2 个 m7a.large 节点。

{% capture aws-eks-security %}
若要加固对 PostgreSQL 和 MSK 的访问，需配置或新建 VPC、将其设为 TBMQ 集群的 VPC，
为 PostgreSQL 和 MSK 创建安全组，并在 TBMQ 集群的 `managed` 节点组中配置这些安全组，
再通过另一安全组配置从 TBMQ 集群节点到 PostgreSQL/MSK 的访问。

关于 `eksctl` VPC 配置详见[此处](https://eksctl.io/usage/vpc-networking/)。
{% endcapture %}
{% include templates/info-banner.md content=aws-eks-security %}

创建 AWS 集群的命令：

```bash
eksctl create cluster -f cluster.yml
```
{: .copy-code}

## 步骤 3. 创建 AWS 负载均衡控制器

集群就绪后需创建 AWS 负载均衡控制器。
可按[此指南](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)操作。
集群脚本将创建以下负载均衡器：

* tb-broker-http-loadbalancer - AWS ALB，用于 Web UI 和 REST API；
* tb-broker-mqtt-loadbalancer - AWS NLB，用于 MQTT 通信。

配置 AWS 负载均衡控制器是**必需步骤**，否则这些负载均衡器无法正常工作。

## 步骤 4. Amazon PostgreSQL 数据库配置

您需要在 Amazon RDS 上配置 PostgreSQL。
可参考 [此指南](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SettingUp.html) 进行配置。

**注意**：建议如下：

* Make sure your PostgreSQL version is 16.x;
* Use ‘Production’ template for high availability. It enables a lot of useful settings by default;
* Consider creation of custom parameters group for your RDS instance. It will make change of DB parameters easier;
* Consider deployment of the RDS instance into private subnets. This way it will be nearly impossible to accidentally expose it to the internet.
* You may also change `username` field and set or auto-generate `password` field (keep your postgresql password in a safe place).

**Note**: Make sure your database is accessible from the cluster, one of the way to achieve this is to create
the database in the same VPC and subnets as TBMQ cluster and use
`eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*` security group. See screenshots below.

{% include images-gallery.html imageCollection="tbmq-rds-set-up" %}

## 步骤 5. Amazon MSK 配置

需配置 Amazon MSK。
在 AWS 控制台打开 MSK 子菜单，点击「Create cluster」并选择「Custom create」模式。
应看到类似界面：

{% include images-gallery.html imageCollection="tbmq-msk-set-up" %}

**注意**：建议如下：

* Apache Kafka 版本可设为 3.7.0，TBMQ 已在其上充分测试；
* 使用 m5.large 或类似实例类型；
* 为 MSK 创建自定义集群配置，便于修改 Kafka 参数；
* 使用默认「Monitoring」或启用「Enhanced topic-level monitoring」。

**注意**：确保 MSK 实例可从 TBMQ 集群访问。
最简单的方式是在同一 VPC 内部署 MSK，建议使用私有子网，降低意外暴露到互联网的风险。

{% include images-gallery.html imageCollection="tbmq-msk-configuration" %}

最后仔细检查 MSK 配置，然后完成集群创建。

## 步骤 6. Amazon ElastiCache (Redis) 配置

需配置 [ElastiCache](https://aws.amazon.com/elasticache/redis/) 的 Redis。TBMQ 用缓存存储 [DEVICE 持久化客户端](/docs/mqtt-broker/architecture/#persistent-device-client) 的消息，
以提升性能、减少 DB 读取（详见下文）。

启用认证后客户端连接 TBMQ 时会查询 MQTT 客户端凭据，大量并发连接会产生大量请求，使用缓存可缓解此问题。

在 AWS 控制台进入 ElastiCache -> Redis clusters -> Create Redis cluster。

**注意**：建议如下：

* Redis 引擎版本选用 7.x，节点至少 1 GB 内存；
* 确保 Redis 集群可从 TBMQ 集群访问，建议与 TBMQ 部署在同一 VPC、使用私有子网，
  并采用 `eksctl-tbmq-cluster-ClusterSharedNodeSecurityGroup-*` 安全组；
* 关闭自动备份。

{% include images-gallery.html imageCollection="tbmq-redis-set-up" %}

## Step 7. Configure links to the Kafka/Postgres/Redis

### Amazon RDS PostgreSQL

Once the database switch to the ‘Available’ state, on AWS Console get the `Endpoint` of the RDS PostgreSQL and paste it to
`SPRING_DATASOURCE_URL` in the `tb-broker-db-configmap.yml` instead of `RDS_URL_HERE` part.

{% include images-gallery.html imageCollection="tbmq-rds-link-configure" %}

Also, you'll need to set `SPRING_DATASOURCE_USERNAME` and `SPRING_DATASOURCE_PASSWORD` with PostgreSQL `username` and `password` corresponding.

### Amazon MSK

Once the MSK cluster switch to the ‘Active’ state, to get the list of brokers execute the next command:
```bash
aws kafka get-bootstrap-brokers --region us-east-1 --cluster-arn $CLUSTER_ARN
```
{: .copy-code}
其中 **$CLUSTER_ARN** 为 MSK 集群的 Amazon 资源名（ARN）：

{% include images-gallery.html imageCollection="tbmq-msk-link-configure" %}

请将 `BootstrapBrokerString` 中的内容填入 `tb-broker.yml` 文件中的 `TB_KAFKA_SERVERS` 环境变量。

Otherwise, click `View client information` seen on the screenshot above. Copy bootstrap server information in plaintext.

### Amazon ElastiCache

Once the Redis cluster switch to the ‘Available’ state, open the ‘Cluster details’ and copy `Primary endpoint` without ":6379" port suffix, it`s **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT**.

{% include images-gallery.html imageCollection="tbmq-redis-link-configure" %}

编辑 `tb-broker-cache-configmap.yml`，将 **YOUR_REDIS_ENDPOINT_URL_WITHOUT_PORT** 替换为实际值。

## 步骤 8. 安装

执行以下命令进行安装：
```bash
./k8s-install-tbmq.sh
```
{: .copy-code}

命令完成后，控制台应显示：

```
INFO  o.t.m.b.i.ThingsboardMqttBrokerInstallService - Installation finished successfully!
```

{% capture aws-rds %}

否则请检查 `tb-broker-db-configmap.yml` 中的 PostgreSQL URL 和密码是否正确。

{% endcapture %}
{% include templates/info-banner.md content=aws-rds %}

## 步骤 9. 启动

Execute the following command to deploy the broker:

```bash
./k8s-deploy-tbmq.sh
```
{: .copy-code}

After a few minutes, you may execute the next command to check the state of all pods.

```bash
kubectl get pods
```
{: .copy-code}

If everything went fine, you should be able to see `tb-broker-0` and `tb-broker-1` pods. Every pod should be in the `READY` state.

## Step 10. Configure Load Balancers

### 10.1 Configure HTTP(S) Load Balancer

Configure HTTP(S) Load Balancer to access web interface of your TBMQ instance. Basically you have 2 possible options of configuration:

* http - Load Balancer without HTTPS support. Recommended for **development**. The only advantage is simple configuration and minimum costs. May be good option for development server but definitely not suitable for production.
* https - Load Balancer with HTTPS support. Recommended for **production**. Acts as an SSL termination point. You may easily configure it to issue and maintain a valid SSL certificate. Automatically redirects all non-secure (HTTP) traffic to secure (HTTPS) port.

See links/instructions below on how to configure each of the suggested options.

#### HTTP Load Balancer

Execute the following command to deploy plain http load balancer:

```bash
kubectl apply -f receipts/http-load-balancer.yml
```
{: .copy-code}

The process of load balancer provisioning may take some time. You may periodically check the status of the load balancer using the following command:

```bash
kubectl get ingress
```
{: .copy-code}

Once provisioned, you should see similar output:

```text
NAME                          CLASS    HOSTS   ADDRESS                                                                  PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       k8s-thingsbo-tbbroker-000aba1305-222186756.eu-west-1.elb.amazonaws.com   80      3d1h
```

#### HTTPS Load Balancer

Use [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) to create or import SSL certificate. Note your certificate ARN.

Edit the load balancer configuration and replace YOUR_HTTPS_CERTIFICATE_ARN with your certificate ARN:

```bash
nano receipts/https-load-balancer.yml
```
{: .copy-code}

Execute the following command to deploy plain https load balancer:

```bash
kubectl apply -f receipts/https-load-balancer.yml
```
{: .copy-code}

### 10.2 Configure MQTT Load Balancer

Configure MQTT load balancer to be able to use MQTT protocol to connect devices.

Create TCP load balancer using following command:

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

The load balancer will forward all TCP traffic for ports 1883 and 8883.

#### One-way TLS

The simplest way to configure MQTTS is to make your MQTT load balancer (AWS NLB) to act as a TLS termination point.
This way we set up the one-way TLS connection, where the traffic between your devices and load balancers is encrypted, and the traffic between your load balancer and TBMQ is not encrypted.
There should be no security issues, since the ALB/NLB is running in your VPC.
The only major disadvantage of this option is that you can’t use “X.509 certificate” MQTT client credentials,
since information about client certificate is not transferred from the load balancer to the TBMQ.

To enable the one-way TLS:

Use [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) to create or import SSL certificate. Note your certificate ARN.

Edit the load balancer configuration and replace YOUR_MQTTS_CERTIFICATE_ARN with your certificate ARN:

```bash
nano receipts/mqtts-load-balancer.yml
```
{: .copy-code}

Execute the following command to deploy plain MQTTS load balancer:

```bash
kubectl apply -f receipts/mqtts-load-balancer.yml
```
{: .copy-code}

#### Two-way TLS

The more complex way to enable MQTTS is to obtain valid (signed) TLS certificate and configure it in the TBMQ.
The main advantage of this option is that you may use it in combination with “X.509 certificate” MQTT client credentials.

To enable the two-way TLS:

Follow [this guide](https://thingsboard.io/docs/user-guide/mqtt-over-ssl/) to create a .pem file with the SSL certificate. Store the file as _server.pem_ in the working directory.

You’ll need to create a config-map with your PEM file, you can do it by calling command:

```bash
kubectl create configmap tbmq-mqtts-config \
 --from-file=server.pem=YOUR_PEM_FILENAME \
 --from-file=mqttserver_key.pem=YOUR_PEM_KEY_FILENAME \
 -o yaml --dry-run=client | kubectl apply -f -
```
{: .copy-code}

* **YOUR_PEM_FILENAME** 为**服务器证书文件**名称。
* **YOUR_PEM_KEY_FILENAME** 为**服务器证书私钥文件**名称。

然后，取消注释 'tb-broker.yml' 文件中所有标有「Uncomment the following lines to enable two-way MQTTS」的段落。

执行以下命令使更改生效：

```bash
kubectl apply -f tb-broker.yml
```
{: .copy-code}

最后，部署「透明」负载均衡器：

```bash
kubectl apply -f receipts/mqtt-load-balancer.yml
```
{: .copy-code}

## 步骤 11. 验证部署

现在可使用负载均衡器的 DNS 名称在浏览器中打开 TBMQ Web 界面。

可使用以下命令查看负载均衡器的 DNS 名称：

```bash
kubectl get ingress
```
{: .copy-code}

将看到类似界面：

```text
NAME                          CLASS    HOSTS   ADDRESS                                                                  PORTS   AGE
tb-broker-http-loadbalancer   <none>   *       k8s-thingsbo-tbbroker-000aba1305-222186756.eu-west-1.elb.amazonaws.com   80      3d1h
```

Use `ADDRESS` field of the `tb-broker-http-loadbalancer` to connect to the cluster.

{% include templates/mqtt-broker/login.md %}

### Validate MQTT access

To connect to the cluster via MQTT you will need to get corresponding service IP. You can do this with the command:

```bash
kubectl get services
```
{: .copy-code}

将看到类似界面：

```text
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP                                                                     PORT(S)                         AGE
tb-broker-mqtt-loadbalancer   LoadBalancer   10.100.119.170   k8s-thingsbo-tbbroker-b9f99d1ab6-1049a98ba4e28403.elb.eu-west-1.amazonaws.com   1883:30308/TCP,8883:31609/TCP   6m58s
```

Use `EXTERNAL-IP` field of the load-balancer to connect to the cluster via MQTT protocol.

### Troubleshooting

In case of any issues you can examine service logs for errors. For example to see TBMQ logs execute the following command:

```bash
kubectl logs -f tb-broker-0
```
{: .copy-code}

Use the next command to see the state of all statefulsets.
```bash
kubectl get statefulsets
```
{: .copy-code}

See [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) command reference for more details.

## Upgrading

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### Backup and restore (Optional)

While backing up your PostgreSQL database is highly recommended, it is optional before proceeding with the upgrade.
For further guidance, follow the [next instructions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_CommonTasks.BackupRestore.html).

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

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release-aws-cluster.md %}

### Upgrade to 2.0.0

For the TBMQ v2.0.0 upgrade, if you haven't installed Redis yet, please follow [step 6](#step-6-amazon-elasticache-redis-configuration) to complete the installation.
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
tbmq-upgrade-without-from-version,Since v2.1.0,shell,resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh,/docs/mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-without-from-version.sh
tbmq-upgrade-with-from-version,Before v2.1.0,markdown,resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md,/docs/mqtt-broker/install/cluster/resources/upgrade-options/k8s-upgrade-tbmq-with-from-version.md{% endcapture %}
{% include tabs.html %}

{% include templates/mqtt-broker/upgrade/stop-tbmq-pods-before-upgrade.md %}

## Cluster deletion

Execute the following command to delete TBMQ nodes:

```bash
./k8s-delete-tbmq.sh
```
{: .copy-code}

Execute the following command to delete all TBMQ nodes and configmaps:

```bash
./k8s-delete-all.sh
```
{: .copy-code}

Execute the following command to delete the EKS cluster (you should change the name of the cluster and the region if those differ):
```bash
eksctl delete cluster -r us-east-1 -n tbmq -w
```
{: .copy-code}

## Next steps

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
