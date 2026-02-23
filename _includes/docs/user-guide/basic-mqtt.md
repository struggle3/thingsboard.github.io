{% if docsPrefix == null %}
{% assign YOUR_TB_HOST = "* **YOUR_TB_HOST** with the host of your ThingsBoard instance;" %}
{% assign TB_HOST = "10.7.0.223" %}
{% assign PEM_CERTIFICATE = "root-ca.pem" %}
{% endif %}
{% if docsPrefix == "pe/" %}
{% assign YOUR_TB_HOST = "* **YOUR_TB_HOST** with the host of your ThingsBoard instance;" %}
{% assign TB_HOST = "10.7.3.177" %}
{% assign PEM_CERTIFICATE = "root-ca.pem" %}
{% endif %}
{% if docsPrefix contains "paas/" %}
{% assign TB_HOST = "{{mqttHostName}}" %}
{% assign PEM_CERTIFICATE = "tb-cloud-root-ca.pem" %}
{% assign CLOUD = " Cloud" %}
{% endif %} 

* TOC 
{:toc}

使用 MQTT 连接的设备可采用 MQTT 认证。需将设备凭证类型从「Access token」改为「MQTT Basic」。
Basic MQTT 凭证包含可选的 client id、username 和 password。详见 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/)。

下面说明如何修改设备凭证以及客户端如何用这些凭证连接设备。
可选方案包括：

## 仅基于 Client ID 的认证

启用此方式时，只需在设备凭证中填写 client ID。MQTT 客户端在指定正确 client ID 后即可连接。

以下示例命令仅使用 MQTT client ID 向 ThingsBoard{{CLOUD}} 发布 telemetry 读数。
命令使用 plain MQTT，不启用 TLS：

{% if (docsPrefix == "pe/") or (docsPrefix == null) %}
```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" -t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -m {"temperature":25}
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
mosquitto_pub -d -q 1 -h "{{mqttHostName}}" -p "1883" -t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -m {"temperature":25}
```
{: .copy-code}
{% endif %}

其中：

{{YOUR_TB_HOST}}
* **YOUR_CLIENT_ID** 替换为您的 client id。

<br>
ThingsBoard 提供「Check Connectivity」功能，会根据 host 和您提供的设备凭证自动生成命令，您只需复制并执行即可。

以下示例仅使用 MQTT client ID 发布 telemetry。首先，将设备凭证类型从「Access token」改为「MQTT Basic」：

{% include images-gallery.html showListImageTitles="true" imageCollection="client-id-only-1" %}

修改设备凭证后，使用「Check connectivity」功能发布 telemetry：

- 点击「Check connectivity」按钮打开对应窗口；
- 在弹出窗口中选择操作系统；
- 按指南命令安装客户端工具；
- 复制并执行发布 telemetry 的命令；

命令执行成功后，应能看到已发布的 temperature 读数。

{% include images-gallery.html imageCollection="client-id-only-2" %}

## 基于 Username 和 Password 的认证

只需在凭证表单中填写 username 和 password。
MQTT 客户端在指定正确的 username 和 password 后即可连接。

以下示例命令使用 MQTT client username 和 password 向 ThingsBoard{{CLOUD}} 发布 telemetry 读数。命令使用 plain MQTT，不启用 TLS：

{% if (docsPrefix == "pe/") or (docsPrefix == null) %}
```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" -t "v1/devices/me/telemetry" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
mosquitto_pub -d -q 1 -h "{{mqttHostName}}" -p "1883" -t "v1/devices/me/telemetry" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}
{% endif %}

其中：

{{YOUR_TB_HOST}}
* **YOUR_CLIENT_USERNAME**、**YOUR_CLIENT_PASSWORD** 替换为您的 client username 和 password。

<br>
「Check Connectivity」会根据您提供的 host 和设备凭证自动生成命令，您只需复制并执行即可。

以下示例使用 MQTT client username 和 password 发布 telemetry。首先，将设备凭证类型从「Access token」改为「MQTT Basic」：

{% include images-gallery.html showListImageTitles="true" imageCollection="username-and-password-1" %}

修改设备凭证后，使用「Check connectivity」功能发布 telemetry：

- 点击「Check connectivity」按钮打开对应窗口；
- 在弹出窗口中选择操作系统；
- 按指南命令安装客户端工具；
- 复制并执行发布 telemetry 的命令；

命令执行成功后，应能看到已发布的 temperature 读数。

{% include images-gallery.html imageCollection="username-and-password-2" %}

## 基于 Client ID、Username 和 Password 的认证

在此选项中，需填写 Client ID、Username 和 Password。MQTT 客户端在指定正确的 client ID、username 和 password 组合后可连接。

以下示例命令使用 MQTT client ID、username 和 password 向 ThingsBoard{{CLOUD}} 发布 telemetry 读数。命令使用 plain MQTT，不启用 TLS：

{% if (docsPrefix == "pe/") or (docsPrefix == null) %}
```bash
mosquitto_pub -d -q 1 -h "YOUR_TB_HOST" -p "1883" -t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
mosquitto_pub -d -q 1 -h "{{mqttHostName}}" -p "1883" -t "v1/devices/me/telemetry" -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}
{% endif %}

其中：

{{YOUR_TB_HOST}}
* **YOUR_CLIENT_ID** 替换为您的 client id；
* **YOUR_CLIENT_USERNAME**、**YOUR_CLIENT_PASSWORD** 替换为您的 client username 和 password。

<br>
「Check Connectivity」会根据您提供的 host 和设备凭证自动生成命令，您只需复制并执行即可。

以下示例使用 MQTT client ID、username 和 password 发布 telemetry。首先，将设备凭证类型从「Access token」改为「MQTT Basic」：

{% include images-gallery.html showListImageTitles="true" imageCollection="client-id-username-and-password-1" %}

修改设备凭证后，使用「Check connectivity」功能发布 telemetry：

- 点击「Check connectivity」按钮打开对应窗口；
- 在弹出窗口中选择操作系统；
- 按指南命令安装客户端工具；
- 复制并执行发布 telemetry 的命令；

命令执行成功后，应能看到已发布的 temperature 读数。

{% include images-gallery.html imageCollection="client-id-username-and-password-2" %}

## MQTTS（MQTT over TLS）

单向 SSL 认证是标准模式，客户端通过服务器证书验证服务器身份。{% unless (docsPrefix == "pe/") or (docsPrefix == null) %}该证书用于 MQTT 客户端验证服务器证书。{% endunless %}

{% if (docsPrefix == "pe/") or (docsPrefix == null) %}
按 [MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/) 指南为自有 ThingsBoard 实例配置服务器证书。该证书用于 MQTT 客户端验证服务器证书。

配置完成后，使用「Check connectivity」下载 CA 根证书到工作目录并发布 telemetry。首先，将设备凭证类型从「Access token」改为「MQTT Basic」：
{% endif %}
{% if docsPrefix contains "paas/" %}
使用「Check connectivity」下载 CA 根证书并发布 telemetry。首先，将设备凭证类型从「Access token」改为「MQTT Basic」：
{% endif %}

{% include images-gallery.html showListImageTitles="true" imageCollection="mqtts-options-1" %}

- 点击「Check connectivity」按钮。在弹出窗口中选择操作系统，并按指南命令安装客户端工具；
- 切换到「MQTTs」协议。复制并执行第一条命令下载有效 CA 证书；
- 从工作目录（证书保存位置）复制并执行第二条命令发布 telemetry。该命令使用 *{{PEM_CERTIFICATE}}* 证书与 ThingsBoard{{CLOUD}} 建立安全连接，并使用您为设备配置的凭证进行认证。

命令执行成功后，应能看到已发布的 temperature 读数。

{% include images-gallery.html imageCollection="mqtts-options-2" %}

<br>
以下为使用 *{{PEM_CERTIFICATE}}* 证书、{% unless docsPrefix contains 'paas/' %}ThingsBoard 实例 host (YOUR_TB_HOST)、{% endunless %}client id (YOUR_CLIENT_ID) 以及所选设备的 client username 和 password (YOUR_CLIENT_USERNAME / YOUR_CLIENT_PASSWORD) 发布 telemetry 的示例命令：

{% if (docsPrefix == "pe/") or (docsPrefix == null) %}
```bash
mosquitto_pub -d -q 1 --cafile {{PEM_CERTIFICATE}} -h YOUR_TB_HOST -p 8883 -t v1/devices/me/telemetry -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
mosquitto_pub -d -q 1 --cafile {{PEM_CERTIFICATE}} -h {{mqttHostName}} -p 8883 -t v1/devices/me/telemetry -i "YOUR_CLIENT_ID" -u "YOUR_CLIENT_USERNAME" -P "YOUR_CLIENT_PASSWORD" -m {"temperature":25}
```
{: .copy-code}
{% endif %}