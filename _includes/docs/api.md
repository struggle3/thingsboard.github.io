ThingsBoard API 由两部分组成：设备 API 和服务端 API。

设备 API 按支持的通信协议分组：

* [**MQTT API**](/docs/{{docsPrefix}}reference/mqtt-api)
{% if docsPrefix != "edge/" and docsPrefix != "pe/edge/" %}
* [**MQTT Sparkplug API**](/docs/{{docsPrefix}}reference/mqtt-sparkplug-api)
{% endif %}
* [**CoAP API**](/docs/{{docsPrefix}}reference/coap-api)
* [**HTTP API**](/docs/{{docsPrefix}}reference/http-api)
* [**LWM2M API**](/docs/{{docsPrefix}}reference/lwm2m-api)
* [**SNMP API**](/docs/{{docsPrefix}}reference/snmp-api)

[**Gateway MQTT API**](/docs/{{docsPrefix}}reference/gateway-mqtt-api) 可通过 **[ThingsBoard Gateway](/docs/iot-gateway/what-is-iot-gateway/)** 将**既有**设备接入平台，或实现自有网关。

{% if docsPrefix != "edge/" and docsPrefix != "pe/edge/" %}

服务端 API 以 REST API 形式提供：

* [**Administration REST API**](/docs/{{docsPrefix}}reference/rest-api) - 服务端核心 API。
* [**Attributes query API**](/docs/{{docsPrefix}}user-guide/attributes/#data-query-api) - [Telemetry Service](/docs/{{docsPrefix}}user-guide/attributes/) 提供的服务端 API。
* [**Timeseries query API**](/docs/{{docsPrefix}}user-guide/telemetry/#data-query-api) - [Telemetry Service](/docs/{{docsPrefix}}user-guide/telemetry/) 提供的服务端 API。
* [**RPC API**](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc-api) - [RPC Service](/docs/{{docsPrefix}}user-guide/rpc/) 提供的服务端 API。
* [**REST Client**](/docs/{{docsPrefix}}reference/rest-client)
* [**Python REST Client**](/docs/{{docsPrefix}}reference/python-rest-client)
* [**Dart API Client**](/docs/{{docsPrefix}}reference/dart-client)

软件开发套件：

* [**Python Client SDK**](/docs/{{docsPrefix}}reference/python-client-sdk) - 用于 Python 项目客户端集成的软件开发套件。
* [**MicroPython Client SDK**](/docs/reference/micropython-client-sdk) - 用于 MicroPython 项目客户端集成的软件开发套件。
* [**CircuitPython Client SDK**](/docs/reference/circuitpython-client-sdk) - 用于 CircuitPython 项目客户端集成的软件开发套件。

{% endif %}