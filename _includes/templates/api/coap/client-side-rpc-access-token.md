向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的 access token。

请求体和响应体均需为有效 JSON 文档，文档内容取决于处理请求的规则节点。

<br>
**示例**

- 在 {% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}**Edge** {% endif %}**根规则链**中添加两个节点：[transformation script](/docs/user-guide/rule-engine-2-0/nodes/transformation/script){:target="_blank"} 和 [rpc call reply](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply){:target="_blank"}，并用「**Success**」连线将它们连接到「[Log RPC from Device](/docs/user-guide/rule-engine-2-0/nodes/action/log){:target="_blank"}」操作节点。
- 在 **script** 节点中输入函数：

```shell
return {msg: {time: new Date()}, metadata: metadata, msgType: msgType};
```
{: .copy-code}

- Save the [rpc-client-request.json](/docs/reference/resources/rpc-client-request.json){:target="_blank" download="rpc-client-request.json"} file to your PC;
- Now, send request to the server using the command below:

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
cat rpc-client-request.json | coap post coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
cat rpc-client-request.json | coap post coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}
{% endif %}

> ⚠️ 请将 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 替换为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 替换为设备的 access token。

- 将收到服务器响应：

```shell
{"time":"Thursday, February 5, 2026, 9:08:22 AM Coordinated Universal Time"}
```

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.html imageCollection="client-side-rpc" %}
{% endif %}