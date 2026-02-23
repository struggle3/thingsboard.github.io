您的 PC 必须与网关处于同一网络：192.168.1.XXX。若非如此，请修改您 PC 的 IP 地址。

{% capture infoWired %}
<body>
  <p>
    <b style="color:red">警告：</b>
    <span style="color:black">请勿使用您网络中已被其他设备占用的 IP 地址！</span>
  </p>
</body>
{% endcapture %}
{% include templates/warn-banner.md content=infoWired %}

**Windows：**
1. 进入 **「控制面板」** → **「网络和 Internet」** → **「网络和共享中心」**，然后点击 **「Ethernet」**（名称可能不同）；
2. 进入 **「属性」** → **「Internet 协议版本 4(TCP/IPv4)」**，选择 **「使用下面的 IP 地址」**，然后手动分配与网关同一子网内的静态 IP；
3. 使用浏览器输入 IP 地址 192.168.1.1 访问 Web 界面；
4. 在浏览器地址栏输入 **http://192.168.1.1** 进入路由器 Web 界面（WebUI）；
5. 出现认证提示时，输入用户名 admin，并输入设备信息标签/刻印上的密码；
6. 登录后，出于安全考虑，必须设置新密码。在更改默认密码之前，您无法与路由器的 WebUI 交互；
7. 接下来，配置向导将帮助您设置路由器的主要运行参数。

![](/images/devices-library/ready-to-go-devices/teltonika-rut955/wired-connection-1.png)
<br><br>

**macOS：**
1. 进入 **「系统设置」** > **「网络」**，然后点击 **「USB 10/100/1000 LAN」**（名称可能不同）；
2. 进入 **「详细信息...」** > **「TCP/IP」**，选择 **「手动」**，然后手动分配与网关同一子网内的静态 IP；
3. 使用浏览器输入 IP 地址 192.168.1.1 访问 Web 界面；
4. 在浏览器地址栏输入 **http://192.168.1.1** 进入路由器 Web 界面（WebUI）；
5. 出现认证提示时，输入用户名 admin，并输入设备信息标签/刻印上的密码；
6. 登录后，出于安全考虑，必须设置新密码。在更改默认密码之前，您无法与路由器的 WebUI 交互；
7. 接下来，配置向导将帮助您设置路由器的主要运行参数。

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-macos-ip.png)
<br><br>

**Ubuntu Linux：**
1. 进入 **「设置」** > **「网络」**，然后点击 **「有线设置」**（名称可能不同）；
2. 进入 **「IPv4」**，选择 **「手动」**，然后手动分配与网关同一子网内的静态 IP；
3. 使用浏览器输入 IP 地址 192.168.1.1 访问 Web 界面；
4. 在浏览器地址栏输入 **http://192.168.1.1** 进入路由器 Web 界面（WebUI）；
5. 出现认证提示时，输入用户名 admin，并输入设备信息标签/刻印上的密码；
6. 登录后，出于安全考虑，必须设置新密码。在更改默认密码之前，您无法与路由器的 WebUI 交互；
7. 接下来，配置向导将帮助您设置路由器的主要运行参数。

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-linux-ip.png)
<br><br>
