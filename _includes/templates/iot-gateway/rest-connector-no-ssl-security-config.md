| **参数** | **默认值**                 | **说明**                                           |
|:--------------|:-|-
| host          | **127.0.0.1**                     | 服务器域名或 IP 地址。                       |
| port          | **5000**                          | 服务器端口。                                       |
| SSL           | **false**                         | 是否验证服务器 SSL 证书（若可用）。  |
| ---           

配置部分如下所示：
```json
{
  "server": {
    "host": "127.0.0.1",
    "port": 5000,
    "SSL": false,
    "security": {
      "cert": "~/ssl/cert.pem",
      "key": "~/ssl/key.pem"
    }
  }
}
```
{: .copy-code}
