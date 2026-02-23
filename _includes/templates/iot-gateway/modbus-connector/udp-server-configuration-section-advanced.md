下表描述了从站 UDP 连接配置参数：

| **参数**         | **默认值**        | **描述**                                                                                                 |
|:----------------------|:-------------------------|-----------------------------------------------------------------------------------------------------------------
| host                  | **127.0.0.1**            | Modbus 服务器的主机名或 IP 地址                                                                         |
| port                  | **5021**                 | Modbus 服务器连接端口                                                                            |
| method                | **socket**               | 帧类型 **Socket** 或 **RTU**（如需要）                                                               |
| unitId                | **0**                    | Modbus 上当前从站的 ID                                                                                   |
| deviceName            | **Modbus Slave Example** | 当前从站名称                                                                                       |
| deviceProfile         | **default**              | 当前从站的设备配置文件                                                                             |
| sendDataToThingsBoard | **false**                | 设为 **TRUE** 时，网关将执行自动配置并在每个轮询周期将值发送到 ThingsBoard |
| pollPeriod            | **5000**                 | 检查属性和遥测的周期（毫秒）                                            |
| ---                   

![image](/images/gateway/modbus-connector/udp-server-configuration-section-advanced-1-ce.png)
