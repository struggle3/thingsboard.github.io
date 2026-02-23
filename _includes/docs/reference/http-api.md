{% if docsPrefix == nil or docsPrefix == "pe/" %}
{% assign HOST_NAME = "$THINGSBOARD_HOST_NAME" %}
{% endif %}
{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
{% assign HOST_NAME = "$THINGSBOARD_EDGE_HOST_NAME" %}
{% endif %}

* TOC
{:toc}

[HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) 是一种通用网络协议，可用于物联网应用。
更多信息请参见[此处](https://www.w3.org/Protocols/rfc2616/rfc2616.txt)。
HTTP 协议基于 TCP，采用请求-响应模型。

ThingsBoard 服务节点充当 HTTP 服务器，支持 HTTP 与 HTTPS 协议。

<hr>

## 客户端库配置

不同平台和语言均有多种 HTTP 客户端库可供使用。
本文示例基于 [curl](https://en.wikipedia.org/wiki/CURL){:target="_blank"}。

**Linux 安装 curl**
```bash
sudo apt-get install curl
```
{: .copy-code}

> 从 Windows 10 build 17063 与 macOS 10.2 6C115 (Jaguar) 起，cURL 默认可用。

<hr>

## HTTP 认证方式

ThingsBoard 支持基于 [access token](/docs/user-guide/ssl/http-access-token/){:target="_blank"} 的认证以保护 HTTP 连接。每次 HTTP 请求时，客户端须在请求 URL 中包含 access token。

> 本指南示例采用**基于 access token 的认证**。

**错误码及原因：**
- **400 Bad Request** - URL、请求参数或请求体无效
- **401 Unauthorized** - **access token** 无效
- **404 Not Found** - 请求的资源不存在

<hr>

{% include templates/api/key-value-format.md %}

也可使用自定义二进制格式或序列化框架，详见 [协议自定义](#protocol-customization){:target="_blank"}。

<hr>

## 遥测上传 API

向 ThingsBoard 服务节点发布遥测数据时，向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

{% endif %}

> ⚠️ 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

支持的最简数据格式为：

```json
{"key1":"value1", "key2":"value2"}
```

or

```json
[{"key1":"value1"}, {"key2":"value2"}]
```

此时，上传的数据将使用服务端时间戳！

若设备能获取客户端时间戳，可采用以下格式：

```json
{"ts":1451649600512, "values":{"key1":"value1", "key2":"value2"}}
```

其中 **1451649600512** 为毫秒精度的 [Unix 时间戳](https://en.wikipedia.org/wiki/Unix_time){:target="_blank"}。
例如，'1451649600512' 对应 'Fri, 01 Jan 2016 12:00:00.512 GMT'。

<br>
以下是发布不同类型遥测数据的命令示例。

> ⚠️ 请勿忘记替换：{% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址；   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的 access token。

**示例 1**。   
以对象形式发布无时间戳数据（将使用服务端时间戳）。

执行命令：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X POST --data "{"temperature":42,"humidity":73}" http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X POST --data "{"temperature":42,"humidity":73}" {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}

遥测数据：

```json
{"temperature":42,"humidity":73}
```

**示例 2**。   
使用 [telemetry-data-as-object.json](/docs/reference/resources/telemetry-data-as-object.json){:target="_blank" download="telemetry-data-as-object.json"} 文件中的数据，以对象形式发布无时间戳数据（将使用服务端时间戳）。

执行命令：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
curl -v -X POST -d @telemetry-data-as-object.json http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X POST -d @telemetry-data-as-object.json {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}


JSON 文件内容：

```json
{
  "stringKey": "value1",
  "booleanKey": true,
  "doubleKey": 42.0,
  "longKey": 73,
  "jsonKey": {
    "someNumber": 42,
    "someArray": [1,2,3],
    "someNestedObject": {"key": "value"}
  }
}
```

**示例 3**。   
使用 [telemetry-data-as-array.json](/docs/reference/resources/telemetry-data-as-array.json){:target="_blank" download="telemetry-data-as-array.json"} 文件中的数据，以对象数组形式发布无时间戳数据（将使用服务端时间戳）。

执行命令：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X POST -d @telemetry-data-as-array.json http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X POST -d @telemetry-data-as-array.json {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}

JSON 文件内容：

```json
[{"key1":"value1"}, {"key2":true}]
```

**示例 4**。使用 [telemetry-data-with-ts.json](/docs/reference/resources/telemetry-data-with-ts.json){:target="_blank" download="telemetry-data-with-ts.json"} 文件中的数据，以带时间戳的对象形式发布数据（将使用遥测时间戳）。

执行命令：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X POST -d @telemetry-data-with-ts.json http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X POST -d @telemetry-data-with-ts.json {{httpsUrl}}/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}

JSON 文件内容：

```json
{
  "ts": 1451649600512,
  "values": {
    "stringKey": "value1",
    "booleanKey": true,
    "doubleKey": 42.0,
    "longKey": 73,
    "jsonKey": {
      "someNumber": 42,
      "someArray": [1, 2, 3],
      "someNestedObject": {
        "key": "value"
      }
    }
  }
}
```

<hr>

## 属性 API

ThingsBoard 属性 API 允许设备：

* 向服务器上传 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"} 设备属性。
* 向服务器请求 [客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"} 与 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"} 设备属性。
* 订阅服务器上的 [共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"} 设备属性。

<hr>

### 向服务器发布属性更新

向 ThingsBoard 服务节点发布客户端设备属性时，向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址；   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的 access token。
<br>

以下是发布不同类型属性数据的命令示例。

**示例 1**。   
发布客户端属性更新

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X POST --data "{"attribute1": "value1", "attribute2":true, "attribute3": 43.0}" http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes --header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```shell
curl -v -X POST --data "{"attribute1": "value1", "attribute2":true, "attribute3": 43.0}" {{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes --header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}

**示例 2**。   
使用 [new-attributes-values.json](/docs/reference/resources/new-attributes-values.json){:target="_blank" download="new-attributes-values.json"} 文件发布客户端属性更新。

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
curl -v -X POST -d @new-attributes-values.json http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X POST -d @new-attributes-values.json {{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}

JSON 文件内容：

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
{: .copy-code}

<hr>

### 向服务器请求属性值

向 ThingsBoard 服务节点请求客户端或共享设备属性时，向以下 URL 发送 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

<br>

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X GET http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X GET "{{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
```
{: .copy-code}

{% endif %}

结果：
```shell
{"client":{"attribute1":"value1","attribute2":true}}
```

{% capture difference %}
**注意**
<br>
客户端属性与共享设备属性的 key 相同是不推荐做法！
但仍可对 client、shared 甚至 server-side 属性使用相同 key。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

### 订阅服务器属性更新

订阅共享设备属性变更时，向以下 URL 发送带可选 "timeout" 请求参数的 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes/updates
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes/updates
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

当共享属性被任一服务端组件（REST API 或 Rule Chain）修改后，客户端将收到如下更新： 

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X GET http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/attributes/updates?timeout=20000
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X GET {{httpsUrl}}/api/v1/$ACCESS_TOKEN/attributes/updates?timeout=20000
```
{: .copy-code}

{% endif %}

结果：
```shell
{"client":{"attribute1":"value1","attribute2":true}}
```

<hr>

## JSON value support

{% include templates/api/json.md %}

<hr>

## RPC API

### 服务端 RPC

订阅来自服务器的 RPC 命令时，向以下 URL 发送带可选 "timeout" 请求参数的 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

订阅后，客户端可能收到 RPC 请求；若该设备无待处理请求，则可能收到超时消息。
RPC 请求体示例见下：

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
&#8194;&#8226;&#8194;**id** - 请求 id，整型请求标识符   
&#8194;&#8226;&#8194;**method** - RPC 方法名，字符串   
&#8194;&#8226;&#8194;**params** - RPC 方法参数，自定义 JSON 对象

可通过向以下 URL 发送 POST 请求回复：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc/{$id}
```
{: .copy-code}

{% endif %}

> 其中 <code>$id</code> 为整型请求标识符。

<br>
**示例说明**：

- 在 ThingsBoard 实例中使用 **RPC 调试终端**部件；
- 使用下方命令订阅来自服务器的 RPC 命令：在第一个终端窗口发送带 observe 标志的 GET 请求。

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
curl -v -X GET http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc?timeout=20000
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -v -X GET {{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc?timeout=20000
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

- 使用 **RPC 调试终端**部件向设备发送 RPC 请求 "connect"；
- 将 [rpc-response.json](/docs/reference/resources/rpc-response.json){:target="_blank" download="rpc-response.json"} 保存到你的 PC；
- 在第二个终端窗口模拟设备向服务器发送响应：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
curl -v -X POST -d @rpc-response.json http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc/1 --header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```shell
curl -v -X POST -d @rpc-response.json {{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc/1 --header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}

应收到来自设备的响应：

```shell
{"result":"ok"}
```

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.html imageCollection="server-side-rpc" %}
{% endif %}

<hr>

### 客户端 RPC

向服务器发送 RPC 命令时，向以下 URL 发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

请求体与响应体须为合法 JSON。内容由处理该请求的 Rule Node 决定。

<br>

**示例**
- 在 {% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}**Edge** {% endif %}**Root Rule Chain** 中添加两个节点：[transformation script](/docs/user-guide/rule-engine-2-0/nodes/transformation/script){:target="_blank"} 和 [rpc call reply](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply){:target="_blank"}，并用 "**Success**" 链接连接到 "[Log RPC from Device](/docs/user-guide/rule-engine-2-0/nodes/action/log){:target="_blank"}"  action 节点。
- 在 **script** 节点中输入函数：

```shell
return {msg: {time: new Date()}, metadata: metadata, msgType: msgType};
```
{: .copy-code}

- 将 [rpc-client-request.json](/docs/reference/resources/rpc-client-request.json){:target="_blank" download="rpc-client-request.json"} 保存到你的 PC；
- 使用下方命令向服务器发送请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
curl -X POST -d @rpc-client-request.json http://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/rpc --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
curl -X POST -d @rpc-client-request.json {{httpsUrl}}/api/v1/$ACCESS_TOKEN/rpc --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}

应收到来自服务器的响应：

```shell
{"time":"Thursday, February 5, 2026, 9:08:22 AM Coordinated Universal Time"}
```

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.html imageCollection="client-side-rpc" %}
{% endif %}

<hr>

## 设备认领

设备认领功能允许终端用户在设备部署并连接至 ThingsBoard 后，安全地将设备与自身账号关联。
设备认领流程及支持场景详见 {% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}[设备认领](/docs/{{docsPrefix}}user-guide/claiming-devices){:target="_blank"}{% endif %}{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}[设备认领](/docs/user-guide/claiming-devices){:target="_blank"}{% endif %} 文档。

**认领请求**   
发起设备认领时，设备须向以下端点发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/claim
```
{: .copy-code}

{% endif %}

> 其中 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为设备的access token。

**请求体**   
请求体须包含如下 JSON 结构：

```json
{"secretKey":"value", "durationMs":60000}
```

**字段说明**
- **secretKey** — 用于授权认领流程的密钥
- **durationMs** — 设备可被认领的时间窗口（毫秒）

{% capture difference %}
**注意**：以上字段可选。若未指定 **secretKey**，则默认使用空字符串。
若未指定 **durationMs**，则使用系统参数 **device.claim.duration**（位于 **/etc/thingsboard/conf/thingsboard.yml** 文件）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## 设备 Provisioning

设备 Provisioning 支持在无需于 ThingsBoard UI 中手动创建的前提下动态注册设备。
Provisioning 流程及支持场景详见 {% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}[设备 Provisioning](/docs/{{docsPrefix}}user-guide/device-provisioning){:target="_blank"}{% endif %}{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}[设备 Provisioning](/docs/user-guide/device-provisioning){:target="_blank"}{% endif %} 文档。

**Provisioning 请求**
发起设备 Provisioning 时，向以下端点发送 POST 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
http(s)://{{HOST_NAME}}/api/v1/provision
```
{: .copy-code}

其中 **{{HOST_NAME}}** 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/provision
```
{: .copy-code}

{% endif %}

**请求体**   
Provisioning 请求须使用如下 JSON 格式：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "u7piawkboq8v32dmcmpp",
  "provisionDeviceSecret": "jpmwdn8ptlswmf4m29bw"
}
```

**字段说明**   
- **deviceName** — 待 Provision 的设备名称。
- **provisionDeviceKey** — 在 ThingsBoard 中配置的 Provisioning key。
- **provisionDeviceSecret** — 与该 Provisioning key 关联的 Provisioning secret。

若凭据有效，ThingsBoard 将自动创建设备（若尚不存在）并返回设备凭据，使设备可与平台通信。

<hr>

## 固件 API

ThingsBoard 通过 HTTP 发起固件更新时，会设置共享属性 _fw_title_、_fw_version_、_fw_checksum_、_fw_checksum_algorithm_。

设备要获取固件更新信息并下载固件，须向以下端点发送 GET 请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}

```shell
http(s)://{{HOST_NAME}}/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
{{httpsUrl}}/api/v1/$ACCESS_TOKEN/firmware?title=$TITLE&version=$VERSION
```
{: .copy-code}

{% endif %}

参数   
{% unless docsPrefix contains "paas/" %}&#8194;&#8226;&#8194;**{{HOST_NAME}}** 为你的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址{% endunless %}   
&#8194;&#8226;&#8194;**$ACCESS_TOKEN** 为设备的 access token   
&#8194;&#8226;&#8194;**$TITLE** - 固件标题   
&#8194;&#8226;&#8194;**$VERSION** - 目标固件版本

<hr>

## 协议自定义

可通过修改对应 [模块](https://github.com/thingsboard/thingsboard/tree/master/transport/http){:target="_blank"} 针对特定场景对 HTTP 传输进行全面自定义。

<hr>

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}