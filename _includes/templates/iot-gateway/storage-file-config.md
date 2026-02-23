|---
| **参数**            | **默认值**                            | **说明**                                                |
|:-|:-|-
| type                     | **file**                                     | 存储类型（将数据保存到硬盘）                       |
| data_folder_path         | **./data/**                                  | 存放数据的文件夹路径（相对或绝对路径）。|
| max_read_records_count   | **6**                                        | 从存储中读取并发送到 ThingsBoard 的消息数量。 |
| max_file_count *         | **5**                                        | 保存的文件最大数量。                      |
| max_records_per_file *   | **14**                                       | 单文件存储的最大记录数。      |
|---


\* -- 若数据量已达该参数，新收到的数据将会丢失。

配置文件中的 storage 部分如下所示：

```json
...
"storage": {
  "type": "file",
  "data_folder_path": "./data/",
  "max_file_count": 5,
  "max_read_records_count": 6,
  "max_records_per_file": 14
},
...
```
