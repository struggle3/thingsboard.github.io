---
layout: docwithnav
title: 燃气关断阀 LoRaWAN "Smartico V-LR" 遥测上传
description: ThingsBoard IoT 平台示例：使用燃气关断阀 LoRaWAN "Smartico V-LR" 通过 MQTT 上传阀门状态数据
hidetoc: "true"
---

* TOC
{:toc}

## 简介

燃气关断阀 LoRaWAN "Smartico V-LR" 用于在低压燃气网络中远程关断燃气供应。阀门采用自主供电，具有可安全恢复供气的阀门激活机制。设有保护密封安装位，防止未授权接触电源并避免阀门从燃气管道上拆卸。下图展示了处理后的遥测结果仪表板。

![image](/images/samples/smartico/gas-valve-lorawan/MainDash.png)

## 前提条件

使用 LoRaWAN 技术将 Gas Valve V-LR 的数据传输至 ThingsBoard 平台。LoRaWAN 为可在远距离交换少量数据的无线通信技术。首先需要配置 LoRaWAN 服务器并确保设备数据可到达服务器。本指南使用 [ChirpStack 开源 LoRaWAN 网络服务器](https://www.chirpstack.io/application-server/)。完成服务器配置后，Applications 页面的表中应出现设备类型的条目。

![image](/images/samples/smartico/gas-valve-lorawan/Lora1.PNG)

例如，我们连接了序列号为 0000129 的设备。在 LoRaWAN 服务器配置正确的情况下，应在"DEVICE DATA"页面看到来自设备的数据流。设备的数据传输频率取决于 Gas Valve 设置。

![image](/images/samples/smartico/gas-valve-lorawan/Lora2.PNG)

要能通过 MQTT 协议接收数据，需要集成 [LoRaWAN 服务器与 Mosquitto MQTT 代理](https://www.chirpstack.io/application-server/integrations/mqtt/)。

## 步骤 1：创建上行数据转换器

首先，应根据设备协议创建上行数据转换器。该转换器将把燃气关断阀 LoRaWAN "Smartico V-LR" 的 Base64 编码遥测 payload 解码为可读的 ThingsBoard 简化数据格式。导入带上行数据转换器的 [uplink_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/uplink_gas_valve.json) 文件。

![image](/images/samples/smartico/gas-valve-lorawan/converter.PNG)

## 步骤 2：集成配置

要将燃气关断阀 LoRaWAN "Smartico V-LR" 集成到 ThingsBoard 平台，需如图创建新集成。

![image](/images/samples/smartico/gas-valve-lorawan/integration.PNG)

此外，应根据 LoRaWAN 服务器配置添加主题过滤器（本示例为 ```application/6/device/+/rx```）。在 Host 和 Port 字段中输入 MQTT 代理的 IP 地址及其端口。

## 步骤 3：验证设备数据接收

连接 Gas Valve V-LR 以传输信息。若集成无误，在首次遥测传输后，DEVICE GROUPS → All 中会出现名为"0000129"的新设备。您还可分别在 DATA CONVERTERS → Uplink Gas Valve → EVENTS 中验证转换前后的输入和输出数据。

![image](/images/samples/smartico/gas-valve-lorawan/Verifying.PNG)

来自 Gas Valve 的输入数据示例如下：
```json
{
    "applicationID": "6",
    "applicationName": "Smartico_gaz_valves",
    "deviceName": "VALVE_0000129",
    "devEUI": "02aaaa0100000081",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "bebb9711-3fe0-4ddd-ad16-9815af9c0f42",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -72,
        "loRaSNR": 9.8,
        "location": {
            "latitude": 48.44229794818326,
            "longitude": 35.014479160308845,
            "altitude": 144
        }
    }],
    "txInfo": {
        "frequency": 868100000,
        "dr": 0
    },
    "adr": true,
    "fCnt": 12,
    "fPort": 2,
    "data": "BkABAACB"
}
```
payload 位于"data"字段中，以 Base64 编码。解码后输出数据如下：
```json
{
    "deviceName": "0000129",
    "deviceType": "Gas Valve",
    "attributes": {
        "integrationName": "Gas Valve"
    },
    "telemetry": {
        "NAME_DEV": "Gas Shutoff Valve LoRaWAN 'Smartico V-LR'",
        "REAL_TIME": "26.08.2020 10:25:20",
        "SERIAL": "0000129",
        "VALVE_MODEL": "Gas",
        "STS_VALVE": "Close",
        "STS_VALVE_CODE": 1,
        "FLG_LOW_BAT": 0,
        "FLG_MOTION_DETECT": 0,
        "FLG_MAGNET_DETECT": 0,
        "FLG_TAMPER_DETECT": 0,
        "FLG_POWER_ON": 0,
        "FLG_POWER_BAT": 0,
        "FLG_ERR_TIME": 1,
        "FLG_CFG_DONE": 0
    }
}
```
以上输入和输出数据仅为示例，与指南开头的仪表板无关。在开启设备前，可通过 [uplink_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/uplink_gas_valve.json) 验证编程代码。为此，在 DATA CONVERTERS 中打开 Uplink Gas Valve 的 **Test decoder function**，将本指南的输入数据复制到 **Payload content** 字段，点击 **TEST** 按钮，**Output** 字段将显示解码后的输出数据（REAL_TIME 字段显示当前日期时间）。

![image](/images/samples/smartico/gas-valve-lorawan/VerifyingUplink.PNG)

## 步骤 4：创建 Gas Valve 资产

要在仪表板中显示数据，需先创建资产并在 RELATIONS 中添加设备 0000129，如图所示。

![image](/images/samples/smartico/gas-valve-lorawan/asset.PNG)

![image](/images/samples/smartico/gas-valve-lorawan/asset2.PNG)

## 步骤 5：规则链导入与配置

除表计读数外，还可监控设备状态（如低电量、设备外壳打开、磁场干扰等）。这些信息在告警部件中显示。因此，需先配置规则链。导入带告警的 [alarms_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/alarms_gas_valve.json) 文件并在 ThingsBoard 中保存规则链配置。

![image](/images/samples/smartico/gas-valve-lorawan/alarm1.PNG)

然后配置 Root Rule chain。应在 Root Rule chain 中添加 Alarms Gas Valve，如图所示。

![image](/images/samples/smartico/gas-valve-lorawan/alarm2.PNG)

## 步骤 6：仪表板导入与配置

要为用户显示数据，需创建仪表板，可从 [dashboard_gas_valve.json](/docs/samples/smartico/gas-valve-lorawan/resources/dashboard_gas_valve.json) 文件导入。

![image](/images/samples/smartico/gas-valve-lorawan/dashboard1.PNG)

导入仪表板时，需如图所示创建别名。

![image](/images/samples/smartico/gas-valve-lorawan/dashboard2.PNG)

若一切配置正确，在 DASHBOARD GROUPS → All 中可看到指南开头提供的新仪表板 **Gas Shutoff Valve LoRaWAN "Smartico V-LR"**。

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
