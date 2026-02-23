---
layout: docwithnav-edge
title: 在 CentOS/RHEL Server 上安装 ThingsBoard Edge
description: 在 CentOS/RHEL Server 上安装 ThingsBoard Edge
---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

本指南介绍在 **RHEL/CentOS 8/9** 上安装 **ThingsBoard Edge** 的步骤。

{% include templates/edge/install/prerequisites.md %}

## 使用 ThingsBoard Server 预配置指令进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% include templates/edge/install/manual-install-instructions-intro.md %}

### 安装前步骤 
在继续安装前，请执行以下命令安装必要工具：

```bash
sudo yum install -y nano wget && sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```
{: .copy-code}

### 步骤 1：安装 Java 17（OpenJDK） 

{% include templates/install/rhel-java-install.md %}

### 步骤 2：配置 ThingsBoard 数据库

**ThingsBoard Edge** 支持 **SQL** 与 **hybrid** 数据库架构。详见 [架构说明](/docs/reference/#sql-vs-nosql-vs-hybrid-database-approach){: target="_blank"}。

{% capture contenttogglespec %}
PostgreSQL <small>(recommended for < 5K msg/sec)</small>%,%postgresql%,%templates/edge/install/rhel-db-postgresql.md%br%
Hybrid <br>PostgreSQL+Cassandra<br><small>(recommended for > 5K msg/sec)</small>%,%hybrid%,%templates/edge/install/rhel-db-hybrid.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="rhelThingsboardDatabase" toggle-spec=contenttogglespec %}

### 步骤 3：选择 Queue 服务
**ThingsBoard Edge** 可使用不同消息系统/代理来存储消息并实现 ThingsBoard 服务间通信。如何选择合适的 queue 实现？

* **In Memory** 为内置默认 queue 实现，适用于开发（PoC）环境，不适合生产部署或集群部署。

* **Kafka** 适用于生产部署，当前大多数 ThingsBoard 生产环境均使用该 queue。 

{% capture contenttogglespecqueue %}
In Memory <small>(built-in and default)</small>%,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>(recommended for on-prem, production installations)</small> %,%kafka%,%templates/edge/install/rhel-queue-kafka.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardQueue" toggle-spec=contenttogglespecqueue %}

### 步骤 4：安装 ThingsBoard Edge 服务

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard-edge/releases/download/{{ site.release.edge_tag }}/tb-edge-{{ site.release.edge_ver }}.rpm
```
{: .copy-code}

进入下载目录并安装 ThingsBoard Edge 服务

```bash
sudo rpm -Uvh tb-edge-{{ site.release.edge_ver }}.rpm
```
{: .copy-code}


### 步骤 5：配置 ThingsBoard Edge

{% include templates/edge/install/linux-configure-edge.md %}

### 步骤 6：运行安装脚本

{% include templates/edge/install/run-edge-install.md %} 

### 步骤 7：重启 ThingsBoard Edge 服务

```bash
sudo service tb-edge restart
```
{: .copy-code}

### 步骤 8：打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %} 

## 故障排除

ThingsBoard Edge 日志位于以下目录：
 
```bash
/var/log/tb-edge
```

检查服务端错误可运行以下命令：
 
```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```

{% include templates/edge/install/edge-service-commands.md %} 

## 下一步

{% include templates/edge/install/next-steps.md %}