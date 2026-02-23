
Efento 传感器的全部配置通过 Android 免费移动应用完成。  
应用可从 [Google Play](https://play.google.com/store/apps/details?id=pl.efento.cloud&hl=en) 下载。  
配置前请确保传感器能够注册到 NB-IoT 网络且 APN 设置正确。  
Efento NB-IoT 传感器及 Efento 移动应用的详细用户手册见 [Efento 官网支持页面](https://getefento.com/support/)。  

{% assign thingsboardHost = coapHostName %}

{% assign efentoSensorConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-1.jpg,
        title: Once you download and install the application select “Nearby sensors” mode and unlock the power user mode: open the application menu and quickly tap Efento logo five times.
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-2.jpg,
        title: Make sure the APN you use allow the device to connect to the server on which your ThingsBoard instance is running. You can check the network status in the Efento mobile application. Connect to the sensor -> click on the menu (three dots in the upper right corner)
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-3.jpg,
        title: Click on Cellular network status. Mare sure that the field “Registration status” value is either “REGISTERED” or “REGISTERED_ROAMING”
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-2.jpg,
        title: Set the sensor to send the data to the server on which ThingsBoard instance is running. Connect to the sensor -> click on the menu (three dots in the upper right corner).
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-4.jpg,
        title: Click on Power user -> Server configuration. Select “Other” and fill in the address of the server (' | append: thingsboardHost | append: '). Default port used for CoAP communication is 5683. Set authentication mode to “custom token” and key in the token you created for the device on ThingsBoard platform.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=efentoSensorConfiguration %}

设置传感器发送数据所用的 CoAP 端点。点击菜单（右上角三个点）-> Power user -> CoAP endpoints，将端点设置为以下值：

- Data: “efento/m”
- Time: “efento/t”
- Configuration: “efento/c”
- Device Info: “efento/i”

{% assign configureSensorEndpoints = '        
    ===
        image: /images/devices-library/ready-to-go-devices/wireless-open-close-sensor/efento-sensor-configuration-5.jpg
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=configureSensorEndpoints %}

