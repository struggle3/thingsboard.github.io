对于属性更新，网关需要知道哪些设备应接收哪些属性的更新。通过设备名和属性名的正则表达式配置。当 ThingsBoard 中某属性更新时，网关会将新值发布到配置的 MQTT 主题。

假设希望 ThingsBoard 将固件版本更新自动推送到设备。在 ThingsBoard 中更新 `firmwareVersion` 共享属性时，网关应将该更新发布到设备订阅的主题。

{% capture difference %}
**请注意：**
**属性更新**允许 ThingsBoard 将共享属性变更推送到设备，适用于：
- 远程配置设备
- 推送固件/软件版本信息
- 向设备发送运行参数
- 实现设备配置管理

网关作为桥梁，检测 ThingsBoard 中的属性变更并发布到设备可订阅的 MQTT 主题。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

在 MQTT 连接器中配置属性更新，使 ThingsBoard 能将属性变更推送到设备。

按以下步骤操作：

{% assign AttributesUpdate = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-gateway.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/mqtt-gateway-configuring-11-ce.png,
        title: 选择 MQTT 连接器，点击“**基本**”。在“**请求映射**”下点击“**添加映射**”以添加新的属性更新映射。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-updates-1.png,
        title: 在**请求类型**中选择“**属性更新**”，将“**设备名过滤器**”填为 `.*` 以匹配所有设备，或使用特定模式仅匹配部分设备。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-updates-2.png,
        title: 将**属性过滤器**配置为 `firmwareVersion` 以仅更新该属性。**响应主题表达式**设为 `sensor/${deviceName}/${attributeKey}`，**响应值表达式**设为 `{"${attributeKey}":"${attributeValue}"}`。可设置**保留**选项决定 MQTT 代理是否保留属性更新消息。
    ===
        image: /images/gateway/mqtt-connector/examples/attribute-updates-3.png,
        title: 记得点击相应按钮保存更改。
    ===
        image: /images/gateway/mqtt-connector/examples/result-device-overview-attribute-updates-1.png,
        title: 进入“**设备**”→选择设备 `SN-001`→“**属性**”标签→选择“**共享属性**”
    ===
        image: /images/gateway/mqtt-connector/examples/result-device-overview-attribute-updates-2.png,
        title: 添加 `firmwareVersion` 属性，类型为“**字符串**”，值设为 "1.2.3"。
    ===
        image: /images/gateway/mqtt-connector/examples/result-device-overview-attribute-updates-3.png,
        title: 找到 `firmwareVersion` 属性并点击铅笔图标进行编辑。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=AttributesUpdate %}

下面演示如何使用该属性更新配置：

### 示例：在 ThingsBoard 中更新设备属性

1. 先订阅将发布属性更新的主题：

```bash
mosquitto_sub -h 127.0.0.1 -p 1884 -t sensor/SN-001/firmwareVersion
```
{: .copy-code}

2. 在 ThingsBoard 中更新属性后，网关会检测变更并将消息发布到配置的主题：

```json
{"firmwareVersion":"1.2.4"}
```

![image](/images/gateway/mqtt-connector/examples/result-device-overview-attribute-updates-4.png)

订阅 `sensor/SN-001/firmwareVersion` 主题的任何设备都会收到该消息。

![image](/images/gateway/mqtt-connector/examples/result-device-overview-attribute-updates-5.png)

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
    "attributeUpdates": [
      {
        "retain": true,
        "deviceNameFilter": ".*",
        "attributeFilter": "firmwareVersion",
        "topicExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
    ]
  }
}
```
{:.copy-code.expandable-15}
