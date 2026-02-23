
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign deviceVendorLink = "https://www.tindie.com/products/sensy32/sensy32-all-in-one-sensor-iot-board-with-lcd/" %}
{% assign thingsboardHost = "https://" | append: hostName %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- A smartphone with the Ezurio Xbit app for configuration of the RS26x ([Android](https://play.google.com/store/apps/details?id=com.rfpros.xbitmobile&hl=en_US){:target="_blank"}/[iOS](https://apps.apple.com/us/app/canvas-xbit-mobile/id6478117073){:target="_blank"})
- LoRaWAN gateway (e.g. [Ezurio RG1xx](https://www.ezurio.com/iot-devices/lorawan-iot-devices/sentrius-rg1xx-lorawan-gateway-wi-fi-ethernet-optional-lte-us-only){:target="_blank"})
- [The Things Stack Community Edition account](https://www.thethingsnetwork.org/){: target="_blank"}
  '
  %}

## 概述

[Sensy32]({{deviceVendorLink}}){: target="_blank"} 是一款面向传感器爱好者、开发者与物联网创客的 IoT 板。  
基于 ESP32-S3，集成多种传感器，可实现数据的监测、分析与可视化。  

Sensy32 支持 Wi-Fi 与 Bluetooth，配备两个 USB Type-C 口，用于充电供电、程序与固件上传、数据通信、外设连接及为传感器等外部设备供电。

Sensy32 板载组件与传感器包括：
- 紫外线传感器
- 红外运动与人体存在传感器
- 温湿度传感器
- 高度与气压传感器
- 九轴姿态 IMU（加速度计/磁力计/陀螺仪）
- 微控制器（ESP32-S3 Wi-Fi 与 Bluetooth）
- 32 Mb Nor Flash
- USB 转串口
- 光照强度传感器
- 电池充电器
- RGB LED
- MEMS 麦克风
- 内置 LCD 屏，支持实时监测与控制

本指南将介绍如何在 ThingsBoard 创建设备、安装所需库和工具，修改代码并上传至设备，使用导入的仪表板在 ThingsBoard 上查看数据。

## 前置条件

继续本指南前需准备以下内容：
- Editor [Arduino IDE](https://www.arduino.cc/en/software){:target="_blank"}
- [CP210xVCP Driver](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers){:target="_blank"}
- Sensy32 board (you can get it from [Tindie](https://www.tindie.com/products/sensy32/sensy32-all-in-one-sensor-iot-board-with-lcd/){:target="_blank"} or [Elecrow](https://www.elecrow.com/){:target="_blank"})
- [ThingsBoard 账户]({{ thingsboardHost }}){: target="_blank"}

## 安装所需库和工具 {#install-required-libraries-and-tools}

Open the [Arduino IDE](https://www.arduino.cc/en/software){:target="_blank"} and install the board package:

**1.** Go to **File > Preferences** and add the following URL to the **Additional Boards Manager URLs** field: 

```text
https://dl.espressif.com/dl/package_esp32_index.json
```
{:.copy-code}

{% assign preferences = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/preferences.png
        title: Go to **File > Preferences** and add the following URL to the **Additional Boards Manager URLs** field: https://dl.espressif.com/dl/package_esp32_index.json
'
%}

{% include images-gallery.liquid imageCollection=preferences %}

**2.** Go to **Tools > Board > Board Manager** and install the **ESP32 by Espressif Systems** board.

{% assign preferences = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/esp32-arduino-ide-board-manager.png
        title: Then go to **Tools > Board > Board Manager** and install the **ESP32 by Espressif Systems** board.
'
%}

{% include images-gallery.liquid imageCollection=preferences %}

<br>

**3.** After the installation is complete, select the board by Board menu: **Tools > Board > ESP32 > ESP32S3 Dev Module**.

Connect the Sensy32 board to the computer using a USB cable and select the port for the device: **Tools > Port > /dev/ttyUSB0**.

Port depends on operation system and may be different:
- for Linux it will be /dev/ttyUSBX
- for MacOS it will be usb.serialX.. or usb.modemX..
- for Windows - COMX.

- Where X - some number, that was assigned by your system.

{% assign preferences = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/esp32-s3-dev-module.png
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/esp32-s3-dev-module-port.png
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=preferences %}

**4.** To install the needed libraries - we will need to do the following steps:
- Go to the **Tools** tab and click on **Manage libraries**.
- Enter the name of the following libraries in the search bar and click **INSTALL**: "ThingsBoard", "ss_oled", "Adafruit TSL259", "SparkFun BNO08x", "SparkFun STHS34PF80", "BMP388_DEV", "SparkFun BME280", "Adafruit LTR390 Library".
- If prompted to install library dependencies, simply click **Install All** to ensure all necessary libraries are installed.

{% assign manageLibraries = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/manage-libraries.png
        title: Go to the **Tools** tab and click on **Manage libraries**.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/install-all.png
        title: If prompted to install library dependencies, simply click **Install All** to ensure all necessary libraries are installed.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-1.png
        title: **ThingsBoard**: This is the ThingsBoard Arduino SDK, used to connect with the ThingsBoard Platform.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-2.png
        title: **ss_oled.h**: This library is used to configure and display data on the LCD screen.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-3.png
        title: **Adafruit_LTR390.h**: A library for communicating with the Adafruit_LTR390 UV sensor.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-4.png
        title: **SparkFun_BNO08x_Arduino_Library.h**: Simplifies interfacing with BNO08x series sensors in Arduino projects.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-5.png
        title: **SparkFun_STHS34PF80_Arduino_Library.h**: Simplifies interfacing with the STHS34PF80 sensor in Arduino projects.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-6.png
        title: **BMP388_DEV.h**: This library facilitates interaction with the BMP388 sensor module.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-7.png
        title: **SparkFunBME280.h**: This library helps work with the SparkFun BME280 sensor, allowing you to read temperature, humidity, and pressure data.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/library-8.png
        title: **Adafruit_TSL2591.h**: A library for communicating with the Adafruit_TSL2591 Light sensor.
'
%}

{% include images-gallery.liquid imageCollection=manageLibraries %}

Let&#39;s dive deeper to see what are these libraries are used for:
- **ThingsBoard**: This is the ThingsBoard Arduino SDK, used to connect with the ThingsBoard Platform.
- **ss_oled.h**: This library is used to configure and display data on the LCD screen.
- **SparkFunBME280.h**: This library helps work with the SparkFun BME280 sensor, allowing you to read temperature, humidity, and pressure data.
- **BMP388_DEV.h**: This library facilitates interaction with the BMP388 sensor module.
- **Adafruit_LTR390.h**: A library for communicating with the Adafruit_LTR390 UV sensor.
- **Adafruit_TSL2591.h**: A library for communicating with the Adafruit_TSL2591 Light sensor.
- **Adafruit_Sensor.h**: Provides common functionality for working without various sensors, simplifying sensor integration in projects.
- **SparkFun_BNO08x_Arduino_Library.h**: Simplifies interfacing with BNO08x series sensors in Arduino projects.
- **SparkFun_STHS34PF80_Arduino_Library.h**: Simplifies interfacing with the STHS34PF80 sensor in Arduino projects.

{% capture difference %}
**Please note:** All provided code examples require ThingsBoard Library version 0.14.0
{% endcapture %}
{% include templates/info-banner.md content=difference %}

At this point, we have installed all required libraries and tools.

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

For simplicity, we will provide the device manually using the UI.

{% assign createDeviceOnThingsBoardPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-1-pe.png
        title: Log in to your ThingsBoard instance and go to the **Entities > Devices** section.
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-2-pe.png
        title: Click the "**+**" button in the top-right corner and select Add new device.
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-3-pe.png
        title: Enter a device name, for example "My New Device". You can leave all other fields with their default values. Click **Add** to add the device.
    ===
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-4-pe.png
        title: Your first device has been added.
'
%}

{% assign createDeviceOnThingsBoardCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-1-ce.png
        title: Log in to your ThingsBoard instance and go to the **Entities > Devices** section.
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-2-ce.png
        title: Click the "**+**" button in the top-right corner and select Add new device.
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-3-ce.png
        title: Enter a device name, for example "My New Device". You can leave all other fields with their default values. Click **Add** to add the device.
    ===
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-4-ce.png
        title: Your first device has been added.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=createDeviceOnThingsBoardPE %}
{% else %}  
{% include images-gallery.liquid showListImageTitles="true" imageCollection=createDeviceOnThingsBoardCE %}
{% endif %}


## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
To connect your device, you’ll first need to get its credentials. While ThingsBoard supports a variety of device credentials, for this guide, we will use the default auto-generated credentials, which is an access token.

{% assign connectDevicePE = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/hello-world-2-1-connect-device-1-pe.png
        title: Click on the device row in the table to open device details.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/hello-world-2-1-connect-device-2-pe.png
        title: Click **Copy access token**. The token will be copied to your clipboard. Please save it in a safe place.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=connectDevicePE %}

Now it&#39;s time to program the board to read data, display it on the Sensy board LCD screen, and connect to ThingsBoard.

To do this, you can use the code below. It contains all required functionality for this guide.

> Click to download the **source code**: [thingsboard.ino](/docs/devices-library/resources/sensy32/thingsboard.ino){:target="_blank" download="thingsboard.ino"}

{% capture difference %}
⚠️ Don&#39;t forget to replace placeholders with your real WiFi network SSID, password, ThingsBoard device access token.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

```text
constexpr char WIFI_SSID[] = "YOUR_WIFI_SSID";

constexpr char WIFI_PASSWORD[] = "YOUR_WIFI_PASSWORD";

constexpr char TOKEN[] = "YOUR_ACCESS_TOKEN";
```

Then upload the code to the device by pressing the Upload button or keyboard combination Ctrl+U.

{% assign upload = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/upload.png
'
%}

{% include images-gallery.liquid imageCollection=upload %}

If you cannot upload the code and receive an error: `Property 'upload.tool.serial' is undefined` you can do the following:

{% assign programmer = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/select-esptool-programmer.png
        title: Go to **Tools > Programmer** and select **Esptool** as a programmer.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/upload-using-programmer.png
        title: Go to **Sketch > Upload Using Programmer**.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=programmer %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
ThingsBoard provides the ability to create and customize interactive visualizations (dashboards) for monitoring and managing data and devices.

Through ThingsBoard dashboards, you can efficiently manage and monitor your IoT devices and data. So, we will create the dashboard for our device.

To do this, you can either create your own dashboard using custom 部件 or import a ready-made one.

In this example we will upload a ready-to-use dashboard. You can also customize it or create your own.

To import the ready-to-use dashboard, follow these steps:
- First download the [My Dashboard](/docs/devices-library/resources/dashboards/sensy32/sensy32-demo-dashboard.json){:target="_blank" download="sensy32-demo-dashboard.json"} file.

{% assign importDashboard = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/import-dashboard-1-pe.png
        title: Navigate to the **Dashboards** page. Click on the "**+**" icon in the top right corner. Select **Import dashboard**.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/import-dashboard-2-pe.png
        title: In the dashboard import window, **upload the JSON file** and click the **Import** button.
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/import-dashboard-3-pe.png
        title: Dashboard has been imported.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=importDashboard %}

"sensy32-demo-dashboard" structure:
- To check the data from our device we need to open the imported dashboard by clicking on it in the table.
- The view of "sensy32-demo-dashboard" containing 部件 representing the following telemetry values: **temperature, humidity, altitude, pressure, motion, uv, accelerometer (valX, valY, and valZ), orientation (quatI, quatJ, quatK, quatReal, and quatRadianAccuracy), light (ir, full, visible, lux)**.
- 您也可以添加部件以展示设备与 Wi-Fi 信息。

{% assign myDashboard = '
    ===
        image: /images/devices-library/ready-to-go-devices/sensy32/my-dashboard.png
'
%}

{% include images-gallery.liquid imageCollection=myDashboard %}

## 总结

Now you can easily connect your Sensy32 and start sending data to ThingsBoard.

To go further, explore the [ThingsBoard documentation](https://thingsboard.io/docs/pe/){:target="_blank"} to learn more about key features, such as creating [dashboards](https://thingsboard.io/docs/pe/user-guide/dashboards/){:target="_blank"} to visualize your telemetry, or setting up [alarm rules](https://thingsboard.io/docs/pe/user-guide/alarm-rules/){:target="_blank"} to monitor device behavior in real time.