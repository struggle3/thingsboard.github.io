---
layout: docwithnav-edge
title: 在 Ubuntu Server 上安装 ThingsBoard Edge
description: 在 Ubuntu Server 上安装 ThingsBoard Edge

---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南介绍在 **Ubuntu 22.04 LTS 与 24.04 LTS** 上安装 **ThingsBoard Edge** 的步骤。

{% include templates/edge/install/prerequisites.md %}

## 使用 Server UI 中的预配置指令进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% include templates/edge/install/manual-install-instructions-intro.md %}

### 步骤 1：安装 Java 17（OpenJDK） 

{% include templates/install/ubuntu-java-install.md %}

### 步骤 2：配置 ThingsBoard Edge 数据库

**ThingsBoard Edge** 支持 **SQL** 与 **hybrid** 数据库架构。详见 [架构说明](/docs/reference/#sql-vs-nosql-vs-hybrid-database-approach){: target="_blank"}。

{% capture contenttogglespec %}
PostgreSQL <small>(recommended for < 5K msg/sec)</small>%,%postgresql%,%templates/edge/install/ubuntu-db-postgresql.md%br%
Hybrid <br>PostgreSQL+Cassandra<br><small>(recommended for > 5K msg/sec)</small>%,%hybrid%,%templates/edge/install/ubuntu-db-hybrid.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardDatabase" toggle-spec=contenttogglespec %}

### 步骤 3：选择 Queue 服务

**ThingsBoard Edge** 可使用不同消息系统和代理来存储消息并实现服务间通信。请根据业务需求选择合适的 queue 实现：

* **In Memory**：内置默认 queue 实现，适用于开发或概念验证（PoC）环境，因可扩展性有限，不建议用于生产或集群部署。

* **Kafka**：建议用于生产部署，当前大多数 ThingsBoard 生产环境均使用该 queue。

{% capture contenttogglespecqueue %}
In Memory <small>(built-in and default)</small>%,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>(recommended for on-prem, production installations)</small>%,%kafka-in-docker%,%templates/edge/install/ubuntu-queue-kafka-in-docker.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %}

### 步骤 4：安装 ThingsBoard Edge 服务

下载安装包：

```bash
wget https://github.com/thingsboard/thingsboard-edge/releases/download/{{ site.release.edge_tag }}/tb-edge-{{ site.release.edge_ver }}.deb
```
{: .copy-code}

进入下载目录并安装 ThingsBoard Edge 服务

```bash
sudo dpkg -i tb-edge-{{ site.release.edge_ver }}.deb
```
{: .copy-code}

### 步骤 5：配置 ThingsBoard Edge

{% include templates/edge/install/linux-configure-edge.md %}

### 步骤 6：运行安装脚本

{% include templates/edge/install/run-edge-install.md %} 

### 步骤 7：启动 ThingsBoard Edge 服务

```bash
sudo service tb-edge start
```
{: .copy-code}

### 步骤 8：打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %} 

## 故障排除

**ThingsBoard Edge** 日志位于以下目录：
 
```bash
/var/log/tb-edge
```
检查服务端错误可运行以下命令：
 
```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```
{: .copy-code}

{% include templates/edge/install/edge-service-commands.md %} 

## 下一步

{% include templates/edge/install/next-steps.md %}
