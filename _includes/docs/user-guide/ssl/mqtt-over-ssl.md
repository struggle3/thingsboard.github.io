* TOC
{:toc}

ThingsBoard 支持在 MQTT 服务器上启用 SSL，包括单向和双向 SSL。

大多数 ThingsBoard 环境中，负载均衡器作为设备与平台之间 SSL 连接的终端。
即：MQTT 流量在设备与负载均衡器之间加密，在负载均衡器与平台服务之间解密。
这种方式配置简单。
多数云负载均衡器（如 AWS、Google Cloud 等）提供内置证书生成工具和完善的 SSL over TCP 配置文档。
缺点是无法使用双向 SSL，客户端证书信息不会从负载均衡器传递到平台服务。

仍可配置 ThingsBoard 使用 MQTT 双向 SSL，并避免在 Load Balancer 上做 SSL 终结。
建议使用受信任 CA 签发的有效 SSL 证书，以节省在 [自签名证书](#self-signed-certificates-generation) 相关问题上的排查时间。
以下说明如何在 PEM 文件格式或 Java Keystore 中配置 SSL。


## 使用 PEM 证书文件的 SSL 配置

{% assign sinceVersion = "3.3.2" %}
{% include templates/since.md %}

通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量。
示例以 **thingsboard.conf** 为例：

```bash
...
export MQTT_SSL_ENABLED=true
export MQTT_SSL_CREDENTIALS_TYPE=PEM
export MQTT_SSL_PEM_CERT=server.pem
export MQTT_SSL_PEM_KEY=server_key.pem
export MQTT_SSL_PEM_KEY_PASSWORD=secret
...
```

说明：

* MQTT_SSL_ENABLED — 启用/禁用 SSL；
* MQTT_SSL_CREDENTIALS_TYPE — 服务器凭证类型。PEM 表示 PEM 证书文件；KEYSTORE 表示 Java keystore；
* MQTT_SSL_PEM_CERT — 服务器证书文件路径。可包含服务器证书或证书链，也可包含服务器私钥；
* MQTT_SSL_PEM_KEY — 服务器证书私钥文件路径。默认可选。若服务器证书文件中不含私钥则必须指定；
* MQTT_SSL_PEM_KEY_PASSWORD — 可选，服务器证书私钥密码。

配置完成后，启动或重启 ThingsBoard 服务。

{% include templates/ssl/pem_files_location.md %}

## 其他配置属性

可通过 [configuration](/docs/user-guide/install/{{docsPrefix}}config/) 文件、docker-compose 或 kubernetes 脚本配置以下环境变量：

 * MQTT_SSL_BIND_ADDRESS — MQTT 服务器绑定地址。默认 *0.0.0.0* 表示所有接口；
 * MQTT_SSL_BIND_PORT — MQTT 服务器绑定端口。默认 *8883*；
 * MQTT_SSL_PROTOCOL — SSL 协议名。默认 *TLSv1.2*。详见 [java doc](https://docs.oracle.com/en/java/javase/11/docs/specs/security/standard-names.html#sslcontext-algorithms)；
 * MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT — 跳过客户端证书有效期校验。默认 *false*。

{% include docs/user-guide/ssl/self-signed-ecc.md %}

## Client 示例

参见以下文档：

 - [设备认证选项](/docs/{{docsPrefix}}user-guide/device-credentials/) — 认证方式概览
 - [基于 Access Token 的认证](/docs/{{docsPrefix}}user-guide/access-token/) — **单向 SSL** 连接示例
 - [基于 X.509 Certificate 的认证](/docs/{{docsPrefix}}user-guide/certificates/) — **双向 SSL** 连接示例
