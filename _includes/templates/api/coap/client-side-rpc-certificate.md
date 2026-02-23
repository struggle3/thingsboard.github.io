向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
coap://{{HOST_NAME}}/api/v1/rpc
```
{: .copy-code}

> ⚠️ 其中 <code>{{HOST_NAME}}</code> 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
coap://{{coapHostName}}/api/v1/rpc
```
{: .copy-code}

{% endif %}

请求体和响应体均需为有效 JSON 文档，文档内容取决于处理请求的规则节点。

<br>
**示例**

- 在 {% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}**Edge** {% endif %}**根规则链**中添加两个节点：[transformation script](/docs/user-guide/rule-engine-2-0/nodes/transformation/script){:target="_blank"} 和 [rpc call reply](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply){:target="_blank"}，并用「**Success**」连线将它们连接到「[Log RPC from Device](/docs/user-guide/rule-engine-2-0/nodes/action/log){:target="_blank"}」操作节点。
- 在 **script** 节点中输入函数：

```shell
return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};
```
{: .copy-code}

- 将 [rpc-client-request.json](/docs/reference/resources/rpc-client-request.json){:target="_blank" download="rpc-client-request.json"} 文件保存到本机；
- 使用以下命令向服务器发送请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
cat rpc-client-request.json | coap post coap://{{HOST_NAME}}/api/v1/rpc
```
{: .copy-code}

> ⚠️ 请将 <code>{{HOST_NAME}}</code> 替换为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
cat rpc-client-request.json | coap post coap://{{coapHostName}}/api/v1/rpc
```
{: .copy-code}

{% endif %}

- 将收到服务器响应：

```shell
{"time":"2016 11 21 12:54:44.287"}
```

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.html imageCollection="client-side-rpc-certificate" %}
{% endif %}