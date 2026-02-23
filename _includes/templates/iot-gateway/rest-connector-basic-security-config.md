
Basic 认证是一种安全配置方式。
REST Connector 等待带有 Authorization 头的 HTTP 请求，该头包含 "Basic" 后跟空格及 base64 编码的 username:password 字符串。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **basic**                      | 授权类型。      |
| username           | **username**                   | 授权用户名。 |
| password           | **password**                   | 授权密码。 |
|---

配置文件中的 security 部分将如下所示：

```json
{
  "security": {
    "type": "basic",
    "username": "username",
    "password": "password"
  }
}
```
{: .copy-code}

另外，请确保请求中包含带有上述凭据的 `Authorization` 头。

若使用 cURL，请求示例为：
```bash
curl --user username:password -H "Content-Type: application/json" -X POST \
    -d '{"name": "SN-001", "sensorModel": "example"}' http://127.0.0.1:5000/test_device
```

若使用 Postman 或 Insomnia，只需启用 Basic 认证即可。
