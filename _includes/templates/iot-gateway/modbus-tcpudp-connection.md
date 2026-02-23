| **参数**                 | **默认值**         | **说明**                                           |
|:-|:--------------------------|-----------------------------------------------------------
| name                          | **Modbus Default Server** | Connector 到服务器的名称。                              |
| host                          | **host.docker.internal**  | Modbus 服务器的主机名或 IP 地址。                  |
| port                          | **5021**                  | 连接 Modbus 服务器的端口。                     |
| type                          | **tcp**                   | 连接类型：**TCP**、**UDP** 或 **Serial**。 |
| method                        | **socket**                | Framer 类型：**Socket** 或 **RTU**（如需要）。        |
| timeout                       | **35**                    | 连接 Modbus 服务器的超时时间（秒）。       |
| byteOrder                     | **LITTLE**                | 读取字节顺序。                                   |
| wordOrder                     | **LITTLE**                | 读取多个寄存器时的字序。        |
|---

也可使用以下配置配置 TLS 连接：

| **参数**                 | **默认值**                            | **说明**           |
|:-|:---------------------------------------------|---------------------------
| certfile                      | **/etc/thingsboard-gateway/certificate.pem** | 证书文件路径。 |
| keyfile                       | **/etc/thingsboard-gateway/privateKey.pem**  | 私钥文件路径。 |
| password                      | **YOUR_PASSWORD**                            | 服务器密码。          |
| server_hostname               | **localhost**                                | 服务器主机名。         |
|---

配置示例：
```json
{
  "master": {
    "slaves": [
      {
        "host": "host.docker.internal",
        "port": 5021,
        "type": "tcp",
        "method": "socket",
        "tls": {
          "certfile": "/etc/thingsboard-gateway/certificate.pem",
          "keyfile": "/etc/thingsboard-gateway/privateKey.pem",
          "password": "YOUR_PASSWORD",
          "server_hostname": "localhost"
        },
        "timeout": 35,
        ...
```
