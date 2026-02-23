向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% else %}

```shell
coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% endif %}

> ⚠️ 请勿忘记将 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 替换为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 替换为设备的 access token。

使用 [new-attributes-values.json](/docs/reference/resources/new-attributes-values.json){:target="_blank" download="new-attributes-values.json"} 文件中的数据发布客户端属性更新。

**「new-attributes-values.json」** 文件内容：

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
cat new-attributes-values.json | coap post coap://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% else %}

```shell
cat new-attributes-values.json | coap post coap://{{coapHostName}}/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% endif %}