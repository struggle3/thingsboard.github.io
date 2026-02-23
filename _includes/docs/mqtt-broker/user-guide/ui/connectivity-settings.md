在 **Connectivity Settings** 页面可覆盖以下协议的默认 **host** 和 **port**：
* **MQTT**。 明文 MQTT 连接的 TCP 监听端口。
* **MQTTS**。 安全 MQTT 连接的 SSL/TLS 端口。
* **WS**。 MQTT over WebSockets 的 WebSocket 监听端口。
* **WSS**。 MQTT over 安全 WebSockets 的安全 WebSocket 监听端口。

Host 指服务器绑定的主机名或 IP 地址。UI 的**默认 host** 为 `window.location.hostname`，动态使用网页 URL 的主机名。

| Protocol  | Default Port | Port Variable              | Bind Address Variable        |
|-----------|--------------|----------------------------|------------------------------|
| **MQTT**  | `1883`       | `LISTENER_TCP_BIND_PORT`   | `LISTENER_TCP_BIND_ADDRESS`  |
| **MQTTS** | `8883`       | `LISTENER_SSL_BIND_PORT`   | `LISTENER_SSL_BIND_ADDRESS`  |
| **WS**    | `8084`       | `LISTENER_WS_BIND_PORT`    | `LISTENER_WS_BIND_ADDRESS`   |
| **WSS**   | `8085`       | `LISTENER_WSS_BIND_PORT`   | `LISTENER_WSS_BIND_ADDRESS`  |

这些自定义值将用于 TBMQ 应用中需要协议特定连接性的各处。主要示例：

* **Check connectivity** 窗口。使用 **MQTT** 的 connectivity 设置生成带自定义 host 和 port 的命令。
* **Add WebSocket Connection** 窗口。使用 **WS** 的 connectivity 设置自动生成带自定义 host 和 port 的 WebSocket 连接 URL。

{% include images-gallery.html imageCollection="settings-connectivity-settings" %}
