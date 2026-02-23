下面我们添加 **MQTT connector**，它将使用带内置数据生成器的演示 broker 订阅若干数据 topic，并将数据发送到网关。

### 配置演示 MQTT broker

我们将使用 docker 镜像作为演示 MQTT broker，可通过以下命令安装并运行：

```shell
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

运行 docker 镜像后，终端会显示以下日志：

![](/images/gateway/dashboard/run-demo-mqtt-broker-image.png)

### 配置 connector

MQTT connector 将使用 anonymous 安全类型，在端口 **1884** 连接到 **"host.docker.internal"** 上名为 **"Demo Broker"** 的 broker。
它将包含 **"data/"** topic 的数据 mapping，指定 JSON converter，并为设备数据定义 attribute 和 time series mapping。
此外，它将处理传感器的 connect 和 disconnect 请求，通过表达式从 topic filter 中提取设备名称。

创建 connector 请按以下步骤操作：

{% assign addNewConnector = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-7-ce.png,
        title: 在右侧面板点击"**Connectors configuration（Connector 配置）**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-8-ce.png,
        title: 点击"**+ Add connector（添加 Connector）**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-mqtt-9-ce.png,
        title: 在下拉中选择"**MQTT**"connector 类型，填写"**Name**"字段，将"**Logging level**"设为 INFO，禁用"**Fill configuration with default values**"并点击"**Add**"按钮；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-mqtt-10-ce.png,
        title: Connector 已创建。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewConnector %} 

首先配置到演示 broker 的连接。从"**Connection to broker（连接 Broker）**"部分开始。
该部分提供详细连接配置选项，包含 host、port、MQTT version、client ID、security 等重要字段。
**host** 字段指定 broker 地址，**port** 字段指定通信端口，**MQTT version** 字段确保与所用协议版本兼容，**client ID** 唯一标识客户端，**security** 配置 client 在 MQTT Broker 的授权。

填写以下字段值：

| **字段名** | **值**            |
|:---------------|:---------------------|
| Host           | host.docker.internal |
| Port           | 1884                 |
| MQTT version   | 5                    |
| Client ID      | 随机生成   |
| Security       | Anonymous            |
| ---            |                      |

{% assign connectionToBroker = '
    ===
        image: /images/gateway/dashboard/connection-to-broker-section-1-ce.png,
        title: 首先配置到演示 broker 的连接。从"**Connection to broker**"部分开始。该部分提供 host、port、MQTT version、client ID、security 等详细连接配置选项。
'
%}

{% include images-gallery.liquid imageCollection=connectionToBroker %}

<br>
接下来进入"**Data mapping（数据映射）**"部分。该部分包含网关连接 broker 后将订阅的 topic 数组，以及处理传入消息（converter）的配置。

按以下步骤配置数据映射：
- 点击"**Add mapping**"按钮
- 在打开窗口中，将"**Topic filter**"字段填为"**data/**"，将"**QoS**"选为"**0 - At most once（最多一次）**"，将"**Payload type**"选为 **JSON**。

{% assign dataMapping1 = '
    ===
        image: /images/gateway/dashboard/data-mapping-0-ce.png,
        title: 点击右侧面板的"**Connectors configuration**"按钮。
    ===
        image: /images/gateway/dashboard/data-mapping-1-ce.png,
        title: 在打开窗口中，将"**Topic filter**"填为"**data/**"，将"**QoS**"选为"**0 - At most once**"，将"**Payload type**"选为 **JSON**。
'
%}

{% include images-gallery.liquid imageCollection=dataMapping1 %}

- 滚动到"**Data conversion（数据转换）**"部分：
  - 对于"**Device**"子节使用以下选项/值：
    - 在"**Name**"行，在"**Source**"下拉中选择"**Constant**"，在"**Value / Expression**"中填写"**Device Demo**"。
    - 在"**Profile name**"行，在"**Source**"下拉中选择"**Constant**"，在"**Value / Expression**"中填写"**default**"。

{% assign dataMapping2 = '
    ===
        image: /images/gateway/dashboard/data-mapping-2-ce.png,
        title: 滚动到"**Data conversion**"部分。对于"**Device**"子节：在 **Name** 行选择"**Constant**"并填写"**Device Demo**"；在"**Profile name**"行选择"**Constant**"并填写"**default**"。
'
%}

{% include images-gallery.liquid imageCollection=dataMapping2 %}

  - 点击"**Attributes**"子节旁的铅笔图标，在打开窗口中：
    - 点击"**Add attribute**"，在"**Key**"中填写"**frequency**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${frequency}**"。
    - 再次点击"**Add attribute**"，在"**Key**"中填写"**power**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${power}**"。
    - 点击"**Apply**"。

{% assign dataMapping3 = '
    ===
        image: /images/gateway/dashboard/data-mapping-3-ce.png,
        title: 点击"**Attributes**"子节旁的铅笔图标；
    ===
        image: /images/gateway/dashboard/data-mapping-4-ce.png,
        title: 点击"**Add attribute**"；
    ===
        image: /images/gateway/dashboard/data-mapping-5-ce.png,
        title: 在"**Key**"中填写"**frequency**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${frequency}**"。再次点击"**Add attribute**"；
    ===
        image: /images/gateway/dashboard/data-mapping-6-ce.png,
        title: 在"**Key**"中填写"**power**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${power}**"。点击"**Apply**"。
'
%}

{% include images-gallery.liquid imageCollection=dataMapping3 %} 

  - 点击"**Time series**"子节旁的铅笔图标，在打开窗口中：
    - 点击"**Add time series**"，在"**Key**"中填写"**temperature**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${temperature}**"。
    - 点击"**Add time series**"，在"**Key**"中填写"**humidity**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${humidity}**"。
    - 点击"**Apply**"。
- 点击"**Add**"。数据映射已添加。

{% assign dataMapping4 = '
    ===
        image: /images/gateway/dashboard/data-mapping-7-ce.png,
        title: 点击"**Time series**"子节旁的铅笔图标；
    ===
        image: /images/gateway/dashboard/data-mapping-8-ce.png,
        title: 点击"**Add time series**"；
    ===
        image: /images/gateway/dashboard/data-mapping-9-ce.png,
        title: 在"**Key**"中填写"**temperature**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${temperature}**"。再次点击"**Add time series**"；
    ===
        image: /images/gateway/dashboard/data-mapping-10-ce.png,
        title: 在"**Key**"中填写"**humidity**"，在"**Type**"中选择"**Integer**"，在"**Value**"中填写"**${humidity}**"。点击"**Apply**"；
    ===
        image: /images/gateway/dashboard/data-mapping-11-ce.png,
        title: 点击"**Add**"；
    ===
        image: /images/gateway/dashboard/data-mapping-12-ce.png,
        title: 数据映射已添加。点击"**Save**"。
'
%}

{% include images-gallery.liquid imageCollection=dataMapping4 %}

完成上述步骤后，网关将接收并应用新配置，并与远程服务器同步状态。可在"**Configuration**"列查看 connector 配置的同步状态，确认网关是否与远程设置一致。

此外，可查看 connector 日志以确认 connector 工作正常，操作如下：
{% assign seeConnectorLogs = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-mqtt-logs-14-ce.png,
        title: 在 connector 的"**General**"标签页中，开启"**Enable remote logging**"开关启用远程日志。在"**Log level**"下拉中选择"**DEBUG**"。点击"**Save**"应用更改；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-mqtt-11-ce.png,
        title: 点击日志图标打开 connector 日志页面；
    ===
        image: /images/gateway/dashboard/gateway-getting-started-mqtt-logs-12-ce.png,
        title: 可看到由"**Created time**"、"**Status**"和"**Message**"列组成的"**Logs**"表格。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=seeConnectorLogs %}

至此，网关已可通过新建并配置的 MQTT connector 处理数据。

下面向上述配置中的 MQTT Broker 发布数据。可使用 **mosquitto_pub** 或您所用编程语言的 MQTT 客户端库。本例使用 **mosquitto_pub** 命令行工具。

1. 确保系统已安装 Mosquitto MQTT 客户端。通常可通过操作系统包管理器安装：
- Ubuntu：
  ```bash
  sudo apt-get install mosquitto-clients
  ```
  {:.copy-code}

- Windows：

    从[官网](https://mosquitto.org/download/)下载 Mosquitto 客户端工具。

    安装后，将安装目录添加到系统 PATH。
- MacOS：
  ```bash
  brew install mosquitto
  ```
  {:.copy-code}

2. 使用 mosquitto_pub 向指定 MQTT topic 发布数据。本例使用配置中定义的 "data/" topic：
```bash
mosquitto_pub -h localhost -p 1884 -t data/ -m '{"frequency": 50, "power": 100, "temperature": 25, "humidity": 60}'
```
{:.copy-code}

其中：
- `-h` - 指定 MQTT broker 的 host 地址；
- `-p` - 指定 MQTT broker 的 port；
- `-t` - 指定要发布到的 MQTT topic（本例为 "data/"）；
- `-m` - 指定要发布的 payload 或消息。应为 JSON 格式，符合配置 mapping 部分中的结构。

请根据需要调整 payload 值。
