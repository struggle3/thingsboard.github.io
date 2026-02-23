下表描述了从站串口连接配置参数：

| **参数** | **默认值** | **描述**                                                                                                          |
|:--------------|:------------------|--------------------------------------------------------------------------------------------------------------------------
| port          |                   | Modbus 服务器连接端口                                                                                     |
| method        | **Socket**        | 帧类型 **Socket** 或 **RTU**（如需要）                                                                        |
| baudrate      | **4800**          | 串口设备的波特率                                                                  |
| bytesize      | **5**             | 串行数据中每字节的位数。可选：5、6、7 或 8                                            |
| stopbits      | **1**             | 每条消息中每个字符后发送的停止位数                                |
| parity        | **None**          | 用于校验数据完整性的校验类型。可选：（**E**）偶、（**O**）奇、（**N**）无 |
| strict        | **true**          | 波特率 <= 19200 时使用字符间超时                                                                            |
| unitId        | **1**             | Modbus 上当前从站的 ID                                                                                            |
| deviceName    | **Temp Sensor**   | 当前从站名称                                                                                                |
| deviceProfile | **default**       | 当前从站的设备配置文件                                                                                      |
| ---           

![image](/images/gateway/modbus-connector/serial-master-connections-advanced-ce.png)

<br>
示例：

```json
"master": {
    "slaves": [
        {
            "method": "ascii",
            "baudrate": 4800,
            "stopbits": 1,
            "bytesize": 5,
            "parity": "N",
            "strict": true,
            "unitId": 1,
            "deviceName": "Temp Sensor",
            "deviceType": "default",
        }
    ]
}
```
