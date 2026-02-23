* TOC
{:toc}

X.509 证书用于为 CoAP over DTLS 配置 [mutual](https://en.wikipedia.org/wiki/Mutual_authentication)（双向）认证。
它与 [access token](/docs/{{docsPrefix}}user-guide/access-token/) 认证类似，但使用 X.509 证书替代 token。

以下说明如何将使用 X.509 证书的 CoAP 客户端连接到 ThingsBoard Cloud。

## 步骤 1：生成客户端证书

使用以下命令生成基于自签名 EC 的私钥和 x509 证书。
该命令基于 **openssl** 工具，您的工作站上通常已安装：

```bash
openssl ecparam -out key.pem -name secp256r1 -genkey
openssl req -new -key key.pem -x509 -nodes -days 365 -out cert.pem 
```
{: .copy-code}

命令输出为私钥文件 *key.pem* 和公钥证书 *cert.pem*。
后续步骤将使用它们。

## 步骤 2：将客户端公钥配置为设备凭据
{% if docsPrefix == 'pe/' %}
进入 **ThingsBoard Web UI -> Device Groups -> Group "All" -> Your Device -> Device Credentials**。
{% else %}
进入 **ThingsBoard Web UI -> Devices -> Your Device -> Device Credentials**。
{% endif %}
选择 **X.509 Certificate** 设备凭据，插入 *cert.pem* 文件内容并保存。
也可通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 完成。

## 步骤 3：使用 X.509 证书连接 DTLS CoAP 客户端

{% include templates/coap-dtls/coap-client-dtls.md %}

最后，运行以下示例脚本以验证 DTLS 的 X.509 证书认证，并订阅共享属性更新：
以下 coap-client 示例演示如何连接到 [ThingsBoard Cloud](https://{{hostName}}/signup) 或任何具有有效且受信任证书的 ThingsBoard CoAP 服务器。

```bash
coap-client-openssl -v 9 -c cert.pem  -j key.pem -m POST \
-t "application/json" -e '{"temperature":43}' coaps://{{coapHostName}}/api/v1/telemetry
```
{: .copy-code}

别忘了将 **{{coapHostName}}** 替换为您的 ThingsBoard 实例主机。
