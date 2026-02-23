1. 进入 **Network** > **Wireless**，点击 **「Scan」** 按钮；
2. 选择要加入的网络；
3. 若存在，请输入密码短语/密码；
4. 设置新网络名称（wwan）；
5. 在 **「Device Configuration」** 页面点击 **「Save & Apply」** 按钮；
6. 在 **「Interface Configuration」** 页面点击 **「Save & Apply」** 按钮；
7. 在 WWAN 上检查新 IP 地址：
   - 在 **Network** > **Interfaces** 中查看 WWAN 接口的新 IP 地址。
8. 检查与互联网的连接：
   - 进入 **Network** > **Diagnostics**，ping 互联网上的「openwrt.org」服务器。（同上，通过其 WAN RJ45 端口连接至您的网络）。
9. 使用浏览器，输入 IP 地址 192.168.8.1 访问 **ACE-GTW-MQTT** Web 界面；
10. 输入用户名（默认：**root**）和密码（默认：**root**），点击 Login。

{% assign wirelessConnection = '
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-1.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-2.png,
	===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-3.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-4.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-5.png,
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/wireless-connection-6.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=wirelessConnection %}
