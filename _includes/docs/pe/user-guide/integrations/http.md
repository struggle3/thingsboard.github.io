{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

HTTP 集成可将现有协议和负载格式转换为 ThingsBoard 消息格式，适用于多种部署场景： 

 - 从外部系统、IoT平台或连接提供商后端流式传输设备和/或资产数据。
 - 从云上运行的自定义应用流式传输设备和/或资产数据。
 - 将采用自定义基于HTTP协议的现有设备连接至ThingsBoard。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/http-integration.svg"></object>

## 创建上行转换器

创建集成前，需在 Data converters 中创建上行转换器。上行转换器用于将设备入站数据转换为 ThingsBoard 展示所需的格式。 
Click on the “plus” and on “Create new converter”. To view the events, enable Debug. 
In the function decoder field, specify a script to parse and transform data.

{% assign feature = "integrations" %}{% include templates/debug-mode.md %}

{% include templates/tbel-vs-js.md %}

{% capture httpuplinkconverterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/http/http-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/http/http-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="httpuplinkconverterconfig" toggle-spec=httpuplinkconverterconfig %}

上行转换器创建完成后即可创建集成。

## 创建集成

- 进入「**Integrations center**」->「**Integrations**」页面，点击「plus」创建新集成。命名为「**HTTP Integration**」，选择类型「**HTTP**」。点击「Next」；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-1-pe.png)
{% endif %}

- 在此步骤可选择已有或新建上行转换器。选择刚创建的「**HTTP Uplink Converter**」。点击「Next」；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-2-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-2-pe.png)
{% endif %}

- 在添加下行转换器步骤中，也可选择已有或新建下行转换器。此处保持「Downlink data converter」为空。点击「Skip」；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-3-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-3-pe.png)
{% endif %}

 - 在此步骤指定「**Base URL**」；

 - 记录「**HTTP endpoint URL**」，后续会用到；

 - 在「**Advanced settings**」中启用「**Replace response status from 'No-Content' to 'OK'**」；

 - 点击「Add」保存集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-integration-4-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/add-integration-4-pe.png)
{% endif %}

## 发送上行消息

发送上行消息需要用到之前从集成中复制的「**HTTP endpoint URL**」。

使用下列命令发送消息。请将 `$DEVICE_NAME`、`$DEVICE_TYPE` 和 `$YOUR_HTTP_ENDPOINT_URL` 替换为实际值。

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICE_NAME\",\"deviceType\":\"$DEVICE_TYPE\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json"
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-send-uplink-message-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/send-uplink-message-1-pe.png)
{% endif %}

<br>
进入 HTTP 集成的「**Events**」标签。若配置正确，应能看到一条状态为 'OK' 的事件。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-send-uplink-message-3-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/send-uplink-message-3-pe.png)
{% endif %}

{% if docsPrefix == "pe/" %}
<br>
发送消息后，新设备已被创建。您会收到相关通知。点击右上角铃铛图标查看通知。 
通知中有操作按钮，点击可进入新设备详情。

![image](/images/user-guide/integrations/http/http-device-2-pe.png)

<br>
此处可看到新设备信息以及我们从设备发送到 ThingsBoard 的遥测数据。

![image](/images/user-guide/integrations/http/http-device-1-pe.png)

<br>
了解**通知**及如何配置，请参阅[此处](/docs/{{docsPrefix}}user-guide/notifications/)。

{% endif %}

{% if docsPrefix contains "paas/" %}
<br>
所创建设备及数据可在「**Device groups**」->「**All**」中查看。

![image](/images/user-guide/integrations/http/device-1-pe.png)

{% endif %}

{% capture difference %}
**注意**
<br>
若未勾选「Allow create devices or assets」，发送包含设备（或资产）参数的消息到 ThingsBoard 时，若该设备（资产）不存在，则不会创建设备（资产）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

发送和接收的数据也可在上行转换器中查看，位于「**Events**」标签的「In」和「Out」块。

{% include images-gallery.html imageCollection="send-uplink-1" %}

<br>
使用[Dashboards](/docs/{{docsPrefix}}user-guide/dashboards/)处理数据。仪表板是收集和展示数据集的现代化形式，通过各种部件呈现数据。  
ThingsBoard 提供多种仪表板示例。了解更多**Solution templates**请参阅[此处](/docs/{{docsPrefix}}solution-templates/overview/)。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-solution-templates.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/solution-templates.png)
{% endif %}

### 启用安全选项

如需，可指定额外参数，缺少这些参数的数据将不会被纳入集成。
勾选 Enable security，点击 Headers filter，填写任意值并保存。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-enable-security-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/security-1-pe.png)
{% endif %}

Headers filter 配置后，上行消息中需加入如下头：

```ruby
-H "test-header:secret"
```

使用下列命令发送启用安全选项的消息。请将 `$DEVICE_NAME`、`$DEVICE_TYPE`、`$YOUR_HTTP_ENDPOINT_URL` 和 `$VALUE` 替换为实际值。

```ruby
curl -v -X POST -d "{\"deviceName\":\"$DEVICE_NAME\",\"deviceType\":\"$DEVICE_TYPE\",\"temperature\":33,\"model\":\"test\"}" $YOUR_HTTP_ENDPOINT_URL -H "Content-Type:application/json" -H "$VALUE"
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-enable-security-2-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/security-2-pe.png)
{% endif %}

## 下行转换器

在「**Data converters**」页面创建下行转换器。要查看事件请启用「Debug mode」。

{% include templates/tbel-vs-js.md %}

{% capture httpdownlinkconverterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/http/http-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/http/http-downlink-converter-config-javascript.md{% endcapture %}
{% include content-toggle.html content-toggle-id="httpdownlinkconverterconfig" toggle-spec=httpdownlinkconverterconfig %}

接下来需将刚创建的下行转换器添加到集成。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-add-downlink-converter-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/http-add-downlink-converter-1-pe.png)
{% endif %}

<br>
要通过集成发送下行，需修改「**Root Rule chain**」：

- 进入「**Rule chains**」页面，点击「**Root Rule Chain**」打开；
- 创建「**integration downlink**」节点，在其设置中指定您的集成；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-downlink-rule-chain-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-rule-chain-1-pe.png)
{% endif %}

- 将「**message type switch**」节点的「**Attributes updated**」和「**Post attributes**」连线到「**integration downlink**」节点。应用更改。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-downlink-rule-chain-2-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-rule-chain-2-pe.png)
{% endif %}

<br>
创建属性或修改属性时，下行消息将被发送到集成。

示例：进入「**Devices**」页面，选择设备，进入「**Attributes**」标签。选择 **Shared attributes**，点击「plus」创建新属性。
设置属性名和值（例如键名为 'firmware'，值为 '01052020.v1.1'）并保存。

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/http/http-downlink-add-attribute-1-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/http/downlink-add-attribute-1-pe.png)
{% endif %}

<br>
再次发送上行消息。终端中会收到 ThingsBoard 的响应：

{% include images-gallery.html imageCollection="downlink-terminal" %}

接收和发送的数据可在下行转换器查看。Events 标签的「In」块显示入站数据，「Out」字段显示发给设备的消息：

{% include images-gallery.html imageCollection="downlink-message" %}


## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
