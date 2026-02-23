### Device configuration

连接并发送数据前，需配置设备和网络服务器。  
首先配置设备，并保存网络服务器配置所需信息。  
要将设备加入网络服务器并从中获取信息，需准备以下设备参数：  
 - **Device EUI** - 设备标识符
 - **Application EUI** - 应用标识符
 - **Application Key** - 用于识别设备的应用密钥。建议使用生成的密钥，而非示例中的密钥！  

以上参数为连接所必需。  
  
根据网络服务器要求，可能还需提供接入类型（OTAA）、LoRaWAN 版本。  
  
通过 NFC 配置设备时，请如右图所示将智能手机靠近设备：  
![NFC zone](/images/devices-library/ready-to-go-devices/ws101-smart-button/nfc-area.png)  
<br>

在智能手机上读写设备配置，可按以下步骤操作：  
{% assign readWriteConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/ws101-smart-button/toolbox-application.png,
        title: Open **ToolBox** application.
    ===
        image: /images/devices-library/ready-to-go-devices/ws101-smart-button/toolbox-read-success.png,
        title: Click on **NFC Read** button and hold your smartphone near the device.
    ===
        image: /images/devices-library/ready-to-go-devices/ws101-smart-button/toolbox-configuration.png,
        title: Go to tab **Setting**, set and save required fields and any other configuration that you need.
    ===
        image: /images/devices-library/ready-to-go-devices/ws101-smart-button/toolbox-write-success.png,
        title: Press **Write** button and hold your smartphone near the device.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=readWriteConfiguration %}

若在保护壳内配置设备与智能手机时遇到问题，建议取下保护壳后再试。  

Now, the device is able to send a data to the network server.  
