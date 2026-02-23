本单元中的配置用于 Modbus 服务器上的数据处理。这些设置将在 ThingsBoard 平台实例中被解析为设备的属性/时序数据。

下表描述了属性和时序参数：

| **参数** | **描述**                                                       |
|:--------------|:----------------------------------------------------------------------
| tag           | 键名                                                              |
| type          | 值类型                                                         | 
| functionCode  | 数据处理中使用的功能，即 Modbus 功能码 |
| objectsCount  | 写入对象数量                                             | 
| address       | 对象地址                                                        |
| ---           

![image](/images/gateway/modbus-connector/attributes-advanced-1-ce.png)

<br>
属性部分示例：

```json
"attributes": [
  {
    "tag": "string_read",
    "type": "string",
    "functionCode": 4,
    "objectsCount": 4,
    "address": 1
  }
]
```

时序部分示例：

```json
"timeseries": [
  {
    "tag": "16uint_read",
    "type": "16uint",
    "functionCode": 4,
    "objectsCount": 2,
    "address": 18
  },
]
```
