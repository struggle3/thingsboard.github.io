* TOC
{:toc}

{% assign sinceVersion = "4.0.1" %}
{% include templates/edge/since-edge.md %}

### 概述

**Edge clustering（Edge 集群）** 指连接并分组多个 **Edge 节点** 以在 **网络边缘** 协同工作。
集群适用于大规模工业物联网、智慧城市、工厂或单区域数千设备的场景。

Edge 特定注意事项：
* 所有 **Edge 节点** 连接到 **同一数据库**。
* **Devices** 可根据负载均衡连接到任意节点。
* **Edge 节点** 共享工作负载并维护本地故障转移。
* **Edge Cluster** 将聚合数据同步到 **ThingsBoard Cloud**。

![edge-cluster](/images/edge/config/edge-cluster.webp){: style="display: block; margin: auto; max-width: 600px; max-height: 600px"}

更多详情请参阅 [microservices architecture](/docs/reference/msa/){: target="_blank"} 页面。

#### 前置条件

**ThingsBoard** 微服务在 **Docker 环境** 中运行。
开始前，请确保系统已安装 [Docker CE](https://docs.docker.com/install/){: target="_blank"} 和 [Docker Compose](https://docs.docker.com/compose/install/){: target="_blank"}。

{% include templates/install/docker-install.md %}

{% include templates/install/docker-install-note.md %}

### 步骤 1. 拉取 ThingsBoard Edge 镜像

[登录](https://docs.docker.com/engine/reference/commandline/login/){: target="_blank"} Docker Hub 并使用命令拉取镜像：

{% if docsPrefix == "pe/edge/" %}
```bash
docker pull thingsboard/tb-edge-pe:{{ site.release.pe_edge_full_ver }}
```
{: .copy-code}

{% else %}

```bash
docker pull thingsboard/tb-edge:{{ site.release.edge_full_ver }}
```
{: .copy-code}

{% endif %}

{% if docsPrefix == "pe/edge/" %}
### 步骤 2. 克隆 ThingsBoard PE Docker compose 脚本

```bash
git clone -b release-4.0.0 https://github.com/thingsboard/thingsboard-edge-pe-docker-compose.git tb-edge-pe-docker-compose --depth 1
cd tb-edge-pe-docker-compose
```
{: .copy-code}

{% else %}

### 步骤 2. 克隆 ThingsBoard Edge CE 仓库

```bash
git clone -b release-4.0 https://github.com/thingsboard/thingsboard-edge.git --depth 1
cd thingsboard-edge/docker-edge
```
{: .copy-code}

{% endif %}

### 步骤 3. 配置 ThingsBoard Edge 数据库和队列服务

在执行初始安装前，配置 **ThingsBoard Edge** 使用的数据库类型。要设置数据库类型，请修改 **环境文件 (.env)** 中的 **DATABASE** 变量值。

**ThingsBoard Edge** 目前支持两种用于存储消息的消息系统/代理：
* **In Memory** 队列实现不适用于任何类型的集群部署。
* **Kafka** 建议用于生产部署，且为默认使用。该队列现用于大多数 ThingsBoard 生产环境。

要编辑 **ThingsBoard Edge .env** 文件，请运行以下命令：
```bash
nano .env
```
{: .copy-code}

检查以下行：
```bash
DATABASE=postgres
TB_QUEUE_TYPE=kafka

CLOUD_ROUTING_KEY=PUT_YOUR_EDGE_KEY_HERE # e.g. 19ea7ee8-5e6d-e642-4f32-05440a529015
CLOUD_ROUTING_SECRET=PUT_YOUR_EDGE_SECRET_HERE # e.g. bztvkvfqsye7omv9uxlp
CLOUD_RPC_HOST=PUT_YOUR_THINGSBOARD_SERVER_DOMAIN_OR_IP_HERE # e.g. thingsboard.cloud
```
{: .copy-code}

查看完整 **.env** 文件：
```liquid
# redis or redis-cluster or redis-sentinel
CACHE=redis

DOCKER_REPO=thingsboard
{% if docsPrefix == "pe/edge/" -%}
TB_EDGE_NODE_DOCKER_NAME=tb-edge-pe-node
TB_EDGE_VERSION=latest
{%- else -%}
TB_EDGE_NODE_DOCKER_NAME=tb-edge-node
TB_EDGE_VERSION=latest
{%- endif -%}
# Database used by ThingsBoard, can be either postgres (PostgreSQL) or hybrid (PostgreSQL for entities database and Cassandra for timeseries database).
# According to the database type corresponding docker service will be deployed (see docker-compose.postgres.yml, docker-compose.hybrid.yml for details).

DATABASE=postgres
TB_QUEUE_TYPE=kafka

CLOUD_ROUTING_KEY=PUT_YOUR_EDGE_KEY_HERE # e.g. 19ea7ee8-5e6d-e642-4f32-05440a529015
CLOUD_ROUTING_SECRET=PUT_YOUR_EDGE_SECRET_HERE # e.g. bztvkvfqsye7omv9uxlp
{% if docsPrefix == "pe/edge/" -%}
CLOUD_RPC_HOST=thingsboard.cloud
CLOUD_RPC_PORT=7070
CLOUD_RPC_SSL_ENABLED=true
{%- else -%}
CLOUD_RPC_HOST=PUT_YOUR_THINGSBOARD_SERVER_DOMAIN_OR_IP_HERE # e.g. thingsboard.cloud
CLOUD_RPC_PORT=7070
{%- endif -%}


LOAD_BALANCER_NAME=haproxy-certbot

# If enabled Prometheus and Grafana containers are deployed along with other containers
MONITORING_ENABLED=false

# Limit memory usage for each Java application
JAVA_OPTS="-Xmx2048M -Xms2048M -Xss384k -XX:+AlwaysPreTouch"
```
{: .copy-code.expandable-7}

* **CACHE：** 设置缓存类型：
  * **redis：** 设置 _redis_ 以使用 Redis 单机缓存（1 节点 - 1 主节点）。
  * **redis-cluster：** 设置 _redis-cluster_ 以使用 Redis 集群缓存（6 节点 - 3 主节点，3 从节点）。
  * **redis-sentinel：** 设置 _redis-sentinel_ 以使用 Redis Sentinel 缓存（3 节点 - 1 主节点，1 从节点，1 哨兵）。
* **DATABASE：** 将 _database_ 值替换为：
  * **postgres：** 设置 _postgres_ 以使用 **PostgreSQL** 数据库。
  * **hybrid：** 设置 _hybrid_ 以使用 **PostgreSQL** 作为实体数据库，**Cassandra** 作为时序数据库。
* **TB_QUEUE_TYPE：** 使用 _kafka_ 作为队列类型。集群部署不支持 _in-memory_ 值。
* **CLOUD_ROUTING_KEY：** 填入您的 Edge key。
* **CLOUD_ROUTING_SECRET：** 填入您的 Edge secret。
* **CLOUD_RPC_HOST：** 若将 **Edge** 连接到 [ThingsBoard Cloud (北美)](https://thingsboard.cloud/signup){: target="_blank"}/[ThingsBoard Cloud (欧洲)](https://eu.thingsboard.cloud/signup){: target="_blank"}，使用 _thingsboard.cloud_ / _eu.thingsboard.cloud_；若连接到 **ThingsBoard PE Platform** 的机器，则使用 **IP 地址**。
* **MONITORING_ENABLED：** 要使用 [Grafana](https://grafana.com/){: target="_blank"} 和/或 [Prometheus](https://prometheus.io/){: target="_blank"} 服务启动集群监控，请将变量设为 _true_。

  请在此[文章](/docs/{{docsPrefix}}user-guide/troubleshooting/#downlink-messages-from-cloud-to-edge){: target="_blank"}中了解如何 **启用下行消息监控**。

{% capture monitoring %}
部署后，您可在 [http://localhost:9090](http://localhost:9090){: target="_blank"} 访问 **Prometheus**，在 [http://localhost:3000](http://localhost:3000){: target="_blank"} 访问 **Grafana**。
<br>本地安装的默认凭据为：
* **Login：** admin 
* **Password：** foobar
{% endcapture %}
{% include templates/info-banner.md content=monitoring %}

### 步骤 4. 创建并检查所需主机卷

{% include templates/install/docker/docker-compose-setup-volumes.md %}

### 步骤 5. 安装并运行 ThingsBoard Edge

要运行安装，请执行以下命令：
```bash 
./docker-install-tb.sh
```
{: .copy-code}

要启动服务，请执行以下命令：
```bash 
./docker-start-services.sh
```
{: .copy-code}

{% capture install-and-run-edge %}
服务启动需要几分钟。所有服务成功启动后，在浏览器中打开 **ThingsBoard Edge** 服务，地址为 **```http://{your-host-ip}```**（_例如 [http://localhost](http://localhost){: target="_blank"}_）。
请使用 **ThingsBoard** 账户的 **凭据** 登录。
{% endcapture %}
{% include templates/info-banner.md content=install-and-run-edge %}

如有问题，请检查 edge 服务日志中的错误。要查看 **ThingsBoard Edge** 节点日志，请执行以下命令：
```bash 
docker-compose logs -f tb-edge1 tb-edge2 tb-edge3
```
{: .copy-code}

要查看所有容器的状态，请使用：
```bash
docker-compose ps
```
{: .copy-code}

要检查所有运行中服务的日志，请使用：
```bash
docker-compose logs -f
```
{: .copy-code}

详见 [docker-compose logs](https://docs.docker.com/compose/reference/logs/){: target="_blank"} 命令参考。

#### 停止并移除 Docker 容器

要停止服务，请使用：

```bash
./docker-stop-services.sh
```
{: .copy-code}

要停止并完全移除已部署的 Docker 容器，请运行：

```bash
./docker-remove-services.sh
```
{: .copy-code}

### 升级

要更新特定或所有服务（拉取更新的 docker 镜像并重建容器）：
```bash
./docker-update-service.sh [SERVICE...]
```
{: .copy-code}

其中：
* **[SERVICE...]：** 要更新的服务列表（在 docker-compose 配置中定义）。若未指定，将更新所有服务。

要升级数据库，请运行以下命令：

```bash
./docker-stop-services.sh
./docker-upgrade-tb.sh
./docker-start-services.sh
```
{: .copy-code}

### 生成 HTTPS 证书
我们使用 **HAproxy** 代理容器流量，Web UI 默认使用 **80** 和 **443** 端口。要使用有效证书启用 HTTPS，请运行以下命令：
```bash
docker exec haproxy-certbot certbot-certonly --domain your_domain --email your_email
docker exec haproxy-certbot haproxy-refresh
```
{: .copy-code}

只有通过域名访问 Web UI 时才会使用有效证书。
若使用 IP 地址访问 UI，将使用自签名证书。

### 下一步

{% include templates/edge/guides-banner-edge.md %}
