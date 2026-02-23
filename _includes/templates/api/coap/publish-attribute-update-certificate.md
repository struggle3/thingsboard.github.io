向以下 URL 发送 POST 请求：

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

Publish client-side attributes update using data from [new-attributes-values.json](/docs/reference/resources/new-attributes-values.json){:target="_blank" download="new-attributes-values.json"} file.

The content of the **"new-attributes-values.json"** file:

```json
{
  "attribute1": "value1",
  "attribute2": true,
  "attribute3": 42.0,
  "attribute4": 73,
  "attribute5": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
  }
}
```

**执行命令：**

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
cat new-attributes-values.json | coap post coap://{{HOST_NAME}}/api/v1/attributes
```
{: .copy-code}

{% else %}

```shell
cat new-attributes-values.json | coap post coap://{{coapHostName}}/api/v1/attributes
```
{: .copy-code}

{% endif %}