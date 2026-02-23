
* TOC
{:toc}


本指南将帮助您使用 Docker Compose 以集群模式部署 TBMQ。

## 前置条件

- [安装 Docker](https://docs.docker.com/engine/installation/)

{% include templates/install/docker-install-note.md %}

## 步骤 1. 拉取 TBMQ 镜像

请确保已通过命令行 [登录](https://docs.docker.com/engine/reference/commandline/login/) Docker Hub。

```bash
docker pull thingsboard/tbmq-node:{{ site.release.broker_full_ver }}
```
{: .copy-code}

## 步骤 2. 克隆 TBMQ 仓库

```bash
git clone -b {{ site.release.broker_branch }} https://github.com/thingsboard/tbmq.git
cd tbmq/docker
```
{: .copy-code}

## 步骤 3. 安装

执行以下命令为所有服务创建所需卷并更新所创建卷中的 haproxy 配置：

```bash
./scripts/docker-create-volumes.sh
```
{: .copy-code}

执行以下命令运行安装：

```bash
./scripts/docker-install-tbmq.sh
```
{: .copy-code}

## 步骤 4. 运行

执行以下命令启动服务：

```bash
./scripts/docker-start-services.sh
```
{: .copy-code}

当所有服务成功启动后，您可以在浏览器中访问 `http://{your-host-ip}`（例如 **http://localhost**），并在 1883 端口使用 MQTT 协议连接客户端。

{% include templates/mqtt-broker/login.md %}

## 步骤 5. 日志、停止与启动命令

若遇问题可查看服务日志。例如查看 TBMQ 日志可执行：

```bash
docker compose logs -f tbmq1
```
{: .copy-code}

或使用以下命令查看所有容器状态：
```bash
docker compose ps
```
{: .copy-code}
使用以下命令查看所有运行中服务的日志：
```bash
docker compose logs -f
```
{: .copy-code}
更多说明请参阅 [docker compose logs](https://docs.docker.com/compose/reference/logs/) 命令参考。

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

若要移除所有容器的 Docker 卷，请执行以下命令。
**注意：** 将删除所有数据，执行前请谨慎。

```bash
./scripts/docker-remove-volumes.sh
```
{: .copy-code}

若需在运行时更新日志（启用 DEBUG/TRACE 日志）或修改 TBMQ、Haproxy 配置，请编辑 _haproxy.cfg_ 或 _logback.xml_ 等文件，
然后执行以下命令使容器应用更改：

```bash
./scripts/docker-refresh-config.sh
```
{: .copy-code}

若要在不重启 Docker 容器的情况下重载 HAProxy 配置，可向该进程（PID 1）发送 HUP 信号：

```
docker exec -it haproxy-certbot sh -c "kill -HUP 1"
```
{: .copy-code}

## 升级

{% include templates/mqtt-broker/upgrade/upgrading.md %}

### 备份与恢复（可选）

强烈建议在升级前备份 PostgreSQL 数据库，但此为可选步骤。
更多说明请参阅 [后续说明](https://github.com/thingsboard/tbmq/blob/main/docker/backup-restore/README.md)。

### 升级至 2.2.0

在此版本中，MQTT 认证机制已从 YAML/环境变量配置迁移到数据库。
升级时，TBMQ 需要知道当前部署启用了哪些认证提供方。
该信息通过传入 **升级容器** 的环境变量提供。

升级脚本要求存在名为 **`tb-mqtt-broker.env`** 的文件并在此文件中显式定义这些变量。
升级过程中不会使用 `docker-compose.yml` 中的环境变量，仅使用 `tb-mqtt-broker.env` 中的值。

> **提示**
> 若仅使用 Basic 认证，请设置 `SECURITY_MQTT_SSL_ENABLED=false`。
> 若仅使用 X.509 认证，请设置 `SECURITY_MQTT_BASIC_ENABLED=false` 和 `SECURITY_MQTT_SSL_ENABLED=true`。

**支持的变量**

  * `SECURITY_MQTT_BASIC_ENABLED`（`true|false`）
  * `SECURITY_MQTT_SSL_ENABLED`（`true|false`）
  * `SECURITY_MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT`（`true|false`）— 通常为 `false`。

准备好该文件并确认取值后，请按 [升级流程](#run-upgrade) 执行。

### 升级至 2.1.0

{% include templates/mqtt-broker/upgrade/update-to-2.1.0-release-docker-cluster.md %}

### 执行升级

若要升级，请从最新发布分支拉取最近更改：

```bash
git pull origin {{ site.release.broker_branch }}
```
{: .copy-code}

{% include templates/mqtt-broker/upgrade/upgrade-to-custom-release.md %}

**注意：** 请确保在合并过程中不丢失您的自定义修改。
确保 .env 文件中的 `TBMQ_VERSION` 已设置为目标版本（例如升级到最新版时设为 {{ site.release.broker_full_ver }}）。

{% include templates/mqtt-broker/install/upgrade-hint.md %}

然后执行以下命令：

{% capture tabspec %}tbmq-upgrade
tbmq-upgrade-without-from-version,Since v2.1.0,shell,resources/upgrade-options/docker-compose-upgrade-tbmq-without-from-version.md,/docs/{{docsPrefix}}mqtt-broker/install/cluster/resources/upgrade-options/docker-compose-upgrade-tbmq-without-from-version.md
tbmq-upgrade-with-from-version,Before v2.1.0,markdown,resources/upgrade-options/docker-compose-upgrade-tbmq-with-from-version.md,/docs/{{docsPrefix}}mqtt-broker/install/cluster/resources/upgrade-options/docker-compose-upgrade-tbmq-with-from-version.md{% endcapture %}
{% include tabs.html %}

## 为 HTTPS 生成证书

我们使用 HAproxy 将流量代理到容器，Web 界面默认使用 80 和 443 端口。
要使用有效证书启用 HTTPS，请执行：

```bash
docker exec haproxy-certbot certbot-certonly --domain your_domain --email your_email
docker exec haproxy-certbot haproxy-refresh
```
{: .copy-code}

**注意：** 仅当通过 URL 中的域名访问 Web 界面时才会使用有效证书。

## 启用 MQTTS（基于 SSL/TLS 的 MQTT）

**MQTTS** 允许客户端通过加密的 TLS/SSL 通道连接 TBMQ，确保 MQTT 消息在传输过程中的机密性与完整性。
常见有两种部署方式：

* **双向 MQTTS（双向 TLS）** – TBMQ 自行终止 TLS，客户端须提供有效证书进行认证。
* **单向 MQTTS（在负载均衡器终止 TLS）** – 由 HAProxy 或其他负载均衡器终止 TLS，并通过可信内网将明文 MQTT 流量转发给 TBMQ。

两种方式均能加密保护外部连接，**双向 MQTTS** 额外通过客户端证书校验提高安全性，
**单向 MQTTS** 则简化 Broker 配置，并可在负载均衡器上复用现有 HTTPS 证书。

### 双向 MQTTS

在此配置下，由 TBMQ 自身处理 TLS 终止及（可选）客户端证书认证。
适用于希望由 Broker 完全控制 SSL/TLS 与双向认证、而不依赖负载均衡器提供安全性的场景。

要启用 **MQTT over SSL（MQTTS）**，需提供有效 SSL 证书并配置 TBMQ 使用它们。

有关支持的证书格式与选项，请参阅 [MQTT over SSL](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/) 文档。

**提供 SSL 证书**

获取有效 SSL 证书与私钥。例如：

* `mqttserver.pem` – 公钥证书（可包含完整链）；
* `mqttserver_key.pem` – 私钥。

> 测试环境支持自签名证书，生产环境建议使用受信任 CA 签发的证书。

**将证书挂载到容器**

打开 `docker-compose.yml`，**取消注释**挂载证书文件的 volume 行：

```yaml
volumes:
  - PATH_TO_CERTS:/config/certificates
```
{: .copy-code}

将 `PATH_TO_CERTS` 替换为包含证书文件的目录路径，并确保 TBMQ 能访问这些文件。

**配置环境变量**

编辑 `tb-mqtt-broker.env`，**取消注释/配置**以下行以启用 SSL：

```yaml
LISTENER_SSL_ENABLED=true
LISTENER_SSL_PEM_CERT=/config/certificates/mqttserver.pem
LISTENER_SSL_PEM_KEY=/config/certificates/mqttserver_key.pem
LISTENER_SSL_PEM_KEY_PASSWORD=server_key_password
```
{: .copy-code}

> 请按需调整文件路径和密码。若私钥未设密码，可将 `LISTENER_SSL_PEM_KEY_PASSWORD` 留空。

**重启服务**

通过重启 TBMQ 服务使更改生效：

```bash
./scripts/docker-start-services.sh
```
{: .copy-code}

启动后，MQTT 客户端即可通过 TLS/SSL 安全连接 **8883** 端口。

### 单向 MQTTS

在此方式下，TLS 在负载均衡器（HAProxy）处终止。
客户端通过 MQTTS（8883 端口）安全连接 HAProxy，HAProxy 通过内网将明文 MQTT 转发给 TBMQ（1883 端口）。
可复用已用于 HTTPS 的证书。

在 HAProxy 中指定证书包路径（含完整链的 PEM + 私钥）。若复用 HTTPS 证书，可引用同一证书包。
找到并更新 _haproxy.cfg_ 文件：

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

> **注意：** 请将 _fullchain-and-key.pem_ 替换为您的证书包实际文件名。

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/mqtt-broker-guides-banner.md %}
