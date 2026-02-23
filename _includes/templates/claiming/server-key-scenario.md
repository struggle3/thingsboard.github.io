{% assign peDocsPrefix = '' %}
{% if docsPrefix contains 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

假设你通过 ThingsBoard [集成](/docs/{{peDocsPrefix}}user-guide/integrations/)连接了大量 NB IoT/LoRaWAN/Sigfox 设备。
集成层会在 ThingsBoard 中自动完成预配置。
若租户管理员知道 DevEUI（LoRaWAN）或其他设备标识符列表，可为每台设备生成随机 Secret Key，并通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 或 UI 将其作为服务端属性上传至 ThingsBoard。
完成后，租户管理员可将这些密钥通过邮件发送给客户，或放入设备包装盒内。

![image](/images/user-guide/claiming-devices/server-side-key-diagram.png)

要预配置设备 Secret Key，租户管理员需将服务端属性「claimingData」设为如下值：

```json
{"secretKey": "YOUR_SECRET_KEY", "expirationTime": 1640995200000}
``` 

其中 expirationTime 为设备可被认领的截止时间，以毫秒级 Unix 时间戳表示（如 1640995200000 对应 2022 年 1 月 1 日）。

服务端属性配置完成后，客户用户可使用 [认领设备](/docs/{{docsPrefix}}user-guide/claiming-devices/#device-claiming-widget) 部件。  
