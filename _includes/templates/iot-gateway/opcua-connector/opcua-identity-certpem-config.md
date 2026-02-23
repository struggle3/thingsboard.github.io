此 identity 小节选项最安全。

| **参数** | **默认值**                             | **说明**                                                           |
|:-|:-|-
| type          | **cert.PEM**                                  | OPC-UA 服务器上的 identity 类型。                                        |
| caCert        | **/etc/thingsboard-gateway/ca.pem**           | CA 证书的路径。                                               |
| privateKey    | **/etc/thingsboard-gateway/private_key.pem**  | 私钥的路径。                                                  |
| cert          | **/etc/thingsboard-gateway/cert.pem**         | 证书文件的路径。                                             |
| mode          | **SignAndEncrypt**                            | 安全模式，有两个选项：**Sign** 和 **SignAndEncrypt**。    |  
| username      | **user**                                      | 登录 OPC-UA 服务器的用户名。                              |
| password      | **5Tr0nG?@$sW0rD**                            | 登录 OPC-UA 服务器的密码。                              |
|---

***可选地，可提供用户名/密码对。***

配置的此部分将如下所示：  

```json
    "identity": {
      "type": "cert.PEM",
      "caCert": "etc/thingsboard-gateway/ca.pem",
      "privateKey": "etc/thingsboard-gateway/private_key.pem", 
      "cert": "etc/thingsboard-gateway/cert.pem",
      "mode": "SignAndEncrypt",
      "username": "user",
      "password": "5Tr0nG?@$sW0rD"
    },
```

![image](/images/gateway/opc-ua-connector/opc-ua-section-application-advanced-certificates-1-ce.png)
