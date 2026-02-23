#### 安装 Java 17 (OpenJDK)

{% include templates/install/rhel-java-install.md %}

{% if page.url contains "remote-integrations" %}

#### 选择集成包

{% capture rhelinstallspec %}
HTTP 集成<br><small>(HTTP、Sigfox、ThingPark、OceanConnect 和 <br> T-Mobile IoT CDP)</small>%,%http%,%templates/edge/install/integration/http-rhel.md%br%
MQTT 集成<br><small>(MQTT、AWS IoT、IBM Watson、The Things Network)</small>%,%mqtt%,%templates/edge/install/integration/mqtt-rhel.md%br%
OPC UA<br> 集成<br>%,%opcua%,%templates/edge/install/integration/opcua-rhel.md%br%
TCP/UDP<br> 集成<br>%,%tcpudp%,%templates/edge/install/integration/tcpudp-rhel.md%br%
CoAP<br> 集成<br>%,%coap%,%templates/edge/install/integration/coap-rhel.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="remoteintegrationinstallrhel" toggle-spec=rhelinstallspec %} 

{% elsif page.url contains "tcp" or page.url contains "udp" %}

{% include /templates/edge/install/integration/tcpudp-rhel.md %}

{% endif %}