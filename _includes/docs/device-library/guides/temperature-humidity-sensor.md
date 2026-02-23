{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: " to ThingsBoard?" %}
{% assign deviceVendorLink = "https://www.lansitec.com/products/lora-temperature-humidity-sensor/" %}
{% assign thingsboardHost = "https://" | append: hostName %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [LoRaWAN 网关](https://www.lansitec.com/products/outdoor-lorawan-gateway/){:target="_blank"}
- [Bluetooth Beacon](https://www.lansitec.com/products/bluetooth-beacon/){:target="_blank"}
- [网络服务器账户](https://www.chirpstack.io/){:target="_blank"}
'
%}

[温湿度传感器（Temperature & Humidity Sensor）]({{deviceVendorLink}}){:target="_blank"}基于先进LoRa调制设计，采用锂电池供电，可持续工作约 5 年，为多种应用提供高性价比的LoRaWAN终端设备。<br>
其IP65防护外壳与长续航带来低维护成本，适合户外使用。传感器工作模式可通过LoRaWAN网络调整。<br>
Lansitec传感器系列与LoRaWAN网络即插即用、完全兼容，也可与Lansitec无线数据传输单元配合实现低成本部署。

## 前置条件

继续本指南前，需准备以下内容：
{{prerequisites}}
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}


## 配置

仅当该设备通过MQTT直接与ThingsBoard通信时，需使用ThingsBoard Cloud。

使用ThingsBoard集成时，可使用本地部署的ThingsBoard PE或ThingsBoard Cloud。

若要与网络服务器创建集成，请先选择所支持的网络服务器之一：

{% assign targetIntegrationTypes = '
ChirpStack,
TheThingsStack,
TheThingsIndustries,
Loriot
' %}

{% include /docs/device-library/blocks/integrations/external-platforms/add-device-through-integration-with-external-converter.liquid target-integration-types=targetIntegrationTypes %}

{% include /docs/device-library/blocks/integrations/external-platforms/lansitec/check-data-on-thingsboard-block.md %}

{% include /docs/device-library/blocks/integrations/external-platforms/lansitec/conclusion-block.md %}
{% include add-device-banner.liquid %}
