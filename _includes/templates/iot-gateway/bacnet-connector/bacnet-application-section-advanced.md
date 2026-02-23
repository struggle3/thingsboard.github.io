| **参数**               | **默认值** | **描述**                                                                                                                            |
|:----------------------------|:------------------|------------------------------------------------------------------------------------------------------------------------------------|
| objectName                  | **TB_gateway**    | BACnet 网络中的网关对象名称。                                                                                                       |
| host                        | **0.0.0.0**       | BACnet 网络中的网关主机。                                                                                                           |
| port                        | **47808**         | BACnet 网络中的网关端口。                                                                                                           |
| mask                        |                   | BACnet 网络中的网关掩码。                                                                                                            |
| objectIdentifier            | **599**           | BACnet 网络中的网关对象标识符。                                                                                                      |
| maxApduLengthAccepted       | **1476**          | APDU 的最大长度。                                                                                                                   |
| segmentationSupported       | **segmentedBoth** | 分段类型，可为（详见下方）：segmentedBoth、segmentedTransmit、segmentedReceive、noSegmentation。                                   |
| vendorIdentifier            | **15**            | BACnet 网络中的网关厂商标识符。                                                                                                      |
| networkNumber               | **3**             | 网段标识符。                                                                                                                        |
| deviceDiscoveryTimeoutInSec | **5**             | 连接器尝试发现 BACnet 设备的时间段。                                                                                                 |
| ---                         |                   |                                                                                                                                    |

**segmentationSupported** 可为以下值之一：
- **segmentedBoth** - 支持发送和接收分段消息；
- **segmentedTransmit** - 仅支持发送分段消息；
- **segmentedReceive** - 仅支持接收分段消息；
- **noSegmentation** - 不支持分段消息。

示例：

```json
"application": {
    "objectName": "TB_gateway",
    "host": "0.0.0.0",
    "port": "47808",
    "objectIdentifier": 599,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "vendorIdentifier": 15
},
```

![image](/images/gateway/bacnet-connector/bacnet-section-application-advanced-1-ce.png)
