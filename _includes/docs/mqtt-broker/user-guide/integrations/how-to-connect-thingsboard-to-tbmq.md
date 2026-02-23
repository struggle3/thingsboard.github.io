{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

本指南介绍如何使用 MQTT 集成将 TBMQ 与 ThingsBoard 连接。
我们使用类型为 **APPLICATION** 的 TBMQ 客户端凭据，将 ThingsBoard 集成作为 APPLICATION 客户端连接。
APPLICATION 客户端专注于订阅高消息率的主题。
客户端离线时消息将持久化，上线后投递，确保关键数据可用。
有关 APPLICATION 客户端的更多信息请参阅[此处](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/)。

ThingsBoard MQTT 集成充当 MQTT 客户端。它订阅主题并将接收的数据转换为遥测和属性更新。
对于下行消息，MQTT 集成将其转换为设备适用的格式并推送到 TBMQ。
注意：TBMQ 应与 ThingsBoard 实例同地部署，或在云端部署并具有有效 DNS 名称或公网静态 IP。
部署在云端的 ThingsBoard 实例无法连接到部署在无互联网连接的本地网络中的 TBMQ。

## 前提条件

本教程使用：

 - **本地**安装的 [ThingsBoard专业版](/docs/user-guide/install/pe/installation-options/) 实例；
 - **本地**安装的 [TBMQ](/docs/{{docsPrefix}}mqtt-broker/install/installation-options/)，且 ThingsBoard PE 实例可访问；
 - 用于发送消息的 mosquitto_pub MQTT 客户端。

## TBMQ 配置

首先，需创建 TBMQ 客户端凭据，用于将 ThingsBoard 集成连接到 TBMQ。

为此，登录 TBMQ 用户界面并按以下步骤操作。

{% include images-gallery.html imageCollection="create-client-credentials" showListImageTitles="true" %}

{% capture difference %}
**请注意**：
<br>
必须[启用](/docs/{{docsPrefix}}mqtt-broker/security/authentication/basic/) Basic 认证。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

现在可继续下一步：配置 ThingsBoard 集成。

## ThingsBoard 配置

本示例使用 MQTT 集成将 ThingsBoard 连接到 TBMQ。
配置 MQTT 集成前，需创建 uplink converter。

### Uplink Converter

解码函数的目的是将入站数据和元数据解析为 ThingsBoard 可消费的格式。

创建 uplink converter：进入 "Integrations center" 部分 -> "Data converters" 页面，点击 "plus" 图标。命名为 "TBMQ Uplink Converter" 并选择类型 "Uplink"。将下方解码脚本粘贴到 decoder functions 部分。点击 "Add"。

{% include images-gallery.html imageCollection="create-uplink-converter" %}

本示例中，decoder function 部分使用以下脚本：

{% include templates/tbel-vs-js.md %}

{% capture mqttuplinkconverterconfig %}
TBEL<small>Recommended</small>%,%accessToken%,%templates/mqtt-broker/user-guide/integrations/mqtt/tbmq-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/mqtt-broker/user-guide/integrations/mqtt/tbmq-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="mqttuplinkconverterconfig" toggle-spec=mqttuplinkconverterconfig %}

### MQTT Integration Setup

现在创建集成。

{% include images-gallery.html imageCollection="create-integration" showListImageTitles="true" %}

然后在 TBMQ UI 中进入 "Sessions" 页面。ThingsBoard 与 TBMQ 成功建立连接后，我们将看到新会话及其状态 "Connected"。

{% include images-gallery.html imageCollection="successful-connection-tbmq-to-thingsboard" %}

在 "Kafka Management" 菜单的 "Topics" 页面，可看到 Kafka topic 名称（对应 MQTT 集成中指定的 client ID）、分区数、副本因子和 topic 大小。

{% include images-gallery.html imageCollection="tbmq-home-page" %}

### 发送 Uplink 消息

现在模拟设备向 TBMQ 发送温度读数。

打开终端并执行以下命令，以简单格式 *`{"value":25.1}`* 向主题 "tb/mqtt-integration-tutorial/sensors/SN-001/temperature" 发送包含温度读数的消息：

```shell
mosquitto_pub -h $THINGSBOARD_MQTT_BROKER_HOST_NAME -p 1883 -q 1 -t "tb/mqtt-integration-tutorial/sensors/SN-001/temperature" -m '{"value":25.1}' -u "username" -P "password"
```
{: .copy-code}

将 `$THINGSBOARD_MQTT_BROKER_HOST_NAME` 替换为 broker 的正确公网 IP 或 DNS 名称，`username` 和 `password` 替换为已配置凭据中的值。

本示例使用以下命令：

```shell
mosquitto_pub -h localhost -p 1883 -q 1 -t "tb/mqtt-integration-tutorial/sensors/SN-001/temperature" -m '{"value":25.1}' -u "tb-pe" -P "secret"
```
{: .copy-code}

![image](/images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-uplink-message-1.png)

发送 uplink 消息后，在 ThingsBoard UI 中进入集成并打开 "Events" 选项卡。此处可看到 "MQTT Integration" 消费的消息。

{% include images-gallery.html imageCollection="tbmq-integration-events" %}

进入 "Entities" 部分 -> "Devices" 页面。可找到由集成预置的 SN-001 设备。
点击设备，进入 "Latest Telemetry" 选项卡查看 "temperature" 键及其值（25.1）。

{% include images-gallery.html imageCollection="tbmq-create-device" %}

## Next steps

{% assign currentGuide = "TBIntegrationGuide" %}{% include templates/mqtt-broker-guides-banner.md %}
