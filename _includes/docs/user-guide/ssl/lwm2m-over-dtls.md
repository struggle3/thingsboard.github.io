* TOC
{:toc}

ThingsBoard 支持在 DTLS 之上运行 LwM2M 服务器。
平台支持 Pre-Shared Key、Raw Public Key 和 X.509 Certificate 在 DTLS 上的凭据。
DTLS 配置需要有效的 [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) 证书。
ECDSA 密钥比 RSA 密钥更小，因此更适合受限设备。
详见对比 [文章](https://sectigostore.com/blog/ecdsa-vs-rsa-everything-you-need-to-know/)。
建议使用受信任 CA 签发的有效 SSL 证书，避免在 [自签名证书](#self-signed-certificates-generation) 相关问题上耗费时间。
以下说明如何配置 PEM 文件格式或 Java Keystore 中证书的 SSL。


## 使用 PEM 证书文件配置 DTLS

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
以 **thingsboard.conf** 为例：

```bash
...
export LWM2M_SERVER_CREDENTIALS_ENABLED=true
export LWM2M_SERVER_CREDENTIALS_TYPE=PEM
export LWM2M_SERVER_PEM_CERT=server.pem
export LWM2M_SERVER_PEM_KEY=server_key.pem
export LWM2M_SERVER_PEM_KEY_PASSWORD=secret
# To enable Bootstrap and Bootstrap over DTLS
export LWM2M_ENABLED_BS=true
export LWM2M_BS_CREDENTIALS_ENABLED=true
export LWM2M_BS_CREDENTIALS_TYPE=PEM
export LWM2M_BS_PEM_CERT=server.pem
export LWM2M_BS_PEM_KEY=server_key.pem
export LWM2M_BS_PEM_KEY_PASSWORD=secret
...
```

其中：

* LWM2M_SERVER_CREDENTIALS_ENABLED - 启用/禁用 X509 Certificate/RPK 凭据支持；
* LWM2M_SERVER_CREDENTIALS_TYPE - 服务器凭据类型。PEM - pem 证书文件；KEYSTORE - java keystore；
* LWM2M_SERVER_PEM_CERT - 服务器证书文件路径。包含服务器证书或证书链，也可包含服务器私钥；
* LWM2M_SERVER_PEM_KEY - 服务器证书私钥文件路径。默认可选。若私钥未包含在服务器证书文件中则必填；
* LWM2M_SERVER_PEM_KEY_PASSWORD - 服务器证书私钥密码（可选）。

完成配置后，启动或重启 ThingsBoard 服务器。

{% include templates/ssl/pem_files_location.md %}


## 额外配置属性

您可通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下额外环境变量。

* LWM2M_SECURITY_BIND_ADDRESS - 安全 LwM2M 服务器的绑定地址。默认值 *0.0.0.0* 表示所有接口；
* LWM2M_SECURITY_BIND_PORT - 安全 LwM2M 服务器的绑定端口。默认值为 *5686*；
* TB_LWM2M_SERVER_SECURITY_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT - 跳过客户端证书有效性检查。默认值为 *false*。
* LWM2M_BS_SECURITY_BIND_ADDRESS - 安全 LwM2M Bootstrap 服务器的绑定地址。默认值 *0.0.0.0* 表示所有接口；
* LWM2M_BS_SECURITY_BIND_PORT - 安全 LwM2M Bootstrap 服务器的绑定端口。默认值为 *5688*；

{% include docs/user-guide/ssl/self-signed-ecc.md %}

## Client Examples

参见以下资源：

- [Access Token 认证](/docs/{{docsPrefix}}user-guide/ssl/coap-access-token/)：**单向 SSL** 连接示例；
- [X.509 证书认证](/docs/{{docsPrefix}}user-guide/ssl/coap-x509-certificates/)：**双向 SSL** 连接示例。
