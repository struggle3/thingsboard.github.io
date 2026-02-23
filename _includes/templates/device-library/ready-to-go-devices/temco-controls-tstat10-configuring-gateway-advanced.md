{% assign creatingGatewayCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-1-ce.png,
        title: 在浏览器中打开 ThingsBoard 并登录。在侧边栏进入「**实体**」>「**网关**」选项卡，点击「**+**」按钮。填写「**名称**」和「**设备档案**」字段并点击「**创建**」按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-2-ce.png,
        title: 使用启动命令启动网关； 
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-3-ce.png,
        title: 网关已创建。点击侧边栏菜单中的「**连接器配置**」按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-4-ce.png,
        title: 点击「**+**」按钮添加新连接器；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/advanced-temco-tstat10-gateway-configuring-1-ce.png,
        title: 选择「**BACnet**」连接器类型，填写「**名称**」字段，禁用默认值填充配置，点击「**添加**」按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/advanced-temco-tstat10-gateway-configuring-2-ce.png,
        title: 在已创建的连接器中，进入「**高级**」部分并粘贴下方的 JSON 配置。将 **host** 和 **port** 配置参数值替换为设备的 host 和 port。同时将「**altResponsesAddresses**」中的「**DEVICE_HOST**」替换为设备 host。点击「保存」按钮。
'
%}

{% assign creatingGatewayPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-1-pe.png,
        title: 在浏览器中打开 ThingsBoard 并登录。在侧边栏进入「**实体**」>「**网关**」选项卡，点击「**+**」按钮。填写「**名称**」和「**设备档案**」字段并点击「**创建**」按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-2-pe.png,
        title: 使用启动命令启动网关； 
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-3-pe.png,
        title: 网关已创建。点击侧边栏菜单中的「**连接器配置**」按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/temco-tstat10-gateway-configuring-4-pe.png,
        title: 点击「**+**」按钮添加新连接器；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/advanced-temco-tstat10-gateway-configuring-1-pe.png,
        title: 选择「**BACnet**」连接器类型，填写「**名称**」字段，禁用默认值填充配置，点击「**添加**」按钮；
    ===
        image: /images/devices-library/ready-to-go-devices/temco-tstat10/advanced-temco-tstat10-gateway-configuring-2-pe.png,
        title: 在已创建的连接器中，进入「**高级**」部分并粘贴下方的 JSON 配置。将 **host** 和 **port** 配置参数值替换为设备的 host 和 port。同时将「**altResponsesAddresses**」中的「**DEVICE_HOST**」替换为设备 host。点击「保存」按钮。
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingGatewayPE %}
{% else %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingGatewayCE %}
{% endif %}

```json
{
  "application": {
    "host": "0.0.0.0",
    "port": "47808",
    "objectName": "TB_gateway",
    "objectIdentifier": 599,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "vendorIdentifier": 15
  },
  "devices": [
    {
      "altResponsesAddresses": ["DEVICE_HOST"],
      "host": "DEVICE_HOST",
      "port": 47808,
      "deviceInfo": {
        "deviceNameExpression": "Temco Tstat10",
        "deviceNameExpressionSource": "constant",
        "deviceProfileExpressionSource": "constant",
        "deviceProfileExpression": "default"
      },
      "pollPeriod": 3000,
      "timeseries": [
        {
          "objectType": "analogInput",
          "objectId": "1",
          "key": "sensor_temperature",
          "propertyId": "presentValue"
        },
        {
          "objectType": "analogInput",
          "objectId": "2",
          "key": "humidity",
          "propertyId": "presentValue"
        },
        {
          "key": "controller_temperature",
          "objectType": "analogInput",
          "objectId": "9",
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
{:.copy-code.expandable-10}
