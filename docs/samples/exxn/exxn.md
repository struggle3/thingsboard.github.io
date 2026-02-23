---
layout: docwithnav
title: EXXN IoT Gateway
description: EXXN IoT Gateway 集成指南

---

* TOC
{:toc}

## 简介

EXXN IoT Gateway 是一款配备 ARM 处理器的多功能设备，可适应多种应用场景，包括环境传感器监测、能耗监测、氡气浓度监测、海洋环境监测以及边缘计算。

本指南概述如何将 EXXN IoT Gateway 与 ThingsBoard 平台集成，以实现设备的远程监测与管理。

<br>
使用 ThingsBoard 开发的示例仪表板，展示 EXXN IoT Gateway 采集的指标。

![image](/images/samples/exxn/ennx-dashboard.png)

## 前置条件

本教程中，我们将配置 EXXN IoT Gateway 通过 MQTT API 集成到 ThingsBoard。为此需要：

 - EXXN IoT Gateway 'Cell 1024'；
 - 设备需可连接，且已通过以太网、调制解调器或 Wi-Fi 接入互联网。

## 技术特性
本指南使用的 EXXN IoT Gateway 'Cell 1024' 技术规格如下：
* ARM Cortex-A53 四核 64 位处理器
* GPU Mali 470
* 2GB DDR4
* 8GB eMMC
* 10/100 Mbit/s 以太网
* Wi-Fi 802.11 b/g/n/AC
* 蓝牙 4.2
* PoE
* 可进行硬件定制开发

<p align="center">
   <img src="/images/samples/exxn/cell_1024.jpg" alt="cell 1024">
</p>

## 为 ThingsBoard 配置设备

包含将设备连接到 ThingsBoard 所需的说明。

### 创建设备

在浏览器中打开平台实例或 ThingsBoard [cloud](https://thingsboard.cloud/) 并以租户管理员身份登录。

进入「**Device groups**」选项卡 ->「**All**」，点击「plus」按钮添加新设备。

输入设备名称，选择现有或新建 [device profile](https://thingsboard.io/docs/user-guide/device-profiles/)，点击「Add」按钮。

![image](/images/samples/exxn/exxn-create-device-cell-1.png)

设备已创建。打开其详情，点击「Copy access token」按钮复制自动生成的 **access token**。

![image](/images/samples/exxn/exxn-create-device-cell-2.png)

### 设备配置

在浏览器中打开 Cell 1024 管理页面：https://[IP_DEVICE]，进入「Cloud」选项卡：
<br>
<br>
  <img src="/images/samples/exxn/conn1.png" alt="conn1">

启用 Cloud 控制并配置所有参数，通过 MQTT 将设备连接到指定的 ThingsBoard 平台：

<img src="/images/samples/exxn/conn2.png" alt="conn2">

配置参数：
- **Cloud Platform**：选择 ThingsBoard。
- **MQTT broker URL**：要集成的服务器 Broker 的 URL。
- **MQTT broker port**：服务器使用的端口号。
- **TLS**：若服务器使用传输层安全协议则选择 true。
- **Connection Type**：选择「Access Token」选项。我们将使用在 ThingsBoard 中预先创建的 Access token。
- **Access Token**：填入在 ThingsBoard 中复制的 Access token。

{% capture domain_owner_note %}
**说明**

当前 EXXN IoT Gateway 使用「Access Token」集成方式。我们正在开发预配置（Pre-Provisioning）集成方式，届时将无需在设备上复制此 Access token。

{% endcapture %}
{% include templates/info-banner.md content=domain_owner_note %}

点击「Save configuration」按钮。

<img src="/images/samples/exxn/conn3.png" alt="conn3">

<br>
要验证设备是否正确连接到 ThingsBoard，进入 **Device groups** 菜单 -> **All** 设备，选择您的设备。在**设备详情**中选择 **client attributes** 选项卡，检查客户属性是否已同步到设备。

若配置正确，应能看到 *serial_number*、*last_rebbot*、*device_model* 等客户属性。

![image](/images/samples/exxn/exxn-client-attributes-device-1.png)

## ThingsBoard 配置

EXXN IoT Gateway 将使用 MQTT API 连接到 ThingsBoard。<br>
此前已介绍如何配置设备连接 ThingsBoard。下面展示在 ThingsBoard 中配置设备以监测数据并管理设备的步骤。

要配置 EXXN IoT Gateway 的数据记录选项，需为设备创建一个键为「config」的 JSON「Shared」属性。

 - 在设备详情的 attributes 选项卡中，添加键为「config」、类型为 **JSON** 的新「**Shared**」属性。

![image](/images/samples/exxn/exxn-shared-attributes-device-1.png)

 - 展开属性内容至全屏以便编写。将设备配置文件内容粘贴到属性值中。

![image](/images/samples/exxn/ennx-config-json.png)

可从[此链接](/docs/samples/exxn/resources/config.json)下载该 JSON 文件示例。

通过该 JSON 文件正确配置设备的所有信息，请参阅 EXXN IoT Gateway 手册。

 - 点击「Add」保存属性。

![image](/images/samples/exxn/exxn-shared-attributes-device-2.png)

### 数据可视化

创建 [dashboard](https://thingsboard.io/docs/pe/user-guide/dashboards/) 以在部件中可视化遥测数据。

 - 进入 **Dashboard groups** 选项卡 -> **All**。点击仪表板页面右上角的「plus」按钮创建新仪表板。输入仪表板名称，点击「Add」按钮。

![image](/images/samples/exxn/exxn-create-dashboard-1.png)

 - 在 **Analohue gauges** 部件包中创建 **Radial gauge** 部件。更多关于部件及其创建方法，请参阅[此指南](https://thingsboard.io/docs/pe/user-guide/dashboards/#widgets)。

设备 JSON 配置文件中已启用的测量项，均会以文件中指定的名称作为指标。

![image](/images/samples/exxn/exxn-create-dashboard-2.png)

<br>
![image](/images/samples/exxn/exxn-create-dashboard-3.png)

### RPC 命令

可以向设备发送命令执行特定任务。方法参数须为 JSON 格式。

![image](/images/samples/exxn/exxn-rpc-button.png)

可发送给设备的所有命令请参阅 EXXN IoT Gateway 手册。

## 更多信息

### 故障排除
 - 集成过程中最常见的问题是无法与 MQTT Broker 建立连接。请确保设备已接入互联网且能通信到 ThingsBoard Broker。
 - 另一常见问题是 Access Token 配置错误。请检查设备上配置的 Access token 是否与 ThingsBoard 中为该设备提供的一致。

<br>

### 反馈与集成支持

更多信息请访问 [EXXN Engineering](http://exxn.es/en/)。
<br>
如有问题或疑问，请随时联系：[troubleshooting@exxn.es](mailto://troubleshooting@exxn.es)

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
