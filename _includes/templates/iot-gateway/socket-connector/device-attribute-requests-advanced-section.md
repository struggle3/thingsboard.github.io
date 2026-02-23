| **参数**           | **默认值** | **说明**                                                                                        |
|:------------------------|:------------------|--------------------------------------------------------------------------------------------------------|
| type                    | **shared**        | 请求的 attribute 类型，可为 "shared" 或 "client"。                                   |
| requestExpression       | **${[0:3]==atr}** | 用于判断来自设备的 request 是否为 "Attribute Request" 的表达式。 |
| attributeNameExpression | **[3:]**          | 用于从接收数据中获取所请求 attribute 名称的表达式。         |
| ---                     |                   |                                                                                                        |

本小节配置如下所示：

```json
"attributeRequests": [
  {
    "type": "shared",
    "requestExpression": "${[0:3]==atr}",
    "attributeNameExpression": "[3:]"
  }
]
```

此外，可一次请求多个 attribute。只需在 attributeNameExpression 参数中再添加一个切片表达式。例如，若要在一次 request 中请求两个 shared attribute，配置如下：

```json
"attributeRequests": [
  {
    "type": "shared",
    "requestExpression": "${[0:3]==atr}",
    "attributeNameExpression": "[4:19][20:]"
  }
]
```

即需发送以下消息以请求两个 shared attribute：
`atr sharedAttribute sharedAttribute1`

![image](/images/gateway/socket-connector/socket-subsection-attribute-request-advanced-1-ce.png)
