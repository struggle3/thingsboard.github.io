---
layout: docwithnav-gw
title: ThingsBoard IoT Gateway 快速入门
description: 配置 MQTT、OPC-UA、Modbus connector，在 Docker 容器中连接各自演示服务器并采集数据。

---

* TOC
{:toc}

ThingsBoard IoT Gateway 是开源方案，作为接入传统与第三方系统的 IoT 设备与 ThingsBoard 之间的桥梁。

本指南覆盖 IoT Gateway 的初始安装与配置，将完成：
- 创建新的网关设备；
- 使用 Docker 命令启动网关；
- 配置多种 connector（[MQTT](/docs/iot-gateway/config/mqtt/)、[OPC-UA](/docs/iot-gateway/config/opc-ua/)、[Modbus](/docs/iot-gateway/config/modbus/)），连接本地演示服务器并读取数据；
- 在 ThingsBoard 中查看收到的设备数据。

## 前置条件

- 开始配置网关前，确保 ThingsBoard 服务器已启动运行。最简便的方式是使用 [ThingsBoard Cloud](https://thingsboard.io/installations/){:target="_blank"}。也可按 [安装指南](/docs/user-guide/install/installation-options/) 手动安装 ThingsBoard。
- 确保已安装并正确配置 Docker。若未安装，可从 [Docker 官网](https://docs.docker.com/engine/install/) 下载，并按对应操作系统的安装指南进行安装。

## 步骤 1. 在 ThingsBoard 上创建新的网关设备

首先，按下列步骤在你的 ThingsBoard 实例中添加网关设备：

{% assign createNewGatewayDevice = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-1-ce.png,
        title: 进入「**实体**」>「**网关**」标签页。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-2-ce.png,
        title: 点击「**+**」按钮，输入网关设备名称（如「My Gateway」），选择设备配置文件，点击「**创建**」。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createNewGatewayDevice %} 

{% capture info %}
<div>
  <p>
    <span style="color:black">若此前已配置过网关，请先备份，新的远程配置会覆盖现有设置文件。  
    <br>若曾使用 3.4 之前的网关版本，网关将自动生成新的 JSON 格式配置文件。</span>
  </p>
</div>
{% endcapture %}
{% include templates/info-banner.md content=info %}

启动网关的步骤如下：

{% assign remoteCreateGatewayDocker = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-3-ce.png,
        title: 选中并点击新建的网关，在右上角点击 **「启动命令」** 按钮。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-4-ce.png,
        title: 点击下载 `docker-compose.yml` 到本机，复制命令并在终端中执行。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=remoteCreateGatewayDocker %}

运行网关 Docker 镜像后，终端中可看到如下日志：

![](/images/gateway/dashboard/launch-gateway-docker.png)

## 步骤 2：启用远程日志

要在平台侧查看网关与 connector 的日志，需启用远程日志。操作步骤如下：

{% assign enableRemoteLogging = '
    ===
        image: /images/gateway/dashboard/general-configuration-1-ce.png,
        title: 在选中的网关页面上，点击右侧面板的 **「通用配置」** 按钮。
    ===
        image: /images/gateway/dashboard/general-configuration-2-ce.png,
        title: 进入「**日志**」标签，开启「**远程日志**」开关，在「**日志级别**」下拉框中选择「**DEBUG**」，点击「**保存**」应用更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=enableRemoteLogging %}

## 步骤 3：添加新 connector

选择 connector 类型即确定网关与其他系统或设备交互所使用的具体连接方式。

了解 connector 工作方式，可从以下 connector 中选择一个：

{% capture connectorscreationspec %}
MQTT<small></small>%,%mqtt%,%templates/iot-gateway/remote-creating-connector-mqtt.md%br%
Modbus<small></small>%,%modbus%,%templates/iot-gateway/remote-creating-connector-modbus.md%br%
OPC-UA<small></small>%,%opcua%,%templates/iot-gateway/remote-creating-connector-opcua.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="connectorsCreation" toggle-spec=connectorscreationspec %}

## 步骤 4：查看设备数据

要查看网关上报的数据，按下列步骤操作：

{% assign checkDeviceData = '
    ===
        image: /images/gateway/dashboard/review-gateway-statistics-1-ce.png,
        title: 进入 **实体** > **设备** 页面，点击已创建设备，打开设备详情页。切换到 **「属性」** 标签查看 connector 中配置的属性。
    ===
        image: /images/gateway/dashboard/review-gateway-statistics-2-ce.png,
        title: 要查看设备实时遥测数据，进入「**最新遥测**」标签。此处可见设备发送的遥测数据，如「**humidity**」「**temperature**」等指标。此标签提供设备遥测的实时更新。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkDeviceData %}

## 配置其他 connector

在第一个 connector 安装并配置成功后，可继续配置其他 connector 连接不同设备。更多 connector 说明见以下文章：  
 - [**MQTT** connector](/docs/iot-gateway/config/mqtt/)
 - [**OPC-UA** connector](/docs/iot-gateway/config/opc-ua/)
 - [**Modbus** connector](/docs/iot-gateway/config/modbus/)
 - [**BLE** connector](/docs/iot-gateway/config/ble/)
 - [**Request** connector](/docs/iot-gateway/config/request/)
 - [**REST** connector](/docs/iot-gateway/config/rest/)
 - [**CAN** connector](/docs/iot-gateway/config/can/)
 - [**FTP** connector](/docs/iot-gateway/config/ftp/)
 - [**Socket** connector](/docs/iot-gateway/config/socket/)
 - [**XMPP** connector](/docs/iot-gateway/config/xmpp/)
 - [**BACnet** connector](/docs/iot-gateway/config/bacnet/)
 - [**OCPP** connector](/docs/iot-gateway/config/ocpp/)
 - [**ODBC** connector](/docs/iot-gateway/config/odbc/)
 - [**SNMP** connector](/docs/iot-gateway/config/snmp/)
 - [**Custom** connector](/docs/iot-gateway/custom/)

关于 *ThingsBoard IoT Gateway* 仪表板，可[在此阅读](/docs/iot-gateway/guides/how-to-enable-remote-configuration/)。

## 下一步

查阅 ThingsBoard 主要功能的相关指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据。
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据。
 - [RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送及从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据。
