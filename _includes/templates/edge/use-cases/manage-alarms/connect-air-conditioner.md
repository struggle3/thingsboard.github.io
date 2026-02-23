要订阅 **空调** 设备从 Edge 下发的 RPC 命令，需先获取 **空调** 设备的凭证。
ThingsBoard 支持多种设备凭证。本指南建议使用默认自动生成的凭证，即访问令牌。

请使用 URL **EDGE_URL** 打开 ThingsBoard **Edge** UI。

{% include images-gallery.html imageCollection="copyAccessTokenAirConditioner" showListImageTitles="true" %}

现在可以订阅空调设备的 RPC 命令。
本示例将使用简单命令通过 MQTT 协议订阅 RPC 命令。

请将以下脚本下载到本地目录：
- [**mqtt-js.sh**](/docs/edge/use-cases/resources/manage-alarms-rpc-requests/mqtt-js.sh)
- [**cooler.js**](/docs/edge/use-cases/resources/manage-alarms-rpc-requests/cooler.js)

{% include templates/edge/node-js-installed-banner.md %}

运行脚本前，请相应修改 **mqtt-js.sh**：

- 将 **YOUR_ACCESS_TOKEN** 替换为上述步骤复制的 **空调** 设备访问令牌。

- 将 **YOUR_TB_EDGE_HOST** 替换为 ThingsBoard Edge 主机。例如 **localhost**。

- 将 **YOUR_TB_EDGE_MQTT_PORT** 替换为 ThingsBoard Edge MQTT 端口。例如 **11883** 或 **1883**。

打开终端，进入包含 **mqtt-js.sh** 和 **cooler.js** 的目录，并确保脚本可执行：
```shell
 chmod +x *.sh
```

安装 **mqtt** Node 模块以在 **cooler.js** 脚本中使用 mqtt 包：
```shell
npm install mqtt --save
```

然后执行以下命令：
```shell
bash mqtt-js.sh
```

您应看到如下输出（含您的主机和设备令牌）：

```shell
pc@pc-XPS-15-9550:~/alarm-tutorial$ bash mqtt-js.sh
Connecting to: localhost:1883 using access token: sFqoF18PTyViO8L0qo7c
Cooler is connected!
```

{% capture new-tab %}
请打开新的终端标签页推送温度遥测到设备，并让当前终端在后台运行直至本指南结束。{% endcapture %}
{% include templates/info-banner.md content=new-tab %}
