| **参数**                     | **描述**                                                                                                                               |
|:----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| host                              | 设备主机。                                                                                                                             |
| port                              | 设备端口。                                                                                                                             |
| pollPeriod                        | 连接器轮询 BACnet 设备的时间周期。                                                                                                     |
| altResponsesAddresses             | 设备响应的替代地址数组（详细示例见[此处](#examples-alternative-responses-addresses)）。                                                  |
| deviceInfo                        |                                                                                                                                       |
| ... deviceNameExpressionSource    | 设备名称来源：constant、expression。                                                                                                   |
| ... deviceNameExpression          | 设备名称（详细示例见[此处](#examples-device-name-expression-and-device-profile-expression)）。                                         |
| ... deviceProfileExpressionSource | 设备配置文件来源：constant、expression。                                                                                              |
| ... deviceProfileExpression       | 设备配置文件名称（详细示例见[此处](#examples-device-name-expression-and-device-profile-expression)）。                                |
| ---                               |                                                                                                                                       |

示例：
 
```json
{
  "host": "192.168.2.110",
  "port": "47808",
  "pollPeriod": 10000,
  "altResponsesAddresses": [
    "192.168.2.110"
  ],
  "deviceInfo": {
    "deviceNameExpression": "BACnet Device ${objectName}",
    "deviceProfileExpression": "default",
    "deviceNameExpressionSource": "expression",
    "deviceProfileExpressionSource": "constant"
  },
  ...
```

![image](/images/gateway/bacnet-connector/bacnet-section-devices-advanced-1-ce.png)
