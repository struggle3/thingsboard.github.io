下表描述了 RPC 请求参数：

| **参数** | **描述**                                                       |
|:--------------|:----------------------------------------------------------------------
| tag           | RPC 方法名称                                                       |
| type          | 值类型                                                         | 
| functionCode  | 数据处理中使用的功能，即 Modbus 功能码 |
| objectsCount  | 写入或读取的对象数量                                     | 
| address       | 对象地址                                                        |
| ---           

![image](/images/gateway/modbus-connector/rpc-requests-advanced-1-ce.png)

<br>
示例：

```json
"rpc": [
  {
    "tag": "setValue",
    "type": "bits",
    "functionCode": 5,
    "objectsCount": 1,
    "address": 31
  }
]
```
