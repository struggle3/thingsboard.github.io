1. 确保已启用无线网络连接。进入 **Start** — **控制面板** — **网络和 Internet** — **网络和共享中心**。点击左侧面板中的 **更改适配器设置**，右键点击 **无线网络适配器**，选择 **启用**；
2. 检查 IP 和 DNS 是否自动获取。右键点击 **无线网络适配器**，选择 **属性**，然后选择 **Internet 协议版本 4** 并点击 **属性**；
3. 若未选中，请勾选自动获取 IP 地址和自动获取 DNS 服务器地址，点击 **确定**；
4. 右键点击 **无线网络适配器**，选择 **连接** 以连接无线网络；
5. 从列表中选择无线网络 <b>RUT955******</b> 并点击 **连接**。输入设备标签上的 WiFi 密码；
6. 在浏览器地址栏输入 http://192.168.1.1 进入路由器 Web 界面（WebUI）；
7. 出现认证提示时，输入用户名 admin，并输入设备信息标签/刻印上的密码；
8. 登录后，出于安全考虑，必须设置新密码。在更改默认密码之前，您无法与路由器的 WebUI 交互；
9. 接下来，配置向导将帮助您设置路由器的主要运行参数。

{% assign wirelessConnection = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-1.png,
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-2.png,
	===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-3.png,
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-4.png,
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/wireless-connection-5.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=wirelessConnection %}
