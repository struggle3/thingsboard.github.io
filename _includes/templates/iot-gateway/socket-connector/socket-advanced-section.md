本配置部分包含 socket 的设置，例如：

| **参数** | **默认值**         | **说明**                       |
|:--------------|:--------------------------|---------------------------------------|
| name          | **TCP Connector Example** | Connector 名称                        |
| type          | **TCP**                   | Socket 类型，可为 TCP 或 UDP |
| address       | **127.0.0.1**             | Connector 绑定地址               |
| port          | **50000**                 | Connector 绑定端口                  |
| bufferSize    | **1024**                  | 接收数据块缓冲区大小    |
| ---           |                           |                                       |

配置部分如下所示：

```json
{
  "type": "TCP",
  "address": "127.0.0.1",
  "port": 50000,
  "bufferSize": 1024,
  ...
}
```

![image](/images/gateway/socket-connector/socket-advanced-configuration-section-1-ce.png)
