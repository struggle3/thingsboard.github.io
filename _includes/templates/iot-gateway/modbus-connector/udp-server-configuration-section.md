以下参数用于配置作为从站的网关的 UDP 连接：

- **主机** - Modbus 服务器的主机名或 IP 地址。
- **端口** - Modbus 服务器连接端口。
- **方法** - 帧类型，可选 **Socket** 或 **RTU**。
- **单元 ID** - Modbus 上当前从站的 ID。
- **设备名称** - 当前从站名称。**请不要使用「Gateway」作为「设备名称」参数的值！**
- **设备配置文件** - 当前从站的设备配置文件。
- **轮询周期 (ms)** - 检查属性和遥测的周期（毫秒）。

{% capture difference %}
所有配置参数列表及详细说明请参阅 
[高级配置](/docs/iot-gateway/config/modbus/#device-rpc-methods) 章节。

更多使用示例请参阅 [示例用法](/docs/iot-gateway/config/modbus/#usage-examples-2) 章节。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/modbus-connector/udp-server-configuration-section-1-ce.png)
