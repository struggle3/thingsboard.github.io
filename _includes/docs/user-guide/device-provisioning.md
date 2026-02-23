* TOC
{:toc}

## 使用场景

作为设备制造商或固件开发者，我希望设备能在 ThingsBoard 中自动完成配置。
在自动配置过程中，设备可以自行生成唯一凭证，也可以请求服务器为其生成唯一凭证。

自 3.5 版本起，ThingsBoard 支持通过 [X.509 证书链](/docs/{{docsPrefix}}user-guide/certificates/) 在 MQTT 上进行认证以完成新设备的自动配置。
   
## 工作原理

<object width="80%" data="/images/user-guide/device-provisioning/flow.svg"></object>

设备可以向 ThingsBoard 发送设备配置请求（Request）。请求必须包含 Provision key 和 secret。
请求可选择性包含设备名称及设备生成的凭证。
若未提供凭证，服务器将为设备生成 Access Token。

配置请求示例：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "YOUR_PROVISION_KEY_HERE",
  "provisionDeviceSecret": "YOUR_PROVISION_SECRET_HERE"
}
```
{: .copy-code}

ThingsBoard 会验证请求并返回设备配置响应（Response）。
成功响应包含设备 ID、凭证类型和正文。
若验证失败，响应仅包含状态。

配置响应示例：

```json
{
  "provisionDeviceStatus":"SUCCESS",
  "credentialsType":"ACCESS_TOKEN",
  "accessToken":"sLzc0gDAZPkGMzFVTyUY"
}
```
{: .copy-code}

验证请求时，ThingsBoard 会先根据 *provisionDeviceKey* 和 *provisionDeviceSecret* 查找对应的 [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)。
找到配置文件后，平台会根据已配置的 provision 策略验证设备名称。
支持两种 provision 策略：

* **允许创建新设备** - 检查同名设备是否尚未在 ThingsBoard 中注册。
适用于生产时无法预知唯一设备名称列表（如 MAC 地址）且设备固件中可访问该信息的场景。
实现更简单，但安全性低于第二种策略。
* **检查预配置设备** - 检查同名设备是否已在 ThingsBoard 中创建但尚未完成 provision。
适用于仅允许特定设备列表进行 provision 的场景。例如在生产中已收集唯一 ID（如 MAC 地址）列表。
可使用[批量配置](/docs/{{docsPrefix}}user-guide/bulk-provisioning/)将该列表导入 ThingsBoard。之后，列表中的设备可发起 provision 请求，其他设备无法完成配置。

配置完成后，ThingsBoard 将更新设备的 *provisionState* 服务端属性，并将其设为 *provisioned*。

## 设备配置文件配置

需在设备配置文件中启用 provisioning 功能，并获取 provision device key 和 provision device secret。

{% include images-gallery.html imageCollection="deviceProfileConfiguration" showListImageTitles="true" %}

## Provision 设备 API

### MQTT 设备 API

可使用 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/#device-provisioning) 参考开发执行 provision 请求的设备固件。
如前所述，设备可请求服务器生成凭证，或在注册时提供自身凭证。
各选项的请求/响应及代码示例见下：

{% capture mqttcredentialstogglespec %}
ThingsBoard 服务器生成凭证%,%without%,%templates/provisioning/mqtt-without-credentials-type.md%br%
设备提供<br>Access Token%,%access-token%,%templates/provisioning/mqtt-access-token-credentials-type.md%br%
设备提供<br>Basic MQTT 凭证%,%mqtt-basic%,%templates/provisioning/mqtt-basic-credentials-type.md%br%
设备提供<br>X.509 证书%,%x509-certificate%,%templates/provisioning/x509-certificate-credentials-type.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="mqttprovisioning" toggle-spec=mqttcredentialstogglespec %}

### HTTP 设备 API

可使用 [HTTP API](/docs/{{docsPrefix}}reference/http-api/#device-provisioning) 参考开发执行 provision 请求的设备固件。
如前所述，设备可请求服务器生成凭证或在注册时提供自身凭证。
各选项的请求/响应及代码示例见下：

{% capture httpcredentialstogglespec %}
ThingsBoard 服务器生成凭证%,%without%,%templates/provisioning/http-without-credentials-type.md%br%
设备提供<br>Access Token%,%access-token%,%templates/provisioning/http-access-token-credentials-type.md%br%{% endcapture %}
{% include content-toggle.liquid content-toggle-id="httpprovisioning" toggle-spec=httpcredentialstogglespec %}

### CoAP 设备 API 

可使用 [CoAP API](/docs/{{docsPrefix}}reference/coap-api/#device-provisioning) 参考开发执行 provision 请求的设备固件。   
如前所述，设备可请求服务器生成凭证或在注册时提供自身凭证。
各选项的请求/响应及代码示例见下：

{% capture coapcredentialstogglespec %}
ThingsBoard 服务器生成凭证%,%without%,%templates/provisioning/coap-without-credentials-type.md%br%
设备提供<br>Access Token%,%access-token%,%templates/provisioning/coap-access-token-credentials-type.md%br%{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapprovisioning" toggle-spec=coapcredentialstogglespec %}

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
