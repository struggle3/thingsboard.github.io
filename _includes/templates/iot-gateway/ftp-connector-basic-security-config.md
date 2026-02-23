
Basic 是一种安全配置方式。
授权时将使用本配置节中提供的 username 和 password 组合。


|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **basic**                      | 授权类型。      |
| username           | **username**                   | 授权用户名。 |
| password           | **password**                   | 授权密码。 |
|---

配置文件中的 security 配置小节将如下所示： 

```yaml
    "security": {
      "type": "basic",
      "username": "username",
      "password": "password"
    }
```
