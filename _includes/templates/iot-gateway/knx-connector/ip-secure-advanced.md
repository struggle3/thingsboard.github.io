保护通过基于以太网/IP 的网络传输的数据，防止未授权访问和篡改。

这些参数可在 "**security**" 子节中配置：

| **参数** | **说明**                                    |
|:--------------|----------------------------------------------------|
| backbone_key  | 用于 KNX Secure Routing，以十六进制表示。 |
| latency_ms    | KNX Secure Routing 的延迟（毫秒）。    |
| ---           |                                                    |

配置文件中此子节如下所示：

```json
"security": {
    "backbone_key": "secret",
    "latency_ms": 100
}
```
