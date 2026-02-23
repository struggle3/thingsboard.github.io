
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://www.milesight-iot.com/lorawan/gateway/ug65" %}

{% assign thingsboardHost = "https://" | append: hostName %}

{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [UG65 gateway user manual](https://resource.milesight.com/milesight/iot/document/ug65-user-guide-en.pdf){: target="_blank"}
- [网络服务器账户](#配置)
'
 %}

## 概述

[UG65 LoRaWAN® Gateway]({{deviceVendorLink}}){: target="_blank"}是一款坚固的 8 通道室内 LoRaWAN® 网关。采用 SX1302 LoRa 芯片与高性能四核 CPU，支持超过 2000 个节点连接。

主要特性：  
 - 大内存四核工业处理器  
 - 搭载 SX1302 芯片，更高吞吐、更低功耗  
 - 8 个半双工/全双工通道  
 - IP65 外壳，工业设计，可应对屋檐等半户外场景  
 - 桌面、壁挂或抱杆安装  
 - 以太网、蜂窝（4G/3G）、Wi-Fi 多回传备份  
 - DeviceHub 与 Milesight IoT Cloud 便于远程设备集中管理  
 - 支持 IPsec/OpenVPN/L2TP/PPTP/DMVPN 等多种 VPN 安全通信  
 - 兼容 The Things Industries、ChirpStack 等主流网络服务器  
 - 噪声检测与分析，提供直观部署图  
 - 内置网络服务器及 MQTT/HTTP/HTTPS API，便于集成  
 - 嵌入式 Python SDK 支持二次开发  
 - 基于 Node-RED 的快速可视化开发  

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

完成本指南中的步骤后，您将在网络服务器上获得已连接并配置好的网关，并在 ThingsBoard 中完成集成，从而添加设备、接收并处理数据。

## 前置条件

继续本指南前，需准备以下内容：  
{{ prerequisites }}
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}


## 网关连接 {#gateway-connection}

根据[官方用户手册](https://resource.milesight.com/milesight/iot/document/ug65-user-guide-en.pdf){: target="_blank"}和[本指南](https://support.milesight-iot.com/support/solutions/articles/73000514278-how-to-connect-milesight-gateway-to-the-internet){: target="_blank"}，您可以通过以下两种方式将网关接入网络并访问 Web 界面：

- 无线连接：
  1. 在电脑上启用无线网络连接，搜索并连接接入点 "Gateway_******"「Gateway_******」。
  2. 在电脑上打开浏览器，输入 IP 地址 **192.168.1.1** 访问 Web 管理界面。
  3. 输入用户名（默认：**admin**）和密码（默认：**password**），点击 **登录**。
  
- 有线连接：
  将电脑通过网线直连 UG65 的 Ethernet 口，或通过 PoE 注入器连接，以访问网关 Web 界面。以下步骤以 Windows 10 为例。

  1. 打开「控制面板」→「网络和 Internet」→「网络和共享中心」，点击「Ethernet」（名称可能不同）。
  2. 进入「属性」→「Internet 协议版本 4(TCP/IPv4)」，选择「使用下面的 IP 地址」，手动设置与网关同网段的静态 IP。
  3. 在电脑上打开浏览器，输入 IP 地址 **192.168.23.150** 访问 Web 管理界面。
  4. 输入用户名和密码，点击「登录」。

{% assign gatewayGeneralSettings = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/general-settings-view.png,
        title: 此时您已可以配置网关。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayGeneralSettings %}

{% assign gatewayPacketForwarderTab = '
    ===
        image: /images/devices-library/ready-to-go-devices/milesight-lorawan-gateway/ns-configuration-before.png,
        title: 在左侧菜单中打开 **Packet Forwarder**，记录 **Gateway EUI** 和 **Gateway ID**，用于在网络服务器上创建网关。
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayPacketForwarderTab %}

默认情况下，Gateway EUI 与 Gateway ID 相同。  

下一步将说明如何将网关连接到网络服务器。  

## 配置

要与网络服务器建立集成，请先选择以下受支持的网络服务器之一：  

{% assign targetIntegrationTypes = '
ChirpStack,
TheThingsStack,
TheThingsIndustries,
Loriot
'%}

{% include /docs/device-library/blocks/basic/thingsboard-create-integration-block.liquid target-integration-types=targetIntegrationTypes %}

{% include /docs/device-library/blocks/basic/thingsboard-check-integration-connection.md %}


## 总结

{% include /docs/device-library/blocks/basic/lora-gateway-conclusion-block.md %}
{% include add-device-banner.liquid %}
