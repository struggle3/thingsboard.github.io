对于连接请求，网关需要知道目标设备名。可使用 [json-path](/docs/iot-gateway/config/mqtt/#json-path) 从 `Message` 负载提取，
也可用 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions) 从主题提取。设备名在 JSON 消息中时选择 [json-path](/docs/iot-gateway/config/mqtt/#json-path)；编码在主题中时选择 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions)。

设备 `SN-001` 已 10 分钟未发送遥测且被标记为不活跃，但您仍需发送 RPC（且暂不打算恢复遥测）。
在 MQTT 连接器中配置连接请求，以（重新）宣告设备，使 RPC 能下发。演示两种提取设备名的方式：

- 从消息（`JSON` 负载）。
- 从主题（如 `sensor/SN-001/connect`）。

按以下步骤操作：

{% assign deviceNameAndProfileTopicAndConstantJson = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-gateway.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/mqtt-gateway-configuring-11-ce.png,
        title: 选择 MQTT 连接器，点击“**基本**”。在“**请求映射**”下点击“**添加映射**”以添加新的连接请求映射。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-1.png,
        title: 在**请求类型**中选择 `Connect request`，将“**主题过滤器**”填为 `sensor/connect`。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-2.png,
        title: **名称**来源选 `Message`，**配置文件名称**来源选 `Constant`。值中设备名填 `${serialNumber}`，设备配置文件填 `Thermometer`。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-3.png,
        title: 记得点击相应按钮保存更改。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-4.png,
        title: 在**请求类型**中选择 `Connect request`，将“**主题过滤器**”填为 `sensor/+/connect`。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-5.png,
        title: **名称**来源选 `Topic`，**配置文件名称**来源选 `Constant`。值中设备名填 `(?<=sensor/)(.*?)(?=/connect)`，设备配置文件填 `Thermometer`。
    ===
        image: /images/gateway/mqtt-connector/examples/connect-request-6.png,
        title: 记得点击相应按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAndProfileTopicAndConstantJson %}

10 分钟无遥测后，设备 `SN-001` 在 ThingsBoard 中被标记为不活跃，如下图所示：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-1-connect.png)

为重新激活设备以接收 RPC 命令，需发送连接请求。下面用两个示例演示：

### 示例 1：设备名来自消息负载

在终端模拟设备向 MQTT 代理发送包含设备名的 JSON 负载消息：

```bash
mosquitto_pub -h 127.0.0.1 -p 1884 -t "sensor/connect" -m '{"serialNumber": "SN-001"}'
```
{: .copy-code}

发送后，ThingsBoard 会更新设备 `SN-001` 的 lastActivityTime 和 lastConnectTime，其状态变为 `Active`：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-connect-2.png)

![image](/images/gateway/mqtt-connector/examples/result-device-overview-connect-3.png)


### 示例 2：设备名来自主题

使用第二种映射配置也可实现同样效果，设备名从主题而非消息负载中提取：

```bash
mosquitto_pub -h 127.0.0.1 -p 1884 -t "sensor/SN-001/connect" -m ''
```
{: .copy-code}


若使用高级配置模式，可使用以下配置：

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
  "mapping": [],
  "requestsMapping": {
    "connectRequests": [
      {
        "topicFilter": "sensor/connect",
        "deviceInfo": {
          "deviceNameExpression": "${serialNumber}",
          "deviceNameExpressionSource": "message",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "Thermometer"
        }
      },
      {
        "topicFilter": "sensor/+/connect",
        "deviceInfo": {
          "deviceNameExpression": "(?<=sensor/)(.*?)(?=/connect)",
          "deviceNameExpressionSource": "topic",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "Thermometer"
        }
      }
    ]
  }
}
```
{:.copy-code.expandable-15}
