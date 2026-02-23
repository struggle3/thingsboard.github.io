按以下说明在 Windows 上下载、安装、配置并运行 mosquitto_pub：

1. 下载并安装 Eclipse Mosquitto。访问 [Mosquitto 官方下载页](https://mosquitto.org/download/)并选择对应的 Windows 安装包（32 位或 64 位视系统而定）。
2. 下载完成后运行安装程序并按提示操作。将在本机安装 Mosquitto，默认安装路径为「C:\Program Files\mosquitto」；
3. 更新系统「Path」变量。可执行文件「mosquitto_pub.exe」和「mosquitto_sub.exe」位于 Mosquitto 的安装目录。需将该目录添加到系统「Path」环境变量，以便 Windows 在任何当前目录下都能找到这些可执行文件。

将 Mosquitto 目录添加到「Path」变量的步骤如下：

{% assign mosquitto-windows = '
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-1.png,
        title: 按 Win + X，选择「System」。然后点击「System」页面；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-2.png,
        title: 进入「About」区域，点击「Advanced system settings」；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-3.png,
        title: 在「System Properties」弹窗中，点击「Advanced」选项卡下的「Environment Variables」按钮；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-4.png,
        title: 在「Environment Variables」弹窗中，选择「Path」，点击「Edit」按钮；
    === 
        image: /images/helloworld/getting-started-pe/mosquitto-windows-5.png,
        title: 在「Edit environment variable」弹窗中点击「New」按钮，添加包含 mosquitto_pub.exe 和 mosquitto_sub.exe 的目录路径（默认「C:\Program Files\mosquitto」）。点击「OK」；
    === 
        image: /images/helloworld/getting-started-pe/mosquitto-windows-6.png,
        title: 点击「OK」保存环境变量修改；
    ===
        image: /images/helloworld/getting-started-pe/mosquitto-windows-7.png,
        title: 最后点击「OK」应用系统属性中的全部更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=mosquitto-windows %}

打开终端，将$THINGSBOARD_HOST_NAME和$ACCESS_TOKEN替换为对应值。

```bash
mosquitto_pub -d -q 1 -h "$THINGSBOARD_HOST_NAME" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为 ThingsBoard Cloud（北美），$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "mqtt.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 为 ThingsBoard Cloud（欧洲），$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "mqtt.eu.thingsboard.cloud" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}


例如，$THINGSBOARD_HOST_NAME 为本地部署，$ACCESS_TOKEN 为 ABC123：

```bash
mosquitto_pub -d -q 1 -h "localhost" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

成功输出应类似如下：

```text
Client mosqpub|xxx sending CONNECT
Client mosqpub|xxx received CONNACK
Client mosqpub|xxx sending PUBLISH (d0, q1, r0, m1, 'v1/devices/me/telemetry', ... (16 bytes))
Client mosqpub|xxx received PUBACK (Mid: 1)
Client mosqpub|xxx sending DISCONNECT
```

{% capture difference %}
**注意：** 自 ThingsBoard 3.2 起，可使用基本 MQTT 凭据（client id、username 和 password 组合），并通过设备配置集自定义 **topic 名称**和 **payload 类型**。详见[此处](/docs/user-guide/device-profiles/#mqtt-transport-type)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}