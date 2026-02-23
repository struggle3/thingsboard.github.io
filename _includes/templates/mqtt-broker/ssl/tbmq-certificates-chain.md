
#### 步骤 1. 准备服务器与 Client 证书链

若自托管 TBMQ，请按 [MQTT over SSL](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/) 指南配置服务器证书。

配置完成后，准备 pem 格式的 CA root 证书。MQTT 客户端将使用该证书校验服务器证书。
将 CA root 证书保存到工作目录，命名为 "**ca.pem**"。

#### Step 2. 生成 Client 证书链

需生成具有合理 Common Names (CN) 的证书链。将使用中间证书为设备签发证书。
例如，证书链 CN 可如下：

 * Root 证书 CN: company-name.com；
 * Intermediate 证书: device-group-name.company-name.com；
 * Device 证书: device-name.device-group-name.company-name.com；

使用以下命令为各级链生成自签名私钥、证书签发请求和 x509 证书。
命令基于 **OpenSSL** 工具，工作机通常已安装：

**步骤 2.1** 生成 root 证书 

生成 Root 证书和私钥，使用以下命令。提示时请填写正确的 CN：

```bash
openssl req -x509 -newkey rsa:4096 -keyout rootKey.pem -out rootCert.pem -sha256 -days 365 -nodes
```
{: .copy-code}

<details>
<summary>
示例输出，CN 为 *company.com*
</summary>
{% highlight text %}
Generating a RSA private key
writing new private key to 'rootKey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:company.com
Email Address []:
{% endhighlight %}
</details>
<br>

**步骤 2.2** 生成 intermediate 证书 

生成 intermediate 密钥和证书请求，使用以下命令。提示时请填写正确的 CN：

```bash
openssl req -new -newkey rsa:4096 -keyout intermediateKey.pem -out intermediate.csr -sha256 -nodes
```
{: .copy-code}

<details>
<summary>
示例输出，CN 为 *group.company.com*
</summary>
{% highlight text %}
Generating a RSA private key
writing new private key to 'intermediateKey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:group.company.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
{% endhighlight %}
</details>
<br>

生成 intermediate 证书，使用以下命令：

```bash
openssl x509 -req -in intermediate.csr -out intermediateCert.pem -CA rootCert.pem -CAkey rootKey.pem -days 365 -sha256 -CAcreateserial -extfile <(echo "basicConstraints=CA:TRUE,pathlen:0")
```
{: .copy-code}

<details>
<summary>
示例输出
</summary>
{% highlight text %}
Signature ok
subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = group.company.com
Getting CA Private Key
{% endhighlight %}
</details>
<br>

**步骤 2.3** 生成 device 证书 

生成 device 密钥和证书请求，使用以下命令。提示时请填写正确的 CN：

```bash
openssl req -new -newkey rsa:4096 -keyout deviceKey.pem -out device.csr -sha256 -nodes
```
{: .copy-code}

<details>
<summary>
示例输出，CN 为 <i>device123.group.company.com</i>
</summary>
{% highlight text %}
Generating a RSA private key
writing new private key to 'deviceKey.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:device.group.company.com
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
{% endhighlight %}
</details>
<br>

生成 device 证书，使用以下命令：

```bash
openssl x509 -req -in device.csr -out deviceCert.pem -CA intermediateCert.pem -CAkey intermediateKey.pem -days 365 -sha256 -CAcreateserial
```
{: .copy-code}

<details>
<summary>
示例输出
</summary>
{% highlight text %}
Signature ok
subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = device.group.company.com
Getting CA Private Key
{% endhighlight %}
</details>
<br>

最后，需将证书自 device 证书至 root 依次拼接为链：

```bash
cat deviceCert.pem intermediateCert.pem rootCert.pem > chain.pem
```
{: .copy-code}

命令将输出各级链的私钥和证书。后续步骤将使用 device 私钥文件 *deviceKey.pem* 和证书链 *chain.pem*。

#### 步骤 3. 在 MQTT Client Credentials 中配置 Intermediate 公钥

进入 **TBMQ Web UI -> Authentication -> Credentials -> Create new or update exising one**。
选择 **X.509 Certificate Chain** 类型，粘贴 *intermediateCert.pem* 的 CN。

#### 步骤 4. 信任证书

MQTT 客户端建立安全 TLS 连接前，签发其证书的 CA (Certificate Authority) 必须被信任。
若证书由知名公共 CA 签发，默认已受信任。
若 TBMQ 与 clients 均使用同一 CA 签发的证书，无需额外配置。
若为其他私有或内部 CA，需将 CA 证书 (`rootCert.pem`) 添加到 TBMQ 使用的 Java truststore。

执行[以下命令](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/#adding-certificate-into-java-truststore)将 CA 证书导入 truststore。

#### 步骤 5. 测试连接

执行以下命令，通过安全通道向 TBMQ 上报温度数据：

```bash
mosquitto_pub --cafile ca.pem -d -q 1 -h "YOUR_TBMQ_HOST" -p "8883" \
-t "sensors/temperature" --key deviceKey.pem --cert chain.pem -m {"temperature":25}
```
{: .copy-code}

[自签名](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/#self-signed-certificates-generation) 服务器证书的类似命令：

```bash
mosquitto_pub --insecure --cafile server.pem -d -q 1 -h "YOUR_TBMQ_HOST" -p "8883" \
-t "sensors/temperature" --key deviceKey.pem --cert chain.pem -m {"temperature":25}
```
{: .copy-code}

请将 **YOUR_TBMQ_HOST** 替换为您的 TBMQ 实例 host。
