Token 是一种安全配置方式。
授权时将使用本配置节中提供的 token。


|**参数**|**默认值**|**说明**|
|:-|:-|-
| type               | **token**                      | 授权类型。      |
| tokens             | **["Bearer ACCESS_TOKEN"]**    | 允许的 token 列表。     |
|---

配置文件中的 security 配置小节将如下所示： 

```yaml
    "security": [
      "type": "token",
      "tokens": [
        "Bearer ACCESS_TOKEN"
      ]
    ]
```
