此小节包含来自 ThingsBoard 平台实例的 RPC 请求配置。

| **参数** | **默认值** | **说明**                                                                                       |
|:--------------|:------------------|-------------------------------------------------------------------------------------------------------|
| method        | **multiply**      | OPC-UA 服务器上的方法名。                                                                      |
| arguments     |                   | 方法的参数（若此参数不存在，参数将从 RPC 请求中获取）。 |
| ... type      | **integer**       | 参数类型。                                                                                 |
| .. value      | **2**             | 参数值。                                                                                |
| ---           |                   |                                                                                                       |

配置的此部分将如下所示：  

```json
"rpc_methods": [
    {
      "method": "multiply",
      "arguments": [
        {
          "type": "integer",
          "value": 2
        },
        {
          "type": "integer",
          "value": 4
        }
      ]
    }
],
```

![image](/images/gateway/opc-ua-connector/opc-ua-subsection-rpc-methods-advanced-1-ce.png)
