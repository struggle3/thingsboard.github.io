|---
| **参数**               | **默认值**                            | **说明** |
|:-|:-|-
| type                        | **sqlite**                                   | 存储类型（将数据保存到 .db 文件）。|
| data_file_path              | **./data/**                                  | 存放数据库文件的目录路径（不含文件名）。需要以路径分隔符结尾。|
| max_read_records_count      | **1000**                                     | 从存储中读取并发送到 ThingsBoard 的最大消息数量。|
| size_limit *                | **1024**                                     | 每个 SQLite 文件的最大大小（兆字节）。超过后触发轮换到新 DB 文件。|
| max_db_amount *             | **10**                                       | 磁盘上保留的轮换 DB 文件最大数量。达到后，后续写入将被丢弃直至清理完成。|    
| oversize_check_period       | **1**                                        | 检查当前 DB 文件大小是否超过 *size_limit* 的频率（分钟）。|
| writing_batch_size          | **1000**                                     | 单次写入请求中，写入 DB 前收集的最大消息数量。|
| messages_ttl_check_in_hours | **1**                                        | Gateway 检查数据过期的时间间隔（小时）。|
| messages_ttl_in_days        | **7**                                        | 各 DB 中消息的自动删除保留天数。|
|---


\* –- 若 DB 文件数量达到 *max_db_amount* 且最后一个数据库超过 *size_limit*，新数据将丢失，直到之前的数据从数据库读取并传递到平台。
请注意：默认数据库文件名为 **data.db**。<br>


配置文件中的 storage 部分如下所示：

```json
...
"storage": {
  "type": "sqlite",
  "data_file_path": "./data/", 
  "max_read_records_count": 1000,
  "size_limit": 1024,
  "max_db_amount": 10,
  "oversize_check_period": 1,
  "writing_batch_size": 1000,
  "messages_ttl_check_in_hours": 1,
  "messages_ttl_in_days": 7
},
...
```
