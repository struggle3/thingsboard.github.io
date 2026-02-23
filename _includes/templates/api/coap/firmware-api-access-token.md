CoAP 客户端需向以下地址发起 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap get coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

其中
- **$THINGSBOARD_HOST_NAME**：localhost 或平台地址
- **$ACCESS_TOKEN**：设备 access token
- **$TITLE**：固件标题
- **$VERSION**：目标固件版本

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/"%}
```shell
coap get coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

其中
- **$ACCESS_TOKEN**：设备 access token
- **$TITLE**：固件标题
- **$VERSION**：目标固件版本

{% endif %}