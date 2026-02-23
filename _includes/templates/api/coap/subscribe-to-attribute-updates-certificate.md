向以下 URL 发送带 Observe 选项的 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap://{{HOST_NAME}}/api/v1/attributes
```
{: .copy-code}

> ⚠️ 请勿忘记将 <code>{{HOST_NAME}}</code> 替换为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。

{% else %}

```shell
coap://{{coapHostName}}/api/v1/attributes
```
{: .copy-code}

{% endif %}

当共享属性被任一服务端组件（REST API 或规则链）修改后，客户端将收到如下更新：

**执行命令：**

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap get -o coap://{{HOST_NAME}}/api/v1/attributes
```
{: .copy-code}

{% else %}

```shell
coap get -o coap://{{coapHostName}}/api/v1/attributes
```
{: .copy-code}

{% endif %}