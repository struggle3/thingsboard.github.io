* TOC
{:toc}

TBMQ 支持在 SSL 上运行 MQTT 服务器与 MQTT over WebSocket，支持单向和双向 SSL。

大多数 TBMQ 环境将负载均衡器作为设备与代理之间 SSL 连接的终止点。
即 MQTT 流量在设备与负载均衡器之间加密，在负载均衡器与代理服务之间解密。
该方式的优点为配置简单。
多数云负载均衡器（AWS、Google Cloud 等）内置证书生成工具，并提供 TCP 上 SSL 的详细配置文档。
缺点为无法实现双向 SSL，客户端证书信息不会从负载均衡器传递至代理服务。

尽管如此，仍可将 TBMQ 配置为 MQTT 的双向 SSL，并避免在负载均衡器上终止 SSL。
建议使用受信任 CA 签发的有效 SSL 证书，并避免在[自签名证书](#self-signed-certificates-generation)问题上花费时间。
下方说明如何为 PEM 文件格式或 Java Keystore 中存储的证书配置 SSL。

## 使用 PEM 证书文件配置 SSL

通过[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/#mqtt-listeners-parameters)文件、docker-compose 或 kubernetes 脚本配置以下环境变量：

```bash
...
export LISTENER_SSL_ENABLED=true
export LISTENER_SSL_CREDENTIALS_TYPE=PEM
export LISTENER_SSL_PEM_CERT=server.pem
export LISTENER_SSL_PEM_KEY=server_key.pem
export LISTENER_SSL_PEM_KEY_PASSWORD=secret
...
```

其中：

* LISTENER_SSL_ENABLED — 启用/禁用 SSL 支持；
* LISTENER_SSL_CREDENTIALS_TYPE — 服务器凭证类型。PEM 为 pem 证书文件；KEYSTORE 为 java keystore；
* LISTENER_SSL_PEM_CERT — 服务器证书文件路径。包含服务器证书或证书链，也可包含服务器私钥；
* LISTENER_SSL_PEM_KEY — 服务器证书私钥文件路径。默认可选。若服务器证书文件中未包含私钥则为必填；
* LISTENER_SSL_PEM_KEY_PASSWORD — 服务器证书私钥密码（可选）。

完成设置后，启动或重启 TBMQ 服务。

{% include templates/mqtt-broker/ssl/pem_files_location.md %}

## 使用 Java Keystore 配置 SSL

通过[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/#mqtt-listeners-parameters)文件、docker-compose 或 kubernetes 脚本配置以下环境变量：

```bash
...
export LISTENER_SSL_ENABLED=true
export LISTENER_SSL_CREDENTIALS_TYPE=KEYSTORE
export LISTENER_SSL_KEY_STORE_TYPE=PKCS12
export LISTENER_SSL_KEY_STORE=keystore.p12
export LISTENER_SSL_KEY_STORE_PASSWORD=tbmq
export LISTENER_SSL_KEY_PASSWORD=tbmq
...
```

其中：

* LISTENER_SSL_ENABLED — 启用/禁用 SSL 支持；
* LISTENER_SSL_CREDENTIALS_TYPE — 服务器凭据类型。PEM 为 pem 证书文件；KEYSTORE 为 java keystore；
* LISTENER_SSL_KEY_STORE_TYPE — 密钥库类型（JKS 或 PKCS12）；
* LISTENER_SSL_KEY_STORE — 存放 SSL 证书或证书链的密钥库路径，亦可包含服务器私钥；
* LISTENER_SSL_KEY_STORE_PASSWORD — 访问密钥库的密码；
* LISTENER_SSL_KEY_PASSWORD — 访问服务器私钥的密码。

完成配置后，启动或重启 TBMQ 服务器。

{% include templates/mqtt-broker/ssl/keystore_files_location.md %}

## 额外配置属性

可通过[配置](/docs/{{docsPrefix}}mqtt-broker/install/config/#mqtt-listeners-parameters)文件、docker-compose 或 kubernetes 脚本配置以下环境变量：

* LISTENER_SSL_BIND_ADDRESS — MQTT 服务器的绑定地址。默认 *0.0.0.0* 表示所有接口；
* LISTENER_SSL_BIND_PORT — MQTT 服务器的绑定端口。默认 *8883*；
* LISTENER_SSL_PROTOCOL — SSL 协议名。默认 *TLSv1.2*。详见 [java doc](https://docs.oracle.com/en/java/javase/17/docs/specs/security/standard-names.html#sslcontext-algorithms)。

{% include docs/user-guide/ssl/self-signed-ecc.md %}

> It is recommended to include the **ca.pem** file in TBMQ’s Truststore.
> This is especially important if you plan to issue client certificates signed by the same CA that signed the server certificate.
> By doing so, TBMQ will be able to validate these client certificates during the TLS handshake, allowing secure MQTT client connections.

为此，需将服务器证书与 CA 证书拼接以创建证书链：

```bash
cat server.pem ca.pem > serverChain.pem
```
{: .copy-code}

然后将生成的 `serverChain.pem` 文件在 TBMQ 中配置，设置以下环境变量：

```bash
LISTENER_SSL_PEM_CERT=serverChain.pem
```
{: .copy-code}

这可确保服务器证书与 CA 证书被正确识别，在使用客户端证书时启用安全双向认证。

{% include templates/mqtt-broker/ssl/pem-to-keystore.md %}

## 将证书添加到 Java Truststore

在基于 Java 的应用中，**truststore** 是包含应用信任实体（证书颁发机构或服务器）证书的特殊密钥库。
将证书加入 truststore 可确保使用该 truststore 运行的 Java 应用会接受由该证书或其颁发 CA 签名的 SSL/TLS 连接。

```bash
keytool -importcert -file CERT.pem -alias ALIAS -keystore keystore.p12 -storepass KEYSTOREPASS
```
{: .copy-code}

**参数说明：**

* `-importcert` — 告知 `keytool` 将证书导入指定 keystore/truststore。
* `-file CERT.pem` — 要导入的证书文件路径。
* `-alias ALIAS` — 密钥库中引用该证书的唯一名称。
* `-keystore keystore.p12` — 将添加证书的 Java keystore/truststore 文件（.jks 或 .p12）。若不存在则会创建。
* `-storepass KEYSTOREPASS` — 保护密钥库的密码。

> 请确保使用相应的 [Keystore 参数](#ssl-configuration-using-java-keystore) 在 TBMQ 中启用 MQTTS。
 
使用 *keytool* 命令前，系统需安装 Java Development Kit (JDK)。

## MQTT over WebSocket 安全连接

要启用 MQTT over WebSockets (WSS)，可按上述相同 SSL 配置步骤操作。
在配置文件、Docker Compose 或 Kubernetes 清单中使用对应的 WebSocket 专用环境变量（如 `LISTENER_WSS_ENABLED`、`LISTENER_WSS_CREDENTIALS_TYPE` 等）即可。

使用 PEM 或 Keystore 的 SSL 配置对原始 MQTT over TLS 和 WebSocket over TLS 端点同样适用。
