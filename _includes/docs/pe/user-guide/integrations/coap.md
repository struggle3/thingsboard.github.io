{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

CoAP 集成用于从使用 CoAP 协议连接 ThingsBoard 的设备流式传输数据，并将这些设备的负载转换为 ThingsBoard 格式。

请参阅集成示意图了解更多。

![image](/images/user-guide/integrations/coap-integration.svg)

## 前置条件

本教程演示 CoAP 集成作为 **tb-core** 服务一部分、选择 **NO SECURE** 安全模式时的工作方式。我们将使用： 

{% if docsPrefix == "pe/" %}
- The instance of [ThingsBoard专业版](https://thingsboard.io/docs/user-guide/install/pe/installation-options/) installed locally;
{% endif %}
{% if docsPrefix contains "paas/" %}
- ThingsBoard Professional Edition instance — [{{hostName}}](https://{{hostName}});
{% endif %}

- [coap-client](https://manpages.ubuntu.com/manpages/focal/man5/coap-client.5.html) 工具，用于模拟连接 CoAP 集成的 CoAP 客户端；

{% if docsPrefix == "pe/" %}
假设我们有一台正在发送当前温度和湿度读数的传感器。传感器设备 **SN-001** 将温度和湿度读数发布到 CoAP 集成的 **coap://localhost** URL。
{% endif %}
{% if docsPrefix contains "paas/" %}
假设我们有一台正在发送当前温度和湿度读数的传感器。传感器设备 **SN-001** 将温度和湿度读数发布到 CoAP 集成的 **coap://int.{{hostName}}** URL。
{% endif %}

演示中假设我们的设备支持 3 种负载类型：
- **Text** — 负载格式为：

```text
SN-001,default,temperature,25.7,humidity,69
```

- **JSON** — 负载格式为：

```json
{
  "deviceName": "SN-001",
  "deviceType": "default",
  "temperature": 25.7,
  "humidity": 69
}
```

- **Binary** — 负载示例（十六进制字符串）：

```text
\x53\x4e\x2d\x30\x30\x31\x64\x65\x66\x61\x75\x6c\x74\x32\x35\x2e\x37\x36\x39
```

负载字节说明：
- **0-5** bytes - **\x53\x4e\x2d\x30\x30\x31** - device name. If we convert it to text - **SN-001**;
- **6-12** bytes - **\x64\x65\x66\x61\x75\x6c\x74** - device type. If we convert it to text - **default**;
- **13-16** bytes - **\x32\x35\x2e\x37** - temperature telemetry. If we convert it to text - **25.7**;
- **17-18** bytes - **\x36\x39** - humidity telemetry. If we convert it to text - **69**;

可根据设备能力和业务场景选择负载类型。

## 上行转换器

配置 **CoAP 集成**前，需创建 **Uplink Converter**，即用于将 CoAP 集成接收的数据解析并转换为 ThingsBoard 格式的脚本。**deviceName** 和 **deviceType** 为必填，attributes 和 telemetry 可选。attributes 和 telemetry 为扁平键值对象，不支持嵌套。

创建 **Uplink Converter**：进入 **Data Converters** 部分，点击 **Add new data converter —> Create new converter**。
命名为 **"CoAP Uplink Converter"**，选择类型 **Uplink**。暂时启用 debug mode。

{% assign feature = "integrations" %}{% include templates/debug-mode.md %}

**选择解码器配置使用的设备负载类型：**

- **Text payload**

{% include templates/tbel-vs-js.md %}

{% capture coapuplinktext %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/coap/coap-uplink-text-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/coap/coap-uplink-text-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="coapuplinktext" toggle-spec=coapuplinktext %}

- **JSON payload**

{% include templates/tbel-vs-js.md %}

{% capture coapuplinkjson %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/coap/coap-uplink-json-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/coap/coap-uplink-json-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="coapuplinkjson" toggle-spec=coapuplinkjson %}


- **Binary payload**

{% capture coapuplinkbinary %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/integration/coap/coap-uplink-binary-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/coap/coap-uplink-binary-java.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="coapuplinkbinary" toggle-spec=coapuplinkbinary %}

## CoAP 集成配置

{% include images-gallery.html imageCollection="coap-integration-setup" showListImageTitles="true" %}

### CoAP 集成配置项

CoAP 集成可配置安全模式：

- **NO SECURE(default mode)**
- **DTLS**
- **MIXED**

![image](/images/user-guide/integrations/coap/coap-integration-modes-1.png)

{% unless docsPrefix contains "paas/" %}


后两种类型在创建集成前，需在 .yml 中启用 DTLS 支持，或在 .conf 中覆盖下列环境变量：

```
# Enable/disable DTLS 1.2 support
export COAP_DTLS_ENABLED=true
# Default CoAP DTLS bind port
export COAP_DTLS_BIND_PORT=5484 
# Path to the key store that holds the SSL certificate
export COAP_DTLS_KEY_STORE=coapserver.jks 
# Password used to access the key store
export COAP_DTLS_KEY_STORE_PASSWORD=server_ks_password
# Password used to access the key
export COAP_DTLS_KEY_PASSWORD=server_key_password
# Key alias
export COAP_DTLS_KEY_ALIAS=serveralias
# Skip certificate validity check for client certificates
export TB_COAP_X509_DTLS_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT=false
```

注意，上述环境变量使用默认 DTLS 配置。要在 DTLS 模式下正确启动 CoAP 服务，需至少更新 key store 配置。详见 [CoAP over DTLS](/docs/{{docsPrefix}}user-guide/coap-over-dtls) 指南。

{% endunless %}

此外，CoAP 集成会根据 Base URL 路径及下列路径前缀自动生成 CoAP endpoint URL：
- **/i** - Integration resource in the CoAP server
- **/$INTEGRATION_ROUTING_KEY** — 自动生成的集成路由键

{% if docsPrefix != "pe/" %}

You can also update the CoAP endpoint URL by setting additional path prefixes in front of base URL:

![image](/images/user-guide/integrations/coap/coap-integration-configuration-extra-path-prefix-1-paas.png)

Each of the additional path prefixes will be added to the CoAP server as CoAP resources, where:
- **api** - parent resource
- **v2** - child resource of **api** resource and parent resource of integration resource **i**

{% endif %}

## 发送上行消息

CoAP 集成创建后，CoAP 服务会注册相应资源并等待设备数据。

选择设备负载类型以发送上行消息

{% capture senduplink %}
Text payload<br>%,%text%,%templates/integration/coap/coap-send-uplink-text.md%br%
JSON payload<br>%,%json%,%templates/integration/coap/coap-send-uplink-json.md%br%
Binary payload<br>%,%binary%,%templates/integration/coap/coap-send-uplink-binary.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="coapintegrationsenduplink" toggle-spec=senduplink %}

命令执行后，进入 **Device groups** -> **All**，应能看到由集成配置的 **SN-001** 设备。 
Click on the device, go to the **Latest Telemetry** tab to see the “temperature” key and its value (25.7) there and also the “humidity” key and its value (69) there as well.

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/coap/coap-integration-test-uplink-pe.png)
{% endif %}
{% if docsPrefix contains "paas/" %}
![image](/images/user-guide/integrations/coap/coap-integration-test-uplink-paas.png)
{% endif %}

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/guides-banner.md %}
