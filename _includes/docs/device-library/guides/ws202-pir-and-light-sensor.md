
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://www.milesight-iot.com/lorawan/sensor/ws202/" %}
{% assign thingsboardHost = "https://" | append: hostName %}
{% assign officialManualLink = "https://resource.milesight.com/milesight/iot/document/ws202-user-guide-en.pdf" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [WS202 PIR & Light Sensor 用户手册](' | append: officialManualLink | append: '){: target="_blank"}
- 支持NFC的智能手机及Milesight ToolBox应用（[Android](https://play.google.com/store/apps/details?id=com.ursalinknfc){: target="_blank"}/[iOS](https://itunes.apple.com/app/id1518748039){: target="_blank"}）
- LoRaWAN®网关（本例为 [UG56 LoRaWAN® Gateway](/device-library/pe/ug56-lorawan-gateway/){:target="_blank"}）
- 已在网络服务器与ThingsBoard上配置的集成
- [网络服务器账户](#设备连接)
'
 %}

## 概述

[WS202 PIR & Light Sensor]({{deviceVendorLink}}){: target="_blank"}是一款基于被动红外技术的PIR传感器，用于检测人体移动或占用。  
WS202可检测 6–8 m 范围内是否有移动。  
此外，WS202配备光照传感器，可将PIR检测结果与场景联动。  
WS202广泛适用于智能家居、智能办公、学校、仓库等场景。  
传感器数据通过标准LoRaWAN®协议实时传输。  
LoRaWAN®支持远距离加密无线传输且功耗极低。  

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}
<br>

## 前置条件

继续本指南前，需准备以下内容：  
{{ prerequisites }}
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}



## 设备连接

根据[官方用户手册]({{officialManualLink}}){: target="_blank"}，需使用支持NFC的智能手机及ToolBox应用连接传感器。  
因本设备仅能通过LoRaWAN®网关工作，需先将其接入已与ThingsBoard配置集成的网络服务器。  
之后即可在ThingsBoard中完成设备配置。

{% if page.hasIntegrationDeviceConfiguration | downcase == "true"%}

{% assign articleFilename = page.name |  replace: ".md", "" %}
{% assign guideFilePath = "/docs/device-library/blocks/ready-to-go-devices/" | append: articleFilename | append: "-configuration-block.md" %}

{% include {{ guideFilePath }} %}

{% endif %}

配置设备时还需将其添加到网络服务器，请选择网关所连接的网络服务器：  

{% assign targetIntegrationTypes = '
ChirpStack,
TheThingsStack,
TheThingsIndustries,
Loriot
'%}

{% include /docs/device-library/blocks/basic/thingsboard-add-lorawan-device-through-integration-block.liquid target-integration-types=targetIntegrationTypes %}

{% include /docs/device-library/blocks/ready-to-go-devices/ws202-pir-and-light-sensor-check-data-block.md %}

## 总结

{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}
