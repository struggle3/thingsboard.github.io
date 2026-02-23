为安全隧道会话提供认证与加密。

这些参数可在 "**security**" 子节中配置：

| **参数**                  | **说明**                                                   |
|:-------------------------------|-------------------------------------------------------------------|
| backbone_key                   | 用于 KNX Secure Routing，以十六进制表示。                |
| latency_ms                     | KNX Secure Routing 的延迟（毫秒）。                   |
| user_id                        | 安全隧道会话中用户认证的标识符。    |
| device_authentication_password | 连接隧道时使用的认证密码。 |
| user_password                  | 用户密码。                                                    |
| ---                            |                                                                   |

配置文件中此子节如下所示：

```json
"security": {
    "backbone_key": "secret",
    "latency_ms": 100,
    "user_id": "user",
    "device_authentication_password": "password",
    "user_password": "password"
}
```
