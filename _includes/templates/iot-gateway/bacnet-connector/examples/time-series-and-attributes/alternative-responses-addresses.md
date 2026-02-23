替代响应地址字段允许您为设备响应指定替代 IP 地址。
当网关和 BACnet 设备位于不同网络时，此功能尤其有用。

例如，考虑以下网络设置：

![image](/images/gateway/bacnet-connector/examples/alternative-responses-addresses-network-setup.png)

在此设置中，网关运行在 Docker 容器内，BACnet 设备位于本地网络中，IP 地址为 `192.168.1.200:45606`，无法从 Docker 容器直接访问。BACPypes 向网关发送 APDU 时不包含端口号，导致连接器无法判断响应是否来自允许的设备。配置替代响应地址后，连接器将使用该 IP 正确识别和验证设备。

要配置替代响应地址，需要在设备配置中添加 `altResponsesAddresses` 字段。以下为配置示例片段：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "0.0.0.0",
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
      "deviceInfo": {
        "deviceNameExpressionSource": "expression",
        "deviceNameExpression": "BACnet Device ${objectName}",
        "deviceProfileExpressionSource": "constant",
        "deviceProfileExpression": "default"
      },
      "host": "192.168.1.200",
      "port": 45606,
      "altResponsesAddresses": ["192.168.1.200"],
      "pollPeriod": 10000,
      "attributes": [],
      "timeseries": "*",
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}

应用此配置后，连接器将使用指定的替代响应地址
`192.168.1.200:45606` 识别和验证来自 BACnet 设备的响应。这确保即使网关与设备位于不同网络，连接器也能有效与设备通信。因此，您应在 ThingsBoard 中看到已创建设备：

![image](/images/gateway/bacnet-connector/examples/alternative-responses-addresses-overview.png)
