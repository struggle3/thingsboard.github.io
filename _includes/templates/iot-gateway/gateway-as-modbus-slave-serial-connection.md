| **参数**                 | **默认值**                     | **描述**                                                                                                                  |
|:-|:-|--------------------------------------------------------------------------------------------------------------------------
| deviceName                    | **Gateway**                           | 设备名称                                                                                                                  |
| deviceType                    | **default**                           | 设备类型                                                                                                                  |
| type                          | **serial**                            | 连接类型可为 **TCP**、**UDP** 或 **Serial**。                                                                              |
| method                        | **rtu**                               | 应用数据单元类型 - **RTU** 或 **ASCII**                                                                                    |
| port                          | **/dev/ttyUSB0**                      | 连接用串口。                                                                                                              |
| baudrate                      | **19200**                             | 串口设备使用的波特率。                                                                                                    |
| byteOrder                     | **BIG**                               | 字节读取顺序。                                                                                                            |
| unitId                        | **0**                                 | 设备的单元 ID                                                                                                             |
| pollPeriod                    | **5000**                              | 检查属性和遥测的周期（毫秒）。                                                                                            |
| sendDataToThingsBoard         | **false**                             | 若设为 TRUE，网关将执行自动配置，并每 <pollPeriod> 毫秒向 ThingsBoard 发送数据                                            |
|---