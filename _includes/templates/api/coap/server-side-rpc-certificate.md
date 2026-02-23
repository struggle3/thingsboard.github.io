向以下 URL 发送带 observe 标志的 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap://{{HOST_NAME}}/api/v1/rpc
```
{: .copy-code}

> ⚠️ 其中 <code>{{HOST_NAME}}</code> 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/"%}

```shell
coap://{{coapHostName}}/api/v1/rpc
```
{: .copy-code}

{% endif %}

订阅后，客户端将接收 RPC 请求。RPC 请求体示例：

```json
{
  "id": "1",
  "method": "setGpio",
  "params": {
    "pin": "23",
    "value": 1
  }
}
```

> 其中   
&#8194;&#8226;&#8194;**id**：请求 id，整数请求标识符   
&#8194;&#8226;&#8194;**method**：RPC 方法名，字符串   
&#8194;&#8226;&#8194;**params**：RPC 方法参数，自定义 json 对象

要回复 RPC 请求，请向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
coap://{{HOST_NAME}}/api/v1/rpc/{$id}
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/"%}

```shell
coap://{{coapHostName}}/api/v1/rpc/{$id}
```
{: .copy-code}

{% endif %}

> Where <code>$id</code> is an integer request identifier.

<br>

**Example**

- Use **RPC debug terminal** widget in your ThingsBoard instance;
- Subscribe to RPC commands from the server using the command below. To do this, in the first terminal window send GET request with observe flag.

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
coap-client -m get coap://{{HOST_NAME}}/api/v1/rpc -s 100 -B 100
```
{: .copy-code}

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/"%}

```shell
coap-client -m get coap://{{coapHostName}}/api/v1/rpc -s 100 -B 100
```
{: .copy-code}
{% endif %}

{% capture difference %}
「`s`」选项表示 subscribe，值需以秒为单位指定。

「`B`」选项表示 break（在指定超时后结束操作），值需以秒为单位指定。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

- 使用 **RPC 调试终端**部件向设备发送「connect」RPC 请求。
- 将 [rpc-response.json](/docs/reference/resources/rpc-response.json){:target="_blank" download="rpc-response.json"} 文件保存到本机。
- 在第二个终端窗口中模拟设备向服务器发送响应：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap-client -f rpc-response.json -m post coap://{{HOST_NAME}}/api/v1/rpc/1
```
{: .copy-code}

> ⚠️ 请将 <code>{{HOST_NAME}}</code> 替换为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。


{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/"%}

```shell
cat rpc-response.json | coap post coap://{{coapHostName}}/api/v1/rpc/1
```
{: .copy-code}
{% endif %}

- 将收到设备响应：

```shell
{"result":"ok"}
```

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.html imageCollection="server-side-rpc-certificate" %}
{% endif %}