|---
| **参数**            | **默认值**                            | **说明**                                                |
|:-|:-|-
| type                     | **memory**                                   | 存储类型（将数据保存到内存，不写入硬盘）。      |
| read_records_count       | **10**                                       | 从存储中读取并发送到 ThingsBoard 的消息数量。 |
| max_records_count *      | **100**                                      | 发送到 ThingsBoard 前存储的最大数据量。   |
|---


\* -- 若存储数据量已达该参数值，新收到的数据将会丢失。

配置文件中的 storage 部分如下所示：

```json
...
"storage": {
  "type": "memory",
  "read_records_count": 10,
  "max_records_count": 100
},
...
```
