BACnet 连接器允许您使用表达式设置动态设备名称和配置文件。当您有多台具有相似配置的设备并希望根据其属性区分它们时，此功能尤其有用。
本示例中，我们将配置 BACnet 设备根据其 `objectName` 和 `address` 属性具有动态设备名称，并根据其 `vendorId` 属性具有动态设备配置文件。

以下为具有动态设备名称和配置文件的 BACnet 设备配置示例片段：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "YOUR_HOST",
    "port": 47808,
    "mask": 24,
    "objectIdentifier": 599,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "vendorIdentifier": 15,
    "deviceDiscoveryTimeoutInSec": 5,
    "devicesDiscoverPeriodSeconds": 30
  },
  "devices": [
    {
      "host": "*",
      "port": "*",
      "pollPeriod": 10000,
      "deviceInfo": {
        "deviceNameExpressionSource": "expression",
        "deviceNameExpression": "${objectName} at ${address}",
        "deviceProfileExpressionSource": "expression",
        "deviceProfileExpression": "${vendorId}_profile"
      },
      "attributes": [],
      "timeseries": "*",
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}

在此配置中：
- `deviceNameExpression` 设为 `${objectName} at ${address}`，将创建设备名称，包含设备对象名称和地址。
- `deviceProfileExpression` 设为 `${vendorId}_profile`，将根据设备的厂商标识符创建设备配置文件名称。

应用此配置后，设备将以反映其特定属性的名称和配置文件创建。下方截图显示设备在 ThingsBoard 中的动态名称和配置文件显示方式：

![image](/images/gateway/bacnet-connector/examples/dynamic-device-name-and-profile-overview.png)

如您所见，设备名称根据 `objectName` 和 `address` 生成，设备配置文件根据 `vendorId` 生成。

设备名称/配置文件的动态表达式为管理具有不同配置的多台 BACnet 设备提供了灵活性，有助于在 ThingsBoard 中有效组织设备。

{% capture dynamicDeviceNameProfileExample %}
完整可用变量列表请参阅
[高级配置](/docs/iot-gateway/config/bacnet/#available-variables-for-device-nameprofile-expressions) 部分。
{% endcapture %}
{% include templates/info-banner.md content=dynamicDeviceNameProfileExample %}
