根据 Modbus master 之间的首选通信方式，此部分有三种配置选项：TCP、UDP 或 Serial 端口。

![image](/images/gateway/modbus-connector/server-slave-configuration-basic.png)

{% capture modbusserverconfigurationsection %}
TCP<small></small>%,%tcp%,%templates/iot-gateway/modbus-connector/tcp-server-configuration-section.md%br%
UDP<small></small>%,%udp%,%templates/iot-gateway/modbus-connector/udp-server-configuration-section.md%br%
Serial<small></small>%,%serial%,%templates/iot-gateway/modbus-connector/serial-server-configuration-section.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="modbusserverconfigurationsection" toggle-spec=modbusserverconfigurationsection %}
