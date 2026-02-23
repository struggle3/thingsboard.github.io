下表描述了在 MQTT broker 上配置授权所需的参数。

| **参数**     | **默认值**                            | **说明**            |
|:------------------|:---------------------------------------------|----------------------------
| type              | **certificates**                             | 授权类型。     |
| pathToCACert      | **/etc/thingsboard-gateway/ca.pem**          | CA 文件路径。           |
| pathToPrivateKey  | **/etc/thingsboard-gateway/privateKey.pem**  | 私钥文件路径。  |
| pathToClientCert  | **/etc/thingsboard-gateway/certificate.pem** | 证书文件路径。  |
| ---               

![image](/images/gateway/mqtt-connector/security-basic-certificates-subsection-1-ce.png)
