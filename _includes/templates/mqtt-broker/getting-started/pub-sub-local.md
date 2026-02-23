##### 订阅 topic

要订阅 **sensors/temperature** topic 并开始接收消息，请使用以下命令：

```bash
mosquitto_sub -d -h localhost -p 1883 -t sensors/temperature -q 1 -u username -P password
```
{: .copy-code}

**注意：** 请将 `username` 和 `password` 替换为您在[认证配置](#configure-client-authentication--authorization)中创建的凭据。

连接成功后，可通过进入 _Sessions_ 页面在 UI 中查看会话信息。

{% include images-gallery.html imageCollection="broker-sessions" %}

##### 发布消息

要向 **sensors/temperature** topic 发布消息，请使用以下命令：

```bash
mosquitto_pub -d -h localhost -p 1883 -t sensors/temperature -m 32 -q 1 -u username -P password
```
{: .copy-code}

**注意：** 请将 `username` 和 `password` 替换为您在[认证配置](#configure-client-authentication--authorization)中创建的凭据。
