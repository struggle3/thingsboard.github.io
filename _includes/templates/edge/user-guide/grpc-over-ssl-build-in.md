按以下说明生成自己的证书文件。该方法适用于测试，但较耗时，不建议在生产环境使用。

#### 生成私钥

使用以下命令生成新私钥，将创建 2048 位 RSA 私钥并保存到 `privateKey.pem` 文件：

```bash
openssl genpkey -algorithm RSA -out privateKey.pem -pkeyopt rsa_keygen_bits:2048
```
{: .copy-code}

#### 生成 CSR（证书签名请求）

接着使用私钥生成 CSR。
需要提供组织名称、Common Name（域名）和电子邮箱等信息，这些将包含在证书的 subject 字段中。
将 CSR 保存为 `certRequest.csr`：

```bash
openssl req -new -key privateKey.pem -out certRequest.csr
```
{: .copy-code}

{% capture common_name_localhost %}
若 ThingsBoard 服务器在本地运行，生成证书时需将 Common Name（域名）设置为 `localhost`。
若服务器为托管部署，请使用其域名。

若证书域名与服务器主机名不匹配，SSL 连接将失败。
{% endcapture %}
{% include templates/warn-banner.md content=common_name_localhost %}


#### 生成自签名证书

最后，通过 CSR 生成自签名证书。以下命令将生成名为 `certFile.crt` 的证书，有效期为 365 天。可修改 `-days` 参数以调整证书有效期：

```bash
openssl x509 -req -in certRequest.csr -signkey privateKey.pem -out certFile.crt -days 365
```
{: .copy-code}

#### 在服务器上启用 SSL 通信

对于 Ubuntu 和 CentOS/RHEL 安装，使用以下命令在服务端启用 SSL 通信：

```bash
sudo sh -c 'cat <<EOL >> /etc/thingsboard/conf/thingsboard.conf
export EDGES_RPC_SSL_ENABLED=true
export EDGES_RPC_SSL_CERT=certFile.crt
export EDGES_RPC_SSL_PRIVATE_KEY=privateKey.pem
EOL'
```
{: .copy-code}

重启服务器以应用更改：

```bash
sudo systemctl restart thingsboard
```
{: .copy-code}
