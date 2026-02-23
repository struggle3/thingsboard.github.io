---
layout: docwithnav-pe
assignees:
- ashvayka
title: ThingsBoard 专业版 Docker Compose 集群设置指南
description: ThingsBoard 专业版 Docker Compose 集群设置指南
redirect_from: "/docs/user-guide/install/pe/docker-cassandra/"  

---

* TOC
{:toc}

{% assign docsPrefix = "pe/" %}

本指南将帮助您使用 Docker Compose 以集群模式设置 ThingsBoard。
为此，我们将使用 [Docker Hub](https://hub.docker.com/search?q=thingsboard&type=image&image_filter=store) 上提供的 Docker 容器镜像。

## 前置条件

ThingsBoard 微服务在 Docker 化环境中运行。
开始前请确保系统中已安装 Docker Engine 和 Docker Compose。 

{% include templates/install/docker-install.md %}

{% capture rule_engine_note %}
请注意，若将规则引擎作为独立服务部署，需要额外的独立许可证密钥。
{% endcapture %}
{% include templates/info-banner.md content=rule_engine_note %}

{% include templates/install/docker-install-note.md %}

## 步骤 1. 拉取 ThingsBoard PE 镜像

{% include templates/install/dockerhub/pull.md %}

## 步骤 2. 克隆 ThingsBoard PE Docker Compose 脚本

```bash
git clone -b release-{{ site.release.ce_ver }} https://github.com/thingsboard/thingsboard-pe-docker-compose.git tb-pe-docker-compose --depth 1
cd tb-pe-docker-compose
```
{: .copy-code}

## 步骤 3. 获取许可证密钥

我们假定您已选择订阅计划或决定购买永久许可证。
否则，请前往 [pricing](/pricing/) 页面选择适合的许可证选项并获取许可证。
详见 [如何获取按需付费订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

**重要提示**：若使用[高级部署类型](/docs/user-guide/install/pe/cluster/docker-compose-setup/#step-6-configure-deployment-type)，请确保已购买至少四个 ThingsBoard PE 实例的许可证密钥。
否则，需修改 [docker-compose.yml](https://github.com/thingsboard/thingsboard-pe-docker-compose/blob/master/advanced/docker-compose.yml)) 的本地副本，以使用您已购买的 ThingsBoard 实例数量。
本指南稍后将使用 PUT_YOUR_LICENSE_SECRET_HERE 引用您在本步骤获取的许可证密钥。


## 步骤 4. 配置许可证密钥

```bash
nano tb-node.env
```
{: .copy-code}

并将 "PUT_YOUR_LICENSE_SECRET_HERE" 替换为许可证密钥参数：

```bash
# ThingsBoard server configuration
...
TB_LICENSE_SECRET=PUT_YOUR_LICENSE_SECRET_HERE
```

## 步骤 5. 配置部署类型

自 ThingsBoard v2.2 起，可使用新的微服务架构和 Docker 容器安装 ThingsBoard 集群。
详见 [**微服务**](/docs/reference/msa/) 架构页面。

Docker Compose 脚本支持三种部署模式。要设置部署模式，请将 `.env` 文件中 `TB_SETUP` 变量的值改为以下之一：

- `basic` **（推荐，默认）** - ThingsBoard 核心与规则引擎在同一 JVM 中启动（仅需一个许可证）。
  MQTT、CoAP 和 HTTP 传输在独立容器中启动。
- `monolith` - ThingsBoard 核心与规则引擎在同一 JVM 中启动（仅需一个许可证）。
  MQTT、CoAP 和 HTTP 传输也在同一 JVM 中启动，以最小化内存占用和服务器要求。
- `advanced` - ThingsBoard 核心与规则引擎在独立容器中启动并复制（需要 4 个许可证）。
  
所有部署模式均支持独立 JS 执行器、Redis 及不同[队列](/docs/user-guide/install/pe/cluster/docker-compose-setup/#step-8-choose-thingsboard-queue-service)。

## 步骤 6. 配置 ThingsBoard 数据库

{% include templates/install/configure-db-docker-compose.md %}

## 步骤 7. 选择 ThingsBoard 队列服务 

{% include templates/install/install-queue-docker-compose.md %}

{% capture contenttogglespecqueue %}
Kafka <small>（默认，推荐用于本地生产部署）</small>%,%kafka%,%templates/install/cluster-queue-kafka.md%br%
Confluent Cloud <small>（基于 Kafka 的事件流平台）</small>%,%confluent-cloud%,%templates/install/cluster-queue-confluent-cloud.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %}

## 步骤 8. 启用监控（可选）

{% include templates/install/configure-monitoring-docker-compose.md %}

## 步骤 9. 启用 Trendz Analytics（可选）

您可随时按以下步骤安装 Trendz Analytics：

编辑配置文件：

```bash
nano .env
```
{: .copy-code}

需确保 `TRENDZ_ENABLED` 变量设置为 `true`：

```bash
TRENDZ_ENABLED=true
```

可在此处了解 Trendz Analytics [详情](/docs/trendz/what-is-trendz/)。

## 步骤 10. 运行

### 创建并检查所需主机卷
{% include templates/install/docker/docker-compose-setup-volumes.md %}

### 安装并运行 ThingsBoard
{% assign dockerComposeFileLocation = "-f $TB_SETUP/docker-compose.yml " %}
{% include templates/install/docker/docker-compose-setup-running.md %}

## 安装后步骤

{% include templates/install/generate_certificate_docker-compose.md %}

### 升级到新版 ThingsBoard

{% include templates/install/upgrade-thingsboard.md %}

### 升级到新版 Trendz（可选）

Trendz Analytics 采用独立的版本体系，应与 ThingsBoard 平台主服务分开更新。

要更新 Trendz，需编辑 .env 文件，将 "TRENDZ_VERSION" 设为目标版本（如升级到最新版可设为 {{ site.release.trendz_ver }}）。然后执行以下命令：

```bash
./docker-stop-services.sh
./docker-upgrade-trendz.sh
./docker-start-services.sh
```
{: .copy-code}

注意，可从任意版本升级 Trendz 至最新版（例如 1.12.0 -> {{ site.release.trendz_ver }} 等）。

## 后续步骤

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
