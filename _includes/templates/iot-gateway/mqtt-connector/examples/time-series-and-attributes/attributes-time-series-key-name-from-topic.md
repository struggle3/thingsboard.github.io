某些场景下，时序数据和属性的键名需要直接从 MQTT 主题结构中提取。这在处理动态主题或主题结构包含重要元数据时尤其有用。本示例演示如何配置 MQTT 连接器，用正则表达式从主题提取时序数据的键名。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

代理运行于 `0.0.0.0:1884`，向主题 `sensors/demo-device/{sensor-name}/value` 发布数据。
主题中的 `{sensor-name}` 为动态部分，代表不同传感器，如 `temperature` 或 `humidity`。

因此主题形式如下：
- `sensors/demo-device/temperature/value`，负载为 `{"value": 25.5}`
- `sensors/demo-device/humidity/value`，负载为 `{"value": 60.2}`

我们将把主题中的 `{sensor-name}` 映射为时序数据。

将以下配置复制粘贴到 MQTT 连接器高级配置模式中：
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
      "topicFilter": "sensors/demo-device/+/value",
      "subscriptionQos": 0,
      "converter": {
        "type": "json",
        "deviceInfo": {
          "deviceNameExpressionSource": "constant",
          "deviceNameExpression": "Demo Device",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "default"
        },
        "timeout": 60000,
        "attributes": [],
        "timeseries": [
          {
            "type": "double",
            "keySource": "topic",
            "key": "(?<=sensors/demo-device/)(.*?)(?=/value)",
            "value": "${value}"
          }
        ]
      }
    }
  ],
  "requestsMapping": {}
}
```
{:.copy-code}

配置要点如下：
- `topicFilter` 设为 `sensors/demo-device/+/value`，`+` 通配符用于捕获动态传感器名。
- 在 `timeseries` 部分，`key` 字段使用正则表达式从主题提取传感器名。正则 `(?<=sensors/demo-device/)(.*?)(?=/value)` 捕获 `sensors/demo-device/` 与 `/value` 之间的部分。
- `keySource` 设为 `topic`，表示键名从主题提取。
- `value` 字段使用 `${value}` 从 JSON 负载提取实际传感器值。

应用该配置后，MQTT 连接器会从主题提取传感器名并用作时序数据的键名，您应能看到对应时序数据正确更新：

![image](/images/gateway/mqtt-connector/examples/time-series-key-name-from-topic-overview.png)
