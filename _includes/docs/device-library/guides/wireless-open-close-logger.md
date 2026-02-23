
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://getefento.com/product/wireless-open-close-logger-nb-iot/" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [Efento mobile application](https://play.google.com/store/apps/details?id=pl.efento.cloud&hl=en)
- [Read user manual (Optional)](https://getefento.com/support/)
'
 %}

## 概述


无线开关传感器可检测门开合事件并记录在本地存储器中。  
检测到状态变化时，设备会立即向云端发送通知。  
采用磁敏传感器检测开合事件。  

Efento NB-IoT 传感器通过蜂窝网络（窄带物联网）传输数据，无需路由器、网关等额外设备。  
传感器配备 Bluetooth Low Energy 接口，可配合智能手机快速完成配置。  
Efento NB-IoT 传感器可与任意云平台集成。  

- 传感器检测开合事件
- 电池可支持最长约 10 年免维护运行
- NB-IoT 传感器通过蜂窝网络将数据发送至 Efento Cloud 或其他云平台
- 可通过云端或蓝牙低功耗手机应用远程修改传感器配置
- 设备本地存储 40,000 条测量记录，存满后覆盖最早数据

### 前置条件

继续本指南前需准备以下内容：  
{{ prerequisites }}

- [ThingsBoard 账户](https://{{hostName}})

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/ready-to-go-devices/thingsboard-create-device-efento-transport-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/ready-to-go-devices/wireless-open-close-logger-configuration-block.md %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
{% include /docs/device-library/blocks/ready-to-go-devices/wireless-open-close-logger-check-data-block.md %}

## 总结

{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}
