| **参数**                     | **默认值**                                           | **说明**                                                                                         |
|:----------------------------------|:------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| deviceNodePattern                 | **Root\\\\.Objects\\\\.Device1**                            | 用于查找当前设备节点的正则表达式。                         |
| deviceNodeSource                  | **path**                                                    | 设备节点来源。                                                                              |
| deviceInfo                        |                                                             |                                                                                                         |
| ... deviceNameExpressionSource    | **path**                                                    | 设备名称来源（可为 [path](#path-types)、[identifier](#identifier-types) 或 constant）。    |
| ... deviceNameExpression          | **Device ${Root\\\\.Objects\\\\.Device1\\\\.serialNumber}** | 用于在变量中查找设备名称的设备名称变量路径。        |
| ... deviceProfileExpressionSource | **constant**                                                | device profile 来源（可为 [path](#path-types)、[identifier](#identifier-types) 或 constant）。 |
| ... deviceProfileExpression       | **Device**                                                  | 用于在变量中查找 device profile 的 device profile 变量路径。        |
| ---                               |                                                             |                                                                                                         |

配置的此部分将如下所示：  

```json
"deviceNodePattern": "Root\\.Objects\\.Device1",
"deviceNodeSource": "path",
"deviceInfo": {
    "deviceNameExpression": "Device ${Root\\.Objects\\.Device1\\.serialNumber}",
    "deviceNameExpressionSource": "path",
    "deviceProfileExpression": "Device",
    "deviceProfileExpressionSource": "constant"
},
```

![image](/images/gateway/opc-ua-connector/opc-ua-section-mapping-advanced-1-ce.png)
