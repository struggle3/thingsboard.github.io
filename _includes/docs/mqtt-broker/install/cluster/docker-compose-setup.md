
* TOC
{:toc}


本指南将帮助你在 Docker Compose 集群模式下部署 TBMQ {{tbmqSuffix}}。

## 前置要求

- [Install Docker](https://docs.docker.com/engine/installation/)

{% include templates/install/docker-install-note.md %}

## 拉取 TBMQ {{tbmqSuffix}} 镜像

请确保已通过命令行[登录](https://docs.docker.com/engine/reference/commandline/login/) Docker Hub。

{% if docsPrefix == null %}
```bash
docker pull thingsboard/tbmq-node:{{ site.release.broker_full_ver }}
docker pull thingsboard/tbmq-integration-executor:{{ site.release.broker_full_ver }}
```
{: .copy-code}
{% else %}
```bash
docker pull thingsboard/tbmq-pe-node:{{ site.release.pe_broker_full_ver }}
docker pull thingsboard/tbmq-pe-integration-executor:{{ site.release.pe_broker_full_ver }}
```
{: .copy-code}
{% endif %}

{% if docsPrefix == null %}
## 克隆 TBMQ 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/docker
```
{: .copy-code}
{% else %}
## 克隆 TBMQ PE Docker Compose 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq-pe-docker-compose.git
cd tbmq-pe-docker-compose/cluster
```
{: .copy-code}
{% endif %}

{% if docsPrefix == "pe/" %}
## Get the license key

Before proceeding, make sure you’ve selected your subscription plan or chosen to purchase a perpetual license.
If you haven’t done this yet, please visit the [Pricing page](/pricing/?section=tbmq-options){: target="_blank"} to compare available options
and obtain your license key.

> **Note:** Throughout this guide, we’ll refer to your license key as **YOUR_LICENSE_KEY_HERE**.

## Configure the license key

```bash
nano tbmq.env
```
{: .copy-code}

并将 license secret 参数填入，替换 "YOUR_LICENSE_KEY_HERE"：

```text
# License info
TBMQ_LICENSE_SECRET=YOUR_LICENSE_KEY_HERE
```

{% endif %}

## 安装

执行以下命令为所有服务创建所需卷，并更新创建卷中的 haproxy 配置。

```bash
./scripts/docker-create-volumes.sh
```
{: .copy-code}

执行以下命令进行安装：

```bash
./scripts/docker-install-tbmq.sh
```
{: .copy-code}

## 运行

执行以下命令启动服务：

```bash
./scripts/docker-start-services.sh
```
{: .copy-code}

所有服务成功启动后，可在浏览器中访问 `http://{your-host-ip}`（例如 **http://localhost**），并通过 1883 端口的 MQTT 协议连接客户端。

{% include templates/mqtt-broker/login.md %}

## 日志、停止和启动命令

遇到问题时，可查看服务日志排查错误。
例如，查看 TBMQ 日志可执行：

```bash
docker compose logs -f tbmq1
```
{: .copy-code}

或使用以下命令查看所有容器状态。
```bash
docker compose ps
```
{: .copy-code}

使用以下命令查看所有运行中服务的日志。

```bash
docker compose logs -f
```
{: .copy-code}

详见 [docker compose logs](https://docs.docker.com/compose/reference/logs/) 命令参考。

执行以下命令停止服务：

```bash
./scripts/docker-stop-services.sh
```
{: .copy-code}

执行以下命令停止并完全移除已部署的 Docker 容器：

```bash
./scripts/docker-remove-services.sh
```
{: .copy-code}

若要删除所有容器的 Docker 卷，执行以下命令。
**注意**：会删除所有数据，执行前请谨慎。

```bash
./scripts/docker-remove-volumes.sh
```
{: .copy-code}

在运行时更新日志级别（启用 DEBUG/TRACE）或修改 TBMQ、Haproxy 配置时，需编辑 _haproxy.cfg_ 或 _logback.xml_ 等文件。
修改后执行以下命令使容器应用更改：

```bash
./scripts/docker-refresh-config.sh
```
{: .copy-code}

To reload HAProxy's configuration without restarting the Docker container, you can send the HUP signal to this process (PID 1):

```
docker exec -it haproxy-certbot sh -c "kill -HUP 1"
```
{: .copy-code}

## Upgrading

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### Backup and restore (Optional)

While backing up your PostgreSQL database is highly recommended, it is optional before proceeding with the upgrade.
{% if docsPrefix == null %} For further guidance, follow the [next instructions](https://github.com/thingsboard/tbmq/blob/main/docker/backup-restore/README.md).
{% else %} For further guidance, follow the [next instructions](https://github.com/thingsboard/tbmq-pe-docker-compose/blob/master/cluster/backup-restore/README.md).
{% endif %}

{% if docsPrefix == null %}

### Upgrade to 2.2.0

In this release, the MQTT authentication mechanism was migrated from YAML/env configuration into the database.
During upgrade, TBMQ needs to know which authentication providers are enabled in your deployment.
This information is provided through environment variables passed to the **upgrade container**.

The upgrade script requires a file named **`tb-mqtt-broker.env`** that explicitly defines these variables.
Environment variables from your `docker-compose.yml` file are not applied during the upgrade — only the values in `tb-mqtt-broker.env` will be used.

> **Tips**
> If you use only Basic authentication, set `SECURITY_MQTT_SSL_ENABLED=false`.
> If you use only X.509 authentication, set `SECURITY_MQTT_BASIC_ENABLED=false` and `SECURITY_MQTT_SSL_ENABLED=true`.

**Supported variables**

  * `SECURITY_MQTT_BASIC_ENABLED` (`true|false`)
  * `SECURITY_MQTT_SSL_ENABLED` (`true|false`)
  * `SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT` (`true|false`) — usually `false`.

Once the file is prepared and the values verified, proceed with the [upgrade process](#run-upgrade).

### Upgrade to 2.1.0

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release-docker-cluster.md %}

{% else %}

### Upgrade from TBMQ CE to TBMQ PE (v2.2.0)

To upgrade your existing **TBMQ Community Edition (CE)** to **TBMQ Professional Edition (PE)**, ensure you are running the latest **TBMQ CE {{site.release.broker_full_ver}}** version before starting the process.
Merge your current configuration with the latest [TBMQ PE Docker Compose scripts](https://github.com/thingsboard/tbmq-pe-docker-compose/tree/{{ site.release.broker_branch }}).
Do not forget to [configure the license key](#configure-the-license-key).

Run the following commands, including the upgrade script to migrate PostgreSQL database data from CE to PE:

```bash
./scripts/docker-stop-services.sh
./scripts/docker-upgrade-tbmq.sh --fromVersion=ce
./scripts/docker-start-services.sh
```
{: .copy-code}

{% endif %}

{% if docsPrefix == null %}

### Run upgrade

In case you would like to upgrade, please pull the recent changes from the latest release branch:

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

{% include templates/mqtt-broker/upgrade/upgrade-to-custom-release.md %}

**Note**: Make sure custom changes of yours if available are not lost during the merge process. 
Make sure `TBMQ_VERSION` in .env file is set to the target version (e.g., set it to {{ site.release.broker_full_ver }} if you are upgrading to the latest).

{% include templates/mqtt-broker/install/upgrade-hint.md %}

After that, execute the following commands:

{% capture tabspec %}tbmq-upgrade
tbmq-upgrade-without-from-version,Since v2.1.0,shell,resources/upgrade-options/docker-compose-upgrade-tbmq-without-from-version.md,/docs/{{docsPrefix}}mqtt-broker/install/cluster/resources/upgrade-options/docker-compose-upgrade-tbmq-without-from-version.md
tbmq-upgrade-with-from-version,Before v2.1.0,markdown,resources/upgrade-options/docker-compose-upgrade-tbmq-with-from-version.md,/docs/{{docsPrefix}}mqtt-broker/install/cluster/resources/upgrade-options/docker-compose-upgrade-tbmq-with-from-version.md{% endcapture %}
{% include tabs.html %}

{% endif %}

## 为 HTTPS 生成证书

使用 HAproxy 将流量代理到容器及 Web UI。默认使用 80 和 443 端口。
使用有效证书启用 HTTPS 时，执行以下命令：

```bash
docker exec haproxy-certbot certbot-certonly --domain your_domain --email your_email
docker exec haproxy-certbot haproxy-refresh
```
{: .copy-code}

**注意**：仅在通过 URL 中的域名访问 Web UI 时才会使用有效证书。

## 启用 MQTTS（MQTT over SSL/TLS）

**MQTTS** 使客户端可通过加密 TLS/SSL 通道连接 TBMQ，保障传输中 MQTT 消息的机密性与完整性。
常见部署方式有两种：

* **双向 MQTTS（双向 TLS）**——TBMQ 负责 TLS 终结，客户端须出示有效证书进行认证。
* **单向 MQTTS（负载均衡器 TLS 终结）**——HAProxy 或其他负载均衡器完成 TLS 终结，并通过可信内网将明文 MQTT 转发到 TBMQ。

两种方式均加密外网连接，**双向 MQTTS** 额外通过客户端证书校验增强安全，**单向 MQTTS** 则简化 broker 配置并复用负载均衡器上的 HTTPS 证书。

### 双向 MQTTS

此配置下，TBMQ 自身完成 TLS 终结及（可选）客户端证书认证。
适用于希望 broker 完全掌控 SSL/TLS 与双向认证、不依赖负载均衡器做安全时。

要启用 **MQTT over SSL (MQTTS)**，需提供有效 SSL 证书并配置 TBMQ 使用。

支持的证书格式与选项详见 [MQTT over SSL](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/) 文档。

**提供 SSL 证书**

获取有效的 SSL 证书和私钥。例如：

* `mqttserver.pem` —— 公钥证书（可含完整链）；
* `mqttserver_key.pem` —— 私钥。

> 支持使用自签名证书进行测试，生产环境建议使用受信任 CA 签发的证书。

**挂载证书到容器**

打开 `docker-compose.yml`，**取消注释**挂载证书文件的 volume 行：

```yaml
volumes:
  - PATH_TO_CERTS:/config/certificates
```
{: .copy-code}

将 `PATH_TO_CERTS` 替换为存放证书的目录路径，确保 TBMQ 可访问。

**配置环境变量**

编辑 `tbmq.env`，**取消注释并配置**以下行以启用 SSL：

```yaml
LISTENER_SSL_ENABLED=true
LISTENER_SSL_PEM_CERT=/config/certificates/mqttserver.pem
LISTENER_SSL_PEM_KEY=/config/certificates/mqttserver_key.pem
LISTENER_SSL_PEM_KEY_PASSWORD=server_key_password
```
{: .copy-code}

> 按需调整文件路径和密码。若私钥未加密，可将 `LISTENER_SSL_PEM_KEY_PASSWORD` 留空。

**重启服务**

重启 TBMQ 服务以应用更改：

```bash
./scripts/docker-start-services.sh
```
{: .copy-code}

启动后，MQTT 客户端可通过 TLS/SSL 安全连接 **8883** 端口。

### 单向 MQTTS

此配置下，TLS 在负载均衡器（HAProxy）处终结。
客户端通过 MQTTS（8883 端口）安全连接 HAProxy，HAProxy 通过内网（1883 端口）将明文 MQTT 转发到 TBMQ。
可复用已用于 HTTPS 的证书。

将 HAProxy 指向证书包（PEM 完整链 + 私钥）。若复用 HTTPS 证书，引用同一证书包。
定位并更新 _haproxy.cfg_ 文件：

```text
 listen mqtts-in
  bind *:${MQTTS_PORT} ssl crt /usr/local/etc/haproxy/certs.d/fullchain-and-key.pem
  mode tcp
  option clitcpka # For TCP keep-alive
  timeout client 3h
  timeout server 3h
  option tcplog
  balance leastconn
  server tbMqtt1 tbmq1:1883 check inter 5s resolvers docker_resolver resolve-prefer ipv4
  server tbMqtt2 tbmq2:1883 check inter 5s resolvers docker_resolver resolve-prefer ipv4
```
{: .copy-code}

> **注意**：将 _fullchain-and-key.pem_ 替换为实际证书包文件名。

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
