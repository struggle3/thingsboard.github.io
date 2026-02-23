### Device configuration

连接并发送数据前，需配置设备和网络服务器。
Firstly, we are going to configure the device, and save required information for network server configuration.
要将设备加入网络服务器并从中获取信息，需准备以下设备参数：

- **Device EUI** - device identifier
- **Application EUI** - Application identifier
- **Application Key** - Application key to identify device. We recommend to use a generated key, not from the example!

根据网络服务器要求，可能还需提供接入类型（OTAA）、LoRaWAN 版本。

VS121 sensor provides user-friendly web GUI for configuration and users can access it via Wi-Fi connection. Default SSID device: Workplace Sensor.

Follow the steps below:
1. Power on the device over Type-C Power Port;
2. Enable the Wireless Network Connection on your computer and the corresponding access point, then connect computer to this access point;
3. Open the Browser and type 192.168.1.1 to access the web GUI (you must be in the one subnetwork);
4. Users need to set the password when using the device for the first time. Additionally three security questions can also be set optionally;
5. After configuration, use username (admin) and custom password to log in to the sensor.

{% assign milesightLogin = '
    ===
        image: /images/devices-library/ready-to-go-devices/vs121-device/milesight-login.png,
        title: Use username (admin) and custom password to log in to the sensor web GUI.
'
%}

{% include images-gallery.liquid imageCollection=milesightLogin %}

To obtain the necessary parameters, follow these steps:
- Go to the **IoT** page in the left panel and navigate to the **LoRa** tab;
- Make a note of **Device EUI** and **App EUI**;
- Generate and enter a new password in hexadecimal format in the **Application Key** field and note it;
- Scroll down and click on the **Save** button.

{% assign milesightInterface = '
    ===
        image: /images/devices-library/ready-to-go-devices/vs121-device/milesight-interface-1.png,
        title: Go to the **IoT** page in the left panel and navigate to the **LoRa** tab. Make a note of **Device EUI** and **App EUI**. Generate and enter a new password in hexadecimal format in the **Application Key** field and note it;
    ===
        image: /images/devices-library/ready-to-go-devices/vs121-device/milesight-interface-2.png,
        title: Scroll down and click on the **Save** button.
'
%}

{% include images-gallery.liquid imageCollection=milesightInterface %}

以上参数为连接所必需。