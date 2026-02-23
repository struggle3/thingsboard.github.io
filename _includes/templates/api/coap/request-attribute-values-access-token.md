向以下 URL 发送 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

{% else %}

```shell
coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

{% endif %}

> ⚠️ 请勿忘记将 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 替换为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 替换为设备的 access token。

{% capture difference %}
**注意：** 此示例使用 coap-client 而非 CoAP cli，因 CoAP cli 不支持查询参数。请参阅 [客户端库配置](#docsContent)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**执行命令：**

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap-client -m get "coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
```
{: .copy-code}

{% else %}

```shell
coap-client -m get "coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
```
{: .copy-code}

{% endif %}