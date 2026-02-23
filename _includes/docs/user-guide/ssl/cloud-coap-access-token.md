* TOC
{:toc}

Access Token 认证是默认的设备认证方式。
设备在 ThingsBoard 中创建后会生成唯一 access token，之后可修改。
客户端必须在 CoAP 请求 URL 中指定 access token。

### Plain CoAP（无 TLS）

以下是一条使用 Access Token **YOUR_ACCESS_TOKEN** 向 {{hostLabel}} 上传温度读数的简单命令。
详见 [CoAP API](/docs/{{docsPrefix}}reference/coap-api/)。该命令使用不带 TLS 的 Plain CoAP：

```bash
coap-client -v 6 -m POST coap://{{coapHostName}}/api/v1/YOUR_ACCESS_TOKEN/telemetry -t json -e "{temperature:25}"
```
{: .copy-code}

上述命令需要 coap-client 库，可通过以下命令安装：

- **Ubuntu 20.04：** sudo apt install libcoap2-bin
- **Ubuntu 18.04：** sudo apt install libcoap1-bin

请将 **YOUR_ACCESS_TOKEN** 替换为设备的 access token。

### DTLS 支持（单向 TLS）

CoAP 在 DTLS 上的 access token 认证是标准模式，客户端通过服务器证书验证服务器身份。

> **注意：**「单向 TLS」表示客户端验证服务器，但服务器不验证客户端。

CoAP 客户端连接服务器时，通过校验证书是否过期、是否受客户端信任来确认服务器身份。
证书在以下情况下被视为受信任：

- 由知名证书颁发机构（CA）签发，如 [Let's Encrypt](https://letsencrypt.org/)；
- 存在于客户端 trust store 中。

要建立信任，CoAP 客户端必须提供用于签署服务器证书的 CA 证书。与依赖系统 trust store 的 HTTPS 不同，使用 DTLS 的 CoAP 客户端需要显式配置 CA 证书。

使用示例前，需安装支持 DTLS 的 CoAP 客户端。

#### 安装支持 DTLS 的 CoAP 客户端

{% include templates/coap-dtls/coap-client-dtls.md %}

#### 示例：

CoAP 客户端必须提供 CA 证书以进行验证，请使用 `-R` 标志并指定包含受信任根 CA 证书的 PEM 文件路径。
ThingsBoard 团队已为 [{{hostLabel}}](https://{{hostName}}/signup){:target="_blank"} 配置有效证书。

请通过此 [**链接**](/docs/{{docsPrefix}}user-guide/resources/coap-over-dtls/ca-root.pem) 下载 CA 根证书，并保存到工作目录，命名为「**ca-root.pem**」。

```bash
wget https://thingsboard.io/docs/{{docsPrefix}}user-guide/resources/coap-over-dtls/ca-root.pem
```
{: .copy-code}

现在可使用 *ca-root.pem* 与 {{hostLabel}} 建立安全连接，并用 Access Token **YOUR_ACCESS_TOKEN** 认证设备以上传遥测：

```bash
coap-client-openssl -v 6 -m POST  -R ca-root.pem -t "application/json" -e '{"temperature":42}' coaps://{{coapHostName}}/api/v1/YOUR_ACCESS_TOKEN/telemetry
```
{: .copy-code}

请将 **YOUR_ACCESS_TOKEN** 替换为设备的 access token。