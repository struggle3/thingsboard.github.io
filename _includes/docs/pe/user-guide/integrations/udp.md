{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

UDP集成可从采用UDP协议的设备向ThingsBoard流式传输数据，并将这些设备的负载转换为ThingsBoard格式。

{% capture difference %}
**请注意**：UDP集成只能以[远程集成](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations){:target="_blank"}方式启动。可在运行TB实例的同一台机器上启动，也可在能通过网络访问TB实例的另一台机器上启动。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

请参阅集成示意图了解更多。

![image](/images/user-guide/integrations/udp-integration.svg)

## 前置条件

本教程将使用：

{% if docsPrefix == "pe/" %}
- 本地安装的[ThingsBoard专业版](https://thingsboard.io/docs/user-guide/install/pe/installation-options/){:target="_blank"}实例；
- 在外部运行且已连接ThingsBoard PE实例的UDP集成；
{% endif %}
{% if docsPrefix contains "paas/" %}
- ThingsBoard Professional Edition实例 — [{{hostName}}](https://{{hostName}}){:target="_blank"};
- 在外部运行且已连接ThingsBoard Cloud的UDP集成；
{% endif %}
- **echo**命令，用于显示一行文本并将其输出重定向到**netcat**（**nc**）工具；
- **netcat**（**nc**）工具，用于建立UDP连接、接收数据并传输；

假设我们有一台正在发送当前温度和湿度读数的传感器。
传感器**SN-001**将数据发送到运行UDP集成的机器的**11560**端口。

为便于演示，我们假设设备能够以4种不同负载类型发送数据。
可根据设备能力和业务场景选择负载类型：
 
{% capture fourpayloadtypes %}
Text payload<br>%,%text%,%templates/integration/udp/text-payload-type.md%br%
JSON payload<br>%,%json%,%templates/integration/udp/json-payload-type.md%br%
Binary payload<br>%,%binary%,%templates/integration/udp/binary-payload-type.md%br%
Hex payload<br>%,%hex%,%templates/integration/udp/hex-payload-type.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="fourpayloadtypes" toggle-spec=fourpayloadtypes %}

{% capture difference %}
**请注意**
<br>
在运行UDP集成的机器上，必须开放**11560**端口以接收入站连接——**nc**工具需能连接到UDP socket。若在本地运行，一般无需额外修改。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 添加UDP集成

**1. 基本设置**

进入「**Integrations center**」的「**Integrations**」页面，点击「plus」按钮开始添加新集成。选择「**UDP**」类型并点击「**Next**」；

![image](/images/user-guide/integrations/udp/udp-integration-setup-1-pe.png)

<br>
**2. 上行数据转换器**

上行转换器是用于解析并将UDP集成接收的数据转换为ThingsBoard格式的脚本。
**deviceName**和**deviceType**为必填，attributes和telemetry为可选。attributes和telemetry为扁平键值对象，不支持嵌套对象。

**选择设备负载类型以配置解码器：**

{% capture uplinkdecoderconfiguration %}
Text payload<br>%,%text%,%templates/integration/udp/uplink-decoder-text-payload.md%br%
JSON payload<br>%,%json%,%templates/integration/udp/uplink-decoder-json-payload.md%br%
Binary payload<br>%,%binary%,%templates/integration/udp/uplink-decoder-binary-payload.md%br%
Hex payload<br>%,%hex%,%templates/integration/udp/uplink-decoder-hex-payload.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="uplinkdecoderconfiguration" toggle-spec=uplinkdecoderconfiguration %}

**3. 下行数据转换器**

在添加下行转换器步骤，可选择已有或新建下行转换器。此处保持「**Downlink data converter**」为空。点击「**Skip**」；

![image](/images/user-guide/integrations/udp/udp-integration-setup-3-pe.png)

<br>
**4. 连接**

如前所述，「**Execute remotely**」选项已勾选且不可修改——UDP集成只能为remote类型。

默认情况下UDP集成使用**11560**端口，您可根据需要改为任意可用端口。

请记录**Integration key**和**Integration secret**——后续在远程UDP集成配置中将使用这些值。

**Enable broadcast - integration will accepts broadcast address packets**选项保持默认。该标识表示集成将接受发往广播地址的UDP包。

<br>
选择**Handler Configuration**的设备负载类型：

{% capture handlerconfiguration %}
Text payload<br>%,%text%,%templates/integration/udp/udp-handler-configuration-text.md%br%
JSON payload<br>%,%json%,%templates/integration/udp/udp-handler-configuration-json.md%br%
Binary payload<br>%,%binary%,%templates/integration/udp/udp-handler-configuration-binary.md%br%
Hex payload<br>%,%hex%,%templates/integration/udp/udp-handler-configuration-hex.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="udpintegrationhandlerconfiguration" toggle-spec=handlerconfiguration %}

## 安装并运行外部UDP集成

请参阅[远程集成指南](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations){:target="_blank"}，在本地或单独机器上安装UDP集成服务。

使用上文中的**Integration key**和**Integration secret**配置您的UDP集成。

## 发送上行消息

创建ThingsBoard UDP集成后，UDP服务启动并等待设备数据。

选择设备负载类型以发送上行消息：

{% capture senduplink %}
Text payload<br>%,%text%,%templates/integration/udp/udp-send-uplink-text.md%br%
JSON payload<br>%,%json%,%templates/integration/udp/udp-send-uplink-json.md%br%
Binary payload<br>%,%binary%,%templates/integration/udp/udp-send-uplink-binary.md%br%
Hex payload<br>%,%hex%,%templates/integration/udp/udp-send-uplink-hex.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="udpintegrationsenduplink" toggle-spec=senduplink %}

进入「**Devices**」页面，应能看到由UDP集成配置的**SN-001**设备。
点击设备，进入「**Latest telemetry**」标签可查看「temperature」键及其值(25.7)以及「humidity」键及其值(69)。

![image](/images/user-guide/integrations/udp/udp-integration-add-device-pe.png)

## 高级用法：下行

要从ThingsBoard向设备发送下行消息，需定义下行转换器。

### 添加下行转换器

{% include templates/tbel-vs-js.md %}

{% capture udpdownlink %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/udp/udp-downlink-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/udp/udp-downlink-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="udpdownlink" toggle-spec=udpdownlink %}

将下行数据转换器添加到UDP集成的步骤：

{% assign udpAddDownlinkConverter = '
  ===
    image: /images/user-guide/integrations/udp/udp-add-downlink-converter-tbel-1-pe.png,
    title: 进入「**Integrations**」页面，点击UDP集成打开详情，点击「pencil」图标进入编辑模式；
  ===
    image: /images/user-guide/integrations/udp/udp-add-downlink-converter-tbel-2-pe.png,
    title: 输入下行数据转换器名称并点击「**Create new converter**」；
  ===
    image: /images/user-guide/integrations/udp/udp-add-downlink-converter-tbel-3-pe.png,
    title: 将脚本粘贴到encoder function区域，点击「Add」；
  ===
    image: /images/user-guide/integrations/udp/udp-add-downlink-converter-tbel-4-pe.png,
    title: 应用更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=udpAddDownlinkConverter %}

{% capture difference %}
可选配置**Cache Size**和**Cache time to live in minutes**——用于在存储连接时避免内存泄漏（仅UDP下行支持）。<br>
**Cache Size** — UDP客户端消息的最大数量。<br>
**Cache time to live in minutes** — 消息存储时长（分钟）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 修改Root Rule Chain

集成配置就绪后，需进入「Rule Chains」页面并配置「**Root Rule Chain**」，使「**Attributes updated**」和「**Post attributes**」消息转发到下行数据转换器：

{% assign ruleChainDownlink = '
  ===
    image: /images/user-guide/integrations/udp/rule-chain-downlink-1-pe.png,
    title: 在Root Rule Chain编辑器中找到「**integration downlink**」节点并拖入规则链；
  ===
    image: /images/user-guide/integrations/udp/rule-chain-downlink-2-pe.png,
    title: 命名为「**UDP Downlink**」，指定「**UDP integration**」，点击「Add」；
  ===
    image: /images/user-guide/integrations/udp/rule-chain-downlink-3-pe.png,
    title: 从「message type switch」节点拖拽连线到「UDP integration」节点，标签为「**Attributes updated**」和「**Post attributes**」。保存所有更改；
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=ruleChainDownlink %}

### 测试下行

要测试下行，请在设备上创建**shared attribute**：

{% assign ruleChainDownlink = '
    ===
        image: /images/user-guide/integrations/udp/udp-add-shared-attribute-1-pe.png,
        title: 进入「**Devices**」页面。点击设备，进入「**Attributes**」标签。选择「**Shared attributes**」，点击「**plus**」图标；
    ===
        image: /images/user-guide/integrations/udp/udp-add-shared-attribute-2-pe.png,
        title: 输入属性名及其值（例如键名为「**firmware**」、值为「**v1.1**」）并点击「Save」；
    ===
        image: /images/user-guide/integrations/udp/udp-add-shared-attribute-3-pe.png,
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=ruleChainDownlink %}

要接收下行消息，需设置响应超时`-w10`（该选项决定等待响应的时长）并再次发送上行消息：

```shell
echo -e 'SN-001,default,temperature,25.7,humidity,69' | nc -w10 -u 127.0.0.1 11560
```
{: .copy-code}

终端中应能看到ThingsBoard的如下响应：

![image](/images/user-guide/integrations/udp/terminal-add-attribute.png)

{% capture difference %}
**注意**
<br>
使用UDP集成且连接建立较长时间时，您将只收到一条下行消息。其余消息将保存在服务端，并在下次上行时发送。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/guides-banner.md %}