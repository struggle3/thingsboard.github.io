* TOC
{:toc}

ThingsBoard 支持在 DTLS 之上运行 CoAP 服务器，支持单向与双向 DTLS。
DTLS 配置需要有效的 [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) 证书。
ECDSA 密钥比 RSA 密钥更小，更适合受限设备。
详见对比 [文章](https://sectigostore.com/blog/ecdsa-vs-rsa-everything-you-need-to-know/)。
建议使用受信任 CA 签发的有效 SSL 证书，避免在 [自签名证书](#self-signed-certificates-generation) 相关问题上耗费时间。
以下说明如何为 PEM 文件格式或 Java Keystore 中的证书配置 SSL。


## 使用 PEM 证书文件配置 SSL

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
以 **thingsboard.conf** 为例：

```bash
...
export COAP_DTLS_ENABLED=true
export COAP_DTLS_CREDENTIALS_TYPE=PEM
export COAP_DTLS_PEM_CERT=server.pem
export COAP_DTLS_PEM_KEY=server_key.pem
export COAP_DTLS_PEM_KEY_PASSWORD=secret
...
```

说明：

* COAP_DTLS_ENABLED — 启用/禁用 TLS 支持；
* COAP_DTLS_CREDENTIALS_TYPE — 服务器凭据类型。PEM 表示 PEM 证书文件；KEYSTORE 表示 Java keystore；
* COAP_DTLS_PEM_CERT — 服务器证书文件路径。可包含服务器证书或证书链，也可包含服务器私钥；
* COAP_DTLS_PEM_KEY — 服务器证书私钥文件路径。默认可选。若服务器证书文件中不含私钥则必须指定；
* COAP_DTLS_PEM_KEY_PASSWORD — 可选，服务器证书私钥密码。

配置完成后，启动或重启 ThingsBoard 服务。

{% include templates/ssl/pem_files_location.md %}


## 其他配置属性

可通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量：

* COAP_DTLS_BIND_ADDRESS — 安全 CoAP 服务器绑定地址。默认值 *0.0.0.0* 表示所有接口；
* COAP_DTLS_BIND_PORT — 安全 CoAP 服务器绑定端口。默认值为 *5684*；
* TB_COAP_X509_DTLS_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT — 跳过客户端证书有效性校验。默认值为 *false*；
* TB_COAP_X509_DTLS_SESSION_INACTIVITY_TIMEOUT — DTLS 会话最大空闲时间（毫秒）。默认值 *86400000* 表示一天；
* TB_COAP_X509_DTLS_SESSION_REPORT_TIMEOUT — 定期清理非活动会话的间隔（毫秒）。默认值 *1800000* 表示 30 分钟。

{% include docs/user-guide/ssl/self-signed-ecc.md %}

## 客户端示例

参见以下资源：

- [Access Token 认证](/docs/{{docsPrefix}}user-guide/ssl/coap-access-token/) — **单向 TLS** 连接示例；
- [X.509 证书认证](/docs/{{docsPrefix}}user-guide/ssl/coap-x509-certificates/) — **双向 TLS** 连接示例。
