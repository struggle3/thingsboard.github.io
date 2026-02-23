---
layout: docwithnav
title: 超声波住宅智能燃气表 LoRaWAN "Smartico G-1.6" 遥测上传
description: ThingsBoard IoT 平台示例：使用智能燃气表 LoRaWAN "Smartico G-1.6" 通过 MQTT 上传燃气数据
hidetoc: "true"
---

* TOC
{:toc}

## 简介

住宅燃气表"Smartico"按规格 G-1.6、G-2.5、G-4、G-6 生产，用于测量天然气和液化气的使用量，并在 20°C 下转换至标准参考。该表采用紧凑设计，无移动机械部件，可在狭小空间安装。测量系统具有高精度计量特性。表支持可视控制和采用 LoRaWAN 技术的免许可频段无线数据传输。下图展示了处理后的遥测结果仪表板。

![image](/images/samples/smartico/gas-meter-lorawan/MainDashboard.png)

## 前提条件

使用 LoRaWAN 技术将 Gas Meter G-1.6 的数据传输至 ThingsBoard 平台。 LoRaWAN 为可在远距离交换少量数据的无线通信技术。首先需要配置 LoRaWAN 服务器并确保设备数据可到达服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。完成服务器配置后，Applications 页面的表中应出现设备类型的条目。

![image](/images/samples/smartico/gas-meter-lorawan/lora1.PNG)

例如，我们连接了序列号为 12676 的设备。在 LoRaWAN 服务器配置正确的情况下，应能看到来自设备的数据流。设备的数据传输频率取决于 Gas Meter 设置。

![image](/images/samples/smartico/gas-meter-lorawan/Lora2.PNG)

要能通过 MQTT 协议接收数据，需要集成 [LoRaWAN 服务器与 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。

## 步骤 1：创建上行数据转换器

首先，应根据设备协议创建上行数据转换器。该转换器将把超声波住宅智能燃气表 LoRaWAN "Smartico G-1.6" 的 Base64 编码遥测 payload 解码为可读的 ThingsBoard 简化数据格式。导入带上行数据转换器的 [uplink_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/uplink_gas_meter.json) 文件。

![image](/images/samples/smartico/gas-meter-lorawan/convert.PNG)

## 步骤 2：集成配置

要将超声波住宅智能燃气表 LoRaWAN "Smartico G-1.6" 集成到 ThingsBoard 平台，需如图创建新集成。

![image](/images/samples/smartico/gas-meter-lorawan/integration.PNG)

此外，应根据 LoRaWAN 服务器配置添加主题过滤器（本示例为 ```application/1/device/+/rx```）。在 Host 和 Port 字段中输入 MQTT 代理的 IP 地址及其端口。

## 步骤 3：验证设备数据接收

连接 Gas Meter 以传输信息。若集成无误，在首次遥测传输后，DEVICE GROUPS → All 中会出现名为"012676"的新设备。您还可分别在 DATA CONVERTERS → Uplink Gas Meter → EVENTS 中验证转换前后的输入和输出数据。

![image](/images/samples/smartico/gas-meter-lorawan/verify.PNG)

来自 Gas Meter 的输入数据示例如下：
```json
{
    "applicationID": "1",
    "applicationName": "Smartico_gas_meters",
    "deviceName": "12676",
    "devEUI": "02aaaa0200003184",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "bd949c88-fd1e-4c97-bbef-ad6412139d89",
        "name": "Kona_micro_lite",
        "rssi": -65,
        "loRaSNR": 6,
        "location": {
            "latitude": 48.44229794818326,
            "longitude": 35.014479160308845,
            "altitude": 144
        }
    }],
    "txInfo": {
        "frequency": 868300000,
        "dr": 0
    },
    "adr": true,
    "fCnt": 742,
    "fPort": 2,
    "data": "BAwMAQAxhAAAA1YK4w=="
}
```
payload 位于"data"字段中，以 Base64 编码。解码后输出数据如下：
```json
{
    "deviceName": "12676",
    "deviceType": "Gas Meter",
    "attributes": {
        "integrationName": "Gas Meter"
    },
    "telemetry": {
        "gasMeter": 0.854,
        "temperature": 27.87,
 	"REAL_TIME": "26.08.2020 15:02:39",
        "SN": "12676",
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 0,
        "FLG_MAGNET_DETECT": 1,
        "FLG_TAMPER_DETECT": 1,
        "STS_VALVE": 0,
        "FLG_ERR_OVR": 0,
        "FLG_ERR_REVERSE": 0,
        "FLG_ERR_SENSOR": 0,
        "FLG_ERR_GAS": 1,
        "FLG_ERR_TIME": 1,
        "FLG_POWER_ON": 0,
        "FLG_LOCK": 0,
        "FLG_CFG_DONE": 0
    }
}
```
以上输入和输出数据仅为示例，与指南开头的仪表板无关。在开启设备前，可通过 [uplink_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/uplink_gas_meter.json) 验证编程代码。为此，在 DATA CONVERTERS 中打开 Uplink Gas Meter 的 **Test decoder function**，将本指南的输入数据复制到 **Payload content** 字段，点击 **TEST** 按钮，**Output** 字段将显示解码后的输出数据（REAL_TIME 字段显示当前日期时间）。

![image](/images/samples/smartico/gas-meter-lorawan/verify1.PNG)

## 步骤 4：创建 Gas Meter 资产

要在仪表板中显示数据，需先创建资产并在 RELATIONS 中添加设备 012676，如图所示。

![image](/images/samples/smartico/gas-meter-lorawan/asset1.PNG)

![image](/images/samples/smartico/gas-meter-lorawan/asset2.PNG)

## 步骤 5：规则链导入与配置

除表计读数外，还可监控设备状态（如低电量、设备外壳打开、磁场干扰等）。这些信息在告警部件中显示。因此，需先配置规则链。导入带告警的 [alarms_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/alarms_gas_meter.json) 文件并在 ThingsBoard 中保存规则链配置。

![image](/images/samples/smartico/gas-meter-lorawan/alarm1.PNG)

然后配置 Root Rule chain。应在 Root Rule chain 中添加 Alarms Gas Meter，如图所示。

![image](/images/samples/smartico/gas-meter-lorawan/alarm2.PNG)

## 步骤 6：仪表板导入与配置

要为用户显示数据，需创建仪表板，可从 [dashboard_gas_meter.json](/docs/samples/smartico/gas-meter-lorawan/resources/dashboard_gas_meter.json) 文件导入。

![image](/images/samples/smartico/gas-meter-lorawan/dashboard1.PNG)

导入仪表板时，需如图所示创建别名。

![image](/images/samples/smartico/gas-meter-lorawan/dashboard2.PNG)

若一切配置正确，在 DASHBOARD GROUPS → All 中可看到指南开头提供的新仪表板 **Ultrasonic Residential Smart Gas Meter LoRaWAN "Smartico G-1.6"**。

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
