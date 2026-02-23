| **参数** | **默认值**                 | **说明**                                           |
|:--------------|:-|-
| host          | **127.0.0.1**                     | 服务器域名或 IP 地址。                       |
| port          | **5000**                          | 服务器端口。                                       |
| SSL           | **true**                          | 是否验证服务器 SSL 证书（若可用）。  |
| cert          | **path_to_the_pem_file**          | 证书文件路径。                                 |
| key           | **path_to_the_key_file**          | 私钥文件路径。                                 |
| ---           

配置部分如下所示：

```json
{
  "server": {
    "host": "127.0.0.1",
    "port": 5000,
    "SSL": true,
    "security": {
      "cert": "~/ssl/cert.pem",
      "key": "~/ssl/key.pem"
    }
  }
}
```
{: .copy-code}
