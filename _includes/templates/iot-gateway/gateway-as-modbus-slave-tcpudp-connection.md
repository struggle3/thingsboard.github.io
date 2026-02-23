| **参数**                 | **默认值**                       | **描述**                                                                                                                  |
|:-|:-|--------------------------------------------------------------------------------------------------------------------------
| type                          | **tcp**                                 | 连接类型可为 **TCP**、**UDP** 或 **Serial**。                                                                             |
| host                          | **127.0.0.1**                           | Modbus 服务器的主机名或 IP 地址。                                                                                         |
| port                          | **5020**                                | Modbus 服务器的连接端口。                                                                                                 |
| method                        | **socket**                              | 帧格式类型 **Socket** 或 **RTU**（如需要）。                                                                               |
| deviceName                    | **Modbus_Slave_Example**                | 设备名称                                                                                                                  |
| deviceType                    | **default**                             | 设备类型                                                                                                                  |
| pollPeriod                    | **5000**                                | 检查属性和遥测的周期（毫秒）。                                                                                            |
| sendDataToThingsBoard         | **false**                               | 若设为 TRUE，网关将执行自动配置，并每 <pollPeriod> 毫秒向 ThingsBoard 发送数据                                              |
| byteOrder                     | **BIG**                                 | 字节读取顺序。                                                                                                            |
| unitId                        | **0**                                   | 设备的单元 ID                                                                                                             |
|---

此外，您可以使用以下配置设置 TLS 连接：

| **参数**                 | **默认值**                            | **描述**                           |
|:-|:-|-------------------------------------------
| certfile                      | **/etc/thingsboard-gateway/certificate.pem** | 证书文件路径。                 |
| keyfile                       | **/etc/thingsboard-gateway/privateKey.pem**  | 私钥文件路径。                 |
| password                      | **YOUR_PASSWORD**                            | 服务器密码。                          |
| reqclicert                    | **false**                                    | 是否向客户端请求证书文件。 |
|---

配置示例：
```json
"slave": {
  "type": "tcp",
  "security": {
    "certfile": "/etc/thingsboard-gateway/certificate.pem",
    "keyfile": "/etc/thingsboard-gateway/privateKey.pem",
    "password": "YOUR_PASSWORD",
    "reqclicert": false
  },
  "host": "127.0.0.1",
  ...
```