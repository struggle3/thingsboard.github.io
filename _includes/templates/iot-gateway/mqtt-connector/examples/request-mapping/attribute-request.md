对于属性请求，网关需要知道目标设备名和要请求的属性。可使用 [json-path](/docs/iot-gateway/config/mqtt/#json-path) 从 `Message` 负载提取设备名，
也可用 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions) 从主题提取。设备名在 JSON 消息中时选择 [json-path](/docs/iot-gateway/config/mqtt/#json-path)；编码在主题中时选择 [正则表达式](/docs/iot-gateway/config/mqtt/#regular-expressions)。

假设要为设备 `SN-001` 从 ThingsBoard 获取当前固件版本，以便根据固件版本做决策。

{% capture difference %}
**请注意：**
**属性请求**允许设备从 ThingsBoard 获取属性值，适用于：
- 获取存储为共享属性的配置参数
- 获取此前上报的客户端属性
- 实现设备配置管理

网关作为桥梁，接收设备的属性请求，从 ThingsBoard 获取属性，并将响应返回给设备。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

在 MQTT 连接器中配置属性请求，使设备能从 ThingsBoard 请求属性值。演示两种提取设备名的方式：

- 从消息（`JSON` 负载）。
- 从主题（如 `sensor/SN-001/attributes/request`）。

按以下步骤操作：

{% assign deviceNameAttributeJson = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-gateway.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/mqtt-gateway-configuring-11-ce.png,
        title: 选择 MQTT 连接器，点击“**基本**”，在“**请求映射**”下点击“**添加映射**”以添加新的属性请求映射。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-request-1.png,
        title: 在**请求类型**中选择“**属性请求**”，将“**主题过滤器**”填为 `v1/devices/me/attributes/request`。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-request-2.png,
        title: 配置设备名和属性。设备名表达式选择来源类型 `Message`，值填 `${serialNumber}`。属性名表达式选择来源类型 `Message`，值填 `${versionAttribute}, ${pduAttribute}`。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-request-3.png,
        title: 将响应主题配置为 `devices/${deviceName}/attrs`，响应值表达式为 `${attributeKey}: ${attributeValue}`。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-request-4.png,
        title: 记得点击相应按钮保存更改。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAttributeJson %}

下面用两个示例演示如何使用这些属性请求配置：

### 示例 1：设备名和属性来自消息负载

假设某设备在 ThingsBoard 中有共享属性 `firmwareVersion`，我们需要因某些目的请求该属性。

先在 ThingsBoard 中为设备 `SN-001` 添加该属性：

1. 进入“**设备**”→选择设备 `SN-001`→“**属性**”标签→选择“**共享属性**”。

2. 点击“**+**”图标，添加 `firmwareVersion` 属性，类型为“**字符串**”，值设为 `1.2.3`，点击“**添加**”。

![image](/images/gateway/mqtt-connector/examples/result-device-overview-attribute-requests-1.png)

此消息的设备名在 JSON 负载中，通过 `${serialNumber}` 提取；属性名通过 `${attributeNames}` 提取。处理完成后，ThingsBoard 将获取设备 "SN-001" 的 "firmwareVersion" 属性并发布到响应主题。

响应将发布到主题 `devices/SN-001/attrs`，负载类似如下：订阅响应主题以查看结果：
在终端执行以下命令并按回车：

```bash
mosquitto_sub -h 127.0.0.1 -p 1884 -t devices/SN-001/attrs
```
{: .copy-code}

在另一终端模拟设备向 MQTT 代理发送包含设备名和属性名的 JSON 负载消息：

```bash
mosquitto_pub -h 127.0.0.1 -p 1884 -t v1/devices/me/attributes/request -m '{"serialNumber": "SN-001", "versionAttribute": "firmwareVersion"}'
```
{: .copy-code}

此消息的设备名在 JSON 负载中，通过 `${serialNumber}` 提取，属性名通过 `${attributeNames}` 提取。处理完成后，ThingsBoard 将获取设备 `SN-001` 的 `firmwareVersion` 属性并发布到响应主题。

![image](/images/gateway/mqtt-connector/examples/result-device-overview-attribute-requests-2.png)

```bash
firmwareVersion: "1.2.3"
```

![image](/images/gateway/mqtt-connector/examples/result-device-overview-attribute-requests-3.png)



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
  "mapping": [
    {
      "topicFilter": "sensor/data",
      "subscriptionQos": 1,
      "converter": {
        "type": "json",
        "deviceInfo": {
          "deviceNameExpressionSource": "message",
          "deviceNameExpression": "${serialNumber}",
          "deviceProfileExpressionSource": "message",
          "deviceProfileExpression": "${sensorType}"
        },
        "timeout": 60000,
        "attributes": [
    
        ],
        "timeseries": [
          {
            "type": "string",
            "key": "temperature",
            "value": "${temp}"
          }
        ]
      }
    }
  ],
  "requestsMapping": {
    "attributeRequests": [
      {
        "retain": false,
        "topicFilter": "v1/devices/me/attributes/request",
        "deviceInfo": {
          "deviceNameExpressionSource": "message",
          "deviceNameExpression": "${serialNumber}"
        },
        "attributeNameExpressionSource": "message",
        "attributeNameExpression": "${attributeNames}",
        "topicExpression": "v1/devices/${deviceName}/attributes/response",
        "valueExpression": "{\"${attributeKey}\": \"${attributeValue}\"}"
      }
    ]
  }
}
```
{:.copy-code.expandable-15}
