要将「车载 IoT 监控系统」连接到 ThingsBoard **Edge**，需先获取设备凭证。
ThingsBoard 支持多种设备凭证。本指南建议使用默认自动生成的凭证，即访问令牌。

请使用 URL **EDGE_URL** 打开 ThingsBoard **Edge** UI。

{% include images-gallery.html imageCollection="copyAccessTokenDevice" showListImageTitles="true" %}

我们将使用简单命令为「车载 IoT 监控系统」设备生成随机遥测，并通过 MQTT 协议发布至 ThingsBoard **Edge**。

请将以下脚本下载到本地目录：
- [**mqtt-generator.py**](/docs/{{docsPrefix}}use-cases/resources/data-filtering-traffic-reduce/mqtt-generator.py)

运行脚本前，请按以下方式修改 **mqtt-generator.py**：

- 将 **YOUR_ACCESS_TOKEN** 替换为前述步骤复制的 **「车载 IoT 监控系统」** 设备的访问令牌。

- 将 **YOUR_TB_EDGE_HOST** 替换为 ThingsBoard Edge 主机地址。例如 **localhost**。

- 将 **YOUR_TB_EDGE_MQTT_PORT** 替换为 ThingsBoard Edge MQTT 端口号。例如 **11883** 或 **1883**。

打开终端，使用以下命令安装 MQTT Python 库：

```bash
sudo pip install paho-mqtt
```
进入包含 Python 脚本的目录，使用以下命令启动应用：

```bash
python mqtt-generator.py
```
打开 ThingsBoard **Edge** UI，确认设备是否成功接收遥测：

{% include images-gallery.html imageCollection="verifyDeviceTelemetryEdge" showListImageTitles="true" %}

打开 **ThingsBoard** UI，确认 Edge 是否成功将数据推送至云端：

{% include images-gallery.html imageCollection="verifyDeviceTelemetry" showListImageTitles="true" %}
