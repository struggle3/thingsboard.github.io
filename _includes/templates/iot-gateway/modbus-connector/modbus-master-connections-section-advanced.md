要添加新的服务器连接配置，请进入「配置」选项卡。

![image](/images/gateway/modbus-connector/add-new-server-connection-advanced-1-ce.png)

根据 Modbus 主站偏好的通信方式，有两种配置选项：使用 TCP、UDP 或串口。

{% capture modbusMasterConnectionsUDPTCPSerial %}
TCP<small></small>%,%tcp%,%templates/iot-gateway/modbus-connector/tcp-master-connections-section-advanced.md%br%
UDP<small></small>%,%udp%,%templates/iot-gateway/modbus-connector/udp-master-connections-section-advanced.md%br%
Serial<small></small>%,%serial%,%templates/iot-gateway/modbus-connector/serial-master-connections-section-advanced.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="modbusMasterConnectionsUDPTCPSerial" toggle-spec=modbusMasterConnectionsUDPTCPSerial %}
