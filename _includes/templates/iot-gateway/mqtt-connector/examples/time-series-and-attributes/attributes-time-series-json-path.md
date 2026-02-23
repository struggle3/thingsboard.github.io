在 MQTT 连接器中，可使用 [json-path](/docs/iot-gateway/config/mqtt/#json-path) 获取属性和时序数据，
从订阅主题收到的 `JSON` 负载中提取所需字段。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

代理运行于 `0.0.0.0:1884`，向主题 `sensor/data` 发布以下 JSON 负载：

```json
{
    "serialNumber": "SN-001",
    "sensorType": "Thermometer",
    "sensorModel": "T-100",
    "temp": 22.82,
    "hum": 59.3
}
```
将 `sensorModel` 映射为 `model`，`temp` 映射为时序数据 `temperature`。接下来在 MQTT 连接器中配置设备名和配置文件。
按以下步骤操作：

{% assign deviceNameAndProfileTopicAndConstantJson = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-3.png,
        title: 选择 MQTT 连接器，点击“**数据映射**”标签。选择要添加时序数据的数据映射（若不清楚如何添加新设备，请参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=opcua){:target="_blank"}或本指南的[数据映射](/docs/iot-gateway/config/opc-ua/#data-mapping)及相应示例）。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-json-path-2.png,
        title: 在打开的数据映射窗口中，点击“**属性**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-json-path-3.png,
        title: 点击“**添加属性**”按钮。“**键**”填 `model`，“**类型**”选 `String`，“**值**”填 `${sensorModel}`。这来自 [json-path](/docs/iot-gateway/config/mqtt/#json-path)。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-json-path-4.png,
        title: 记得点击相应按钮保存更改。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-json-path-5.png,
        title: 在打开的数据映射窗口中，点击“**时序数据**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-json-path-6.png,
        title: 点击“**添加时序数据**”按钮。“**键**”填 `temperature`，“**类型**”选 `Double`，“**值**”填 [json-path](/docs/iot-gateway/config/mqtt/#json-path) `${temp}`。
     ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-json-path-7.png,
        title: 记得点击相应按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAndProfileTopicAndConstantJson %}

可以检查属性数据是否正确设置。进入“**实体**”→“**设备**”，选择已创建设备，可在“**属性**”部分看到湿度数据：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-2.png)

可以检查温度数据是否发送正确。进入“**实体**”→“**设备**”，选择已创建设备，可在“**最新遥测**”部分看到湿度数据：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-1.png)

若使用高级配置模式并需用 [json-path](/docs/iot-gateway/config/mqtt/#json-path) 设置 `temperature` 和 `model` 数据，可使用以下配置：

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
      "topicFilter": "sensor/data",
      "subscriptionQos": 1,
      "converter": {
        "type": "json",
        "deviceInfo": {
          "deviceNameExpression": "${serialNumber}",
          "deviceNameExpressionSource": "message",
          "deviceProfileExpressionSource": "message",
          "deviceProfileExpression": "${sensorType}"
        },
        "attributes": [
          {
            "key": "model",
            "type": "string",
            "value": "${sensorModel}"
          }
        ],
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
