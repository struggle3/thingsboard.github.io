当网络中有许多设备具有相同的对象列表且需要读取其值时，为每个设备复制配置并不方便。BACnet 连接器允许您自动查找网络上的所有设备，并使用相同配置连接它们。为此，您需要指定设备的 host 和 port，以及设备名称和设备配置文件的模板。

让我们看一个如何正确配置自动设备发现的示例。

假设我们有两台具有相同对象列表的设备：

| Object Type  | Object ID | Property ID   | Key         |
|--------------|-----------|---------------|-------------|
| Analog Input | 1         | Present Value | temperature |
| Binary Input | 1         | Present Value | relay       |
| Analog Input | 2         | Present Value | humidity    |
| Analog Input | 3         | Present Value | pressure    |
| ---          |           |               |             |

要配置自动设备发现，请使用以下 BACnet 连接器配置：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "YOUR_HOST",
    "port": 47808,
    "objectIdentifier": 599,
    "vendorIdentifier": 15,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "deviceDiscoveryTimeoutInSec": 5
  },
  "devices": [
    {
      "altResponsesAddresses": [],
      "host": "*",
      "port": "*",
      "deviceInfo": {
        "deviceNameExpression": "${objectName}",
        "deviceProfileExpression": "default",
        "deviceNameExpressionSource": "expression",
        "deviceProfileExpressionSource": "constant"
      },
      "pollPeriod": 10000,
      "timeseries": [
        {
          "key": "temperature",
          "objectType": "analogInput",
          "objectId": 1,
          "propertyId": "presentValue"
        },
        {
          "key": "relay",
          "objectType": "binaryInput",
          "objectId": 1,
          "propertyId": "presentValue"
        },
        {
          "key": "humidity",
          "objectType": "analogInput",
          "objectId": 2,
          "propertyId": "presentValue"
        },
        {
          "key": "pressure",
          "objectType": "analogInput",
          "objectId": 3,
          "propertyId": "presentValue"
        }
      ],
      "attributes": [],
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}

以下为主要参数，用于正确配置自动设备检测。我们来详细了解：

- `host` - 需指定为 `*`，以便连接器接受来自网络上所有设备的所有 IAm 消息。
- `port` - 需指定为 `*`，以便连接器接受来自网络上所有设备的所有 IAm 消息。
- `deviceNameExpression` - 设备名称的模板。使用 `${objectName}` 将设备名称与 BACnet 网络中的对象名称匹配。
- `deviceProfileExpression` - 设备配置文件的模板。本例中我们使用 `default`，因为所有设备类型相同。

保存更改并启动连接器后，它将向网络发送 WhoIs 查询并开始接收来自所有设备的 IAm 消息。收到 IAm 消息后，连接器将为每个发现的设备使用指定模板自动创建设备，并开始从对象读取数据。下方截图显示自动发现后的设备列表：

![image](/images/gateway/bacnet-connector/examples/discovered-devices-overview.png)
