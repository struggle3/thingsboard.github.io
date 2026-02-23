---
layout: docwithnav-edge
title: 使用 Docker 安装 ThingsBoard Edge（Linux 或 Mac OS）
description: 使用 Docker 在 Linux 或 Mac OS 上安装 ThingsBoard Edge

---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南介绍在 **Linux 或 Mac OS** 上使用 **Docker** 运行 **ThingsBoard Edge** 的步骤。

{% include templates/edge/install/prerequisites.md %}

### Docker 安装

{% capture local-deployment %}
**ThingsBoard** supports **Docker Compose V2** (Docker Desktop or Compose plugin) starting from **3.4.2 release**.

We strongly recommend **upgrading to and using Docker Compose V2**, as Docker no longer supports docker-compose as a standalone setup.
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

- [Install Docker CE](https://docs.docker.com/engine/install/){:target="_blank"}
- [Install Docker Compose](https://docs.docker.com/compose/install/){:target="_blank"}

{% include templates/install/docker-install-note.md %}

## 使用 ThingsBoard Server 预配置指令进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% include templates/edge/install/manual-install-instructions-intro.md %}

### 步骤 1：运行 ThingsBoard Edge

{% include templates/edge/install/docker-images-location.md %}

{% include templates/edge/install/copy-edge-credentials.md %}

### 步骤 2：选择 Queue 和/或 Database 服务

**ThingsBoard Edge** 可使用多种消息系统/代理来存储消息并实现 ThingsBoard 服务间通信。如何选择合适的 queue 实现？

* **In Memory** 为内置默认 queue 实现，适用于开发（PoC）环境，不适合生产部署或集群部署。

* **Kafka** 适用于生产部署，当前大多数 ThingsBoard 生产环境均使用该 queue。

* **Hybrid** 实现将 PostgreSQL 和 Cassandra 与 Kafka queue 服务相结合，若计划在生产中管理 100 万以上设备或需要高数据摄入速率（超过 5000 msg/sec），建议采用。

Create a docker compose file for the **ThingsBoard Edge** service:

{% capture contenttogglespecqueue %}
In Memory <small>(built-in and default)</small>%,%inmemory%,%templates/edge/docker-queue-in-memory.md%br%
Kafka <small>(recommended for on-prem, production installations)</small>%,%kafka%,%templates/edge/install/docker-queue-kafka.md%br%
Hybrid <small>(PostgreSQL+Cassandra with Kafka queue service)</small>%,%hybrid%,%templates/edge/install/docker-queue-hybrid.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %}

### 步骤 3：打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %}

### 步骤 4：分离、停止与启动命令

{% assign serviceFullName = "ThingsBoard Edge" %}
{% include templates/edge/detaching-stop-start-edge.md %}

## 故障排除

{% include templates/edge/install/docker-troubleshooting.md %}

## 下一步

{% include templates/edge/install/next-steps.md %}



