{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://exxn.es/en/iot-gateway/" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- Device have to be connected to the Internet via Ethernet, Modem or WIFI. '
 %}

{% assign thingsboardInstanceLink = "https://" | append: hostName %}

## 概述
The EXXN IoT Gateway is a versatile device with an ARM processor that can be adapted to a variety of use cases, including monitoring environmental sensors, energy consumption, radon gas levels, marine environments, and edge computing.
<br>
<br>
<br>
<br>
<br>
<br>

### Prerequisites

继续本指南前，需准备以下内容：  
{{ prerequisites }}
- [ThingsBoard 账户]({{thingsboardInstanceLink}}){: target="_blank"}  


## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-create-device-thingsboard-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-configuration-block.md %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
{% include /docs/device-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-check-data-on-thingsboard-block.md %}

## 使用 RPC 控制设备 {#control-device-using-rpc}

{% include /docs/device-library/blocks/ready-to-go-devices/iot-gateway-cell-1024-using-rpc-block.md %}

## Additional info
Here you can find some additional links, that can be useful.  

### Troubleshooting
 - The most common problem in the integration process is not having a connection with the MQTT Broker. Make sure the device is connected to the internet and is able to communicate with the ThingsBoard Broker.  
 - Another common problem is not setting the correct Access Token. Check that the provided Access token is configured in ThingsBoard for the device.  

### Feedback & Help

For more information, visit the website at [EXXN Engineering](https://exxn.es/en/){:target="_blank"}.  
If you have any problems or doubts, please do not hesitate in contact to EXXN support at: [troubleshooting@exxn.es](mailto://troubleshooting@exxn.es).  

## 总结

{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}