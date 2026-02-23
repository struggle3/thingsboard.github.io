下表描述了在 ThingsBoard 平台上配置 IoT Gateway 授权的参数。

|**参数**|**默认值**|**说明**|
|:-|:-|-
| accessToken              | **PUT_YOUR_GW_ACCESS_TOKEN_HERE**               | ThingsBoard 服务器分配给网关的访问令牌。       |
| caCert                   | **/etc/thingsboard-gateway/mqttserver.pub.pem** | CA 证书文件路径。                                |
|---    

配置文件中的 security 配置小节将如下所示：

```json
...
"security": {
  "accessToken": "PUT_YOUR_GW_ACCESS_TOKEN_HERE",
  "caCert": "/etc/thingsboard-gateway/mqttserver.pub.pem"
},
...
```
