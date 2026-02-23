---
layout: docwithnav-trendz
assignees:
- ashvayka
title: 在 Ubuntu 上安装 ThingsBoard Trendz Analytics
description: 在 Ubuntu 上安装 ThingsBoard Trendz Analytics

trendz-settings:
  0:
    image: /images/trendz/install/sync/trendz-settings-1.png
    title: "Log in to <b>ThingsBoard</b> as a <b>Sysadmin</b>."  
  1:
    image: /images/trendz/install/sync/trendz-settings-2.png
    title: "Open the <b>Trendz Settings</b> page."  
  2:
    image: /images/trendz/install/sync/trendz-settings-3.png
    title: "If you see the message <b>\"Synchronization completed successfully\"</b>, the synchronization has been completed automatically and no further action is required."
trendz-sync:
  0:
    image: /images/trendz/install/sync/trendz-sync-1.png
    title: "If you see an error message, follow these steps."
  1:
    image: /images/trendz/install/sync/trendz-sync-2.png
    title: "Enter the correct <b>Trendz internal URL</b> and <b>ThingsBoard internal URL</b>."
  2:
    image: /images/trendz/install/sync/trendz-sync-3.png
    title: "Click <b>Save configuration</b>."
  3:
    image: /images/trendz/install/sync/trendz-sync-4.png
    title: "Click <b>Retry discovery</b>."
  4:
    image: /images/trendz/install/sync/trendz-sync-5.png
    title: "Once the message <b>\"Synchronization completed successfully\"</b> appears, the synchronization is complete."

---

* TOC
{:toc}

本指南说明如何在**Ubuntu 22.04 LTS**或**Ubuntu 24.04 LTS**上安装**Trendz Analytics**。

**Ubuntu安装前重要说明**

Trendz Analytics的部分功能（如**predictions**、**metric explorations**和**Python calculation fields**）依赖Python executor。

Python executor**仅能通过Docker运行**。即使在Ubuntu上，也要使用Docker才能完整使用Trendz。
建议遵循[Docker (Linux或Mac OS) 安装指南](/docs/trendz/install/docker)，采用Docker安装而非Ubuntu。

**仅**在有充分理由使用Ubuntu + Docker组合方案时再继续阅读本文。

## Prerequisites

### Hardware Requirements

{% include templates/trendz/install/hardware-requirements.md %}

### Software Requirements

{% include templates/trendz/install/docker-requirements-linux.md %}
{% include templates/trendz/install/thingsboard-requirements.md %}

## Installation Steps

### Step 1. Install Java 17 (OpenJDK)

{% include templates/install/ubuntu-java-install.md %}

### Step 2. Trendz Analytics service installation

下载安装包。

```bash
wget https://dist.thingsboard.io/trendz-{{ site.release.trendz_ver }}.deb
```
{: .copy-code}

安装Trendz Analytics服务

```bash
sudo dpkg -i trendz-{{ site.release.trendz_ver }}.deb
```
{: .copy-code}

### Step 3. Configure Trendz database

Trendz使用PostgreSQL作为数据库。可在同一服务器为Trendz安装PostgreSQL，或使用云商的托管PostgreSQL服务。

* **PostgreSQL Installation**

{% include templates/install/postgres-install-ubuntu.md %}

* **Create Database for Trendz**

连接数据库并创建trendz库：

```bash
psql -U postgres -d postgres -h 127.0.0.1 -W
```
{: .copy-code}

创建名为"trendz"的数据库：
```bash
CREATE DATABASE trendz;
```
{: .copy-code}

按"Ctrl+D"两次退出。

* **Configure database connection for Trendz**

编辑Trendz配置文件

```bash
sudo nano /etc/trendz/conf/trendz.conf
```
{: .copy-code}

在配置文件中添加以下行。**勿忘**将"PUT_YOUR_POSTGRESQL_PASSWORD_HERE"替换为**真实的postgres用户密码**：

```bash
# DB Configuration
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/trendz
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
```
{: .copy-code}

### Step 4. Run installation script

Trendz服务安装完毕且DB配置更新后，执行以下脚本：

```bash
sudo /usr/share/trendz/bin/install/install.sh
```
{: .copy-code}

### Step 5. Start Trendz service

执行以下命令启动Trendz Analytics：

```bash
sudo service trendz start
```
{: .copy-code}

### Step 6. Sync ThingsBoard With Trendz

{% include templates/trendz/install/sync-with-tb.md %}

### Step 7. Install Trendz Python Executor

要使用Trendz Python Calculation Fields或Prediction Models等全部Trendz能力，
需安装Trendz Python Executor——该服务可安全运行Python代码。

安装方法[见](/docs/trendz/install/python-executor-configuration)。

## Authentication

{% include templates/trendz/install/authentication.md %}

## Troubleshooting

Trendz日志位于以下目录：

```bash
/var/log/trendz
```

检查backend是否有错误可执行：

```bash
cat /var/log/trendz/trendz.log | grep ERROR
```

## HTTPS configuration

{% include templates/trendz/install/https-configuration.md %}

## Next steps

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
