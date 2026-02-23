---
layout: docwithnav-gw
title: 以软件包方式安装 ThingsBoard IoT Gateway
description: 在 Ubuntu 22.04 LTS / 24.04 LTS 上安装 ThingsBoard IoT Gateway
redirect_from: 
 - "/docs/iot-gateway/install/rpi/"
---

本指南介绍如何在 Ubuntu 22.04 LTS / 24.04 LTS 上安装 ThingsBoard IoT Gateway。

## 前置条件

- 系统最低要求符合该 OS 的官方[最低要求](https://help.ubuntu.com/lts/serverguide/preparing-to-install.html#system-requirements)； 
- 安装 [Python](https://www.python.org){:target="_blank"} 3.7 或更高版本。

## 步骤 1：下载 deb 文件

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/latest/download/python3-thingsboard-gateway.deb
```
{: .copy-code}

## 步骤 2：使用 apt 安装网关

以软件包方式安装 ThingsBoard IoT Gateway 并作为 daemon 运行，执行以下命令：<br><br>

```bash
sudo apt install ./python3-thingsboard-gateway.deb -y
```
{: .copy-code}

deb 包将自动安装 IoT Gateway 所需的库：  

1. 系统库：*libffi-dev, libglib2.0-dev, libxml2-dev, libxslt-dev, libssl-dev, zlib1g-dev, python3-dev, python3-pip*。  
2. Python 模块：*importlib, importlib-metadata, jsonschema, pymodbus, lxml, jsonpath-rw, paho-mqtt, pyserial, PyYAML, simplejson, pyrsistent*。  

## 步骤 3：检查网关状态 

```bash
systemctl status thingsboard-gateway
```
{: .copy-code}

输出中可能出现报错，属正常现象，因网关尚未配置连接 ThingsBoard：

```text
... python3[7563]: ''2019-12-26 09:31:15' - ERROR - mqtt_connector - 181 - Default Broker connection FAIL with error 5 not authorised!'
... python3[7563]: ''2019-12-26 09:31:15' - DEBUG - mqtt_connector - 186 - "Default Broker" was disconnected.'
... python3[7563]: ''2019-12-26 09:31:16' - DEBUG - tb_client - 78 - connecting to ThingsBoard'
... python3[7563]: ''2019-12-26 09:31:17' - DEBUG - tb_client - 78 - connecting to ThingsBoard'
```

## 步骤 4：配置网关

参考 [**配置指南**](/docs/iot-gateway/configuration/) 配置网关。配置生效需重启网关。

```bash
systemctl restart thingsboard-gateway
```
{: .copy-code}

## 离线构建版本

离线构建是 ThingsBoard Gateway 软件包的特殊变体，专为无互联网环境下的安装与运行设计。离线构建无需在运行时安装依赖即可使用任意 connector，已预打包全部依赖，包括：
- 预构建的 Python 虚拟环境。
- 所有必需的 Python 包。
- 应用 wheel（`.whl`）。

适用于隔离、离线或受限网络环境下的部署。

### 使用场景示例

某公司全部基础设施部署在私有数据中心。其 ThingsBoard Gateway 需连接网络内的 OPC-UA 和 MQTT 源，但因严格防火墙规则无法访问互联网。

### 前置条件

离线构建需满足与标准包安装相同的前置条件，且需安装 **Python 3.11**。若 Python 版本不兼容，安装程序会退出并提示如何安装正确版本。

安装正确 Python 版本可执行：

```bash
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update
sudo apt-get install -y python3.11 python3.11-venv
```
{: .copy-code}

### 安装

#### 步骤 1：下载 deb 文件

下载安装包。

```bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/latest/download/python3.11-thingsboard-gateway-offline.deb
```
{: .copy-code}

#### 步骤 2：使用 apt 安装网关

以软件包方式安装 ThingsBoard IoT Gateway 并作为 daemon 运行，执行以下命令：<br><br>

```bash
sudo apt install ./python3.11-thingsboard-gateway-offline.deb -y
```
{: .copy-code}

#### 步骤 3：检查网关状态 

```bash
systemctl status thingsboard-gateway
```
{: .copy-code}

### 故障排查

- **Python 版本错误**

  安装程序会提示如何安装所需版本的详细说明。
- **修复 Python 后需卸载已安装的 ThingsBoard IoT Gateway**

  安装正确 Python 版本后，使用以下命令卸载之前安装的 Gateway 包：

  ```bash
  sudo dpkg --purge python3-thingsboard-gateway
  ```
  {: .copy-code}

  然后按上文所述安装离线构建包。
