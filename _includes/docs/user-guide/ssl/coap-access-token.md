* TOC 
{:toc}
  
Access Token 认证是默认的设备认证方式。设备在 ThingsBoard 中创建后，会生成默认的 access token。之后可修改。
若要通过 Access Token 认证将设备连接到服务器，客户端必须在 CoAP 请求 URL 中指定 access token。
详见 [CoAP API](/docs/{{docsPrefix}}reference/coap-api/)。

CoAP 在 DTLS 上的 Access Token 认证是一种标准认证模式，客户端设备通过服务器证书验证服务器身份。
要为 DTLS 启用 CoAP Access Token 认证，服务器证书链需由受信任 CA 签发，或客户端需将自签名服务器证书（.cer 或 .pem）导入其 trust store。
否则连接会因 "Unknown CA" 错误而失败。

以下 coap-client 示例演示如何连接到 [ThingsBoard Cloud](https://{{hostName}}/signup) 或任何具有有效且受信任证书的 ThingsBoard CoAP 服务器。

## 使用 access token 连接 DTLS CoAP 客户端

### Plain CoAP（无 TLS）

下面是一条使用 Access Token **YOUR_ACCESS_TOKEN** 向 ThingsBoard 实例 **YOUR_TB_HOST** 上传温度读数的简单命令。
详见 [CoAP API](/docs/{{docsPrefix}}reference/coap-api/)。该命令使用不带 TLS 的 Plain CoAP：

```bash
coap-client -v 6 -m POST coap://YOUR_TB_HOST:5683/api/v1/YOUR_ACCESS_TOKEN/telemetry -t json -e "{temperature:25}"
```
{: .copy-code}

上述命令需要 coap-client 库，可通过以下命令安装： 

 - **Ubuntu 20.04:** sudo apt install libcoap2-bin
 - **Ubuntu 18.04:** sudo apt install libcoap1-bin

别忘了将 **YOUR_TB_HOST** 替换为您的 ThingsBoard 实例主机，**YOUR_ACCESS_TOKEN** 替换为设备的 access token。

### DTLS 支持（单向 TLS）

CoAP 在 DTLS 上的 access token 认证是一种标准模式，客户端设备通过服务器证书验证服务器身份。

> **注意：**“单向 TLS”是指客户端验证服务器，但服务器不验证客户端。

CoAP 客户端连接服务器时，通过验证证书是否过期、是否受客户端信任来确认服务器身份。
在以下情况下证书被视为受信任：

 - 由知名证书颁发机构（CA）签发，如 [Let's Encrypt](https://letsencrypt.org/)；
 - 存在于客户端的 trust store 中。

要建立信任，CoAP 客户端必须提供用于签署服务器证书的 CA 证书。与某些依赖系统 trust store 的 HTTPS 实现不同，使用 DTLS 的 CoAP 客户端需要显式配置 CA 证书。

若未提供 CA 证书，连接可能仍会成功，但证书验证会被禁用，
即客户端会接受服务器提供的任何证书而不校验其真实性。 

```bash
127.0.0.1:35046 <-> 127.0.0.1:5684 DTLS: unable to get local issuer certificate: overridden: 'localhost' depth=0
127.0.0.1:35046 <-> 127.0.0.1:5684 DTLS: unable to get certificate CRL: overridden: 'localhost' depth=0
127.0.0.1:35046 <-> 127.0.0.1:5684 DTLS: unable to verify the first certificate: overridden: 'localhost' depth=0
```

尽管有这些警告，握手仍会成功完成：

```bash
127.0.0.1:35046 <-> 127.0.0.1:5684 DTLS: Using cipher: ECDHE-ECDSA-AES256-GCM-SHA384
```

这会使连接暴露于中间人（MITM）攻击，生产环境中应避免。
为提高安全性，请考虑使用 [Two-Way DTLS](/docs/{{docsPrefix}}user-guide/ssl/coap-x509-certificates/)，
实现客户端与服务器互相验证证书。

在使用示例之前，需先安装支持 DTLS 的 CoAP 客户端。

#### 安装支持 DTLS 的 CoAP 客户端

{% include templates/coap-dtls/coap-client-dtls.md %}

#### 示例： 

由于 CoAP 客户端必须始终提供 CA 证书以进行验证，
请使用 `-R` 标志，后跟包含受信任根 CA 证书的 PEM 文件路径。

{% unless docsPrefix contains "paas/" %}
若您托管自己的 ThingsBoard 实例，请参阅 [CoAP over DTLS](/docs/{{docsPrefix}}user-guide/coap-over-dtls/) 指南以配置服务器证书。
{% endunless %}

配置完成后，需准备 pem 格式的 CA 根证书。该证书将供 CoAP 客户端验证服务器证书。
将 CA 根证书保存到工作目录，命名为 "**ca-root.pem**"。

现在可使用 "**ca.pem**" 建立与 ThingsBoard 实例 **YOUR_TB_HOST** 的安全连接，并使用 Access Token **YOUR_ACCESS_TOKEN** 认证设备以上传遥测数据：

```bash
coap-client-openssl -v 6 -m POST  -R ca-root.pem -t "application/json" -e '{"temperature":42}' coaps://YOUR_TB_HOST/api/v1/YOUR_ACCESS_TOKEN/telemetry
```
{: .copy-code}

别忘了将 **YOUR_TB_HOST** 替换为您的 ThingsBoard 实例主机，**YOUR_ACCESS_TOKEN** 替换为设备的 access token。
