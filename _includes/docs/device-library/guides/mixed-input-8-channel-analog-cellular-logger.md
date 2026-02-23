
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://fusiondaq.com/product/mixed-input-8-channel-analog-cellular-logger/" %} 
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [Read user manual (Optional)](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf)
'
 %}

## 概述


FDQ-99900 MI-8 是一款紧凑型 24 位数据采集系统（DAQ），可连接最多 10 个外接传感器，将数据本地记录到 SD 卡或通过蜂窝网络推送至云端。  
高级触发功能使 MI-8 仅上传关注事件，节省存储与流量。  
低功耗与宽工作温度范围，适合户外与远程部署。  
MI-8 可选带壳或裸板，支持定制包装；裸板（OEM）常与传感器等一起安装于 IP-67 NEMA 防护壳内。  

本指南将介绍如何[在 ThingsBoard 中创建设备](#create-device-on-thingsboard)、[配置并连接设备](#connect-device-to-thingsboard)、以及[在 ThingsBoard 上查看数据](#check-data-on-thingsboard)。  

### 前置条件

继续本指南前需准备以下内容：  
{{ prerequisites }}

- [ThingsBoard 账户](https://{{hostName}})


## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/device-library/blocks/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger-configuration-block.md %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
{% include /docs/device-library/blocks/ready-to-go-devices/mixed-input-8-channel-analog-cellular-logger-check-data-block.md %}

## 总结

{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}
