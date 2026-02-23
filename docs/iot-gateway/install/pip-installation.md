---
layout: docwithnav-gw
title: IoT Gateway Pip 安装
description: 通过 pip 安装 ThingsBoard IoT Gateway

---

## 包管理器安装

要以 Python 模块方式安装 ThingsBoard Gateway，请按以下步骤操作：

**1. 使用 apt 安装所需系统库：**

```bash
sudo apt install python3-dev python3-pip libglib2.0-dev 
```
{: .copy-code}

**2. 使用 pip 安装 ThingsBoard Gateway 模块：**

```bash
sudo pip3 install thingsboard-gateway
```
{: .copy-code}

**3. 下载配置示例，创建日志目录：**

- 下载配置示例：  

  ```bash
  wget https://github.com/thingsboard/thingsboard-gateway/releases/latest/download/configs.tar.gz
  ```
  {: .copy-code}

- 创建配置目录：  
  ```bash
  sudo mkdir /etc/thingsboard-gateway
  ```
  {: .copy-code}

- 创建日志目录：  
  ```bash
  sudo mkdir /var/log/thingsboard-gateway
  ```
  {: .copy-code}

- 解压配置：
  ```bash
  sudo tar -xvzf configs.tar.gz -C /etc/thingsboard-gateway
  ```
  {: .copy-code}


**4. 设置目录权限：**

- 日志目录：
  ```bash
  sudo chown YOUR_USER:YOUR_USER -R /var/log/thingsboard-gateway
  ```
  {: .copy-code}

- 配置目录：
  ```bash
  sudo chown YOUR_USER:YOUR_USER -R /etc/thingsboard-gateway
  ```
  {: .copy-code}

- tmp 目录：
  ```bash
  sudo chown YOUR_USER:YOUR_USER /tmp
  ```
  {: .copy-code}

其中 `YOUR_USER` 为运行网关的用户名。

**5. 配置网关：**

首先，按以下步骤在 ThingsBoard 实例中添加网关设备：

{% assign createNewGatewayDevice = '
  ===
    image: /images/gateway/dashboard/gateway-getting-started-1-ce.png,
    title: 进入「**实体**」>「**网关**」页面，点击右上角「**加号**」图标添加新网关。
  ===
    image: /images/gateway/dashboard/gateway-getting-started-2-ce.png,
    title: 在弹出窗口中输入网关名称（如「My Gateway」），选择「**default**」设备配置文件，点击「**创建**」。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createNewGatewayDevice %}

接下来需配置正确的 host、port 和凭证，步骤如下：

- 点击「**通用配置**」按钮，在「**通用**」标签页复制 **Access token**；
- 打开终端并执行以下命令：

```text
nano /etc/thingsboard-gateway/config/tb_gateway.json
```
{: .copy-code}

- 粘贴复制的 access token，并将平台 host 和 port 替换为你的值；
- 保存并退出 nano。

{% assign configureGateway = '
    ===
        image: /images/gateway/install/configure-gateway-1-ce.png,
        title: 点击「**通用配置**」按钮；
    ===
        image: /images/gateway/install/configure-gateway-2-ce.png,
        title: 在「**通用**」标签页复制 **Access token**；
    ===
        image: /images/gateway/install/configure-gateway-3-ce.png,
        title: 打开终端并执行：`nano /etc/thingsboard-gateway/config/tb_gateway.json`。粘贴 access token，替换平台 host 和 port。保存并退出 nano。
'
%}

{% include images-gallery.liquid imageCollection=configureGateway %}

**6. 配置日志：**

- 点击「**通用配置**」按钮；
- 进入「**日志**」标签，将「**文件路径**」字段值改为：

```text
/var/log/thingsboard-gateway 
```
{: .copy-code}

- 对「**本地日志**」中各标签重复上述步骤；
- 点击「**保存**」。

{% assign configureGatewayLogs = '
    ===
        image: /images/gateway/install/configure-gateway-4-ce.png,
        title: 点击「**通用配置**」按钮；
    ===
        image: /images/gateway/install/configure-gateway-5-ce.png,
        title: 进入「**日志**」标签，将所有标签中的「**文件路径**」设为 `/var/log/thingsboard-gateway`，然后点击「**保存**」。
'
%}

{% include images-gallery.liquid imageCollection=configureGatewayLogs %}

**7. 可通过以下命令验证安装**。*详细配置请参见[配置指南](/docs/iot-gateway/configuration/)：*

```bash
thingsboard-gateway
```
{: .copy-code}

- 若配置正确，网关状态将显示为 `Active`。

{% assign configureCorrectGateway = '
    ===
        image: /images/gateway/install/configure-gateway-6-ce.png,
        title: 若配置正确，网关状态将显示为 `Active`。
'
%}

{% include images-gallery.liquid imageCollection=configureCorrectGateway %}

## 下一步

查阅 ThingsBoard 主要功能的相关指南：

 - [快速入门](/docs/iot-gateway/getting-started/) - ThingsBoard IoT Gateway 入门。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据。
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据。
 - [RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送及从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据。
