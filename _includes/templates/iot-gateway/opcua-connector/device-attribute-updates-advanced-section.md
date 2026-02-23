| **参数** | **默认值**                                 | **说明**                                                                                           |
|:--------------|:--------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| key           | **deviceName**                                    | 平台上的 shared attribute 名称。                                                                    |
| type          | **path**                                          | shared attribute 来源（可为 [path](#path-types)、[identifier](#identifier-types) 或 constant）。 |
| value         | **Root\\\\.Objects\\\\.Device1\\\\.serialNumber** | 用于查找当前设备节点的正则表达式或标识符。           |
| ---           |                                                   |                                                                                                           |

配置文件中此小节如下所示：

```json
"attributes_updates": [
    {
      "key": "deviceName",
      "type": "path",
      "value": "Root\\.Objects\\.Device1\\.serialNumber"
    }
]
```

![image](/images/gateway/opc-ua-connector/opc-ua-subsection-attribute-updates-advanced-1-ce.png)
