---
layout: docwithnav
title: 漏水检测器 LoRaWAN "Smartico L2-LR" 遥测上传
description: ThingsBoard IoT 平台示例：使用漏水检测器 LoRaWAN "Smartico L2-LR" 通过 MQTT 上传漏水数据
hidetoc: "true"
---

* TOC
{:toc}

## 简介

漏水检测器 LoRaWAN "Smartico L2-LR" 用于工业、公用事业和自动化领域的远程数据采集、漏水检测及通过 LoRaWAN 网络的数据传输。设备采用双区域被动漏水传感器控制，提供高能效方案。传感器的防水外壳设计适用于户外使用。下图展示了处理后的遥测结果仪表板。

![image](/images/samples/smartico/leaks-detector-lorawan/mainDash.PNG)

## 前提条件

使用 LoRaWAN 技术将 Leaks Detector L2-LR 的数据传输至 ThingsBoard 平台。LoRaWAN 为可在远距离交换少量数据的无线通信技术。首先需要配置 LoRaWAN 服务器并确保设备数据可到达服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。完成服务器配置后，Applications 页面的表中应出现设备类型的条目。

![image](/images/samples/smartico/leaks-detector-lorawan/Lora1.PNG)

例如，我们连接了序列号为 13123 的设备。在 LoRaWAN 服务器配置正确的情况下，应在"DEVICE DATA"页面看到来自设备的数据流。设备的数据传输频率取决于 Leaks Detector 设置。

![image](/images/samples/smartico/leaks-detector-lorawan/Lora2.PNG)

要能通过 MQTT 协议接收数据，需要集成 [LoRaWAN 服务器与 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。

## 步骤 1：创建上行数据转换器

首先，应根据设备协议创建上行数据转换器。该转换器将把漏水检测器 LoRaWAN "Smartico L2-LR" 的 Base64 编码遥测 payload 解码为可读的 ThingsBoard 简化数据格式。导入带上行数据转换器的 [uplink_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/uplink_leaks_detector.json) 文件。

![image](/images/samples/smartico/leaks-detector-lorawan/uplink.PNG)

## 步骤 2：集成配置

要将漏水检测器 LoRaWAN "Smartico L2-LR" 集成到 ThingsBoard 平台，需如图创建新集成。

![image](/images/samples/smartico/leaks-detector-lorawan/Integration.PNG)

此外，应根据 LoRaWAN 服务器配置添加主题过滤器（本示例为 ```application/7/device/+/rx```）。在 Host 和 Port 字段中输入 MQTT 代理的 IP 地址及其端口。

## 步骤 3：验证设备数据接收

连接 Leaks Detector L2-LR 以传输信息。若集成无误，在首次遥测传输后，DEVICE GROUPS → All 中会出现名为"13123"的新设备。您还可分别在 DATA CONVERTERS → Uplink Leaks Detector → EVENTS 中验证转换前后的输入和输出数据。

![image](/images/samples/smartico/leaks-detector-lorawan/verifying.PNG)

来自 Leaks Detector 的输入数据示例如下：
```json
{
    "applicationID": "7",
    "applicationName": "Smartico_leak_sensor",
    "deviceName": "13123",
    "devEUI": "02aaaa0100003343",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "4e9ed6ae-b658-4e11-b686-1ecae882c807",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -68,
        "loRaSNR": 4.8,
        "location": {
            "latitude": 48.44229794818326,
            "longitude": 35.014479160308845,
            "altitude": 144
        }
    }],
    "txInfo": {
        "frequency": 868500000,
        "dr": 0
    },
    "adr": true,
    "fCnt": 2220,
    "fPort": 7,
    "data": "YgAtAAAAAAAAAAA="
}
```
payload 位于"data"字段中，以 Base64 编码。解码后输出数据如下：
```json
{
    "deviceName": "13123",
    "deviceType": "Leak Sensor",
    "attributes": {
        "integrationName": "Leaks Detector"
    },
    "telemetry": {
        "NAME_DEV": "Leaks Detector LoRaWAN 'Smartico L2-LR'",
        "SN": "13123",
        "REAL_TIME": "27.08.2020 10:46:25",
        "FRAUD_1": "Not discovered",
        "FRAUD_2": "Not discovered",
        "FRAUD_1D": 1,
        "FRAUD_2D": 1,
        "FLG_ERR_PULSE_1": 0,
        "FLG_ERR_PULSE_2": 0,
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 1,
        "FLG_MAGNET_DETECT": 0,
        "FLG_TAMPER_DETECT": 0,
        "FLG_POWER_ON": 0,
        "FLG_POWER_BAT": 1,
        "FLG_ERR_TIME": 1,
        "FLG_CFG_DONE": 0
    }
}
```
以上输入和输出数据仅为示例，与指南开头的仪表板无关。在开启设备前，可通过 [uplink_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/uplink_leaks_detector.json) 验证编程代码。为此，在 DATA CONVERTERS 中打开 Uplink Leaks Detector 的 Test decoder function，将本指南的输入数据复制到 **Payload content** 字段，点击 **TEST** 按钮，**Output** 字段将显示解码后的输出数据（REAL_TIME 字段显示当前日期时间）。

![image](/images/samples/smartico/leaks-detector-lorawan/verifying2.PNG)

## 步骤 4：创建 Leaks Detector 资产

要在仪表板中显示数据，需先创建资产并在 RELATIONS 中添加设备 13123，如图所示。

![image](/images/samples/smartico/leaks-detector-lorawan/addAsset.PNG)

![image](/images/samples/smartico/leaks-detector-lorawan/addRelation.PNG)

## 步骤 5：规则链导入与配置

除表计读数外，还可监控设备状态（如低电量、设备外壳打开、磁场干扰等）。这些信息在告警部件中显示。因此，需先配置规则链。导入带告警的 [alarms_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/alarms_leaks_detector.json) 文件并在 ThingsBoard 中保存规则链配置。

![image](/images/samples/smartico/leaks-detector-lorawan/alarm1.PNG)

然后配置 Root Rule chain。应在 Root Rule chain 中添加 Alarms Leaks Detector，如图所示。

![image](/images/samples/smartico/leaks-detector-lorawan/alarm2.PNG)

## 步骤 6：仪表板导入与配置

要为用户显示数据，需创建仪表板，可从 [dashboard_leaks_detector.json](/docs/samples/smartico/leaks-detector-lorawan/resources/dashboard_leaks_detector.json) 文件导入。

![image](/images/samples/smartico/leaks-detector-lorawan/dashboard.PNG)

导入仪表板时，需如图所示创建别名。

![image](/images/samples/smartico/leaks-detector-lorawan/alias.PNG)

若一切配置正确，在 DASHBOARD GROUPS → All 中可看到指南开头提供的新仪表板 **Leaks Detector LoRaWAN Smartico "L2-LR"**。

## Next steps

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}

## 另见

浏览其他[示例](/docs/samples)或探索 ThingsBoard 主要功能相关指南：

 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据

{% include templates/feedback.md %}

{% include socials.html %}

## Next steps

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
