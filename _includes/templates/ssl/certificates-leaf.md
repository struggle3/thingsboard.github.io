## X.509 证书：

### Step 1. 准备服务器与证书链

{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
ThingsBoard Team 已为 [ThingsBoard Cloud](https://{{hostName}}/signup){:target="_blank"} 配置有效证书。
{% endif %}
{% if docsPrefix == null or docsPrefix == "pe/" %}
若自托管 ThingsBoard，请按 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/){:target="_blank"} 指南配置服务器证书。
{% endif %}

配置完成后，准备 pem 格式的 CA root 证书。MQTT 客户端将使用该证书校验服务器证书。
将 CA root 证书保存到工作目录，命名为 "**ca-root.pem**"。
*{{mqttHostName}}* 的 CA root 证书示例见[此处](/docs/paas/user-guide/resources/mqtt-over-ssl/ca-root.pem)。

### Step 2. 生成 Client 证书

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

### Step 3. 将 Client 公钥配置为 Device Credentials

进入 **ThingsBoard Web UI -> Entities -> Devices -> Your Device -> Manage credentials**。
选择 **X.509 Certificate** 设备凭据，粘贴 *cert.pem* 内容并保存。
也可通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 完成。

### Step 4. 测试连接

执行以下命令，通过安全通道向 ThingsBoard Cloud 上报温度数据：

{% if docsPrefix contains 'paas/' %}
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "{{mqttHostName}}" -p "8883" \
-t "v1/devices/me/telemetry" --key key.pem --cert cert.pem -m {"temperature":25}
```
{: .copy-code}
{% else %}
```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" --key key.pem --cert cert.pem -m {"temperature":25}
```
{: .copy-code}
{% endif %}

请将 **YOUR_TB_HOST** 替换为您的 ThingsBoard 实例 host。
