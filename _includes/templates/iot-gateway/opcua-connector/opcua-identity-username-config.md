使用此选项可提供用户名和密码以连接 OPC-UA 服务器。

| **参数** | **默认值**  | **说明**                              |
|:--------------|:-------------------|----------------------------------------------|
| type          | **basic**          | Identity 类型。                            |
| username      | **user**           | 登录 OPC-UA 服务器的用户名。 |
| password      | **5Tr0nG?@$sW0rD** | 登录 OPC-UA 服务器的密码。 |
| ---           |                    |                                              |

配置的此部分将如下所示：  

```json
    "identity": {
      "type": "basic",
      "username": "user",
      "password": "5Tr0nG?@$sW0rD"
    },
```

![image](/images/gateway/opc-ua-connector/opc-ua-section-application-advanced-basic-1-ce.png)
