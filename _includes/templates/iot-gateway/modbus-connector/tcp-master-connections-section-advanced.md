下表描述了从站 TCP 连接配置参数：

| **参数** | **默认值** | **描述**                                   |
|:--------------|:------------------|---------------------------------------------------
| host          | **127.0.0.1**     | Modbus 服务器的主机名或 IP 地址           |
| port          | **5021**          | Modbus 服务器连接端口              |
| method        | **Socket**        | 帧类型 **Socket** 或 **RTU**（如需要） |
| unitId        | **1**             | Modbus 上当前从站的 ID                     |
| deviceName    | **Temp Sensor**   | 当前从站名称                         |
| deviceProfile | **default**       | 当前从站的设备配置文件               |
| ---           

![image](/images/gateway/modbus-connector/tcp-master-connections-advanced-ce.png)

<br>
示例：

```json
"master": {
    "slaves": [
        {
            "host": "127.0.0.1",
            "port": 5021,
            "method": "socket",
            "unitId": 1,
            "deviceName": "Temp Sensor",
            "deviceType": "default",
        }
    ]
}
```
