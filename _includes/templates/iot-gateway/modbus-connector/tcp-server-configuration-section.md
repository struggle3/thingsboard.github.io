以下参数用于配置 Gateway as Slave 的 TCP 连接：

- **Host** - Modbus 服务器的主机名或 IP 地址。
- **Port** - 连接 Modbus 服务器的端口。
- **Method** - framer 类型，**Socket** 或 **RTU**。
- **Unit ID** - Modbus 上当前 slave 的 ID。
- **Device name** - 当前 slave 的名称。**切勿将 "Device name" 参数设为 "Gateway"！**
- **Device profile** - 当前 slave 的 device profile。
- **Poll period (ms)** - 检查 attribute 和 telemetry 的周期（毫秒）。

{% capture difference %}
所有配置参数列表及详细说明请参见[高级配置](/docs/iot-gateway/config/modbus/#device-rpc-methods)部分。

更多使用示例请参见[使用示例](/docs/iot-gateway/config/modbus/#usage-examples-2)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

![image](/images/gateway/modbus-connector/tcp-server-configuration-section-1-ce.png)
