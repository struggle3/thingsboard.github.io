{% capture connectivityContent %}
ThingsBoard 提供多种设备连接方式。下图旨在直观呈现现有选项，帮助您为设备选择合适方案。
若通过图表仍无法确定设备连接方式或有任何疑问，请[联系我们](/docs/contact-us/)，以帮助我们改进本指南。
{% endcapture %}
{% include templates/info-banner.md content=connectivityContent %}

{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% if docsPrefix == 'pe/' %}
  <object width="100%" style="max-width: max-content;" data="/images/connectivity-pe.svg">设备连接决策树。若设备支持 IP 且可自定义固件，可根据协议使用 MQTT、HTTP、CoAP、Sparkplug 或 MQTT Gateway 原生 ThingsBoard API。若已连接 Azure、AWS、IBM Watson 或 OPC-UA 等后端，使用相应集成。LoRaWAN、SigFox、NB-IoT、SMS 等非 IP 设备或 OPC-UA、Modbus、BLE、CAN、REST、SNMP 等工业协议可通过 IoT Gateway 连接。其他协议请使用「联系我们」表单。</object>
{% elsif docsPrefix == 'paas/' %}
  <object width="100%" style="max-width: max-content;" data="/images/connectivity-paas.svg">设备连接决策树。若设备支持 IP 且可自定义固件，可根据协议使用 MQTT、HTTP、CoAP、Sparkplug 或 MQTT Gateway 原生 ThingsBoard API。若已连接 Azure、AWS、IBM Watson 或 OPC-UA 等后端，使用相应集成。LoRaWAN、SigFox、NB-IoT、SMS 等非 IP 设备或 OPC-UA、Modbus、BLE、CAN、REST、SNMP 等工业协议可通过 IoT Gateway 连接。其他协议请使用「联系我们」表单。</object>
{% elsif docsPrefix == 'paas/eu/' %}
  <object width="100%" style="max-width: max-content;" data="/images/connectivity-paas-eu.svg">设备连接决策树。若设备支持 IP 且可自定义固件，可根据协议使用 MQTT、HTTP、CoAP、Sparkplug 或 MQTT Gateway 原生 ThingsBoard API。若已连接 Azure、AWS、IBM Watson 或 OPC-UA 等后端，使用相应集成。LoRaWAN、SigFox、NB-IoT、SMS 等非 IP 设备或 OPC-UA、Modbus、BLE、CAN、REST、SNMP 等工业协议可通过 IoT Gateway 连接。其他协议请使用「联系我们」表单。</object>
{% else %}
  <object width="100%" style="max-width: max-content;" data="/images/connectivity.svg">设备连接决策树。若设备支持 IP 且可自定义固件，可根据协议使用 MQTT、HTTP、CoAP、Sparkplug 或 MQTT Gateway 原生 ThingsBoard API。若已连接 Azure、AWS、IBM Watson 或 OPC-UA 等后端，使用相应集成。LoRaWAN、SigFox、NB-IoT、SMS 等非 IP 设备或 OPC-UA、Modbus、BLE、CAN、REST、SNMP 等工业协议可通过 IoT Gateway 连接。其他协议请使用「联系我们」表单。</object>
{% endif %}


## 连接常见设备

您可查看[设备库](/docs/{{docsPrefix}}device-library)了解如何将常用设备连接至 ThingsBoard。

## 内置传输协议

内置传输协议实现适用于使用这些协议通信、并能直接连接 ThingsBoard 的设备。

- [MQTT API 参考](/docs/{{docsPrefix}}reference/mqtt-api)
- [MQTT Sparkplug API 参考](/docs/{{docsPrefix}}reference/mqtt-sparkplug-api)
- [CoAP API 参考](/docs/{{docsPrefix}}reference/coap-api)
- [HTTP API 参考](/docs/{{docsPrefix}}reference/http-api)
- [LwM2M API 参考](/docs/{{docsPrefix}}reference/lwm2m-api)
- [SNMP API 参考](/docs/{{docsPrefix}}reference/snmp-api)

以上大部分协议支持 JSON、Protobuf 或自有数据格式。在可控制固件的情况下，这是新设备的最佳选择。

## IoT Gateway

ThingsBoard IoT Gateway 可将位于局域网、无法访问互联网或使用特定非 IP 协议的设备连接至平台。
IoT Gateway 支持 MQTT、OPC-UA、Modbus、BLE、HTTP、CAN、BACnet、ODBC、SNMP 等协议。
网关将设备数据转换为 ThingsBoard 内部格式，并通过 MQTT 上传至平台。
更多信息请参阅[什么是 IoT Gateway？](/docs/iot-gateway/what-is-iot-gateway/)。

## LoRaWAN

可通过本[指南](https://www.chirpstack.io/application-server/integrations/thingsboard/)将 ChirpStack 网络服务器与 ThingsBoard社区版集成。

[ThingsBoard PE](/products/thingsboard-pe/) 通过[集成](/docs/{{peDocsPrefix}}user-guide/integrations/)支持 ChirpStack 及多种其他网络服务器，
例如：[TheThingsStack](/docs/{{peDocsPrefix}}user-guide/integrations/ttn/)、[TheThingsIndustries](/docs/{{peDocsPrefix}}user-guide/integrations/tti/)、
[LORIOT](/docs/{{peDocsPrefix}}user-guide/integrations/loriot/)、[Actility ThingPark](/docs/{{peDocsPrefix}}user-guide/integrations/thingpark/) 或支持 [webhooks](/docs/{{peDocsPrefix}}user-guide/integrations/http/) 或 [mqtt](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/) 的其他网络服务器。
ThingsBoard PE 集成的显著优势在于可定义自定义[数据转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#data-converters)函数。

## Sigfox

[ThingsBoard PE](/products/thingsboard-pe/) 开箱支持 Sigfox [集成](/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/)。

## NB IoT 及其他协议

[ThingsBoard PE](/products/thingsboard-pe/) 支持多种[集成](/docs/{{peDocsPrefix}}user-guide/integrations/)，覆盖市场上大部分设备。
如需帮助连接设备，请[联系我们](/docs/contact-us/)。
