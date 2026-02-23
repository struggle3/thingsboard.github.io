
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://store.ncd.io/product/c1d2-industrial-iot-wireless-2-channel-vibration-temperature-sensor-v3" %}
{% assign thingsboardHost = "https://" | append: {{hostName}} %}
{% assign officialManualLink = "https://resource.milesight.com/milesight/iot/document/am300-series-user-guide-en.pdf" %}

## 概述

**工业物联网无线振动温度传感器**

该 IIoT 传感器用于监测工业环境中的振动、频率与温度，为预测性维护、设备监控及整体运行效率提供数据支持。

<br><br><br>
振动类典型应用场景：

• 旋转设备的高级预测性维护<br>
• 结构健康综合监测<br>
• 制造过程自动化与质量控制<br>
• 工业系统能效优化

本教程将引导您完成 NCD 工业物联网无线振动温度传感器与 Enterprise IIoT 网关的配置，包括创建设备、配置参数、通过 MQTT 协议将传感器数据发送至 ThingsBoard，以及设计用于传感器数据监控与分析的实时仪表板。

**Enterprise IIoT Gateway Lite（企业 IIoT 网关精简版）**

![Enterprise IIoT Gateway Lite](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/3-ncd-to-thingsboard-IIoT-Gateway-Lite.png){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
Enterprise IIoT 网关负责接收、处理、解码并转发 NCD 工业物联网传感器的数据至各类云服务或工业协议。可将其类比为 Wi-Fi 路由器，但采用名为 DigiMesh® 的专用无线协议。NCD 传感器与 Enterprise IIoT 网关均通过该协议通信，专为工业场景设计与验证。

## 概述（集成流程）

工业物联网无线振动温度传感器采集温度与振动等现场关键参数，通过 DigiMesh® 工业协议将数据发送至 Enterprise IIoT 网关。网关搭载 NCD Node-RED 库，对数据进行接收、解码与过滤后，经 MQTT 协议上传至 ThingsBoard。在 ThingsBoard 中，可通过自定义仪表板对数据进行查询、分析与实时可视化，为监控与决策提供依据。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/4-ncd-to-thingsboard-overview.png)

## 前提条件

要将 NCD 工业物联网传感器数据发送至 ThingsBoard，需满足以下条件：

- [ThingsBoard Cloud](https://thingsboard.io/installations/){:target="_blank"} 账户
- NCD 工业物联网无线振动温度传感器 V3
- NCD Enterprise IIoT 网关标准版或精简版：
  - [Enterprise IIoT Gateway](https://store.ncd.io/product/enterprise-iiot-gateway/){:target="_blank"}
  - [Enterprise IIoT Gateway Lite](https://store.ncd.io/product/enterprise-iiot-gateway-lite/){:target="_blank"}

{% capture difference %}
**说明**：本示例使用 ThingsBoard Cloud，也可使用 [ThingsBoard 本地部署](/docs/user-guide/install/pe/installation-options/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture difference %}
**说明**：本教程同样适用于其他 NCD 工业传感器。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

具备上述组件后，可将 NCD 传感器接入 Enterprise IIoT 网关，并利用内置 Node-RED 通过 MQTT 协议将传感器数据转发至 ThingsBoard。

本教程将按步骤说明关键配置：连接 NCD 设备、在平台上注册、配置 ThingsBoard Cloud 账户、添加并关联新网关，以及创建仪表板以有效展示实时传感器数据。

## 配置 NCD 振动传感器与 Enterprise IIoT 网关

我们先配置 Enterprise IIoT 网关与振动传感器，再将二者连接。流程较为简单，详细步骤可参考下方 NCD 文档，此处仅作简要说明：

- [工业物联网无线振动温度传感器 V3 快速入门](https://ncd.io/blog/industrial-iot-wireless-vibration-temperature-sensor-v3-quick-start-guide/){:target="_blank"}<br>
- [工业物联网无线振动温度传感器 V3 用户手册](https://ncd.io/blog/industrial-iot-wireless-vibration-temperature-sensor-v3-user-manual/){:target="_blank"}

按说明开箱、接线并上电 NCD Enterprise IIoT 网关。将 ETH0 口接入支持 DHCP 的路由器（网关作为 DHCP 客户端），将自动获取 IP。等待设备启动后，可通过其本地 IP 或域名加端口 1880（Node-RED 默认端口）访问其上的 Node-RED。

建议使用本地域名格式：**ncd-xxxx.local:1880**，其中 **xxxx** 为 Enterprise IIoT 网关 MAC 地址后四位（印于设备侧面）。例如：**http://ncd-c398.local:1880**

### 将传感器连接到网关

打开 Node-RED 后，可见已预置的流，包含 Wireless Gateway 节点与 Debug 节点，用于接收并显示已连接设备的消息。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/5-ncd-to-thingsboard-nodered.png)

该流已预配置，可直接接收 NCD 传感器数据。当 NCD 传感器接入无线网络并上报数据时，**Wireless Gateway** 节点会自动接收并处理消息，再经输出端发送至 **Debug** 节点，在 Node-RED 编辑器右侧的 **调试窗口** 中显示。
此时可上电 NCD 振动传感器。NCD 工业传感器出厂带电池，也支持外接供电（可在购买时选配）。

本教程以电池供电为例，步骤同样适用于外接供电。启用传感器时，打开外壳并将电源开关拨到「内部电池供电」档位。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/6-ncd-to-thingsboard-vibration-sensor-inside.png)

该设备电源开关有三档：

- 电池供电
- 关闭
- 外接供电

**电池供电** 档使用机内电池为传感器供电并上报数据。

**关闭** 档会关闭传感器所有模块，不再上报数据。

**外接供电** 档通过机身上的圆孔电源接口连接外部电源为传感器供电并上报数据。

### NCD 振动传感器消息

传感器上电后开始上报数据，您会在 Node-RED 中看到传入消息。**Wireless Gateway** 节点解码传感器数据并经输出端发送至 **Debug** 节点，在 Node-RED 编辑器的 **调试窗口** 中显示。激活 NCD 振动传感器后，调试窗口会显示类似以下内容：

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/7-ncd-to-thingsboard-debug-window.png)

NCD 传感器会发送多种消息，用于反映当前模式、运行状态及实际传感器数据。本教程主要关注 **RUN sensor_mode** 与 **sensor_data** 消息。

### RUN sensor_mode 消息

RUN 消息表示由 **msg.payload.mac** 标识的传感器已上电，并已通过无线网络与 **Enterprise IIoT 网关** 成功通信。该消息包含 MAC **地址**、**传感器类型**、**节点 ID**、**模式** 与 **时间戳** 等关键信息。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/8-ncd-to-thingsboard-debug-run-message.png)

### sensor_data message

The **sensor_data** message includes critical information such as the **firmware version**, **battery percentage**, **sensor type**, **data values**, **sensor name**, **MAC address**, and other essential details.

The **sensor_data** message can be identified by the **msg.topic** property. When the sensor transmits a data message, the **msg.topic** is set to **sensor_data** which makes it easier to filter or manage the sensor data. To view the sensor data in the **debug window**, simply click on the message. You should see something like this.

In this tutorial, our primary focus will be on transmitting **RUN sensor mode** and **sensor data** messages to effectively monitor the sensor’s real-time status. We will explore these topics in greater detail later in the tutorial. For now, let’s move on to **ThingsBoard** to configure all the necessary components.

{% assign thingsboardDebugMsgPayload = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/9-ncd-to-thingsboard-debug-msg-payload.png,
'
%}

{% include images-gallery.liquid imageCollection=thingsboardDebugMsgPayload %}

## 配置 ThingsBoard Cloud

可参考以下文档快速上手 ThingsBoard 专业版及 MQTT 网关 API：

- [ThingsBoard 专业版入门](https://thingsboard.io/docs/paas/eu/getting-started-guides/helloworld/){:target="_blank"}
- [MQTT 网关 API 参考](https://thingsboard.io/docs/reference/gateway-mqtt-api/){:target="_blank"}

第一步：使用您的 ThingsBoard 账户 [登录](https://thingsboard.cloud/login){:target="_blank"}。 

{% assign thingsboardWelcome = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/sign-into-thingsboard-1-pe.png,
        title: 第一步：使用您的 ThingsBoard 账户登录。
'
%}

{% include images-gallery.liquid imageCollection=thingsboardWelcome %}

<br>
登录后将看到入门资源与解决方案模板，可先浏览以熟悉 **ThingsBoard** 环境。

{% assign thingsboardWelcome2 = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/thingsboard-welcome-1-pe.png,
        title: 登录后将看到入门资源与解决方案模板，可先浏览以熟悉 ThingsBoard 环境。
'
%}

{% include images-gallery.liquid imageCollection=thingsboardWelcome2 %}

<br>
接着在 ThingsBoard 实例中 [添加新设备](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}。按以下步骤操作：

{% assign addingIsGatewayDevice = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-is-gateway-device-1-pe.png,
        title: 进入 **「实体」** 下的 **「设备」** 页面，在设备列表中点击表格右上角 **「+」**，从下拉菜单中选择 **「添加新设备」**。
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-is-gateway-device-2-pe.png,
        title: 在弹出的新窗口中为设备命名（本例使用 **NCD Enterprise IIoT Gateway**），可填写标签、分组、描述等。勾选 **「Is gateway」**，然后点击 **「下一步：凭据」**。
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-is-gateway-device-3-pe.png,
        title: 进入设备凭据窗口，选择 **「MQTT Basic」**（可在此增加 MQTT 安全层）。在各选项旁点击 **「生成」** 生成 **Client ID**、**Username**、**Password**，供 **Node-RED MQTT 节点** 与 **Enterprise IIoT 网关** 建立连接使用。
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-is-gateway-device-4-pe.png,
        title: 生成凭据后，使用 **「复制」** 获取各值，建议暂存到临时文件，后续在本指南的 **Node-RED MQTT 节点** 中会用到。然后点击 **「添加」**。
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-is-gateway-device-5-pe.png,
        title: 随后会弹出连接测试窗口。因使用网关需配合 ThingsBoard 网关设备的 MQTT 主题，可跳过该步。连接使用的 MQTT 服务器为「mqtt.thingsboard.cloud」。点击 **「关闭」** 继续。
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-is-gateway-device-6-pe.png,
        title: 已成功添加使用 MQTT 协议的新网关。下一步在 Enterprise IIoT 网关中配置 MQTT 凭据以验证连接。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addingIsGatewayDevice %}

## 导入并配置 NCD 模板流

下一步是 **导入** 并 **配置** 预置的 **流模板**。该流会在将振动传感器数据连接到 ThingsBoard MQTT 代理并发布前进行过滤与格式化，并依据 ThingsBoard MQTT 网关 API 参考设置相应主题。导入流时，请打开 GitHub 仓库并复制或下载 RAW JSON 文件：[ncd-vibration-sensor-t80-to-thingsboard-mqtt.json](/docs/devices-library/resources/ncd-vibration-sensor-t80-to-thingsboard-mqtt.json){:target="_blank"}

{% capture difference %}
**内部说明**：该流将位于 NCD Github 仓库。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

在 Node-RED 中，点击编辑器右上角主菜单中的 **「导入」**：

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/28-ncd-to-thingsboard-node-red-import.png)

<br>
导入 **ncd-vibration-sensor-t80-to-thingsboard-mqtt.json** 时，在弹出窗口中点击 **「选择要导入的文件」** 选择文件，或将复制的 JSON 粘贴到粉色文本框，然后点击 **「导入」**。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/29-ncd-to-thingsboard-node-red-import.png)

<br>
Node-RED 编辑器顶部会弹出提示，显示已成功导入工作区的节点。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/30-ncd-to-thingsboard-node-red-importing.png)

<br>
可在 Node-RED 工作区中摆放流。下一步将 **Wireless Gateway** 节点的输出连接到 **ncd-filter-mode** 节点的输入，如下图所示。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/31-ncd-to-thingsboard-node-red-connect.png)

<br>
下面简要说明该流中各节点的作用，不展开每个节点的详细说明。

{% capture difference %}
**说明**：若需了解各节点用法，可在 Node-RED 编辑器中选中节点并点击「Info」选项卡，查看 Node-RED 中与该节点相关的文档。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/32-ncd-to-thingsboard-node-red-info.png)

<br>
**ncd-filter-mode**：该节点处理来自 **Wireless Gateway** 节点的消息，按 topic 过滤并分流。**输出 1** 对应 topic **sensor_mode** 的消息（传感器运行模式）；本教程关注 **RUN 模式**，表示传感器已接入 Enterprise IIoT 网关网络并可上报数据。**输出 2** 对应 **sensor_data** 消息，包含 **电池电量**、**振动**、**温度** 等传感器读数。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/33-ncd-to-thingsboard-node-red-filter.png)

<br>
**ncd-filter-by-run-mode**：该节点判断传感器是否处于 **RUN 模式**。若非 RUN 模式，消息不会通过该节点。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/34-ncd-to-thingsboard-node-red-run-mode.png)

<br>
**ncd-set-device**：该节点从传感器 MAC 地址中取后 8 位（**xx:xx:xx:xx**）并赋给 **msg.payload.device**。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/35-ncd-to-thingsboard-node-red-set-device.png)

<br>
{% capture difference %}
**说明**：NCD 设备 MAC 地址示例：**00:13:A2:00:42:53:64:33**。经该节点处理后，msg.payload.device 将包含缩短后的 MAC 地址：**42:53:64:33**。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**ncd-set-mqtt-topic-connect**：该节点设置发往 ThingsBoard 的 MQTT 主题，用于通知平台设备已成功连接网关。  
**msg.topic = &#39;v1/gateway/connect&#39;**

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/36-ncd-to-thingsboard-node-red-topic-connect.png)

<br>
**ncd-filter-by-type**：NCD IoT 提供多种工业物联网传感器，以 **sensor type** 区分。该节点按传感器类型过滤消息；本例过滤 **单通道振动传感器**（sensor type **80**）的消息。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/37-ncd-to-thingsboard-node-red-filter-by-type.png)

<br>
**ncd-attributes**：该函数节点通过 JavaScript 保证 **type 80** 的 sensor_data 在部署后仅发送一次，并可定义 **地址**、**传感器名称**、**固件版本**、**节点 ID**、**传感器类型** 等 **传感器属性**，再按 ThingsBoard MQTT 网关 API 格式封装。JavaScript 代码如下：

```js
// Retrieve the 'flag' from the context or default to false
const flag = context.get("flag") || false;

if (!flag) {
   // Destructure properties from msg.payload
   const {
       addr,
       sensor_name: sensorName,
       firmware,
       nodeId,
       sensor_type: sensorType
   } = msg.payload;

   // Extract the device from the address
   const device = addr.substring(12);

   msg.payload = {
       [device]: {
           "Sensor Name": sensorName,
           "Firmware": firmware,
           "Node ID": nodeId,
           "Sensor Type": sensorType
       }
   };

   // Set the 'flag' in the context to avoid re-execution
   context.set("flag", true);
   return msg;
}
```

**ncd-set-mqtt-topic-attributes**：该节点设置发往 ThingsBoard 的 MQTT 主题，用于在 ThingsBoard 上更新传感器属性。  
**msg.topic = &#39;v1/gateway/attributes&#39;**

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/38-ncd-to-thingsboard-node-red-topic-atributes.png)

<br>
**ncd-add-battery-to-sensor-data**：该节点将振动传感器的电池电量加入 **msg.payload.sensor_data**，该消息已包含温度与振动等变量，便于在本教程中以单条消息携带全部相关变量。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/39-ncd-to-thingsboard-node-red-battery.png)

<br>
**ncd-telemetry**：该函数节点从 msg.payload 中取出 **传感器 MAC 地址** 与 **时间戳**，再取 **sensor_data**（含电池电量）并按 ThingsBoard MQTT 网关 API 格式封装。JavaScript 代码如下：

```js
// Destructure relevant properties from msg.payload
const { addr, received: timestamp } = msg.payload;

// Extract the device ID from the address
const device = addr.substring(12);

// Extract the data from the message
const sensor_data = msg.payload.sensor_data;

// Construct the payload in a clean and structured way
msg.payload = {
   [device]: [
       {
           ts: timestamp,
           values: sensor_data
       }
   ]
};

return msg;
```

**ncd-set-mqtt-topic-telemetry**：该节点设置发往 ThingsBoard 的遥测 MQTT 主题，用于在 ThingsBoard 上写入传感器遥测数据。  
**msg.topic = &#39;v1/gateway/telemetry&#39;**

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/40-ncd-to-thingsboard-node-red-topic-telemetry.png)

<br>
**ncd-to-thingsboard**：该 MQTT 输出节点使用所需凭据连接 MQTT 代理并接入 ThingsBoard，将振动传感器数据发布到 ThingsBoard Cloud。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/41-ncd-to-thingsboard-node-red-mqtt-node.png)

<br>
了解流中各 Node-RED 节点的作用后，下一步使用 **ThingsBoard** 中生成的凭据配置 MQTT 输出节点。双击 **ncd-to-ThingsBoard** 节点打开属性，先配置 **mqtt-broker config 节点**：点击 **「添加新的 mqtt-broker config 节点」**。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/42-ncd-to-thingsboard-node-red-add-new-mqtt.png)

<br>
将 Server 属性设为 ThingsBoard MQTT 代理地址：**mqtt.thingsboard.cloud**。本例使用默认端口 **1883**。最后配置 **Client ID**（在 ThingsBoard 中生成）。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/43-ncd-to-thingsboard-node-red-client-id.png)

<br>
在「安全」选项卡中填入 **ThingsBoard** 中生成的 **Username** 与 **Password**。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/44-ncd-to-thingsboard-node-red-security.png)

<br>
保存节点内配置时，点击 **「Update」** 按钮。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/45-ncd-to-thingsboard-node-red-update.png)

<br>
完成后即完成 MQTT 服务器配置。Topic 属性保持为空，其值将由前述节点中的 msg 属性动态传入，这些节点已为各类 MQTT 消息设置了对应主题。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/46-ncd-to-thingsboard-node-red-mqtt-server.png)

<br>
保存 MQTT 输出节点的修改后，点击 **「Done」** 图标。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/47-ncd-to-thingsboard-node-red-done.png)

<br>
配置好 MQTT 凭据后，NCD 振动传感器再次上报时，数据将经 MQTT 在对应主题下发布到 ThingsBoard。要保存并应用 Node-RED 中的修改，请点击编辑器右上角的 **「Deploy」** 按钮。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/48-ncd-to-thingsboard-node-red-deploy.png)

<br>
点击 **「Deploy」** 后，MQTT 输出节点下方会显示 **connecting**，表示正在尝试连接 MQTT 服务器。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/48-ncd-to-thingsboard-node-red-mqtt-node.png)

<br>
连接成功后，状态会变为 **connected**，表示 Node-RED 已与 MQTT 服务器通信。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/49-ncd-to-thingsboard-node-red-mqtt-node-connected.png)

<br>
要测试通信，可手动触发 NCD 振动传感器上报：按下传感器内部的 **RESET** 按钮。需先卸下白色外壳上的四颗螺丝，找到 RESET 按钮并按一次。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/50-ncd-to-thingsboard-vibration-reset-button.jpg)

{% capture difference %}
**说明**：也可不按 RESET，等待传感器按用户设定周期下一次上报后再进行测试。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

传感器发送新消息后，调试窗口会显示来自 **debug thingsboard** 节点的消息，可通过 **msg.topic** 识别：

- **v1/gateway/connect**   
- **v1/gateway/attributes**   
- **v1/gateway/telemetry**   

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/51-ncd-to-thingsboard-node-red-mqtt-messages.png)

<br>
按下传感器上的 **RESET** 后，传感器会先尝试建立无线网络连接；成功接入 **Enterprise IIoT 网关** 网络后发送 **RUN** 消息，随后发送 **sensor_data** 消息。
流会利用 RUN 与 sensor_data 中的信息组装 **connect**、**attributes**、**telemetry** 消息。下面分别说明这三类消息。

## Connect 消息

当 **工业物联网无线振动温度传感器** 与 **Enterprise IIoT 网关** 成功建立连接时，会生成第一条消息。**Wireless Gateway** 节点收到包含传感器连接状态的 **sensor_mode** 消息后，流通过 **switch** 节点判断是否为 **RUN** 消息（表示传感器已成功连接并可工作）。
若为 **RUN** 消息，流会提取传感器 **MAC 地址** 并按 **ThingsBoard API** 格式化。该消息用于告知 ThingsBoard 设备已成功连接网关，平台可识别传感器并开始接收遥测与属性数据以供分析与可视化。

```
Topic: v1/gateway/connect
```

```
Message: {
    "device":"Device A"
}
```

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/52-ncd-to-thingsboard-node-red-mqtt-connect.png)

### Attributes 消息

该消息由流根据 **sensor_data** 构建，从中提取 **传感器名称**、**固件版本**、**节点 ID**、**传感器类型** 等关键信息，并按 **ThingsBoard 属性 API** 的键值对格式封装。流仅向 ThingsBoard 发送一次该消息。

在 ThingsBoard 中，**设备属性** 是与设备关联的键值对，用于存储配置、元数据与运行信息等，为设备提供上下文。通过上传传感器属性，ThingsBoard 可保存传感器名称、版本等特征，便于在平台内监控与管理设备。

```
Topic: v1/gateway/attributes
```

```
Message:{
    "Device A":{
        "attribute1":"value1", 
        "attribute2": 42
    }, 
    "Device B":{
        "attribute1":"value1",
        "attribute2": 42
    }
}
```

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/53-ncd-to-thingsboard-node-red-mqtt-attributes.png)

### Telemetry 消息

该消息包含实时 **传感器数据**，如 **温度**、**振动**、**电池电量** 等。流将数据格式化后以 **遥测数据** 形式发布到 **ThingsBoard**。ThingsBoard 中的遥测用于实时监控与可视化，便于用户跟踪传感器状态与历史表现。

通过发送该遥测消息，传感器数据会在 ThingsBoard 上持续更新，可在仪表板中展示、用于分析、触发告警或根据读数执行其他操作，从而在工业物联网应用中实现有效的传感器网络监控与管理。

```
Topic: v1/gateway/attributes
```

```
Message: {
    "Device A": [
        {
            "ts": 1483228800000,
            "values": {
                "temperature": 42,
                "humidity": 80
            }
        },
    ]
}
```

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/54-ncd-to-thingsboard-debug-sensor-data.png)

## 检查与 ThingsBoard Cloud 的连接

返回 **ThingsBoard** 平台后，会看到已按 **MAC 地址** 自动添加新设备。**Enterprise IIoT 网关** 与 **传感器设备** 均会显示为 **Active**。系统会根据传感器通信情况自动更新设备状态。
可点击新设备查看 **属性**、**最新遥测**、**告警**、**事件**、**关系**、**审计日志** 等，以了解设备在 ThingsBoard 中的状态与运行情况。

{% assign createdDevice1 = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/created-new-device-1-pe.png,
        title: 返回 **ThingsBoard** 平台后，会看到已按 **MAC 地址** 自动添加新设备；**Enterprise IIoT 网关** 与 **传感器设备** 均为 **Active**，系统会根据传感器通信自动更新状态。
'
%}

{% include images-gallery.liquid imageCollection=createdDevice1 %}

可点击 **「Attributes」** 选项卡查看新添加的传感器属性。这些属性一般只更新一次，不会随每次上报变化，表示传感器的静态或较少变更信息，例如：

- 传感器名称：便于识别的名称。
- 固件版本：传感器当前固件版本。
- 节点 ID：网络中该传感器的唯一标识。
- 传感器类型：传感器类型。

{% assign createdDevice2 = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/created-new-device-2-pe.png,
        title: 可点击 **「Attributes」** 选项卡查看新添加的传感器属性。
'
%}

{% include images-gallery.liquid imageCollection=createdDevice2 %}

可在 **「Latest telemetry」** 选项卡下查看最新传感器遥测，包括温度、振动、电池电量等实时数据。每次传感器向 ThingsBoard 上报时这些值会更新，是监控传感器性能与状态的主要数据来源，可用于创建告警或构建展示实时测量的仪表板。每次传感器发送数据后，界面会显示更新后的数值，与下图类似。

{% assign createdDevice3 = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/created-new-device-3-pe.png,
        title: 可在 **「Latest telemetry」** 选项卡下查看最新传感器遥测。
'
%}

{% include images-gallery.liquid imageCollection=createdDevice3 %}

## Create a ThingsBoard Dashboard

下一步是在 ThingsBoard 中创建[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}。ThingsBoard 的**仪表板**用于可视化与监控从 IoT 设备采集的数据。请创建仪表板并添加若干[部件](/docs/{{docsPrefix}}user-guide/widgets/){:target="_blank"}，以展示实体列表及其最新 NCD 传感器数值。
创建新的空白仪表板可按以下步骤操作：

{% assign addingDashboard = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-1-pe.png,
        title: 通过左侧主菜单进入 **「Dashboards」** 页面（默认进入「All」分组），点击右上角 **「+」**，从下拉菜单选择 **「创建新仪表板」**；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-2-pe.png,
        title: 在弹出对话框中输入仪表板标题，描述可选，点击 **「添加」**；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-3-pe.png,
        title: 点击屏幕顶部的「**添加部件**」按钮，或点击屏幕中央的「**添加新部件**」大图标（若为本仪表板首个部件）；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-4-pe.png,
        title: 找到 **「Digital gauges」** 部件组并点击；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-5-pe.png,
        title: 选择「**迷你仪表盘**」部件；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-6-pe.png,
        title: 在 **「Device」** 属性中选择已创建设备；在 **「Data key」** 中点击 **「+Add」** 会列出传感器上报的变量，本例选择 **「Temperature」**。
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-7-pe.png,
        title: 在属性中可设置单位、量程、小数位数、样式等。点击 **「添加」** 图标将部件加入仪表板；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-8-pe.png,
        title: 可拖拽部件右下角以略微放大。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addingDashboard %}

完成后，仪表板上会出现该仪表部件，显示传感器上报的最新值（本例为 23 摄氏度）。

在「编辑」模式下将鼠标悬停于部件上时，部件右上角会显示按钮，用于编辑、下载、删除部件或调整位置与大小。

添加更多部件时可按以下步骤操作：

{% assign addingDashboard2 = '
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-9-pe.png,
        title: 再次点击「**添加部件**」；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-10-pe.png,
        title: 本例添加第二个部件以显示传感器电池电量。进入 **「Status indicators」** 部件组；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-11-pe.png,
        title: 选择「**电池电量**」部件；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-12-pe.png,
        title: 将 **「Device」** 再次设为之前添加的 NCD 设备；在 **「Data key」** 中点击并选择 NCD 振动传感器上报变量列表中的 **「battery_percent」**；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-13-pe.png,
        title: 在 **「Appearance」** 下选择 **「Horizontal. Divided」** 调整布局。ThingsBoard 会实时预览该部件的布局效果。点击 **「添加」**；
    ===
        image: /images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-14-pe.png,
        title: 按需调整部件大小与位置。保存对 ThingsBoard 仪表板的修改请点击右上角 **「保存」**。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addingDashboard2 %}

按需可添加任意数量部件，步骤与前述相同。每个部件均可 **自定义** 与 **调整**，包括 **样式**、**颜色**、**单位**、**图标**、**元素**、**分布**、**大小** 等，并可绑定振动传感器上报的变量。

我们已按同样方式在仪表板上添加了若干部件并绑定传感器振动变量。仪表板最终布局如下。
点击右上角 **「Expand to fullscreen」** 可全屏查看仪表板。

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-17-pe.png)

最终仪表板效果如下：

![image](/images/devices-library/ready-to-go-devices/ncd-vibration-temperature-sensor/adding-new-dashboard-18-pe.png)

## 总结

本教程介绍了将 NCD 工业物联网无线振动温度传感器与 ThingsBoard Cloud 集成的步骤，便于您管理与可视化 NCD 传感器上报的振动与温度数据。

将 NCD 工业物联网无线振动温度传感器成功接入 ThingsBoard 后，可进一步为传感器数据设置阈值与告警、在超限时通过邮件、短信或网页通知；也可通过为用户分配角色与权限，实现对设备与仪表板的定制访问。 
{% include add-device-banner.liquid %}