当 BACnet 设备有许多对象，而您只想读取设备中的特定对象或属性时，可使用筛选选项指定应收集并发送到平台的数据。

让我们看一个如何正确配置筛选功能的示例。

在本例中，我们的设备有许多对象，但我们只想读取前三个 `Analog Value` 对象的 `presentValue` 和 `units` 属性。为此，需要如下在属性/时序部分配置筛选选项：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "YOUR_HOST",
    "port": 47808,
    "mask": "24",
    "objectIdentifier": 599,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "vendorIdentifier": 15,
    "deviceDiscoveryTimeoutInSec": 5,
    "devicesDiscoverPeriodSeconds": 30
  },
  "devices": [
    {
      "deviceInfo": {
        "deviceNameExpression": "BACnet Device ${objectName}",
        "deviceProfileExpression": "default",
        "deviceNameExpressionSource": "expression",
        "deviceProfileExpressionSource": "constant"
      },
      "altResponsesAddresses": [],
      "host": "YOUR_DEVICE_HOST",
      "port": "YOUR_DEVICE_PORT",
      "pollPeriod": 10000,
      "attributes": [],
      "timeseries": [
        {
          "key": "${objectName} ${objectType}",
          "objectType": "analogValue",
          "objectId": "1-3",
          "propertyId": ["presentValue", "units"]
        }
      ],
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}

从上述配置可以看出，我们已将 `objectType` 指定为 `analogValue`，`objectId` 指定为 `1-3`（表示读取 ID 为 1 到 3 的对象），`propertyId` 指定为包含 `presentValue` 和 `units` 的数组。此配置将确保仅读取并发送所选对象的指定属性到平台。此外，我们将 `key` 指定为 `${objectName} ${objectType}`，以便遥测 key 更具描述性。

保存更改并启动连接器后，您可以看到对应设备已添加到平台，其遥测开始填充筛选后的数据。下方截图显示应用筛选配置后设备遥测的示例：

![image](/images/gateway/bacnet-connector/examples/filtering-objects-and-properties-overview.png)
