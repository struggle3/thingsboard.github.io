RPC 到设备允许向直接连接或通过网关连接 ThingsBoard 的设备发送 RPC 命令。

例如，我们将使用带温度传感器的 BACnet 控制器。我们还知道温度传感器的对象 ID 为：`Analog Value:1`，因此将使用 RPC 到设备读取该值。要调用此方法，首先需要配置 BACnet 连接器以支持 RPC 调用。为此，请按以下步骤操作：

{% assign rpcToDevice = '
    ===
        image: /images/gateway/bacnet-connector/examples/select-created-gateway.png,
        title: 在左侧边栏中进入 "**实体**" → "**网关**" 并选择您的网关。
    ===
        image: /images/gateway/bacnet-connector/examples/select-connector-configuration.png,
        title: 点击右侧菜单的 "**连接器配置**" 按钮。
    ===
        image: /images/gateway/bacnet-connector/examples/select-device-configuration.png,
        title: 选择已创建的 BACnet 连接器并点击 "**设备**" 标签。确保已配置并连接设备（若不知如何操作，请参阅本指南的 [应用设置](/docs/iot-gateway/config/bacnet/#application) 和 [数据映射](/docs/iot-gateway/config/bacnet/#data-mapping) 部分）。点击要配置属性更新的设备上的 "**铅笔**" 图标。
    ===
        image: /images/gateway/bacnet-connector/examples/rpc-to-device-1.png,
        title: 向下滚动到 "**RPC 方法**" 部分，点击 "**铅笔**" 图标以编辑 RPC 方法。
    ===
        image: /images/gateway/bacnet-connector/examples/rpc-to-device-2.png,
        title: 点击 "**添加方法**" 按钮。在 "**Method**" 字段填写 `getTemperature`，选择 "**Request Type**" 为 "**Read Property**"，"**Object ID**" 为 "**Analog Value**" 和 "**1**"，"**Property ID**" 为 "**Present Value**"。
    ===
        image: /images/gateway/bacnet-connector/examples/rpc-to-device-3.png,
        title: 记得点击 "**应用**" 按钮保存更改，并点击保存连接器配置按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=rpcToDevice %}

配置已完成，让我们看看如何调用该方法。在 RPC 调试终端部件中，运行以下命令：

```bash
getTemperature
```

响应：

![image](/images/gateway/bacnet-connector/examples/rpc-to-device-4.png)

{% capture difference %}
RPC 调试终端仅用于示例目的，您可以使用任何支持 RPC 调用的部件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

上述示例的 BACnet 连接器完整配置如下
**（请务必使用正确的设备 host 和 port）**：

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
      "timeseries": [
        {
          "key": "some-key",
          "objectType": "binaryInput",
          "objectId": 1,
          "propertyId": "presentValue"
        }
      ],
      "attributes": [],
      "attributeUpdates": [],
      "serverSideRpc": [
        {
          "method": "getTemperature",
          "objectType": "analogValue",
          "objectId": 1,
          "propertyId": "presentValue",
          "timeout": 5000,
          "requestType": "readProperty"
        }
      ]
    }
  ]
}
```
{:.copy-code}
