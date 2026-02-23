属性更新允许您更新 BACnet 设备上的对象值。您可以在设备配置页面的 "**属性更新**" 部分添加新的属性更新。

例如，我们将使用连接了继电器的 BACnet 控制器。我们还知道该继电器的对象 ID 为：`Binary Input:1`。我们将此对象 ID 作为遥测参数添加，key 为 `relay`。使用遥测便于我们后续查看通过属性更新更改的值是否生效。您也可以将此遥测数据点添加到设备配置中，或使用保留的 `get` 方法检查节点值。

让我们向配置中添加属性更新。为此，请按以下步骤操作：

{% assign attributeUpdates = '
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
        image: /images/gateway/bacnet-connector/examples/connector-configuration-attribute-updates-1.png,
        title: 向下滚动到 "**属性更新**" 部分，点击 "**铅笔**" 图标以编辑属性更新。
    ===
        image: /images/gateway/bacnet-connector/examples/connector-configuration-attribute-updates-2.png,
        title: 点击 "**添加属性更新**" 按钮。在本例中，我们将添加 `relay` 属性更新，因此在 "**Key**" 字段输入 `relay`，选择 "**Object ID**" 为 **Analog Input** 和 "**1**"，"**Property ID**" 为 "**Present Value**"。
    ===
        image: /images/gateway/bacnet-connector/examples/connector-configuration-attribute-updates-3.png,
        title: 记得点击 "**应用**" 按钮保存更改，并点击保存连接器配置按钮。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attributeUpdates %}

现在我们可以检查属性更新是否生效。进入 "**实体**" → "**设备**" → 选择已创建设备 → "**属性**" 标签 → 选择 "**共享属性**" → 点击 "**+**" 图标并添加 `relay` 属性，类型设为 "**Boolean**"，值设为 "**True**"。

{% assign attributeUpdates2 = '
    ===
        image: /images/gateway/bacnet-connector/examples/connector-configuration-attribute-updates-4.png,
    ===
        image: /images/gateway/bacnet-connector/examples/connector-configuration-attribute-updates-5.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=attributeUpdates2 %}

现在，让我们检查继电器对象 ID 的值。在所选设备中，进入 "**最新遥测**" 标签并检查 `relay` 遥测的值。由于我们将共享属性设为了 `true`，其应为 `true`。

![image](/images/gateway/bacnet-connector/examples/connector-configuration-attribute-updates-6.png)

尝试将 `relay` 共享属性的值更改为 `false`。几秒钟后，您应看到 `relay` 遥测值已变为 `false`，这表示属性更新已正确生效。

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
    "networkNumber": 3,
    "deviceDiscoveryTimeoutInSec": 5
  },
  "devices": [
    {
      "altResponsesAddresses": [],
      "host": "YOUR_DEVICE_HOST",
      "port": 47808,
      "networkMask": "",
      "deviceInfo": {
        "deviceNameExpression": "${objectName}",
        "deviceProfileExpression": "default",
        "deviceNameExpressionSource": "expression",
        "deviceProfileExpressionSource": "constant"
      },
      "pollPeriod": 10000,
      "timeseries": [
        {
          "key": "relay",
          "objectType": "binaryInput",
          "objectId": 1,
          "propertyId": "presentValue"
        }
      ],
      "attributes": [],
      "attributeUpdates": [
        {
          "key": "relay",
          "objectType": "binaryInput",
          "objectId": 1,
          "propertyId": "presentValue"
        }
      ],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}
