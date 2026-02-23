
Basic 认证是一种安全配置方式。
Request Connector 发送带有 Authorization 头的 HTTP 请求，该头包含 "Basic" 后跟空格及 base64 编码的 username:password 字符串。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **basic**                      | 授权类型。      |
| username           | **username**                   | 授权用户名。 |
| password           | **password**                   | 授权密码。 |
|---

配置文件中的 security 部分将如下所示： 

```yaml
    "security": {
      "type": "basic",
      "username": "username",
      "password": "password"
    }
```
