此类方案的优势在于配置简单。
大多数云负载均衡器（AWS、Google Cloud 等）内置证书生成工具，并有丰富的 SSL 配置文档。

尽管如此，仍可配置 ThingsBoard 启用 SSL 而无需在负载均衡器上做 SSL 终结。
我们建议使用受信任 CA 签发的有效 SSL 证书，避免在 [自签名证书](#self-signed-certificates-generation) 相关问题上周折。
以下说明如何配置 PEM 文件格式或 Java Keystore 中的证书。   

## 使用 PEM 证书文件配置 SSL

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
以 **thingsboard.conf** 为例：

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

 * SSL_ENABLED - 启用/禁用 SSL 支持；
 * SSL_CREDENTIALS_TYPE - 服务器凭据类型。PEM - pem 证书文件；KEYSTORE - java keystore；
 * SSL_PEM_CERT - 服务器证书文件路径。包含服务器证书或证书链，也可包含服务器私钥；
 * SSL_PEM_KEY - 服务器证书私钥文件路径。默认可选。若私钥未包含在服务器证书文件中则必填；
 * SSL_PEM_KEY_PASSWORD - 服务器证书私钥密码（可选）。

完成配置后，启动或重启 ThingsBoard 服务器。

{% include templates/ssl/pem_files_location.md %}


{% include docs/user-guide/ssl/self-signed-ecc.md %}
