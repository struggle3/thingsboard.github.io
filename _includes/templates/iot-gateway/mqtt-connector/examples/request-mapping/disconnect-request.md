对于断开连接请求，网关需要知道目标设备名。可使用 [json-path](/docs/iot-gateway/config/mqtt/#json-path) 从 `Message` 负载提取，
也可用 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions) 从主题提取。设备名在 JSON 消息中时选择 [json-path](/docs/iot-gateway/config/mqtt/#json-path)；编码在主题中时选择 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions)。

假设希望让设备 `SN-001` 立即从平台断开，而无需等待 10 分钟不活跃超时——便于仪表盘、告警和规则链对状态变更做出反应。

{% capture difference %}
**请注意：**
**断开连接请求**会立即告知平台设备已离线，并停止向其路由 **RPC** 和 **属性更新**。
它不会阻断 MQTT 流量：若设备（或网关）继续发布，新消息仍会到达，设备可能根据 10 分钟不活跃超时再次被标记为活跃。
界面中的“活跃”标志遵循最后活动时间；除非不再有消息到达，否则超时前可能仍显示活跃。
.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

在 MQTT 连接器中配置断开连接请求，以在设备断开时通知平台。演示两种提取设备名的方式：

- 从消息（`JSON` 负载）。
- 从主题（如 `sensor/SN-001/disconnect`）。

按以下步骤操作：

{% assign deviceNameDisconnectJson = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-gateway.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/mqtt-gateway-configuring-11-ce.png,
        title: 选择 MQTT 连接器，点击“**基本**”。在“**请求映射**”下点击“**添加映射**”以添加新的断开连接请求映射。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-1.png,
        title: 在**请求类型**中选择“**断开连接请求**”，将“**主题过滤器**”填为 `sensor/disconnect`。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-2.png,
        title: **名称**字段的来源类型选 `Message`。值中设备名填 `${serialNumber}`。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-3.png,
        title: 记得点击相应按钮保存更改。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-4.png,
        title: 在**请求类型**中选择“**断开连接请求**”，将“**主题过滤器**”填为 `sensor/+/disconnect`。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-5.png,
        title: **名称**字段的来源类型选 `Topic`。值中设备名填 `(?<=sensor/)(.*?)(?=/disconnect)`。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-6.png,
        title: 记得点击相应按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameDisconnectJson %}

下面用两个示例演示如何使用这些断开连接请求配置：

![image](/images/gateway/mqtt-connector/examples/result-device-overview-1-disconnect.png)

### 示例 1：设备名来自消息负载

当设备名包含在消息负载中时，可按以下方式发送断开连接请求：

```bash
mosquitto_pub -h 127.0.0.1 -p 1884 -t "sensor/disconnect" -m '{"serialNumber": "SN-001"}'
```
{: .copy-code}

此消息的设备名在 JSON 负载中，通过 `${serialNumber}` 提取。处理完成后，ThingsBoard 会将设备 `SN-001` 标记为已断开。

![image](/images/gateway/mqtt-connector/examples/result-device-overview-2-disconnect.png)

### 示例 2：设备名来自主题

当设备名编码在主题路径中时，可按以下方式发送断开连接请求：

```bash
mosquitto_pub -h 127.0.0.1 -p 1884 -t "sensor/SN-001/disconnect" -m ''
```
{: .copy-code}

此情况下，设备名通过正则表达式 `(?<=sensor/)(.*?)(?=/disconnect)` 从主题提取。处理完成后，ThingsBoard 会将设备 `SN-001` 标记为已断开。

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
    "disconnectRequests": [
      {
        "topicFilter": "sensor/disconnect",
        "deviceInfo": {
          "deviceNameExpression": "${serialNumber}",
          "deviceNameExpressionSource": "message"
        }
      },
      {
        "topicFilter": "sensor/+/disconnect",
        "deviceInfo": {
          "deviceNameExpression": "(?<=sensor/)(.*?)(?=/disconnect)",
          "deviceNameExpressionSource": "topic"
        }
      }
    ]
  }
}
```
{:.copy-code.expandable-15}
