设备名和配置文件可从消息源和字节负载中提取。本示例使用 [切片](/docs/iot-gateway/config/mqtt/#slices) 指定设备名和常量配置文件。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

代理运行于 `0.0.0.0:1884`，向主题 `sensor/raw_data` 发布以下 BYTES 负载：

`b"AM-120"` — Python 字节字面量（ASCII）

假设要从该负载创建设备。前四个字节表示设备名，其余字节表示温度值。

配置 MQTT 连接器，从原始字节提取设备名，并使用常量作为设备配置文件（例如 `default`）。

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
        title: 选择已创建的 MQTT 连接器，选择“**基本**”并点击“**数据映射**”，再点击“**+ 添加映射**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-and-constant-bytes-4.png,
        title: 在打开的窗口中，“**主题过滤器**”填 `sensor/raw_data`，“**QoS**”填 `0`、`1` 或 `2` 之一，“**负载类型**”选 `Bytes`。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-and-constant-bytes-5.png,
        title: 在“**设备**”子部分，“**名称**”字段选“**Message**”，填 `[0:4]`，这些是用于提取设备名的 [切片](/docs/iot-gateway/config/mqtt/#slices)。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-and-constant-bytes-6.png,
        title: 在“**配置文件名称**”子部分，“**名称**”字段选“**Constant**”，填 `default`，这是用于形成设备配置文件名的**常量**值。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-and-constant-bytes-7.png,
        title: 还需要至少添加一个属性/时序数据，因为连接器不会添加无可读数据的设备。前四个字节表示设备名，其余字节表示温度值。点击“**时序数据**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-and-constant-bytes-8.png,
        title: 在打开的窗口中，点击“**添加时序数据**”按钮并按对应图片填写字段。不要忘记保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAndProfileTopicAndConstantJson %}

可以检查设备名和配置文件是否正确设置。进入“**实体**”→“**设备**”，设备名应为 `AM-1`，配置文件为 `default`。

![image](/images/gateway/mqtt-connector/examples/device-name-and-profile-message-and-constant-bytes-9.png)

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
        "attributes": [],
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
