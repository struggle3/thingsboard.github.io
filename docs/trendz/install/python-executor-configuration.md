---
layout: docwithnav-trendz
title: Trendz Python 执行器配置
description: 如何在 Linux 或 Mac OS 上配置 Trendz Python 执行器

---

* TOC
{:toc}

## 概述

Trendz Python 执行器用于运行：

* Python 计算字段
* 所有预测模型（傅里叶变换除外）
* 指标浏览器的代码生成

自 1.14.0 版本起，运行这些功能的唯一方式是通过 Docker（或 Kubernetes）使用 Trendz Python 执行器。

## 前置条件

### Windows

{% include templates/trendz/install/docker-requirements-windows.md %}

### Linux

{% include templates/trendz/install/docker-requirements-linux.md %}

## Python 执行器独立安装

### 步骤 1：创建 Docker Compose 文件

使用以下配置创建 Docker Compose 文件：

```yml
services:
  trendz-python-executor:
    restart: always
    image: "thingsboard/trendz-python-executor:{{ site.release.trendz_ver }}"
    ports:
      - "8181:8181"
    environment:
      EXECUTOR_MANAGER: 1
      EXECUTOR_SCRIPT_ENGINE: 6
      THROTTLING_QUEUE_CAPACITY: 10
      THROTTLING_THREAD_POOL_SIZE: 6
      NETWORK_BUFFER_SIZE: 5242880
    volumes:
      - trendz-python-executor-conf:/python-executor-config-files
      - trendz-python-executor-data:/data
```
{: .copy-code}

关键字段说明：

* `8181` - Python 执行器与 Trendz 服务通信的端口
* `restart: always` - 失败或系统重启时自动重启执行器
* `thingsboard/trendz-python-executor:{{ site.release.trendz_ver }}` - Trendz Python 执行器的 Docker 镜像
* `trendz-python-executor-conf:/python-executor-config-files` - 将卷 `trendz-python-executor-conf` 挂载到 Trendz Python 执行器的配置文件目录
* `trendz-python-executor-data:/data` - 将卷 `trendz-python-executor-data` 挂载到 Trendz Python 执行器的额外数据目录

### 步骤 2：启动 Python 执行器

```bash
docker compose up -d
docker compose logs -f trendz-python-executor
```
{: .copy-code}

### 步骤 3：将 Trendz 连接到 Python 执行器

* **Linux 或 Mac OS**

配置 Trendz 与 Python 执行器通信。

编辑 `/usr/share/trendz/conf/trendz.conf` 并添加：

```bash
export SCRIPT_ENGINE_TIMEOUT=30000
export SCRIPT_ENGINE_PROVIDER=DOCKER_CONTAINER
export SCRIPT_ENGINE_DOCKER_PROVIDER_URL=PYTHON_EXECUTOR_HOST:PYTHON_EXECUTOR_PORT
```
{: .copy-code}

将 `PYTHON_EXECUTOR_HOST` 和 `PYTHON_EXECUTOR_PORT` 替换为您的 Python 执行器服务值，并确保 Trendz 能访问此网络目标。

* **Windows**

以管理员身份打开记事本并编辑：

```text
C:\Program Files (x86)\trendz\conf\trendz.yml
```
{: .copy-code}

找到 `script-engine` 块并配置：

```yml
script-engine:
  provider: "${SCRIPT_ENGINE_PROVIDER:DOCKER_CONTAINER}"
  runtime-timeout: "${SCRIPT_ENGINE_TIMEOUT:60000}"
  callback-timeout: "${SCRIPT_ENGINE_TIMEOUT:60000}"
  docker-provider-url: "${SCRIPT_ENGINE_DOCKER_PROVIDER_URL:PYTHON_EXECUTOR_HOST:PYTHON_EXECUTOR_PORT}"
  websocket-buffer-size: "${SCRIPT_ENGINE_WEBSOCKET_BUFFER_SIZE:20971520}"
  websocket-concurrency: "${SCRIPT_ENGINE_WEBSOCKET_CONCURRENCY:5}"
```

将 `PYTHON_EXECUTOR_HOST` 和 `PYTHON_EXECUTOR_PORT` 替换为您的 Python 执行器服务值，并确保 Trendz 能访问此网络目标。

## 如何将 Trendz Python 执行器 1.13.2 迁移到 1.14.0

若您已有低于 1.14.0 的 Python 执行器连接到 Trendz，应在将 Trendz 更新到 1.14.0 之前先迁移。

### 步骤 1. 修改 Docker Compose 文件

找到启动 Python 执行器所用的 `docker-compose.yml` 文件。

将 Python 执行器镜像标签更改为 1.14.0，并更新 `volumes` 部分以包含配置和数据目录。

最终的 `docker-compose.yml` 应如下所示：

```yml
services:
  trendz-python-executor:
    restart: always
    image: "thingsboard/trendz-python-executor:{{ site.release.trendz_ver }}"
    ports:
      - "8181:8181"
    environment:
      EXECUTOR_MANAGER: 1
      EXECUTOR_SCRIPT_ENGINE: 6
      THROTTLING_QUEUE_CAPACITY: 10
      THROTTLING_THREAD_POOL_SIZE: 6
      NETWORK_BUFFER_SIZE: 5242880
    volumes:
      - trendz-python-executor-conf:/python-executor-config-files
      - trendz-python-executor-data:/data
```
{: .copy-code}

### 步骤 2. 重启 Python 执行器

重启 Python 执行器以应用更改：

```bash
docker compose up -d
docker compose logs -f trendz-python-executor
```
{: .copy-code}

## 如何将额外库连接到 Python 执行器

如有需要，您可以为 **Python 执行器** 添加额外的 Python 库，并在 Trendz 计算字段或 Trendz 自定义预测模型中使用它们。

例如，若要添加 **`emoji`** 库（特定版本 2.2.0），请按以下步骤操作。

### 步骤 1. 在运行中的容器中打开 shell

```bash
docker compose exec trendz-python-executor bash
```

### 步骤 2. 将库添加到 `requirements.txt`

您需要将库名称和版本追加到配置目录（`/python-executor-config-files`）中的 `requirements.txt` 文件：

```bash
echo 'emoji==2.2.0' >> /python-executor-config-files/requirements.txt
```
{: .copy-code}

追加所有必要依赖后，输入 `exit` 退出 shell。

### 步骤 3. 重启 Docker 容器

查找容器名称并重启：
```bash
docker compose restart trendz-python-executor
```
{: .copy-code}

### 步骤 4. 验证安装

检查日志以确认库已成功安装：

```bash
docker compose logs trendz-python-executor
```
{: .copy-code}

您应看到：

```text
Installing custom Python requirements...
Requirement already satisfied: emoji==2.2.0 in /usr/local/lib/python3.9/site-packages
```

容器重启后，您可以在 Trendz 计算字段或 Trendz 自定义预测模型中导入并使用自定义库。

## 下一步

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
