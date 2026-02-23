下表描述了从站串口连接配置参数：

| **参数** | **默认值**        | **描述**                                                                            |
|:--------------|:-------------------------|--------------------------------------------------------------------------------------------
| port          |                          | Modbus 服务器连接端口                                                       |
| method        | **socket**               | 应用数据单元类型 - **RTU** 或 **ASCII**                                       |
| unitId        | **0**                    | Modbus 上当前从站的 ID                                                              |
| deviceName    | **Modbus Slave Example** | 当前从站名称 **请不要使用「Gateway」作为「设备名称」参数的值！** |
| deviceProfile | **default**              | 当前从站的设备配置文件                                                        |
| pollPeriod    | **5000**                 | 检查从站属性和遥测的周期（毫秒）                      |
| baudrate      | **4800**                 | 串口设备使用的波特率                                    |
| ---           

![image](/images/gateway/modbus-connector/serial-server-configuration-section-advancd-1-ce.png)
