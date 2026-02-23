本部分的配置用于从 ThingsBoard 向设备发送 RPC 请求。

| **参数**    | **默认值** | **说明**                                                             |
|:-----------------|:------------------|-----------------------------------------------------------------------------|
| methodRPC        | **rpcMethod1**    | RPC 方法名称。                                                            |
| withResponse     | **true**          | 布尔值，确定是否向 ThingsBoard 返回响应。 |
| methodProcessing | **write**         | 操作类型。                                                          |
| encoding         | **utf-8**         | 将接收到的字符串数据写入存储时使用的编码。                 |
| ---              |                   |                                                                             |

配置文件中本小节如下所示：

```json
"serverSideRpc": [
  {
    "methodRPC": "rpcMethod1",
    "withResponse": true,
    "methodProcessing": "write",
    "encoding": "utf-8"
  }
]
```

![image](/images/gateway/socket-connector/socket-subsection-rpc-methods-advanced-1-ce.png)
