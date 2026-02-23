本节的配置用于从 ThingsBoard 向设备发送 RPC 请求。

| **参数**  | **描述**                                                               |
|----------------|-------------------------------------------------------------------------------|
| method         | RPC 方法名称。                                                              |
| requestType    | "**writeProperty**" 用于写入数据，"**readProperty**" 用于读取数据。        |
| requestTimeout | 等待 BACnet 设备响应的超时时间（毫秒）。       |
| objectType     | BACnet 设备中的对象类型。                                             |
| objectId       | BACnet 设备中的对象 ID。                                               |
| propertyId     | BACnet 设备中的属性 ID。                                             |
| priority       | 要写入值的优先级（可选，1 到 16 的整数）。 |
| ---            | ---                                                                           |

若 value 为 None，BACnet 连接器将发送带 Null 值的 relinquish 命令。
此外，写入 RPC 应包含 value 或 priority，或两者都包含。

配置文件中该子节示例如下：

```json
"serverSideRpc": [
  {
    "method": "set_state",
    "requestType": "writeProperty",
    "requestTimeout": 10000,
    "objectType": "binaryOutput",
    "objectId": 1,
    "propertyId": "presentValue"
  },
],
```

![image](/images/gateway/bacnet-connector/bacnet-subsection-rpc-methods-advanced-1-ce.png)
