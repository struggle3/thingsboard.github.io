---
layout: docwithnav
assignees:
- ashvayka
title: 使用 Docker Compose 的集群设置
description: ThingsBoard IoT 平台 Docker Compose 集群设置指南

---

* TOC
{:toc}

本指南将帮助您使用 Docker Compose 工具以集群模式搭建 ThingsBoard。

## 前置条件

ThingsBoard 微服务在 Docker 化环境中运行。
开始前，请确保您的系统已安装 Docker Engine 和 Docker Compose。

{% include templates/install/docker-install.md %}

{% include templates/install/docker-install-note.md %}

## 步骤 1. 拉取 ThingsBoard CE 镜像

确保您已通过命令行[登录](https://docs.docker.com/engine/reference/commandline/login/) Docker Hub。

```bash
docker pull thingsboard/tb-node:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-web-ui:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-js-executor:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-http-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-mqtt-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-coap-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-lwm2m-transport:{{ site.release.ce_full_ver }}
docker pull thingsboard/tb-snmp-transport:{{ site.release.ce_full_ver }}
```

## 步骤 2. 查阅架构页

自 ThingsBoard v2.2 起，可使用新的微服务架构和 docker 容器安装 ThingsBoard 集群。
详见 [**microservices**](/docs/reference/msa/) 架构页了解更多信息。

## 步骤 3. 克隆 ThingsBoard CE 仓库

```bash
git clone -b {{ site.release.branch }} https://github.com/thingsboard/thingsboard.git --depth 1
cd thingsboard/docker
```
{: .copy-code}

## 步骤 4. 配置 ThingsBoard 数据库

{% include templates/install/configure-db-docker-compose.md %}

## 步骤 5. 选择 ThingsBoard 队列服务

{% include templates/install/install-queue-docker-compose.md %}

{% capture contenttogglespecqueue %}
Kafka <small>（默认，推荐用于本地和生产安装）</small>%,%kafka%,%templates/install/cluster-queue-kafka.md%br%
Confluent Cloud <small>（基于 Kafka 的事件流平台）</small>%,%confluent-cloud%,%templates/install/cluster-queue-confluent-cloud.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

## 步骤 6. 启用监控（可选）

{% include templates/install/configure-monitoring-docker-compose.md %}

## 步骤 7. 运行

### 创建并检查所需主机卷
{% include templates/install/docker/docker-compose-setup-volumes.md %}

### 安装并运行 ThingsBoard
{% assign dockerComposeFileLocation = "" %}
{% include templates/install/docker/docker-compose-setup-running.md %}

## 安装后步骤

{% include templates/install/generate_certificate_docker-compose.md %}

### 升级到新 ThingsBoard 版本

{% include templates/install/upgrade-thingsboard.md %}

## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
