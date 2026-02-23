---
layout: docwithnav
title: 三相智能电表「Smartico E307」遥测上传
description: 使用智能电表「Smartico E307」通过 MQTT 上传电表数据的 ThingsBoardIoT平台示例。
hidetoc: "true"
---

* TOC
{:toc}

## 简介
三相智能电表 「Smartico E307」针对智能计量系统优化，有多种外形和规格。Smartico E307 为真正的智能电表，可将数据存储在非易失性存储器中，并测量消耗和输送到电网的有功/无功电能。主要功能是精确测量回路电网参数，包括电压、电流、功率、频率等。Dashboard 包含两种状态——计数器读数和质量参数。下图展示了经遥测处理后的 dashboard 状态。

Dashboard 的计数器读数状态。

![image](/images/samples/smartico/elec-meter-lorawan/MainDash1.PNG)

Dashboard 的质量参数状态。

![image](/images/samples/smartico/elec-meter-lorawan/MainDash2.PNG)

## 前置条件
LoRaWAN technology is used to transfer data from the Electricity Meters "Smartico E307" to the ThingsBoard platform. This is the wireless communication technology that allows small amounts of data to be exchanged over a long distance. First of all, you need to configure the LoRaWAN server and make sure that data from the device goes to the server.  This guide uses [ChirpStack open-source LoRaWAN Network Server](https://www.chirpstack.io/application-server/){:target="_blank"}. 
After finishing the server configuration on the Applications page, an entry with the device type should appear in the table.

![image](/images/samples/smartico/elec-meter-lorawan/Lora1.PNG)

例如，我们连接了序列号为 0012778 的设备。在 LoRaWAN 服务器正确配置下，应能看到设备的数据流。设备的数据传输频率取决于电表设置。

![image](/images/samples/smartico/elec-meter-lorawan/Lora2.PNG)

要通过 MQTT 协议接收数据，需集成 [LoRaWAN 服务器与 Mosquitto MQTT broker](https://www.chirpstack.io/application-server/integrations/mqtt/){:target="_blank"}。

## 步骤 1. 创建 Uplink Data Converters

首先，根据设备协议创建 Uplink Data Converter。该 converter 会将电表「Smartico E307」的 encoded Base64 遥测 payload 解码为可读、简化的 ThingsBoard 数据格式。导入 [uplink_elec_meter.json](/docs/samples/smartico/elec-meter-lorawan/resources/uplink_elec_meter.json){:target="_blank"} 文件作为 Uplink data converter。

![image](/images/samples/smartico/elec-meter-lorawan/uplink.PNG)

## 步骤 2. Integration 配置

要将电表「Smartico E307」集成到 ThingsBoard 平台，请按图中所示创建新 integration。

![image](/images/samples/smartico/elec-meter-lorawan/Integration.PNG)

此外，需根据 LoRaWAN 服务器配置添加 topic filter（本示例为 ``` application/2/device/+/rx ``` ）。在 Host 和 Port 字段中填入 MQTT broker 所在的 IP 地址及其端口。

## 步骤 3. 验证设备数据接收

连接电表并传输数据。若 integration 无误，在首次遥测上报后，实体区域「Devices」页面会出现名为「0012778」的新设备。也可在「Integrations center」→「Data converters」→ Uplink Elec meter →「Events」标签页中验证转换前后的 input 与 output 数据。

![image](/images/samples/smartico/elec-meter-lorawan/verifying.PNG)

Input data from Electricity Meters looks like this:
```json
{
    "applicationID": "2",
    "applicationName": "Smartico_electric_meters",
    "deviceName": "0012778",
    "devEUI": "02aaaa02000031ea",
    "rxInfo": [{
        "gatewayID": "647fdafffe00d228",
        "uplinkID": "9d29d67f-8db2-4c7e-9fa8-b7f9bd5be9e6",
        "name": "tectelic_micro_lite_TECH",
        "rssi": -80,
        "loRaSNR": 5.2,
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
    "fCnt": 2202,
    "fPort": 15,
    "data": "QF8gJWwgSK4giMogyIYhQHEhgcshwTwiw1BBwABNNw=="
}
```

The payload is contained in the “data” field and encrypted in Base64. 解码后的 output 数据如下所示：

```json
{
    "deviceName": "0012778",
    "deviceType": "elecMeter",
    "attributes": {
        "integrationName": "Elec Meter"
    },
    "telemetry": {
        "REAL_TIME": "27.08.2020 09:51:49",
        "SN": "0012778",
        "deviceTypeTelemetry": "Smartico E307",
        "NAME_DEV": "Electricity Meter 'Smartico E307'",
        "VOLTAGE_A": 222.2,
        "VOLTAGE_B": 225,
        "VOLTAGE_C": 218.2,
        "CURRENT_A": 1.13,
        "CURRENT_B": 4.59,
        "CURRENT_C": 3.16,
        "FREQUENCY": 50,
        "POWER_FULL_SUMMARY": 197.67,
        "POWER_FULL_A": null,
        "POWER_FULL_B": null,
        "POWER_FULL_C": null,
        "POWER_ACTIVE_SUMMARY": null,
        "POWER_ACTIVE_A": null,
        "POWER_ACTIVE_B": null,
        "POWER_ACTIVE_C": null,
        "POWER_REACTIVE_SUMMARY": null,
        "POWER_REACTIVE_A": null,
        "POWER_REACTIVE_B": null,
        "POWER_REACTIVE_C": null,
        "VALUE": null,
        "ENERGY_ACTIVE_SUMMARY": null,
        "ENERGY_ACTIVE_T1": null,
        "ENERGY_ACTIVE_T2": null,
        "ENERGY_ACTIVE_T3": null,
        "ENERGY_ACTIVE_T4": null,
        "ENERGY_ACTIVE_T5": null,
        "ENERGY_ACTIVE_T6": null,
        "ENERGY_ACTIVE_T7": null,
        "ENERGY_ACTIVE_T8": null,
        "ENERGY_REACTIVE_SUMMARY": null,
        "ENERGY_REACTIVE_T1": null,
        "ENERGY_REACTIVE_T2": null,
        "ENERGY_REACTIVE_T3": null,
        "ENERGY_REACTIVE_T4": null,
        "ENERGY_REACTIVE_T5": null,
        "ENERGY_REACTIVE_T6": null,
        "ENERGY_REACTIVE_T7": null,
        "ENERGY_REACTIVE_T8": null
    }
}
```
Input 与 output 数据仅供示例，与指南开头的 dashboard 无关。 
在启用设备前，可通过 [uplink_elec_meter.json](/docs/samples/smartico/elec-meter-lorawan/resources/uplink_elec_meter.json){:target="_blank"} 文件中的编程代码验证功能。为此，在 DATA CONVERTERS 中打开 Uplink Elec meter 的 **Test decoder function**，将本指南中的 input 数据复制到 **Payload content** 字段，点击 **TEST** 按钮，**Output** 字段中应出现如图所示的解码 output 数据（REAL_TIME 字段显示当前日期和时间）。

![image](/images/samples/smartico/elec-meter-lorawan/verifyingUplink.PNG)

## 步骤 4. 创建电表 Asset

要在 dashboard 中显示数据，需先创建 asset，并在 RELATIONS 中添加设备 0012778，如下图所示。

![image](/images/samples/smartico/elec-meter-lorawan/asset1.PNG)

![image](/images/samples/smartico/elec-meter-lorawan/asset2.PNG)

## 步骤 5. Dashboard 导入与配置

要向用户展示数据，需创建 dashboard，可从 [dashboard_elec_meter.json](/docs/samples/smartico/elec-meter-lorawan/resources/dashboard_elec_meter.json){:target="_blank"} 文件导入。 

![image](/images/samples/smartico/elec-meter-lorawan/dash1.PNG)

导入 dashboard 时，需如图创建 alias。

![image](/images/samples/smartico/elec-meter-lorawan/dash2.PNG)

若一切正确，在「Dashboards」页面将看到本指南开头的 **三相智能电表「Smartico E307」** dashboard。

## 另请参阅

浏览其他 [samples](/docs/samples){:target="_blank"} 或查看 ThingsBoard 主要功能相关指南：

 - [Device attributes](/docs/user-guide/attributes/) - 如何使用 device attributes。
 - [Telemetry data collection](/docs/user-guide/telemetry/) - 如何采集 telemetry 数据。
 - [Using RPC capabilities](/docs/user-guide/rpc/) - 如何向/从设备发送命令。
 - [Rule Engine](/docs/user-guide/rule-engine/) - 如何使用 rule engine 分析设备数据。
 - [Data Visualization](/docs/user-guide/visualization/) - 如何可视化采集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## Next steps

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}