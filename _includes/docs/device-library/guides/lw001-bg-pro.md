
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://www.mokosmart.com/lorawan-tracker-lw001-bg-pro/" %}
{% assign thingsboardHost = "https://" | append: hostName %}
{% assign officialManualLink = "https://docs.mokosmart.com/wp-content/uploads/2025/06/LW001-BG-PRO-product-brief.pdf" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- [LW001-BG PRO user manual](' | append: officialManualLink | append: '){: target="_blank"}
  '
  %}

## 概述

[LW001-BG PRO]({{deviceVendorLink}}){: target="_blank"} 是一款无线、智能、超低功耗的室内外 LoRaWAN 定位器。  
集成 **GPS**、**Bluetooth**、**Wi-Fi** 定位，支持多种工作模式，适用于各类追踪应用。<br>

支持 **ABP** 与 **OTAA** 两种 LoRaWAN 入网方式，可通过 **MKLoRa** 应用轻松配置或更新。  
适用于物流优化、资产管理、仓储盘点、户外追踪、防盗、牲畜追踪等场景。<br>

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

## 前置条件

继续本指南前需准备以下内容：  
{{ prerequisites }}
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}


## 配置

![{{deviceName}}](/images/devices-library/ready-to-go-devices/lw001-bg-pro/mklora-app-qr-code.png){: style="float: left; max-width: 150px; max-height: 150px; margin: 0px 10px 0px 0px"}
To connect the device and start sending data, both the device and the network server must be configured. Users can configure the device using the MKLora application.   
To download the MKLora app, scan the QR code on the left or follow the [provided link](https://play.google.com/store/apps/details?id=com.moko.mklora&pcampaignid=web_share){:target="_blank"}.

After the MKLora APP is installed, users can start the configuration.<br><br><br>

First, we will configure the device and save the required information that will be used later for the network server configuration.
To add a device to network server and get information from it, we will need the following device parameters:
- **Device EUI** - device identifier  
- **Application EUI** - Application identifier  
- **Application Key** - Application key to identify device. We recommend to use a generated key, not from the example!  

The parameters above are required for connection.

Depending on the network server, you may also need to provide join type (OTAA), LoRaWAN version.

After the device is turned on, the device Bluetooth will start broadcasting. Open the MKLoRa APP and choose LW001, then you can search the LW001-BG PRO device by click the refresh icon. The default broadcast name of the device: LW001-BG -XXXX.

Then click "Connect" button, the default login password is Moko4321.

Go to "Lora" and check the "Connection Settings", you can configure/read the Device EUI, APP EUI and APPkey.

ThingsBoard supports various network servers. To create an integration with a network server, please choose one of the supported network servers:

{% assign targetIntegrationTypes = '
ChirpStack,
TheThingsStack,
TheThingsIndustries,
Loriot
'%}

{% include /docs/device-library/blocks/integrations/devices-configuration/lw001-bg-pro/thingsboard-create-lw001-bg-pro-device-block.liquid target-integration-types=targetIntegrationTypes %}

{% capture lw001bgproconfig %}
ChirpStack<small>Recommended</small>%,%%,%templates/docs/device-library/blocks/integrations/devices-configuration/lw001-bg-pro-chirpstack-block.md%br%
TheThingsStack<small></small>%,%%,%templates/docs/device-library/blocks/integrations/devices-configuration/lw001-bg-pro-thethingsstack-block.md%br%
TheThingsIndustries<small></small>%,%%,%templates/docs/device-library/blocks/integrations/devices-configuration/lw001-bg-pro-thethingsindustries-block.md%br%
Loriot<small></small>%,%%,%templates/docs/device-library/blocks/integrations/devices-configuration/lw001-bg-pro-loriot-block.md{% endcapture %}

## 在 ThingsBoard 上创建仪表板 {#create-dashboard-on-thingsboard}

为获得更直观的展示，可使用仪表板。

在 ThingsBoard 中添加仪表板请按以下步骤操作：

- 填写**仪表板标题**并点击 **Add** 按钮
- 点击**添加部件**按钮在仪表板中添加部件

{% assign CreateDashboardOnThingsBoard  = '
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/46.png,
        title: 进入 **仪表板** 页面。默认进入仪表板组「全部」。点击右上角「+」图标，选择 **创建新仪表板**。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/47.png,
        title: 填写**仪表板标题**并点击 **Add** 按钮。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/48.png,
        title: 仪表板将打开。点击**添加部件**按钮添加新部件。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/49.png,
        title: 例如，要展示位置信息，可使用 **Maps** 部件。
    ===
        image: /images/devices-library/ready-to-go-devices/lw001-bg-pro/50.png,
        title: 然后将数据源选为刚创建设备，并选择要展示的变量。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=CreateDashboardOnThingsBoard %}


<br><b><font size="4">导入仪表板</font></b>

您可[下载此示例仪表板（JSON 格式）](/docs/devices-library/resources/dashboards/lw001-bg-pro/lw001-bg_pro_lorawan_tracker_dashboard.json){:target="_blank" download="lw001-bg_pro_lorawan_tracker_dashboard.json"}并[导入](/docs/{{docsPrefix}}user-guide/dashboards/#import-dashboard){:target="_blank"}到您的 ThingsBoard 实例。
{% include add-device-banner.liquid %}
