{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

TCP集成可从采用TCP传输协议的设备向ThingsBoard流式传输数据，并将这些设备的负载转换为ThingsBoard格式。

{% capture difference %}
**请注意**：TCP集成只能以[远程集成](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations){:target="_blank"}方式启动。可在运行TB实例的同一台机器上启动，也可在能通过网络访问TB实例的另一台机器上启动。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

请参阅集成示意图了解更多。

![image](/images/user-guide/integrations/tcp-integration.svg)

## 前置条件

本教程将使用：

{% if docsPrefix == "pe/" %}
 - 本地安装的[ThingsBoard专业版](https://thingsboard.io/docs/user-guide/install/pe/installation-options/){:target="_blank"}实例；
{% endif %}
{% if docsPrefix contains "paas/" %}
 - ThingsBoard Professional Edition实例 — [{{hostName}}](https://{{hostName}}){:target="_blank"};
{% endif %}
 - 在外部运行且已连接云端ThingsBoard PE实例的TCP集成；
 - **echo** 命令，用于显示一行文本并将其输出重定向到**netcat**（**nc**）工具；
 - **netcat**（**nc**）工具，用于建立TCP连接、接收数据并传输；

假设我们有一台正在发送当前温度和湿度读数的传感器。
传感器设备**SN-002**将其温度和湿度读数发布到运行TCP集成的机器的**10560**端口。

为便于演示，我们假设设备能够以3种不同负载类型发送数据：

可根据设备能力和业务场景选择负载类型：

{% capture threepayloadtypes %}
Text payload<br>%,%text%,%templates/integration/tcp/text-payload-type-tcp.md%br%
JSON payload<br>%,%json%,%templates/integration/tcp/json-payload-type-tcp.md%br%
Binary payload<br>%,%binary%,%templates/integration/tcp/binary-payload-type-tcp.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="threepayloadtypes" toggle-spec=threepayloadtypes %} 

{% capture difference %}
**请注意**
<br>
在运行TCP集成的机器上，必须开放**10560**端口以接收入站连接——**nc**工具需能连接到TCP socket。若在本地运行，一般无需额外修改。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 添加TCP集成

**1. 基本设置**

进入「**Integrations center**」的「**Integrations**」页面，点击「plus」按钮开始添加新集成。选择「**TCP**」类型并点击「**Next**」；

![image](/images/user-guide/integrations/tcp/tcp-integration-setup-1-pe.png)

<br>
**2. 上行数据转换器**

上行转换器是用于解析并将TCP集成接收的数据转换为ThingsBoard可消费格式的脚本。
**deviceName**和**deviceType**为必填，**attributes**和**telemetry**为可选。**attributes**和**telemetry**为扁平键值对象，不支持嵌套对象。

选择设备负载类型以配置解码器：

{% capture tcpuplinkdecoderconfiguration %}
Text payload<br>%,%text%,%templates/integration/tcp/uplink-decoder-text-payload-tcp.md%br%
JSON payload<br>%,%json%,%templates/integration/tcp/uplink-decoder-json-payload-tcp.md%br%
Binary payload<br>%,%binary%,%templates/integration/tcp/uplink-decoder-binary-payload-tcp.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="tcpuplinkdecoderconfiguration" toggle-spec=tcpuplinkdecoderconfiguration %}

{% capture difference %}
**注意**
<br>
尽管Debug mode对开发和故障排查很有用，但在生产模式下长期启用会大幅增加数据库占用的磁盘空间，因所有调试数据都会存储其中。强烈建议调试完成后关闭Debug mode。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**3. 下行数据转换器**

在添加下行转换器步骤，可选择已有或新建下行转换器。此处保持「**Downlink data converter**」为空。点击「**Skip**」；

![image](/images/user-guide/integrations/tcp/tcp-integration-setup-3-pe.png)

<br>
**4. 连接**

如前所述，「**Execute remotely**」选项已勾选且不可修改——TCP集成只能为**remote**类型。

默认情况下TCP集成使用**10560**端口，您可根据需要改为任意可用端口。

请记录**Integration key**和**Integration secret**——后续在远程TCP集成配置中将使用这些值。

选择**Handler Configuration**的设备负载类型

{% capture handlerconfiguration %}
Text payload<br>%,%text%,%templates/integration/tcp/tcp-handler-configuration-text.md%br%
JSON payload<br>%,%json%,%templates/integration/tcp/tcp-handler-configuration-json.md%br%
Binary payload<br>%,%binary%,%templates/integration/tcp/tcp-handler-configuration-binary.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="tcpintegrationhandlerconfiguration" toggle-spec=handlerconfiguration %}

其他选项保持默认，简要说明如下：
- **Max number of pending connects on the socket** — 入站连接请求队列的最大长度。若队列已满时收到连接请求，连接将被拒绝；
- **Size of the buffer for inbound socket** — socket数据接收缓冲区的KB大小；
- **Size of the buffer for outbound socket** — socket数据发送缓冲区的KB大小；
- **Enable sending of keep-alive messages on connection-oriented sockets** — 标识是否定期向对端socket发送探测以保持连接存活；
- **Forces a socket to send the data without buffering (disable Nagle's buffering algorithm)** — 禁用socket上的Nagle算法，该算法会延迟发送直到累积一定数据量。

点击「**Add**」完成TCP集成添加。

## 安装并运行外部TCP集成

请参阅[远程集成指南](/docs/{{peDocsPrefix}}user-guide/integrations/remote-integrations){:target="_blank"}，在本地或单独机器上安装TCP集成服务。

请使用上文中的**Integration key**和**Integration secret**配置您的TCP集成。

## 发送上行消息

创建ThingsBoard TCP集成后，TCP服务启动并等待设备数据。

选择设备负载类型以发送上行消息

{% capture senduplink %}
Text payload<br>%,%text%,%templates/integration/tcp/tcp-send-uplink-text.md%br%
JSON payload<br>%,%json%,%templates/integration/tcp/tcp-send-uplink-json.md%br%
Binary payload<br>%,%binary%,%templates/integration/tcp/tcp-send-uplink-binary.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="tcpintegrationsenduplink" toggle-spec=senduplink %}

进入「**Devices**」页面，应能看到由TCP集成配置的**SN-002**设备。
点击设备，进入「**Latest telemetry**」标签可查看「**temperature**」键及其值(25.7)。

![image](/images/user-guide/integrations/tcp/tcp-integration-create-device-1-pe.png)

若负载包含「**humidity**」遥测，也应能看到「humidity」键及其值(69)。

## 高级用法：下行

要从ThingsBoard向设备发送下行消息，需定义下行转换器。

### 添加下行转换器

以下示例为发送属性更新消息。可使用我们的示例下行转换器，或根据您的配置自行编写。

{% include templates/tbel-vs-js.md %}

{% capture tcpdownlink %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/tcp/tcp-downlink-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/tcp/tcp-downlink-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="tcpdownlink" toggle-spec=tcpdownlink %}

将下行数据转换器添加到TCP集成的步骤：

{% assign tcpAddDownlinkConverter = '
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-downlink-converter-tbel-1-pe.png,
        title: 进入「**Integrations**」页面，点击TCP集成打开详情，点击「pencil」图标进入编辑模式；
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-downlink-converter-tbel-2-pe.png,
        title: 输入下行数据转换器名称并点击「**Create new converter**」；
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-downlink-converter-tbel-3-pe.png,
        title: 将脚本粘贴到encoder function区域，点击「Add」；
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-downlink-converter-tbel-4-pe.png,
        title: 应用更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=tcpAddDownlinkConverter %}

{% capture difference %}
可选配置**Cache Size**和**Cache time to live in minutes**——用于在存储连接时避免内存泄漏（仅TCP下行支持）。<br>
**Cache Size** — TCP客户端消息的最大数量。<br>
**Cache time to live in minutes** — 消息存储时长（分钟）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 修改Root Rule Chain

集成配置就绪后，需进入「Rule Chains」页面并配置「**Root Rule Chain**」，使「**Attributes updated**」消息转发到下行数据转换器。

{% assign tcpRuleChainDownlink = '
    ===
        image: /images/user-guide/integrations/tcp/tcp-rule-chain-downlink-pe.png,
        title: 打开「Root Rule Chain」，找到「**integration downlink**」节点并拖入规则链。命名为「**TCP integration downlink**」，指定**TCP integration**，点击「Add」；
    ===
        image: /images/user-guide/integrations/tcp/tcp-rule-chain-and-attributes-updated-pe.png,
        title: 此后，点击「**message type switch**」规则节点右侧灰色圆圈，拖拽到「**integration downlink**」左侧，选择**Attributes Updated**，点击「**Add**」并保存Root Rule Chain。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=tcpRuleChainDownlink %}

### 测试下行

要测试下行，请在设备上创建**shared attribute**：

{% assign testDownlink = '
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-shared-attribute-1-pe.png,
        title: 进入「**Devices**」页面。点击**SN-002**设备，进入「**Attributes**」标签。选择「**Shared attributes**」，点击「**plus**」图标；
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-shared-attribute-2-pe.png,
        title: 输入属性名及其值（例如键名为「**firmware**」、值为「**v1.1**」）并点击「Save」；
    ===
        image: /images/user-guide/integrations/tcp/tcp-add-shared-attribute-3-pe.png,
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=testDownlink %}

要接收下行消息，需设置响应超时`-w60`（该选项决定等待响应的时长）并再次发送上行消息：

```shell
echo -e 'SN-002,default,temperature,25.7\nSN-002,default,humidity,69' | nc -w60 127.0.0.1 11560
```
{: .copy-code}

终端中应能看到ThingsBoard的如下响应：

![image](/images/user-guide/integrations/tcp/tcp-terminal-send-downlink-message.png)

接收和发送的数据可在下行转换器中查看。在「**Events**」标签的「**In**」块中查看入站数据，「**Out**」字段显示发给设备的消息。

{% assign eventsTab = '
    ===
        image: /images/user-guide/integrations/tcp/tcp-downlink-converter-events-in-pe.png,
        title: 接收和发送的数据可在下行转换器中查看。在「**Events**」标签的「**In**」块中查看入站数据。
    ===
        image: /images/user-guide/integrations/tcp/tcp-downlink-converter-events-out-pe.png,
        title: 「**Out**」字段显示发给设备的消息。
'
%}

{% include images-gallery.liquid imageCollection=eventsTab %}

{% capture difference %}
**注意**
<br>
使用TCP集成且连接建立较长时间时，您将只收到一条下行消息。其余消息将保存在服务端，并在下次上行时发送。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}