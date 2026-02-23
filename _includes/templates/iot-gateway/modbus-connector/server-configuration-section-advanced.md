根据 Modbus 主站偏好的通信方式，有两种配置选项：使用 TCP/UDP 或串口。

![image](/images/gateway/modbus-connector/server-slave-configuration-advanced.png)

{% capture modbusserverconfigurationsection %}
TCP<small></small>%,%tcp%,%templates/iot-gateway/modbus-connector/tcp-server-configuration-section-advanced.md%br%
UDP<small></small>%,%udp%,%templates/iot-gateway/modbus-connector/udp-server-configuration-section-advanced.md%br%
Serial<small></small>%,%serial%,%templates/iot-gateway/modbus-connector/serial-server-configuration-section-advanced.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="modbusserverconfigurationsection" toggle-spec=modbusserverconfigurationsection %}
