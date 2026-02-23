
此流程要求设备基于触发事件生成 Secret Key。 
例如，设备启动时或按下某物理按钮时。 
Secret Key 生成后，在一定时间内有效。 
设备将认领信息（Claiming Information）发送至服务器，其中包含 Secret Key 及密钥有效期。

{% capture cache-living-time %}
默认可将过期时间设为接收请求的日期时间加上 1 天作为最大值。  
若要延长，应在 thingsboard.yaml 中增加 **caffeine.specs.claimDevices.timeToLiveInMinutes** 参数值。{% endcapture %}
{% include templates/info-banner.md content=cache-living-time %}

ThingsBoard 服务器在密钥有效期内保存认领信息。见下图。

![image](/images/user-guide/claiming-devices/device-side-key-diagram.png)

设备可通过所有支持的传输协议向 TB 发送认领信息。消息体有两个可选参数：**secretKey** 和 **durationMs**。 
**secretKey** 参数为 claiming 流程增加安全性。
**durationMs** 参数决定 claiming 过期时间。
若未指定 **secretKey**，默认使用空字符串。
若未指定 **durationMs**，使用系统参数 **device.claim.duration**（位于 **/etc/thingsboard/conf/thingsboard.yml**）。

{% unless docsPrefix contains "paas/" %}
要启用 claiming devices 功能，需将系统参数 **security.claim.allowClaimingByDefault** 设为 **true**（参见 [配置指南](/docs/user-guide/install/{{docsPrefix}}config/)）， 
否则已配置设备必须在服务端设置 **claimingAllowed** 属性为 **true**。
{% endunless %}

请参阅 Device API 参考以了解消息结构与发送 claiming 消息的 topics/URLs。
也可使用 MQTT Gateway API 一次发起多设备 claiming。

 - [MQTT Device API](/docs/{{docsPrefix}}reference/mqtt-api/#claiming-devices)
 - [CoAP Device API](/docs/{{docsPrefix}}reference/coap-api/#claiming-devices)
 - [HTTP Device API](/docs/{{docsPrefix}}reference/http-api/#claiming-devices)
 - [MQTT Gateway API](/docs/{{docsPrefix}}reference/gateway-mqtt-api/#claiming-devices-api)
 

认领信息发送后，设备可以明文或 QR 码显示 Secret Key。用户扫描该密钥并用于发送认领请求。
认领请求包含设备名称与 Secret Key。可使用 MAC 地址或其他唯一属性作为设备名称。 
发送认领请求的说明请见[此处](/docs/{{docsPrefix}}user-guide/claiming-devices/#device-claiming-api-request)。   

**注意：** Secret Key 也可为空字符串。若设备无法显示 Secret Key 时可用此方式。 
例如，可在设备上按下 claim 按钮后 30 秒内允许认领。此情况下用户只需知道设备名称（MAC 地址等）即可。

服务器验证认领请求并返回认领响应。认领响应包含认领操作状态，成功时包含 Device ID。

认领信息配置完成后，客户用户可使用 [认领设备](/docs/{{docsPrefix}}user-guide/claiming-devices/#device-claiming-widget) 部件。   