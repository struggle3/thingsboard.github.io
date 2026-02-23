
#### 步骤 1. 准备服务器与 Client 证书

若自托管 TBMQ，请按 [MQTT over SSL](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/) 指南配置服务器证书。

配置完成后，准备 pem 格式的 CA root 证书。MQTT 客户端将使用该证书校验服务器证书。
将 CA root 证书保存到工作目录，命名为 "**ca.pem**"。

#### 步骤 2. 生成 Client 证书

使用以下命令生成自签名私钥和 x509 证书。
命令基于 **openssl** 工具，工作机通常已安装：

生成 RSA 密钥和证书：

```bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365 -nodes
```
{: .copy-code}

生成 EC 密钥和证书：

```bash
openssl ecparam -out key.pem -name prime256v1 -genkey
openssl req -new -key key.pem -x509 -nodes -days 365 -out cert.pem 
```
{: .copy-code}

命令输出为私钥文件 *key.pem* 和公钥证书 *cert.pem*。
后续步骤将使用这两个文件。

#### 步骤 3. 在 MQTT Client Credentials 中配置 Client 公钥

进入 **TBMQ Web UI -> Authentication -> Credentials -> Create new or update exising one**。
选择 **X.509 Certificate Chain** 类型，粘贴 *cert.pem* 的 CN。

#### 步骤 4. 信任证书

MQTT 客户端建立安全 TLS 连接前，其证书必须被信任。
若证书由知名公共 CA 签发，默认已受信任。
若为自签名证书，需将 client 证书 (`cert.pem`) 导入 TBMQ 使用的 Java truststore。

执行[以下命令](/docs/{{docsPrefix}}mqtt-broker/security/mqtts/#adding-certificate-into-java-truststore)将证书导入 truststore。

#### 步骤 5. 测试连接

执行以下命令，通过安全通道向 TBMQ 上报温度数据：

```bash
mosquitto_pub --cafile ca.pem -d -q 1 -h "YOUR_TBMQ_HOST" -p "8883" \
-t "sensors/temperature" --key key.pem --cert cert.pem -m {"temperature":25}
```
{: .copy-code}

请将 **YOUR_TBMQ_HOST** 替换为您的 TBMQ 实例 host。
