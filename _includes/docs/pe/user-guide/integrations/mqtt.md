{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

MQTT 集成用于连接外部 MQTT broker，订阅其数据流并将设备各类负载转换为 ThingsBoard 消息格式。典型场景是设备已接入外部 MQTT broker 或采用 MQTT 后端的物联网平台/连接提供商。 

请参阅集成示意图了解更多。 

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/mqtt-integration.svg"></object>

ThingsBoard MQTT 集成作为 MQTT 客户端运行。 订阅主题并将数据转换为遥测与属性更新。 对于下行消息，MQTT 集成会转换为设备适用格式并推送到外部 MQTT broker。 
注意：MQTT broker 需与 ThingsBoard 实例同机部署或部署在云端并具有有效 DNS 名或静态 IP。 ThingsBoard instance that is running in the cloud can’t connect to the MQTT broker deployed in local area network.

## MQTT 集成配置

本教程将配置 MQTT 集成，使设备可连接平台并能向设备发送 RPC 命令。

### 前置条件

本教程将使用：

{% if docsPrefix == "pe/" %}
- The instance of [ThingsBoard专业版](https://thingsboard.io/docs/user-guide/install/pe/installation-options/) installed locally;
  {% endif %}
  {% if docsPrefix contains "paas/" %}
- ThingsBoard Professional Edition instance — [{{hostName}}](https://{{hostName}});
  {% endif %}
 - ThingsBoard PE 可访问的 MQTT broker — broker.hivemq.com（端口 1883）；
 - mosquitto_pub 和 mosquitto_sub 客户端用于收发消息；   
 - 用于 RPC 仿真的高级[设备模拟器](/docs/user-guide/integrations/resources/mqtt-client.py)。

假设我们有一台正在发送当前温度读数的传感器。
传感器设备 *SN-001* 将温度读数发布到 '**tb/mqtt-integration-tutorial/sensors/SN-001/temperature**'，并订阅 '**tb/mqtt-integration-tutorial/sensors/SN-001/rx**' 接收 RPC 调用。

### ThingsBoard 配置

配置 MQTT 集成前，需创建上行和下行转换器。

上行转换器用于解析和转换 MQTT 集成接收的数据。

下行转换器解析并转换 ThingsBoard 发送的数据，使之符合现有设备的格式。

#### 上行转换器

解码函数用于将入站数据和 metadata 解析为 ThingsBoard 可处理的格式。
*deviceName* 和 *deviceType* 为必填，*attributes* 和 *telemetry* 可选。
*Attributes* 和 *telemetry* 为扁平键值对象，不支持嵌套。

创建上行转换器：进入 **Integrations center** -> **Data converters** 页面，点击「plus」。
命名为「**MQTT Uplink Converter**」，选择类型 **Uplink**。暂时启用 **debug mode**。

{% assign feature = "integrations" %}{% include templates/debug-mode.md %}

{% include templates/tbel-vs-js.md %}

{% capture mqttuplinkconverterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/mqtt/mqtt-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/mqtt/mqtt-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="mqttuplinkconverterconfig" toggle-spec=mqttuplinkconverterconfig %}

#### 下行转换器

下行转换器转换出站 RPC 消息，随后由集成发送到外部 MQTT broker。

{% capture difference %}
**注意：**
<br>
即使不发送下行 RPC，也需创建占位下行转换器。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

创建另一转换器，命名为「**MQTT Downlink Converter**」，类型 **Downlink**。保留默认脚本，点击 **Add**。     

{% include templates/tbel-vs-js.md %}

{% capture mqttdownlinkconverterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/mqtt/mqtt-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/mqtt/mqtt-downlink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="mqttdownlinkconverterconfig" toggle-spec=mqttdownlinkconverterconfig %}


#### MQTT 集成配置

- 进入 **Integrations center** -> **Integrations** 页面，点击「plus」添加新集成。命名为「**MQTT Integration**」，选择类型 **MQTT**；

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-integration-1-pe.png)

- 下一步添加刚创建的 **uplink** 和 **downlink** 转换器；

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-integration-2-pe.png)

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-integration-3-pe.png)

- 在连接步骤中指定 **host**：**broker.hivemq.com**，**port**：**1883**；

- 添加 **topic filter**：

```shell
tb/mqtt-integration-tutorial/sensors/+/temperature
```
{: .copy-code}

 - 也可选择 MQTT **QoS** 级别。默认使用 MQTT QoS 0（At most once）；

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-integration-4-pe.png)

- 进入 **advanced settings**。建议取消勾选 **Clean session**。多数 broker 不支持粘性会话，启用该选项可能导致静默断开；

- 保持 **Downlink topic pattern** 为默认，即集成将使用 metadata.topic 作为下行 topic；

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-integration-5-pe.png)

- [可选] 点击 **Check connection** 检查与 Service Bus topic 的连接。点击 **Add** 创建集成。

![image](/images/user-guide/integrations/mqtt/mqtt-integration-add-integration-6-pe.png)

#### 发送上行消息

模拟设备向集成发送温度读数。

在终端发送简单格式的温度读数消息 *`{"value":25.1}`*：

```shell
mosquitto_pub -h broker.hivemq.com -p 1883 -t "tb/mqtt-integration-tutorial/sensors/SN-001/temperature" -m '{"value":25.1}'
```
{: .copy-code}

![image](/images/user-guide/integrations/mqtt/mqtt-integration-send-uplink-message-1.png)

{% if docsPrefix == "pe/" %}
发送上行消息后，新设备已被创建。您会收到相关通知。 
点击右上角铃铛图标查看通知。 
通知中包含所创建设备的链接。进入该设备。

![image](/images/user-guide/integrations/mqtt/mqtt-integration-go-to-devices-1-pe.png)

此处可看到新设备信息以及我们发送给设备的遥测数据。

![image](/images/user-guide/integrations/mqtt/mqtt-integration-go-to-devices-2-pe.png)

了解*通知*及配置方法请参阅[此处](/docs/{{docsPrefix}}user-guide/notifications/)。
{% endif %}

{% if docsPrefix contains "paas/" %}
进入 **Device Groups** -> **All** 后，应能看到由集成配置的 *SN-001* 设备。
点击设备，进入 *Latest Telemetry* 标签，可看到 "temperature" 键及其值 (25.1)。

![image](/images/user-guide/integrations/mqtt/mqtt-integration-go-to-devices-2.png)

{% endif %}

返回 **Integrations** 页面，进入 **Events** 标签，可看到 **MQTT Integration** 消费的消息。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-events-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-events-1.png)
{% endif %}

**MQTT Uplink Converter** 的 **Events** 标签中有「*In*」「*Out*」「*Metadata*」列。 
「*In*」和「*Metadata*」为数据转换器输入，「*Out*」为输出。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-converter-events-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-converter-events-1-paas.png)
{% endif %}

<br>
**总结：**上行数据转换器定义设备配置及输入数据解读方式。 
本示例从 topic 中提取设备名（SN-001），设置默认设备类型（sensor）并填入遥测值。 
更复杂场景可编写脚本，从 data 或 metadata 任意部分获取数据。

### 向设备发送单向 RPC

本节说明如何使用控制部件向设备发送单向RPC请求。

- 进入 **Dashboards** 页面，创建名为 **MQTT RPC** 的新仪表板并打开，点击 **Entity aliases** 图标添加别名；
- 命名别名（如 **Sensor**），选择筛选类型 **Single Entity**、类型 **Device**，选择 **SN-001** 传感器。点击 **Add** 再 **Save**；
- 添加新部件，从下拉菜单选择**Control Widgets**包，选择**Knob Control**部件；
- 在**Data**字段选择已创建的别名(**Sensor**)。将**Number of digits after floating point**设为0；
- 进入**Advanced**标签，将**Minimum value**设为15、**Maximum value**设为45。其余保持默认。点击**Add**创建部件；
- Save changes.

{% include images-gallery.html imageCollection="create_dashboard" %}

进入 **Rule Chains** 页面，打开 **Root Rule Chain**。双击 **message type switch** 节点并启用其 **Debug mode**。 

{% include images-gallery.html imageCollection="edit_rule_node" %}

返回仪表板，旋转旋钮几次。 

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-turn-knob-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-turn-knob-1.png)
{% endif %}

**message type switch** 节点的 **Events** 标签中应能看到消息类型为 *RPC_CALL_FROM_SERVER_TO_DEVICE*、关系类型为 *RPC Request to Device* 的入站消息。可查看 Knob Control 发送给规则引擎的 data 和 metadata。

{% include images-gallery.html imageCollection="incoming_messages" %}

要使传感器执行该命令，需将 **RPC Request to Device** 类型消息转发到下行数据转换器。
在 Root Rule Chain 编辑器中找到 **integration downlink** 节点，拖放到规则链。命名为 **MQTT Integration Downlink**，选择 **MQTT Integration**，点击 **Add**。
从 Message Type Switch 拖拽连线到 MQTT Integration Downlink，标签为 "RPC Request to Device"，点击 add。

{% include images-gallery.html imageCollection="add_rule_node" %}

进入 **Data converters** 页面，打开「**MQTT Downlink Converter**」，将默认脚本替换为以下内容：

{% capture mqttdownlinkconverterconfig2 %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/mqtt/mqtt-downlink-converter-config-tbel-2.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/mqtt/mqtt-downlink-converter-config-javascript-2.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="mqttdownlinkconverterconfig2" toggle-spec=mqttdownlinkconverterconfig2 %}

上述脚本从 *msg.params* 值中移除引号（原为带引号的字符串）并解析为整数，然后构建传给集成的结果对象。
结果对象结构需满足：data（原样发送到外部 MQTT broker 的消息负载）和 metadata（供集成使用）。如前所述，集成下行 topic 配置为 **${topic}**，即集成将使用 metadata.topic 作为下行 topic。

打开终端执行：

```shell
mosquitto_sub -h broker.hivemq.com -p 1883 -t "tb/mqtt-integration-tutorial/sensors/+/rx"
```
{: .copy-code}

![image](/images/user-guide/integrations/mqtt/mqtt-integration-execute-command.png)

返回仪表板再次旋转旋钮。终端中应能看到旋钮控制部件发送的一系列入站消息：
```shell
{"value":33}
{"value":42}
```

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-turn-the-wheel-1-pe.png)

![image](/images/user-guide/integrations/mqtt/mqtt-integration-turn-the-wheel-2-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-integration-turn-the-wheel-1.png)

![image](/images/user-guide/integrations/mqtt/mqtt-integration-turn-the-wheel-2.png)
{% endif %}

### 模拟双向 RPC 

模拟向设备发送 RPC 请求并接收响应。

首先修改转换器，使下行消息发送到 topic '**tb/mqtt-integration-tutorial/sensors/+/rx/twoway**'，设备响应接收自 topic 
**tb/mqtt-integration-tutorial/sensors/+/rx/response**。

修改下行转换器，使消息发送到 topic '**tb/mqtt-integration-tutorial/sensors/+/rx/twoway**'。打开「**MQTT Downlink Converter**」，将第 16 行改为

```shell
topic: 'tb/mqtt-integration-tutorial/sensors/'+metadata['deviceName']+'/rx/twoway'
```
{: .copy-code}

或将下列代码粘贴到编码器窗口：

{% capture mqttdownlinkconverterconfig3 %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/mqtt/mqtt-downlink-converter-config-tbel-3.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/mqtt/mqtt-downlink-converter-config-javascript-3.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="mqttdownlinkconverterconfig3" toggle-spec=mqttdownlinkconverterconfig3 %}

然后配置上行转换器以接收响应消息。打开「**MQTT Uplink Converter**」，将下列代码粘贴到解码器窗口：

{% capture mqttuplinkconverterconfig2 %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/mqtt/mqtt-uplink-converter-config-tbel-2.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/mqtt/mqtt-uplink-converter-config-javascript-2.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="mqttuplinkconverterconfig2" toggle-spec=mqttuplinkconverterconfig2 %}

上述脚本与初始版本略有不同，可区分 Post Telemetry 请求和 RPC 调用响应，向规则引擎发布不同类型输出。

还需在集成中添加 topic filter 以接收 RPC 响应消息：**MQTT Integration** -> **Topic filters** -> **Add topic filter**。 
使用默认 **QoS** 添加该 topic：

```shell
tb/mqtt-integration-tutorial/sensors/+/rx/response
```
{: .copy-code}

应用更改。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-rpc-edit-integration-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-rpc-edit-integration-1.png)
{% endif %}

运行设备模拟器。**mosquitto_pub** 和 **mosquitto_sub** 不足以完成本示例，请启动[高级模拟器](/docs/user-guide/integrations/resources/mqtt-client.py)：

```js
python mqtt-client.py
```
{: .copy-code}

![image](/images/user-guide/integrations/mqtt/mqtt-rpc-send-message-2.png)

在仪表板上旋转旋钮。终端中应有类似输出：

```shell
Incoming message
Topic: tb/mqtt-integration-tutorial/sensors/SN-001/rx/twoway
Message: {"value":40}
This is a Two-way RPC call. Going to reply now!
Sending a response message: {"rpcReceived":"OK"}
```

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-rpc-turn-the-wheel-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-rpc-turn-the-wheel-1.png)
{% endif %}

进入 **Devices** 页面，在 SN-001 设备的 **Latest telemetry** 标签中可看到 *rpcReceived* 遥测值为 "*OK*"。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-rpc-device-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/mqtt/mqtt-rpc-device-1-paas.png)
{% endif %}

### MQTT 重传机制

MQTT 集成使用 ThingsBoard 内置 MQTT 客户端。

{% if docsPrefix contains "paas" %}
{% include docs/user-guide/mqtt-retransmission-mechanism.md show-yml-config=false %}
{% else %}
{% include docs/user-guide/mqtt-retransmission-mechanism.md show-yml-config=true %}
{% endif %}

MQTT 消息被丢弃时，对应规则引擎消息将通过 **Failure** 链路由，并带有相应异常信息。

## 视频教程

### 配置 MQTT 集成

本视频为 MQTT 集成的分步配置教程。

<br>
<div id="video">  
 <div id="video_wrapper">
     <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/BeN5bsDQbdo" frameborder="0" allowfullscreen></iframe>
 </div>
</div> 

### 配置向设备发送 RPC 请求

可通过本视频了解如何配置向设备发送 RPC 请求，并通过 MQTT 集成接收模拟响应。

<br>
<div id="video">  
 <div id="video_wrapper">
     <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/A_jCXQj_LXs" frameborder="0" allowfullscreen></iframe>
 </div>
</div> 

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
