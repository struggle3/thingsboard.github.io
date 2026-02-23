* TOC
{:toc}

## 概述

在 ThingsBoard 中，**设备属性**是与设备关联的键值对。用于存储配置设置、元数据或其他相关信息。

订阅设备属性使客户端能够在这些属性变更时收到更新。订阅方法因属性类型和使用的通信协议而异。

属性分为三种类型：
* **Server-side Attributes（服务器端属性）：** 仅由服务器设置和使用。可通过 User Interface (UI) 或 REST API 配置。
* **Shared Attributes（共享属性）：** 设备可订阅更新以在服务器修改时接收实时通知。可通过 UI 或 REST API 配置。
* **Client-side Attributes（客户端属性）：** 由设备设置并存储在服务器上。只能通过 UI 或 REST API 读取。

更多详细信息和示例，请参阅 ThingsBoard 文档 [Working with IoT Device Attributes](/docs/{{peDocsPrefix}}user-guide/attributes/){: target="_blank"}。

以下指南说明设备与 **ThingsBoard Cloud** 之间经由 **ThingsBoard Edge** 的实时双向通信。

## 前置条件

* **ThingsBoard Cloud** 或本地托管 [Server](/docs/{{peDocsPrefix}}user-guide/install/installation-options/){: target="_blank"}。
* 已安装 **ThingsBoard Edge** 且具备网络访问。
* 能够通过 [MQTT](/docs/{{peDocsPrefix}}reference/mqtt-api/){: target="_blank"}、[HTTP](/docs/{{peDocsPrefix}}reference/http-api/){: target="_blank"} 或 [CoAP](/docs/{{peDocsPrefix}}reference/coap-api/){: target="_blank"} 连接到 **ThingsBoard Edge** 的 **Device**。

## 步骤 1. 为 Edge 配置规则链

要自动将消息（数据或属性）从设备路由到 **ThingsBoard Cloud**，请为 **ThingsBoard Edge** 配置规则链：

{% include images-gallery.html imageCollection="routeMessagesToCloud" showListImageTitles="true" %}

## 步骤 2. 为 Cloud 配置规则链

要将某些属性更新消息发回 Edge，请修改 Cloud 的 root 规则链。属性更新消息到达 Edge 后，您应在设备上看到该消息。

{% include images-gallery.html imageCollection="backToEdge" showListImageTitles="true" %}

要重写并返回接收到的数据到 Edge，请在 **"script"** 节点中添加以下脚本：
```bash
// POST PROCESSING LOGIC
msg = {"attribute1_result": "value1_result"};
metadata = {};

return {msg: msg, metadata: metadata, msgType: msgType};
```
{: .copy-code}

## 步骤 3. 订阅设备属性变更并发布设备属性消息

**设备属性变更** 的订阅及随后 **设备属性消息** 的发布流程取决于使用的协议。以下是物联网应用中遥测和属性更新的常用协议：

{% capture  deviceConnectivityAPI %}
MQTT%,%MQTT%,%/templates/edge/user-guide/mqtt-subscribe-to-attribute.md%br%
HTTP%,%HTTP%,%/templates/edge/user-guide/http-subscribe-to-attribute.md%br%
CoAP%,%CoAP%,%/templates/edge/user-guide/coap-subscribe-to-attribute.md%br%{% endcapture %}
{% include content-toggle.liquid content-toggle-id="deviceConnectivityAPI" toggle-spec=deviceConnectivityAPI %}

## 步骤 4. 确认结果

确认收到并推送的属性：
{% include images-gallery.html imageCollection="terminal" showListImageTitles="true" %}
{% include images-gallery.html imageCollection="checkResultOnDevice" showListImageTitles="true" %}
{% include images-gallery.html imageCollection="checkResultOnEdge" showListImageTitles="true" %}
{% include images-gallery.html imageCollection="checkResultOnCloud" showListImageTitles="true" %}


## 下一步

{% include templates/edge/guides-banner-edge.md %}
