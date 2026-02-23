* TOC
{:toc}

TBMQ 为监听器提供灵活配置选项，支持 TCP、SSL/TLS 和 MQTT over WebSockets 协议。

### TCP Listener

默认情况下，TBMQ 在端口 `1883` 启用 TCP 监听器。
若需禁用 TCP 监听器，可将 `LISTENER_TCP_ENABLED` 环境变量设为 `false`。

此外，若需修改 broker 绑定的主机地址或监听端口，
可分别修改 `LISTENER_TCP_BIND_ADDRESS` 和 `LISTENER_TCP_BIND_PORT` 变量。
这可灵活配置 broker 在指定网络接口和端口上监听。

通过调整这些环境变量，可根据需求自定义 TBMQ 的 TCP 监听行为。

### TLS Listener

启用 SSL/TLS 监听器：将 `LISTENER_SSL_ENABLED` 环境变量设为 `true`。默认 broker 在 `8883` 端口监听。
修改 broker 监听的主机和/或端口：分别更新 `LISTENER_SSL_BIND_ADDRESS` 和 `LISTENER_SSL_BIND_PORT` 变量。

通过设置 `LISTENER_SSL_CREDENTIALS_TYPE` 参数选择凭据类型。当前支持 `PEM` 和 `KEYSTORE`。
所有可用属性列表见[配置文档](/docs/{{docsPrefix}}mqtt-broker/install/config/)。

若选择 KeyStore 作为凭据类型，需配置：
- 将 `LISTENER_SSL_KEY_STORE` 变量设为包含服务器证书链的 `.jks` 文件路径。
- 将 `LISTENER_SSL_KEY_STORE_PASSWORD` 变量设为访问密钥库的密码。
- 将 `LISTENER_SSL_KEY_PASSWORD` 变量设为服务器证书的密码。

若选择 Pem 作为凭据类型，需配置：
- 将 `LISTENER_SSL_PEM_CERT` 变量设为服务器证书文件路径。
- 将 `LISTENER_SSL_PEM_KEY` 变量设为服务器证书私钥文件路径。
- 将 `LISTENER_SSL_PEM_KEY_PASSWORD` 变量设为服务器证书私钥的密码。

若需双向 TLS，还需通过向已配置的 KeyStore/PEM 文件添加受信任证书/链来配置 TrustStore。
有关配置可能性和证书生成的更多信息，请参阅以下 security [页面](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/)。

### WS Listener

默认情况下，TBMQ 在端口 `8084` 启用 WebSocket 监听器。
若需禁用 WS 监听器，可将 `LISTENER_WS_ENABLED` 环境变量设为 `false`。

此外，若需修改 broker 绑定的主机地址或监听端口，
可分别修改 `LISTENER_WS_BIND_ADDRESS` 和 `LISTENER_WS_BIND_PORT` 变量。

WS 监听器默认配置为协商所有 MQTT 版本，即 `WS_NETTY_SUB_PROTOCOLS` 设为 `mqttv3.1,mqtt`。
子协议设置 `mqtt` 表示 MQTT 3.1.1 和 MQTT 5。

### WSS Listener

启用 WebSocket Secure 监听器：将 `LISTENER_WSS_ENABLED` 环境变量设为 `true`。默认 broker 在 `8085` 端口监听。
修改 broker 监听的主机和/或端口：分别更新 `LISTENER_WSS_BIND_ADDRESS` 和 `LISTENER_WSS_BIND_PORT` 变量。

通过设置 `LISTENER_WSS_CREDENTIALS_TYPE` 参数选择凭据类型。
支持选项与 [TLS](#tls-listener) 监听器相同。

若选择 KeyStore 作为凭据类型，需配置：
- 将 `LISTENER_WSS_KEY_STORE` 变量设为包含服务器证书链的 `.jks` 文件路径。
- 将 `LISTENER_WSS_KEY_STORE_PASSWORD` 变量设为访问密钥库的密码。
- 将 `LISTENER_WSS_KEY_PASSWORD` 变量设为服务器证书的密码。

若选择 Pem 作为凭据类型，需配置：
- 将 `LISTENER_WSS_PEM_CERT` 变量设为服务器证书文件路径。
- 将 `LISTENER_WSS_PEM_KEY` 变量设为服务器证书私钥文件路径。
- 将 `LISTENER_WSS_PEM_KEY_PASSWORD` 变量设为服务器证书私钥的密码。

若需双向 TLS，请勿忘记配置 TrustStore，添加受信任证书/链。
WSS 监听器与 [WS](#ws-listener) 监听器使用相同的协商子协议。若需修改此默认行为，请适当更新 `WSS_NETTY_SUB_PROTOCOLS` 参数。

### Next steps

- [**Connectivity settings**](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/settings/#connectivity) - 了解如何为基于不同协议的功能在 TBMQ UI 中配置 hosts 和 ports。
{% assign currentGuide = "SecurityGuide" %}{% include templates/mqtt-broker-guides-banner.md %}
