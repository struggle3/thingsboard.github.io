
设备凭证用于在设备上运行的应用连接 ThingsBoard 服务器。
ThingsBoard 支持多种设备凭证类型，目前提供三种：

 - [**Access Token**](/docs/{{docsPrefix}}user-guide/access-token/) — 通用凭证，适用于多种设备。
 基于 Access Token 的认证可用于未加密、单向 SSL 模式或 DTLS accessToken 模式。
   - **优点：** 适用于资源受限设备。网络开销低。配置和使用简单。
   - **缺点：** 在未加密网络连接（如 HTTP 而非 HTTPS、无 TLS/SSL 的 MQTT、无 DTLS 的 CoAP 等）下容易被截获。
 - [**Basic MQTT**](/docs/{{docsPrefix}}user-guide/basic-mqtt/) — 与第一种类似，但基于 MQTT Client Id、username 和 password。可用于未加密或单向 SSL 模式。
   - **优点：** 适用于资源受限设备。网络开销低。配置和使用简单。
   - **缺点：** 在未加密网络连接（无 TLS/SSL 的 MQTT）下容易被截获。
 - [**X.509 Certificates**](/docs/{{docsPrefix}}user-guide/certificates/) — 遵循 [PKI](https://en.wikipedia.org/wiki/Public_key_infrastructure)、[TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) 和 [DTLS](https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security) 标准。
 基于 X.509 Certificate 的认证用于双向 SSL 模式及 CoAP DTLS X.509 Certificate 模式。
   - **优点：** 通过加密网络与公钥基础设施提供更高安全性。
   - **缺点：** 部分资源受限设备不支持。会增加电池与 CPU 消耗。

设备凭证需配置到服务器上对应的设备实体。可通过以下方式完成：

 - **自动**：使用 [X.509 Certificate chain](/docs/{{docsPrefix}}user-guide/certificates/) 或 [device provisioning](/docs/{{docsPrefix}}user-guide/device-provisioning/)。设备可自动在 ThingsBoard 中完成 provision。
 - **脚本**：使用 ThingsBoard [REST API](/docs/{{docsPrefix}}reference/rest-api/)。例如在制造、QA 或采购订单履行阶段。
 - **手动**：使用 ThingsBoard [Web UI](/docs/{{docsPrefix}}user-guide/ui/devices/#manage-device-credentials)。例如开发用途，或由系统管理员操作。


