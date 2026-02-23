根据 Modbus 主站偏好的通信方式，有三种配置选项：使用 TCP、UDP 或串口。

{% capture difference %} 
所有配置参数列表及详细说明请参阅 
[高级配置](/docs/iot-gateway/config/modbus/#device-mapping) 章节。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture modbusMasterConnectionsUDPTCPSerial %}
TCP<small></small>%,%tcp%,%templates/iot-gateway/modbus-connector/tcp-master-connections-section.md%br%
UDP<small></small>%,%udp%,%templates/iot-gateway/modbus-connector/udp-master-connections-section.md%br%
Serial<small></small>%,%serial%,%templates/iot-gateway/modbus-connector/serial-master-connections-section.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="modbusMasterConnectionsUDPTCPSerial" toggle-spec=modbusMasterConnectionsUDPTCPSerial %}
