Topic filters 定义**基于 MQTT 的订阅**，并作为 TBMQ HTTP Integration 的触发器。当 broker 收到与 configured **topic filters** 匹配的消息时，integration 会处理并转发到指定外部系统。

若 integration 配置了如下 topic filter：
```plaintext
tbmq/devices/+/status
```

则匹配该模式的消息都会触发 integration，例如：
```plaintext
tbmq/devices/device-01/status
tbmq/devices/gateway-01/status
```
