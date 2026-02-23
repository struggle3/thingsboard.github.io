* TOC
{:toc}

TBMQ 支持托管 Web UI 并通过 SSL 提供 REST API 调用的 HTTP 服务器。

大多数 TBMQ 环境使用负载均衡器作为客户端与 broker 之间 SSL 连接的终止点。
换言之，用户浏览器与负载均衡器之间的互联网流量已加密，但负载均衡器与 broker 服务之间已解密。
此方式的优点是配置简单。
大多数云负载均衡器（AWS、Google Cloud 等）具有内置证书生成工具和丰富的 SSL 配置文档。

尽管如此，仍可将 TBMQ 配置为启用 SSL，避免在 Load Balancer 上终止 SSL。
建议使用受信任 CA 机构签发的有效 SSL 证书，避免在[自签名证书](#self-signed-certificates-generation)问题上耗费时间。
以下说明如何为 PEM 文件格式或 Java Keystore 存储的证书配置 SSL。

## 使用 PEM 证书文件配置 SSL

通过[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/#http-server-parameters)文件、docker-compose 或 kubernetes 脚本设置以下环境变量：

```bash
...
export SSL_ENABLED=true
export SSL_CREDENTIALS_TYPE=PEM
export SSL_PEM_CERT=server.pem
export SSL_PEM_KEY=server_key.pem
export SSL_PEM_KEY_PASSWORD=secret
...
```

其中：

* SSL_ENABLED — 启用/禁用 SSL 支持；
* SSL_CREDENTIALS_TYPE — 服务器凭据类型。PEM — pem 证书文件；KEYSTORE — java keystore；
* SSL_PEM_CERT — 服务器证书文件路径。包含服务器证书或证书链，亦可包含服务器私钥；
* SSL_PEM_KEY — 服务器证书私钥文件路径。默认可选。若私钥未包含在服务器证书文件中则为必填；
* SSL_PEM_KEY_PASSWORD — 可选服务器证书私钥密码。

完成配置后，启动或重启 TBMQ 服务器。

{% include templates/mqtt-broker/ssl/pem_files_location.md %}

## 使用 Java Keystore 配置 SSL

通过[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/#http-server-parameters)文件、docker-compose 或 kubernetes 脚本设置以下环境变量：

```bash
...
export SSL_ENABLED=true
export SSL_CREDENTIALS_TYPE=KEYSTORE
export SSL_KEY_STORE_TYPE=PKCS12
export SSL_KEY_STORE=keystore.p12
export SSL_KEY_STORE_PASSWORD=tbmq
export SSL_KEY_PASSWORD=tbmq
...
```

其中：

* SSL_ENABLED — 启用/禁用 SSL 支持；
* SSL_CREDENTIALS_TYPE — 服务器凭据类型。PEM — pem 证书文件；KEYSTORE — java keystore；
* SSL_KEY_STORE_TYPE — 密钥库类型（JKS 或 PKCS12）；
* SSL_KEY_STORE — 存放 SSL 证书或证书链的密钥库路径，亦可包含服务器私钥；
* SSL_KEY_STORE_PASSWORD — 访问密钥库的密码；
* SSL_KEY_PASSWORD — 访问服务器私钥的密码。

完成配置后，启动或重启 TBMQ 服务器。

{% include templates/mqtt-broker/ssl/keystore_files_location.md %}

{% include docs/user-guide/ssl/self-signed-ecc.md %}

{% include templates/mqtt-broker/ssl/pem-to-keystore.md %}
