要向 **DHT22** 传感器上传温度遥测，需先获取 **DHT22** 传感器的凭证。
ThingsBoard 支持多种设备凭证。本指南建议使用默认自动生成的凭证，即访问令牌。

请使用 URL **EDGE_URL** 打开 ThingsBoard **Edge** UI。

{% include images-gallery.html imageCollection="copyAccessTokenDht22" showListImageTitles="true" %}

现在可以代表设备发布温度遥测数据。
本示例将使用简单命令通过 HTTP 或 MQTT 发布温度数据。

{% capture connectdevicetogglespec %}
HTTP<small>Linux、macOS 或 Windows</small>%,%http%,%templates/edge/getting-started/http.md%br%
MQTT<small>Linux 或 macOS</small>%,%mqtt-linux%,%templates/edge/getting-started/mqtt-linux.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/edge/getting-started/mqtt-windows.md%br%
CoAP<small>Linux 或 macOS</small>%,%coap%,%templates/edge/getting-started/coap.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec %}

成功发布温度为 **51** 的「temperature」读数后：

{% capture connectdevicetogglespec2 %}
HTTP<small>Linux、macOS 或 Windows</small>%,%http%,%templates/edge/use-cases/manage-alarms/http-above-threshold.md%br%
MQTT<small>Linux 或 macOS</small>%,%mqtt-linux%,%templates/edge/use-cases/manage-alarms/mqtt-linux-above-threshold.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/edge/use-cases/manage-alarms/mqtt-windows-above-threshold.md%br%
CoAP<small>Linux 或 macOS</small>%,%coap%,%templates/edge/use-cases/manage-alarms/coap-above-threshold.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec2 %}

您应能在设备告警选项卡中立即看到告警：

{% include images-gallery.html imageCollection="deviceAlarmTab" showListImageTitles="true" %}
