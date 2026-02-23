* TOC
{:toc}

基于 Access Token 的认证是 ThingsBoard 默认的设备认证类型。
设备在 ThingsBoard 中创建后，会生成唯一的 access token，后续可修改。
客户端必须在 MQTT 连接消息中，将 access token 作为用户名传递。

#### 明文 MQTT（无 SSL）

下面是一个使用 Access Token *YOUR_ACCESS_TOKEN* 向 {{hostLabel}} 上报温度数据的简单示例。
详见 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用明文 MQTT（无 TLS）：

```bash
mosquitto_pub -d -q 1 -h "{{mqttHostName}}" -p "1883" -t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **{{mqttHostName}}** 作为主机、**1883** 作为端口，需要安装 mosquitto 客户端库，可使用：**apt-get install mosquitto-clients**

#### MQTTS（MQTT over SSL）

单向 SSL 认证为标准模式，客户端通过服务器证书验证服务器身份。
ThingsBoard 团队已为 [{{hostLabel}}](https://{{hostName}}/signup){:target="_blank"} 配置了有效证书。

请使用以下[**链接**](/docs/{{docsPrefix}}user-guide/resources/mqtt-over-ssl/ca-root.pem)下载 CA 根证书，并保存到工作目录为 "**ca-root.pem**"。

```bash
wget https://thingsboard.io/docs/{{docsPrefix}}user-guide/resources/mqtt-over-ssl/ca-root.pem
```
{: .copy-code}

然后可使用 *ca-root.pem* 建立与 {{hostLabel}} 的安全连接，并使用 Access Token *YOUR_ACCESS_TOKEN* 进行设备认证以上报遥测数据：

```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "{{mqttHostName}}" -p "8883" -t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

上述命令使用 **{{mqttHostName}}** 作为主机、**8883** 作为端口，需要安装 mosquitto 客户端库，可使用：**apt-get install mosquitto-clients**
