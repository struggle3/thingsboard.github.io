* TOC
{:toc}
  
基于 Access Token 的认证是默认的设备认证类型。
唯一 Access Token 在设备于 ThingsBoard 中创建时生成，之后可修改。
客户端必须在 MQTT connect 消息中将 access token 作为 username 传递。

## Plain MQTT（无 SSL）

以下示例命令使用 Access Token *YOUR_ACCESS_TOKEN* 向 ThingsBoard Cloud 上传温度读数。
更多详情见 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。该命令使用 plain MQTT，不启用 TLS：

```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" \ 
-t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

以上命令需安装 mosquitto clients 库，可使用：**apt-get install mosquitto-clients**。
请将 **YOUR_TB_HOST** 替换为 ThingsBoard 实例的 host，**YOUR_ACCESS_TOKEN** 替换为设备的 access token。

## MQTTS（MQTT over SSL）

单向 SSL 认证是标准认证模式，客户端通过服务器证书验证服务器身份。

{% unless docsPrefix contains "paas/" %}
若自行托管 ThingsBoard 实例，请按 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/) 指南配置服务器证书。
{% endunless %}

配置完成后，需准备 PEM 格式的 CA 根证书，供 MQTT 客户端验证服务器证书。
将 CA 根证书保存到工作目录，命名为「**ca-root.pem**」。
*{{mqttHostName}}* 的 CA 根证书示例见 [此处](/docs/paas/user-guide/resources/mqtt-over-ssl/ca-root.pem)。

可使用 *ca-root.pem* 建立与 ThingsBoard 实例 (*YOUR_TB_HOST*) 的安全连接，并用 Access Token (*YOUR_ACCESS_TOKEN*) 认证设备以上传 telemetry：

```bash
mosquitto_pub --cafile ca-root.pem -d -q 1 -h "YOUR_TB_HOST" -p "8883" \
-t "v1/devices/me/telemetry" -u "YOUR_ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

以上命令需安装 mosquitto clients 库，可使用：**apt-get install mosquitto-clients**。
请将 **YOUR_TB_HOST** 替换为 ThingsBoard 实例的 host，**YOUR_ACCESS_TOKEN** 替换为设备的 access token。

