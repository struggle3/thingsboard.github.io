设备名和配置文件可从主题中提取。本示例使用 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions) 指定设备名和常量配置文件。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

代理运行于 `0.0.0.0:1884`，向主题 `sensor/Thermo-A/data` 发布数据（其中 `Thermo-A` 为设备名），负载如下：

```json
{
    "sensorModel": "T-100",
    "temp": 23.82,
    "hum": 60.3
}
```
匹配该主题时，可在**主题过滤器**中填 `sensor/Thermo-A/data`，或使用[通配符](/docs/iot-gateway/config/mqtt/#wildcard-usage)
同时订阅 `sensor/Thermo-A/data` 及如 `sensor/Thermo-B/data` 等主题。

配置 MQTT 连接器，使设备名从主题获取，配置文件使用常量（如 `Thermometer`）。按以下步骤操作：

{% assign deviceNameAndProfileTopicAndConstantJson = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-3.png,
        title: 选择已创建的 MQTT 连接器，选择“**基本**”并点击“**数据映射**”，再点击“**+ 添加映射**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-topic-constant-json-4.png,
        title: 在打开的窗口中，“**主题过滤器**”填 `sensor/+/data`，“**QoS**”填 `0`、`1` 或 `2` 之一，“**负载类型**”选 `JSON`。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-topic-constant-json-5.png,
        title: 在“**设备**”子部分，“**名称**”字段选“**Topic**”，填 `(?<=sensor/)(.*?)(?=/data)`，这是用于提取设备名的 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions)。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-topic-constant-json-6.png,
        title: 在“**配置文件名称**”子部分，“**名称**”字段选“**Constant**”，填 `Thermometer`，这是用于形成设备配置文件名的**常量**值。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-topic-constant-json-7.png,
        title: 还需要至少添加一个属性/时序数据，因为连接器不会添加无可读数据的设备。点击“**时序数据**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-8.png,
        title: 在打开的窗口中，点击“**添加时序数据**”按钮并按对应图片填写字段。不要忘记保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAndProfileTopicAndConstantJson %}

可以检查设备名和配置文件是否正确设置。进入“**实体**”→“**设备**”，设备名应为 `Thermo-A`，配置文件为 `Thermometer`。

![image](/images/gateway/mqtt-connector/examples/device-name-and-profile-topic-constant-json-9.png)

若使用高级配置模式并需用主题和 json path 设置设备名和配置文件，可使用以下配置：

```json
{
  "broker": {
    "host": "127.0.0.1",
    "port": 1884,
    "clientId": "ThingsBoard_gateway",
    "version": 5,
    "maxMessageNumberPerWorker": 10,
    "maxNumberOfWorkers": 100,
    "keepAlive": 60,
    "cleanSession": true,
    "cleanStart": true,
    "sessionExpiryInterval": 0,
    "security": {
      "type": "anonymous"
    }
  },
  "mapping": [
    {
      "topicFilter": "sensor/+/data",
      "subscriptionQos": 1,
      "converter": {
        "type": "json",
        "deviceInfo": {
          "deviceNameExpression": "(?<=sensor/)(.*?)(?=/data)",
          "deviceNameExpressionSource": "topic",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "Thermometer"
        },
        "attributes": [],
        "timeseries": [
          {
            "key": "temperature",
            "type": "double",
            "value": "${temp}"
          }
        ]
      }
    }
  ],
  "requestsMapping": {}
}
```
{:.copy-code.expandable-15}
