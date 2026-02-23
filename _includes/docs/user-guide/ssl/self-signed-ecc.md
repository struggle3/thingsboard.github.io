## 自签名证书生成

以下说明用于生成自有证书文件，适用于测试环境，耗时且不推荐用于生产环境。

> **注意：** 需在已安装 openssl 的 Linux 类系统上执行以下步骤。

可选择为服务器创建自签名证书，或按进阶步骤创建 CA 签名的服务器证书。
两种方式都能实现同一目标：用有效证书保护服务器。

#### 自签名证书 PEM 文件

这是更简单的方式，由服务器自行生成并签署证书，适用于基础测试或无需证书颁发机构（CA）的小型部署。
生成服务器自签名 PEM 证书及私钥可使用以下命令：

```bash
openssl ecparam -out server_key.pem -name secp256r1 -genkey
openssl req -new -key server_key.pem -x509 -nodes -days 365 -out server.pem 
```
{: .copy-code}

如不想用密码保护私钥，可加 `-nodes`（no DES 的缩写），否则会要求输入「至少 4 个字符」的密码。

**days** 参数（365）可改为任意数字以影响有效期。随后会提示输入「Country Name」等，可直接按 Enter 使用默认值。

添加 `-subj '/CN=localhost'` 可跳过证书内容相关提问（将 localhost 替换为你的域名）。

自签名证书不经第三方校验，除非事先导入浏览器。如需更高安全性，应使用由证书颁发机构（CA）签名的证书。

#### 由证书颁发机构（CA）签名的证书 PEM 文件

本方法通过创建证书颁发机构（CA）来签署服务器证书，适合需要更高安全性的场景，
尤其是计划管理多张证书或需要专用 CA 进行签名时。

**生成 CA 私钥：**

```bash
openssl ecparam -out ca_key.pem -name secp256r1 -genkey
```
{: .copy-code}

**生成自签名 CA 证书：**

```bash
openssl req -new -x509 -key ca_key.pem -days 365 -out ca.pem
```
{: .copy-code}

将生成有效期为 365 天的自签名 CA 证书「**ca.pem**」。按提示填写证书信息（如 Common Name：My Root CA）。

**生成服务器私钥：**

```bash
openssl ecparam -out server_key.pem -name secp256r1 -genkey
```
{: .copy-code}

将生成 **EC 私钥 server_key.pem**。

**创建证书签名请求（CSR）：**

```bash
openssl req -new -key server_key.pem -out server.csr
```
{: .copy-code}

「**server.csr**」包含待 CA 签名的服务器信息。

**最后，使用 CA 签署服务器证书：**

```bash
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca_key.pem -CAcreateserial -out server.pem -days 365
```
{: .copy-code}

该命令将生成由 CA 签名的服务器证书「**server.pem**」。

`-req`：表示输入为证书签名请求（CSR）。
`-CA` 与 `-CAkey`：指定用于签署服务器证书的 CA 证书「**ca.pem**」及其私钥「**ca_key.pem**」。

`-CAcreateserial` 会自动生成序列号文件「**ca.srl**」以记录该 CA 的证书序列号。 
签署多张证书时很有用。若不希望生成「**ca.srl**」，可将 `-CAcreateserial` 换成 `-set_serial <serial_number>` 手动指定序列号。
