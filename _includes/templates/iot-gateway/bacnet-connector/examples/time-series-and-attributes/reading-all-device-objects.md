当 BACnet 设备有许多对象，您希望读取设备的所有对象而无需在连接器配置中手动添加每个对象时，或当您不知道设备中有哪些对象并希望自动读取所有对象时，BACnet 连接器支持此功能，允许您通过轻松配置一个参数即可读取设备的所有对象。

让我们看一个如何正确配置读取所有设备对象的示例。

要读取所有设备对象，您需要决定这些对象的值将存储在哪里：`telemetry` 或 `attributes`。根据此选择，需在相应部分放入 `*`。

在本例中，我们将把所有对象存储在时序中，因此设备配置如下：

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
      "host": "YOUR_DEVICE_HOST",
      "port": 47808,
      "deviceInfo": {
        "deviceNameExpression": "${objectName}",
        "deviceProfileExpression": "default",
        "deviceNameExpressionSource": "expression",
        "deviceProfileExpressionSource": "constant"
      },
      "pollPeriod": 10000,
      "timeseries": "*",
      "attributes": [],
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}

从上述配置可以看出，我们在 `timeseries` 部分放入了 `*`，表示所有设备对象将保存到遥测中。在 `attributes` 部分我们没有放入 `*`，因此不会读取属性。

保存更改并启动连接器后，您可以看到对应设备已添加到平台，其遥测开始填充所有设备对象：

![image](/images/gateway/bacnet-connector/examples/device-objects-overview.png)
