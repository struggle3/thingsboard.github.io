下表描述了在 ThingsBoard 平台上配置 IoT Gateway 授权的参数。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| caCert                   | **/etc/thingsboard-gateway/ca.pem**          | CA 证书文件路径。                                                      |
| privateKey               | **/etc/thingsboard-gateway/privateKey.pem**  | 私钥文件路径。                                             |
| cert                     | **/etc/thingsboard-gateway/certificate.pem** | 证书文件路径。                                             |
| checkCertPeriod          | **86400**                                    | 检查证书有效性的周期（秒）            |
| certificateDaysLeft      | **3**                                        | 证书到期前多少天将生成新证书  |
|---    

配置文件中的 security 配置小节将如下所示：

```json
...
"security": {
  "caCert": "/etc/thingsboard-gateway/ca.pem",
  "privateKey": "/etc/thingsboard-gateway/privateKey.pem",
  "cert": "/etc/thingsboard-gateway/certificate.pem",
  "checkCertPeriod": 86400,
  "certificateDaysLeft": 3
},
...
```
