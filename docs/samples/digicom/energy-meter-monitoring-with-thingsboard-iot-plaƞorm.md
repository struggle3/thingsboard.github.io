---
layout: docwithnav
assignees:
- stitenko
title: 使用 ThingsBoardIoT平台监测电能表
description: 使用 ThingsBoardIoT平台监测电能表
hidetoc: "true"

---

* TOC
{:toc}

![image](/images/samples/digicom/head1.png)

Digicom 设备旨在与 ThingsBoardIoT平台互操作，提供必要设置与功能以便轻松集成，让您能够创建用于展示和监测数据与遥测的仪表板。

本教程作为集成指南，侧重搭建专业监测应用，涵盖 Digicom 设备的基本要点及通过 MQTT 协议集成对应的 ThingsBoard 配置。

![image](/images/samples/digicom/scenario1.png)

所述场景包括：Digicom 设备连接到 MQTT broker，ThingsBoard 通过 MQTT 集成订阅这些数据流，并通过特定数据转换器将有效载荷转换为 ThingsBoard 消息格式。

开始前：要使本教程生效，需准备：
- Digicom 设备，如 DRN500 或 DRN3000 多功能路由器，固件 1.10 或更高
- 云端或本地部署的 ThingsBoard 实例，且具有可公开访问的地址

## ThingsBoard 设置

首先激活 ThingsBoard 账户（云端或本地）。可在「更多参考资料与指南」章节找到安装与设置个人 ThingsBoard 实例的详细说明。

登录并完成配置准备。

## 创建 MQTT 集成

我们先定义数据入口部分。[MQTT 集成](/docs/{{docsPrefix}}user-guide/integrations/mqtt/){:target="_blank"}用于连接外部 MQTT broker、订阅其数据流，并将设备任意类型的有效载荷转换为 ThingsBoard 消息格式。典型用途是当设备已连接到外部 MQTT broker 或其它具备 MQTT 后端的IoT平台、连接提供商时使用。

进入「**Integrations center**」->「**Integrations**」页面，点击「**plus**」按钮创建新集成。选择类型「**MQTT**」，点击「**Next**」；

![image](/images/samples/digicom/integ-mqtt-1.png)

<br>
下一步为 [Uplink data converter](/docs/{{docsPrefix}}user-guide/integrations/#uplink-data-converter){:target="_blank"} 命名，选择「**TBEL**」，清空 Decoder 函数的全部内容。

{% capture difference %}
**说明：** [ThingsBoard Expression Language (TBEL)](/docs/{{docsPrefix}}user-guide/tbel/){:target="_blank"} 是 UDF 原始编程语言 JavaScript 的优化且高效的替代方案。推荐使用 TBEL，JavaScript 仍将继续支持。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

将以下 TBEL 代码粘贴到 Decoder 函数中，然后点击「**Next**」。

```js
// *** Digicom Data Converter ***

var variableNamesMap = {
  "Volts": "voltage",
  "Ampere": "current",
  "Frequency": "hertz",
  "kVA": "power"
};

var payload = decodeToJson(payload);
if (payload.modbus == null) {
  return;}
  
var telemetry = [];
var telemetries = payload.modbus.data[0].samples;
foreach(sample: telemetries) {
  var values = {};
  var varName = variableNamesMap[sample.reg];
  if (varName != null) {
    values[varName] = sample.value;
    telemetry.push({
      ts: Long.parseLong(sample
        .timestamp) * 1000,
      values: values
    });
  }}

var result = {
  deviceName: payload.serialnum,
  deviceType: payload.type,
  attributes: {
    model: payload.model,
    integrationName: metadata['integrationName'],
  },
  telemetry: telemetry};
        
/** Helper functions 'decodeToString' and 'decodeToJson' are already built-in **/

return result;
```
{:.copy-code.expandable-10}

![image](/images/samples/digicom/integ-mqtt-2.png)

<br>
在 [Downlink data converter](/docs/{{docsPrefix}}user-guide/integrations/#downlink-data-converter){:target="_blank"} 选项卡中点击「**Skip**」。

![image](/images/samples/digicom/integ-mqtt-3.png)

<br>
填写「**Connection**」选项卡：

- 设置外部 MQTT broker 的「**Host**」地址和「**Port**」；
- **Credentials type** 选择「**Basic**」，填写「**Username**」和「**Password**」（用于在外部 MQTT broker 上鉴权）；
- 设置以下 **Topic**：

```
digicom/+/data/modbus
```
{: .copy-code}

- 选择 **QoS 1**；

若要预先测试，可点击「**Check connection**」。

![image](/images/samples/digicom/integ-mqtt-4.png)

<br>
点击「**Add**」完成集成设置。

![image](/images/samples/digicom/integ-mqtt-5.png)

<br>
若连接成功，MQTT 集成状态将显示「**Active**」。否则将保持「Inactive」，直到首次与外部 broker 建立连接。  
若连接失败，请随后仔细核对地址、端口与凭证。

![image](/images/samples/digicom/integ-mqtt-6.png)

## 检查并测试数据转换器

[Data converter](/docs/{{docsPrefix}}user-guide/integrations/#data-converters){:target="_blank"} 负责将设备传入的数据结构转换为适合 ThingsBoard 的遥测与属性数据格式。  
在此处，我们可在收到设备真实数据之前模拟并测试转换过程。

进入「**Integration center**」的「**Data converters**」页面。点击「**Modbus Data**」转换器，进入编辑模式。

![image](/images/samples/digicom/test-data-converter-1.png)

<br>
进入编辑模式后，「**Test decoder function**」按钮将可用。点击进入测试环境。

![image](/images/samples/digicom/test-data-converter-2.png)

<br>
将下表 JSON 报文代码复制到「**Payload content**」选项卡，点击「**Test**」按钮，查看「**Output**」选项卡。

```json
{
    "timestamp": "1741688471",
    "serialnum": "50012345",
    "type": "Router500",
    "model": "8D5913",
    "method": "event",
    "msg_cnt": "1494",
    "done": "true",
    "modbus": {
        "data": [{
            "device": "Energy_Meter",
            "event": "read",
            "samples": [{
                "timestamp": "1741869373",
                "reg": "Volts",
                "unit": "V",
                "value": "228.800000",
                "deferred": "false"
            }, {
                "timestamp": "1741869374",
                "reg": "Ampere",
                "unit": "A",
                "value": "0.868000",
                "deferred": "false"
            }, {
                "timestamp": "17418693735",
                "reg": "Frequency",
                "unit": "Hz",
                "value": "50",
                "deferred": "false"
            }, {
                "timestamp": "1741869376",
                "reg": "kVA",
                "unit": "kVA",
                "value": "1.491000",
                "deferred": "false"
            }]
        }]
    }
}
```
{:.copy-code.expandable-10}


![image](/images/samples/digicom/test-data-converter-3.png)

<br>
若此前配置正确，将看到转换结果：

```json
{
  "deviceName": "50012345",
  "deviceType": "Router500",
  "attributes": {
    "model": "8D5913",
    "integrationName": "MQTT integration"
  },
  "telemetry": [{
    "ts": 1741869373000,
    "values": {
      "voltage": "228.800000"
    }
  }, {
    "ts": 1741869374000,
    "values": {
      "current": "0.868000"
    }
  }, {
    "ts": 17418693735000,
    "values": {
      "hertz": "50"
    }
  }, {
    "ts": 1741869376000,
    "values": {
      "power": "1.491000"
    }
  }]
}
```

数据入口阶段已完成且正常工作。点击「**Cancel**」，再点击「**X**」图标退出编辑模式。  
接下来进行设备设置。

## 设备设置

登录设备。输入 **Username** 和 **Password**，点击「**Login**」按钮。

![image](/images/samples/digicom/log1.png)

<br>
本指南将使用 Modbus 功能从电能表读取数据，并通过 MQTT 协议将数据发送到 ThingsBoard。
我们主要说明 Modbus 与 MQTT 配置，假定设备已正确配置互联网访问，且 Modbus 物理连接已正确完成。  
从下拉菜单选择「**Modbus**」–「**COM Configuration**」。

![image](/images/samples/digicom/modbus_serial1.png)

<br>
将 Modbus 串口 **enabled** 设为启用，根据电能表运行参数设置 **type**、**speed** 和 **data format**。  
点击「**Save**」按钮。

![image](/images/samples/digicom/Immagine-11.png)

<br>
从下拉菜单进入「**Modbus**」–>「**Modbus Master**」。  
点击「**Add**」按钮。

![image](/images/samples/digicom/Immagine-13.png)

<br>
将 Modbus Master 配置设为 **enabled**，设置 **Name**、**ID**、**Connection type**、**COM type** 及 **settings**、**rates**、**register formats**。将 **Data Destination** 设为 **MQTT**，然后点击「**Save**」按钮。

![image](/images/samples/digicom/Immagine-14.png)

<br>
下面定义从电能表读取的 4 组示例数据（电压、电流、频率、kVA）并作为时序发送到 ThingsBoard，用于后续展示与仪表板。  
点击「**Requests**」按钮。

![image](/images/samples/digicom/slave1.png)

<br>
填写电压（**Volts**）所需参数，点击「**Save**」按钮。

![image](/images/samples/digicom/Immagine-16.png)

<br>
点击「**Add**」按钮，按相同方式配置电流（**Ampere**）、频率（**Hertz**）和功率（**kVA**）。  
最终效果如下。

![image](/images/samples/digicom/Immagine-17.png)

<br>
若配置正确，**Value** 列会按指定 Scan rate 显示并更新测量数据。
点击「**Test**」可立即触发一次数据读取。

<br>
从下拉菜单选择 **Modbus** – **MQTT Configuration**。

![image](/images/samples/digicom/modqtt1.png)

<br>
填写外部 Broker 的 MQTT 目标参数，如 **Server Address**、**Port Number**、**Username** 和 **Password**（本例使用 **MQTT Basic Authentication**）。  
设置设备发送数据的 **Publishing topic**。默认设备 Modbus 数据发布到以下 topic 结构： 

```
digicom/<device SN>/data/modbus
```
{:.copy-code}

点击「**Save**」按钮。

![image](/images/samples/digicom/modqtt2.png)

<br>
需重启设备以使新配置生效。  
从下拉菜单选择 **Device** –「**Reboot**」。

![image](/images/samples/digicom/reb1.png)

<br>
点击「**Reboot**」并**确认**。

![image](/images/samples/digicom/reb2.png)

等待设备重新就绪后，返回 ThingsBoard 账户，在「**Devices**」页面检查设备是否出现。

## 检查设备

从左侧菜单栏进入「**Entities**」的「**Devices**」页面。
当设备首次向 ThingsBoard 连接的外部 MQTT broker 发布数据后，新的[设备](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}应会显示。

![image](/images/samples/digicom/check-device-1.png)

<br>
检查遥测与属性数据。
点击设备行（非复选框），进入「**Last telemetry**」选项卡。
此面板显示数据转换器从数据流中提取的最新测量值。

进入「**Attributes**」选项卡。
此面板显示数据转换器从数据流中提取的最新 Client 和 Server 属性。

![image](/images/samples/digicom/check-device-2.png)

<br>
数据已在系统中，接下来可创建简单仪表板。

## 创建仪表板

ThingsBoard 提供强大功能——创建和自定义交互式可视化，即[Dashboards](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}。这些仪表板是高效监测与管理数据和设备的工具。

通过左侧主菜单进入「**Dashboards**」页面。点击屏幕右上角「**+**」，从下拉菜单选择「**Create new dashboard**」。
在弹出对话框中输入仪表板标题，description 可选。点击「**Add**」。

![image](/images/samples/digicom/dashboard-energy-meter-1.png)

<br>
创建后仪表板会自动打开，可立即添加部件。  
点击屏幕顶部的「**Add widget**」按钮，或点击屏幕中央较大的「**Add new widget**」图标（若为该仪表板上首个部件）。

![image](/images/samples/digicom/dashboard-energy-meter-2.png)

<br>
找到「**Analogue gauges**」部件包并点击。

![image](/images/samples/digicom/dashboard-energy-meter-3.png)

<br>
选择「**Radial gauge**」部件。

![image](/images/samples/digicom/dashboard-energy-meter-4.png)

<br>
出现「Add Widget」窗口。在「**Device**」字段指定设备「**50012345**」作为数据源。  
将遥测键「**power**」设为 **Data key**。  
向下滚动并按需设置其它项，如标题、单位、仪表量程最小最大值。

若要进一步自定义，进入「**Advanced**」调整部件外观与样式。

点击「**Add**」。

![image](/images/samples/digicom/dashboard-energy-meter-5.png)

<br>
已添加显示当前功率读数的部件。

![image](/images/samples/digicom/dashboard-energy-meter-6.png)

<br>
同样为另外三个遥测值（data keys）添加部件，并在仪表板上合理排列。  
完成后点击「**Save**」保存仪表板。

![image](/images/samples/digicom/dashboard-energy-meter-7.png)

## 更多参考资料与指南

可在在线文档中查阅更多关于 ThingsBoard 使用、创建[customers](/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"}、[users](/docs/{{docsPrefix}}user-guide/ui/users/){:target="_blank"}和[assets](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"}，以及让[dashboards](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}更强大的指南。

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}