| **参数** | **默认值**  | **说明**                                                                                                    |
|:--------------|:-------------------|--------------------------------------------------------------------------------------------------------------------|
| addressFilter | *.*                | 用于过滤允许连接到 connector 的 IP 地址。                                               |
| deviceName    | **Device Example** | ThingsBoard 中的设备名称。                                                                                |
| deviceType    | **default**        | ThingsBoard 的设备类型，默认无此参数，可自行添加。                              |
| encoding      | **utf-8**          | 将字符串数据写入存储时使用的编码。                                                                 |
| ---           |                    |                                                                                                                    |

示例：
```json
{
  "address": "127.0.0.1:50001",
  "deviceName": "Device Example",
  "deviceType": "default",
  "encoding": "utf-8",
  ...
```

![image](/images/gateway/socket-connector/socket-subsection-device-advanced-1-ce.png)
