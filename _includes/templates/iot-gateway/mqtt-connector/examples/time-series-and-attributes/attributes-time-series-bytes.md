在 MQTT 连接器中，可使用[切片](/docs/iot-gateway/config/mqtt/#slices)获取属性和时序数据，
从订阅主题收到的 `BYTES` 负载中提取所需字段。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

代理运行于 `0.0.0.0:1884`，向主题 `sensor/raw_data` 发布以下 BYTES 负载：

`b"AM-120"` — Python 字节字面量（ASCII）

前四个字节表示设备名，其余字节表示温度值。
配置 MQTT 连接器，将原始负载存入 `rawData` 属性，解析第 5–6 字节为 `temperature` 并发布为 temp 时序数据。然后配置 MQTT 连接器中的设备名和配置文件。

按以下步骤操作：

{% assign deviceNameAndProfileIdentifierPath = '
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
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-bytes-2.png,
        title: 在打开的数据映射窗口中，点击“**属性**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-bytes-3.png,
        title: 点击“**添加属性**”按钮。“**键**”填 `rawData`，“**类型**”选 `Raw`，“**值**”填 `[:]`。这来自[切片](/docs/iot-gateway/config/mqtt/#slices)。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-bytes-4.png,
        title: 记得点击截图中的相应按钮保存更改。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-bytes-5.png,
        title: 在打开的数据映射窗口中，点击“**时序数据**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-bytes-6.png,
        title: 点击“**添加时序数据**”按钮。“**键**”填 `temp`，“**类型**”选 `Raw`，“**值**”填 `[4:]`。这来自[切片](/docs/iot-gateway/config/mqtt/#slices)。
     ===
        image: /images/gateway/mqtt-connector/examples/attributes-time-series-bytes-7.png,
        title: 记得点击截图中的相应按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAndProfileIdentifierPath %}

可以检查属性数据是否正确设置。进入“**实体**”→“**设备**”，选择已创建设备，可在“**属性**”部分看到湿度数据：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-4.png)

可以检查温度数据是否发送正确。进入“**实体**”→“**设备**”，选择已创建设备，可在“**最新遥测**”部分看到湿度数据：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-3.png)

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
      "topicFilter": "sensor/raw_data",
      "subscriptionQos": 1,
      "converter": {
        "type": "bytes",
        "deviceInfo": {
          "deviceNameExpression": "[0:4]",
          "deviceNameExpressionSource": "message",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "default"
        },
        "attributes": [
           {
            "key": "rawData",
            "type": "raw",
            "value": "[:]"
          }
        ],
        "timeseries": [
          {
            "key": "temp",
            "type": "raw",
            "value": "[4:]"
          }
        ]
      }
    }
  ],
  "requestsMapping": {}
}
```
{:.copy-code.expandable-15}
