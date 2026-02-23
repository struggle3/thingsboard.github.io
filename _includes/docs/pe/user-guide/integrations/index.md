{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

ThingsBoard 平台集成功能面向两大用例/部署方式：

- 将采用特定负载格式的 NB IoT、LoRaWAN、SigFox 等设备直接接入 ThingsBoard 平台。
- 从已接入现有物联网平台的设备流式传输数据，以支持实时交互式仪表板及高效数据处理。
  
两类用例有若干共同点。部署拓扑中均有服务端组件阻止直接访问设备，并提供一组 API 与现场设备交互。
设备负载格式未统一，同类传感器的不同厂商甚至不同版本往往使用不同格式。

ThingsBoard 集成的职责是在核心平台能力（遥测采集、属性与 RPC 调用）与特定第三方平台 API 之间提供安全、可靠的 API 桥接。

## 工作原理

ThingsBoard 目前支持多种集成协议，以 HTTP、MQTT、OPC-UA 最为常用。
平台也支持与 LoRaWAN 网络服务器、Sigfox 后端、各类 NB IoT 设备等的集成，可通过原始 UDP 和 TCP 集成。
AWS IoT、IBM Watson、Azure Event Hub 等支持通过 MQTT 或 AMQP 订阅设备数据流。

![image](/images/user-guide/integrations/overview/create-integration-1.png)

平台集成列表持续增加，但整体集成概念相同，说明如下。

消息从外部平台到达 ThingsBoard 后，会按平台特定负载格式和安全规则进行校验。
校验通过后，ThingsBoard 集成会调用已配置的[**上行数据转换器**](#uplink-data-converter)，从入站消息中提取有效信息子集。
消息将设备及平台特定的负载转换为 ThingsBoard 所需格式。

自 TB PE v2.0 起，规则引擎也可向集成推送下行消息。此类消息示例包括：
 
 - [共享属性](/docs/{{docsPrefix}}user-guide/attributes/#device-specific-attribute-types){:target="_blank"}（配置）更新的通知；
 - [单向 RPC 调用](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc-api){:target="_blank"}以触发设备侧操作的通知；
 - 来自规则引擎的任意自定义消息。
 
常见用例包括：
 
 - 根据共享属性变化调整数据上报频率；
 - 根据共享属性变化触发固件更新；
 - 根据 RPC 调用改变设备状态；
 
规则引擎推送消息后，ThingsBoard 会调用已配置的[**下行数据转换器**](#downlink-data-converter)，将规则引擎消息转换为集成所需的数据格式。

<br>

<object width="100%" data="/images/user-guide/integrations/integrations-overview.svg"></object>
 
## 上行数据转换器

上行数据转换器的主要作用是将来自设备的入站消息负载（如 MQTT、HTTP、CoAP 等协议）解析并转换为 ThingsBoard 可处理的格式。

自 ThingsBoard 4.0 起，对于接收具有相同结构的负载消息的集成，编写转换器的流程已简化。
您可直接在界面中选择集成消息字段应写入属性还是遥测，无需在解码函数中手动定义。

该功能适用于下列集成的上行转换器：

- [ChirpStack](/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/){:target="_blank"}
- [Loriot](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/){:target="_blank"}
- [The Things Stack Community](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/){:target="_blank"}
- [The Things Stack Industries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/){:target="_blank"}
- **ThingPark**
- **ThingPark Enterprise**

> 4.0 之前创建的转换器仍可使用并正常工作。

### 通用上行数据转换器

创建适用于所有集成类型的通用上行数据转换器，请按下列步骤操作：

- 进入「**Integration center**」的「**Data converters**」部分，点击「**plus**」图标，在下拉菜单中选择「**Create new converter**」。
- 在新窗口中：
  - 将转换器类型选择器设为「**Uplink**」。
  - 选择使用该转换器的** integration type**（如 [MQTT](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/){:target="_blank"}、[OPC-UA](/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/){:target="_blank"} 等），若在多种集成中使用则保持「All」。
  - 输入转换器名称。
  - （可选）开发或测试时启用 **Debug mode** 以便排查问题。

{% assign feature = "uplink converter" %}
{% include templates/debug-mode.md %}

- 在 **Main decoding configuration** 部分定义解码逻辑：使用提供的默认脚本或输入自定义脚本解析并转换入站数据。

{% include templates/tbel-vs-js.md %}

![image](/images/user-guide/integrations/overview/adding-uplink-converter-1.png)

- 配置 **advanced decoding parameters**：
  - 为避免遥测或属性值的不必要更新，可使用「**Update only keys list**」字段。该列表中指定的键仅在其值与先前不同时才会更新。若某键出现在转换后的消息中但值未变，则跳过更新。
  > **注意**：集群环境下，若消息由不同集成执行节点接收，或转换器配置已更新，「Update only keys list」中键对应的值可能会被多次更新。  
- 配置完成后，点击「**Add**」创建并保存新转换器。

![image](/images/user-guide/integrations/overview/adding-uplink-converter-2.png)

### 类型化上行数据转换器

类型化上行数据转换器面向特定集成类型。
为支持**新版上行转换器功能**的集成（[ChirpStack](/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/){:target="_blank"}、[Loriot](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/){:target="_blank"}、[The Things Stack Community](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/){:target="_blank"}、[The Things Stack Industries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/){:target="_blank"}、ThingPark、ThingPark Enterprise）创建上行数据转换器，请按下列步骤：

- 「**Integration type**」字段列出所有支持的集成。本例使用 [Loriot](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/){:target="_blank"}。
- 指定转换器名称。
- 进入「**Main decoding configuration**」部分： 
  - 选择集成将创建的实体类型（**Device** 或 **Asset**）并指定实体名称。
  > Entity name 字段必填。默认遵循 **Device $eui**（或 **Asset $eui**）模式。在设备名称中需突出 **$** 模式。输入 **$** 时将出现 Loriot 消息的可用键列表，该列表为标准格式且不依赖具体消息内容。**$eui** 模式将动态从 Loriot 消息获取设备唯一标识。
- 在 **Main decoding configuration** 部分定义解码逻辑：使用提供的默认脚本或输入自定义脚本解析并转换入站数据。

{% include templates/tbel-vs-js.md %}

![image](/images/user-guide/integrations/overview/uplink-converter-20-1.png)

- 配置 **advanced decoding parameters**：
  - **Device profile**、**Device label**、**Customer name**、**Device group name** 字段非必填，可使用 **$** 模式动态填充。
  若 Device profile 为空，将使用「default」。
  - 在 **Attributes** 和 **Telemetry** 部分分别指定应解释为属性和遥测的键。
  若入站消息中缺少某指定键，转换器将忽略。
  - 为避免不必要更新，可使用「**Update only keys list**」字段。该列表中指定的键仅在其值发生变化时更新；若某键在转换消息中出现但值相同，则跳过更新。
  > **注意**：集群环境下，若消息由不同集成执行节点接收，或转换器配置已更新，「Update only keys list」中键对应的值可能会被多次更新。
- 配置完成后，点击「**Add**」创建并保存新转换器。

![image](/images/user-guide/integrations/overview/uplink-converter-20-2.png)

### 测试解码函数

创建上行数据转换器时，可验证用于处理入站设备数据的解码逻辑。
点击「**Test payload decoder**」开始。
可模拟转换器如何处理实际负载，并据此微调解码函数。

{% assign testDecoderFunctionWindow = '
    ===
        image: /images/user-guide/integrations/overview/test-payload-decoder-1.png,
        title: Click the "**Test payload decoder**" button to validate the decoding logic used to process incoming device data.
    ===
        image: /images/user-guide/integrations/overview/test-payload-decoder-2.png,
        title: Test decoder function window.
'
%}

{% include images-gallery.liquid imageCollection=testDecoderFunctionWindow %}

#### Payload

**Payload** 表示从设备接收到的编码输入数据。

> 注意：各集成类型有预填示例负载。可作为起点，或修改以匹配您集成的消息格式。

格式因集成类型而异，可为：
- **JSON**
- **TEXT**
- **Binary (Base64)**
  > 对于 **Binary (Base64) payload content type**，负载会自动解码为字节数组，无需在脚本中手动解码。

可在解码脚本中使用 *payload* 关键字访问负载。

#### Metadata

**Metadata** 是包含集成提供的特殊字段的键值映射。
可在解码脚本中使用 metadata 关键字引用这些值。

此外，可在各集成设置中配置自定义 metadata 参数。
例如，可定义 deviceType 等 metadata 参数，并在脚本中用于在创建设备时自动分配设备类型。

#### Converter output

**Converter output** 以 JSON 展示解码函数返回的结果，包括设备值数组（如遥测或属性），也可包含遥测时间戳。
便于比对和验证解码数据如何被 ThingsBoard 解释与处理。

> 输出 JSON 中仅 **deviceName** 和 **deviceType** 为必填。

{% capture difference %}
**注意**：自 2.4.2 起，ThingsBoard 也支持使用 **assetName** 和 **assetType** 替代 deviceName 和 deviceType。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture difference %}
**注意**：自 2.4.2 起，ThingsBoard 支持可选的 **customerName** 和 **groupName**。
这些参数将使 ThingsBoard 自动创建客户和/或实体组，并将实体分配给客户和/或组。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

Example of converter output data:

```json
{
  "entityType": "DEVICE",
  "name": "Device 1000000000000001",
  "profile": "default",
  "telemetry": [{
    "ts": 1684478801936,
    "values": {
      "battery": 95,
      "temperature": 36.6,
      "saturation": 99
    }
  }, {
    "rssi": -21,
    "data": "01755e030001040001",
    "battery": 94,
    "snr": 10,
    "fСnt": 2
  }],
  "attributes": {
    "serialNumber": "SN-12345678",
    "fPort": 85,
    "dr": "SF9 BW125 4/5",
    "frequency": 867500000,
    "eui": 1000000000000001
  }
}
```

## 下行数据转换器

**下行数据转换器**的主要作用是将规则引擎的入站消息及其 metadata 转换为对应集成使用的格式。

{% capture difference %}
**注意**：下行转换器通常为可选。仅在集成需要 ThingsBoard 发送出站消息（如 RPC、属性更新或其他命令）时需创建。若集成仅接收数据而不发起出站通信，可跳过创建下行转换器。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

创建下行数据转换器步骤：
- 进入「**Integration center**」的「**Data converters**」部分，点击「**plus**」图标，在下拉菜单中选择「**Create new converter**」。
- 在新窗口中：
  - 将转换器类型选择器切换为「**Downlink**」。
  - 选择使用该转换器的 **integration type**（如 [MQTT](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/){:target="_blank"}、[OPC-UA](/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/){:target="_blank"} 等），若在多种集成中使用则保持「All」。
  - 输入转换器名称。
  - （可选）开发或测试时启用 **Debug mode** 以便排查问题。

{% assign feature = "downlink converter" %}
{% include templates/debug-mode.md %}

- 在 **Main encoding configuration** 部分定义编码逻辑：输入用于解析并转换输出数据的**script**。

{% include templates/tbel-vs-js.md %}

- Click the "**Add**" button to create and save your new converter.

![image](/images/user-guide/integrations/overview/add-downlink-converter.png)

<br>
Downlink Converter is basically a user defined function with the following signature:

```javascript
function encoder(msg, metadata, msgType, integrationMetadata);
```

其中

ㅤ**&#42; msg** — 规则引擎消息的 JSON<br>
ㅤ**&#42; metadata** — 与消息相关的键值对列表（由规则引擎产生）<br>
ㅤ**&#42; msgType** — 规则引擎消息类型。详见[预定义消息类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types){:target="_blank"}<br>
ㅤ**&#42; integrationMetadata** — 包含集成特定字段的键值映射。可在集成详情中为各集成配置额外 metadata
  
### Converter output

转换器输出应为符合以下结构的有效 JSON 文档：

```json
{
    "contentType": "JSON",
    "data": "{\"tempFreq\":60,\"firmwareVersion\":\"1.2.3\"}",
    "metadata": {
        "topic": "temp-sensor/sensorA/upload"
    }
}
```

其中

ㅤ**&#42; contentType** — JSON、TEXT 或 BINARY（Base64 字符串），与集成类型相关<br>
ㅤ**&#42; data** — 按 contentType 的字符串数据<br>
ㅤ**&#42; metadata** — 与消息相关的键值对。例如 MQTT 集成使用的 topic 等

### 同步与异步下行

多数集成可异步处理发往设备的下行消息。
例如，规则引擎推送到基于 MQTT 的集成的每条消息会立即推送到对应外部 MQTT broker。

但 SigFox 或通用 HTTP 集成等无法异步推送消息。
由于底层 HTTP 协议特性，这些集成只能在响应上行消息请求时同步推送下行信息。
此时，由规则引擎产生的最后一条下行消息会保存在队列中，直至该设备收到新的上行消息。

### 示例

假设通过 ThingsBoard REST API 更新了温度与湿度上报频率属性，并希望将该更新推送到外部 MQTT broker（TTN、Mosquitto、AWS IoT 等）。
您可能还想包含先前配置的「firmwareVersion」属性值，而该值在本次请求中并不存在。
推送更新使用的 topic 应包含设备名称。

{% include templates/tbel-vs-js.md %}

{% capture downlinkdataconverterexample1 %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/overview/downlink-data-converter-example-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/overview/downlink-data-converter-example-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="downlinkdataconverterexample1" toggle-spec=downlinkdataconverterexample1 %}

为使集成执行下行处理，租户管理员需配置与下图类似的规则链：

![image](/images/user-guide/integrations/downlink-rule-chain-example-pe.png)

完整规则链配置见[此处](/docs/user-guide/resources/downlink-example-rule-chain.json){:target="_blank"}。

## 转换器库

ThingsBoard 转换器库是内置的上行解码函数集合，支持 100 多种设备及六种主流 LoRaWAN 网络服务器。
可显著简化与各类传感器和厂商的集成配置。

目前支持转换器库的集成有：[ChirpStack](/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/){:target="_blank"}、[Loriot](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/){:target="_blank"}、[The Things Stack Community](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/){:target="_blank"}、[The Things Stack Industries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/){:target="_blank"}、**ThingPark**、**ThingPark Enterprise**。
未来将支持更多集成。

访问转换器库：

- 进入「**Integrations center**」下的「**Integrations**」页面，点击「**plus**」图标开始创建新集成。
  - 选择当前支持转换器库的集成之一。 
  - 点击「**Next**」继续。
- 在「**Uplink data converter**」标签：
  - 切换到「**Library**」选项。
  - 从下拉菜单中选择**设备厂商**。
  - 选择您使用的具体**传感器型号**，对应解码函数将自动加载到编辑器。
  - 如需要，配置高级解码选项。
  - 点击「**Next**」。
- 继续完成集成配置。

{% assign convertersLibrary = '
    ===
        image: /images/user-guide/integrations/overview/converters-library-1.png,
        title: Navigate to the "**Integrations**" page under the "**Integrations center**" section. Click the "**plus**" icon button to start creating a new integration. Select one of the integrations that currently support the converters library. Click "**Next**" to proceed.
    ===
        image: /images/user-guide/integrations/overview/converters-library-2.png,
        title: Switch to the "**Library**" option. From the dropdown menu, choose the **device vendor**. Then select the specific **sensor model** you are using. The corresponding decoder function will be automatically loaded into the editor.
    ===
        image: /images/user-guide/integrations/overview/converters-library-3.png,
        title: If needed, configure advanced decoding options. Click "**Next**". Continue the process to finalize the integration setup.
'
%}

{% include images-gallery.liquid imageCollection=convertersLibrary %}

转换器库为开源项目，由 ThingsBoard 团队维护，托管在 GitHub：[链接](https://github.com/thingsboard/data-converters){:target="_blank"}。

{% if docsPrefix == "pe/" %}
<br>**使用自定义转换器仓库**

可[配置](/docs/user-guide/install/pe/how-to-change-config/){:target="_blank"} ThingsBoard 使用包含针对您设备的个性化解码器的自有仓库，以替代默认转换器库。

在 ThingsBoard 配置文件中设置以下环境变量以指定自定义仓库与分支：

```text
export TB_INTEGRATIONS_CONVERTERS_LIBRARY_REPO_URL=https://github.com/my-github-account/my-repo-name.git
export TB_INTEGRATIONS_CONVERTERS_LIBRARY_REPO_BRANCH=my-branch
```

其中

ㅤ**&#42; TB_INTEGRATIONS_CONVERTERS_LIBRARY_REPO_URL** — 您的 GitHub（或其他 Git）仓库 URL<br>
ㅤ**&#42; TB_INTEGRATIONS_CONVERTERS_LIBRARY_REPO_BRANCH** — ThingsBoard 拉取转换器的分支名（如 main、develop 或任意自定义分支）

![image](/images/user-guide/integrations/overview/terminal-custom-repo-converters-library.png)

配置后，ThingsBoard 将直接从您的自定义 Git 仓库拉取设备解码函数。
{% endif %}

## Debug mode

**Debug mode** 对开发和故障排查非常有用。
但长期开启会显著增加数据库占用的磁盘空间，因为所有调试数据都会写入数据库。
因此自 3.9 起，ThingsBoard 仅在前 15 分钟内保存全部调试事件，之后只保留失败事件。
这些设置可组合或完全关闭。

## 部署方式

ThingsBoard 集成有两种部署方式：嵌入式与远程。详见下方说明与架构图。

### 嵌入式集成

嵌入式集成运行在主 ThingsBoard 服务进程中，本质上属于单体部署。

优点：
* 部署新集成简便（在 ThingsBoard UI 中几步即可）；
* 消息交付延迟低；

缺点：
* 占用主 ThingsBoard 进程资源：网络连接、OS 线程、CPU；
* 隔离程度低；
* 若 ThingsBoard 部署在云端，无法访问本地 MQTT broker 或 OPC-UA 服务器。

<object width="100%" data="/images/user-guide/integrations/embeded-integrations-overview.svg"></object>

### 远程集成

自 ThingsBoard PE v2.4.1 起支持远程集成，支持新的部署模式。
可在本地网络安装远程集成，将数据流式传输到云。

假设您有本地部署的 MQTT broker 或 OPC-UA 服务器。
这些 broker 或服务器无独立公网 IP，云端 ThingsBoard 实例无法直接连接。
但可将远程集成安装在本地网络内、靠近该服务器。
该集成会连接 broker/服务器，拉取数据并存储在本地文件系统。
网络可用时，远程集成会将数据流式传输到云端的 ThingsBoard 实例。

优点：
* 支持与本地网络中的服务器集成；
* 将集成进程与主 ThingsBoard 进程隔离；

缺点：
* 需额外安装独立包；

按[本指南](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations){:target="_blank"}配置远程运行集成。

<object width="100%" data="/images/user-guide/integrations/remote-integrations-overview.svg"></object>

## 平台集成与 IoT Gateway

熟悉 ThingsBoard 的用户可能注意到，集成功能与 [IoT Gateway](/docs/iot-gateway/what-is-iot-gateway/){:target="_blank"} 有部分重叠。
但两者有重要差异：

  - IoT Gateway 面向本地网络部署，集成面向服务到服务集成。
  - IoT Gateway 面向 < 1000 设备规模，集成面向高吞吐、可扩展及作为 ThingsBoard 服务一部分的集群部署。
  - Gateway 添加自定义负载解码器需重新编译并重启，而 Integration Converter 是可在运行中修改的 JS 函数。 
  
两者都重要，适用于不同场景。

## 功能规划

### 使用统计
 
计划记录各集成处理的消息数量统计，并可设置租户/系统级别的处理量限制。

### 更多集成与协议

计划为不同平台及通信协议（如 gRPC）提供更多专门集成。

### 更多数据转换器

计划收集并维护市面主流设备的数据转换器，进一步简化集成。
您可将自己的转换器分享给社区或提交给我们，以便纳入官方发行版。   

[联系我们](/docs/contact-us/)为您的用例建议缺失功能。

## 另见

查看与具体集成相关的指南和视频教程：

 - [HTTP](/docs/{{peDocsPrefix}}user-guide/integrations/http/)
 - [MQTT](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/)
 - [AWS IoT](/docs/{{peDocsPrefix}}user-guide/integrations/aws-iot/)
 - [AWS Kinesis](/docs/{{peDocsPrefix}}user-guide/integrations/aws-kinesis/)
 - [IBM Watson IoT](/docs/{{peDocsPrefix}}user-guide/integrations/ibm-watson-iot/)
 - [Azure Event Hub](/docs/{{peDocsPrefix}}user-guide/integrations/azure-event-hub/)
 - [Azure IoT Hub](/docs/{{peDocsPrefix}}user-guide/integrations/azure-iot-hub/)
 - [Actility ThingPark](/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/)
 - [TheThingsIndustries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/)
 - [SigFox](/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/)
 - [OceanConnect](/docs/{{peDocsPrefix}}user-guide/integrations/ocean-connect/)
 - [TheThingsStack](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/)
 - [OPC-UA](/docs/{{peDocsPrefix}}user-guide/integrations/opc-ua/)
 - [TCP](/docs/{{peDocsPrefix}}user-guide/integrations/tcp/)
 - [UDP](/docs/{{peDocsPrefix}}user-guide/integrations/udp/)
 - [Custom](/docs/{{peDocsPrefix}}user-guide/integrations/custom/)
 - [LORIOT](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/)
 - [Kafka](/docs/{{peDocsPrefix}}user-guide/integrations/kafka/)
 - [ChirpStack](/docs/{{peDocsPrefix}}user-guide/integrations/chirpstack/)
 - [CoAP](/docs/{{peDocsPrefix}}user-guide/integrations/coap/)

## 视频教程

观看下方视频，了解如何分步配置上行数据转换器。

<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/CojStpYCTGI" frameborder="0" allowfullscreen></iframe>
    </div>
</div>


## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}




