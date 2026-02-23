### Device configuration

连接并发送数据前，需配置设备和网络服务器。  
首先配置设备，并保存网络服务器配置所需信息。  
要将设备加入网络服务器并从中获取信息，需准备以下设备参数：
- **Device EUI** - device identifier
- **Application EUI** - Application identifier
- **Application Key** - Application key to identify device. We recommend to use a generated key, not from the example!

以上参数为连接所必需。

根据网络服务器要求，可能还需提供接入类型（OTAA）、LoRaWAN 版本。

通过 NFC 配置设备时，请如右图所示将智能手机靠近设备：  

![NFC zone](/images/devices-library/ready-to-go-devices/am308/am308-connect.png)  
<br>

在智能手机上读写设备配置，可按以下步骤操作：  
{% assign readWriteConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/ws202-pir-and-light-sensor/toolbox-application.png,
        title: Open **ToolBox** application.
    ===
        image: /images/devices-library/ready-to-go-devices/am308/toolbox-read-success.png,
        title: Click on **NFC Read** button and hold your smartphone near the device.
    ===
        image: /images/devices-library/ready-to-go-devices/am308/toolbox-configuration.png,
        title: Go to tab **Setting**, set and save required fields and any other configuration that you need.
    ===
        image: /images/devices-library/ready-to-go-devices/am308/toolbox-write-success.png,
        title: Press **Write** button and hold your smartphone near the device.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=readWriteConfiguration %}

The developer also provides the possibility of connecting through a computer if necessary:

![Device connect](/images/devices-library/ready-to-go-devices/am308/am308-connect-to-pc.png)

See the [manual](https://resource.milesight.com/milesight/iot/document/am300-series-user-guide-en.pdf){: target="_blank"} for details.