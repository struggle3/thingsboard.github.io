{% if docsPrefix == nil or docsPrefix == "pe/" %}
{% assign HOST_NAME = "$THINGSBOARD_HOST_NAME" %}
{% endif %}
{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
{% assign HOST_NAME = "$THINGSBOARD_EDGE_HOST_NAME" %}
{% endif %}

* TOC
{:toc}

[MQTT](https://en.wikipedia.org/wiki/MQTT){:target="_blank"}是一种轻量级发布/订阅消息协议，可能是最适合各类物联网设备的协议。 

ThingsBoard服务节点充当MQTT代理，支持：   
&#8194;**&#8226;**&#8194;QoS 0（最多一次）   
&#8194;**&#8226;**&#8194;QoS 1（至少一次）   
&#8194;**&#8226;**&#8194;通过[设备配置](/docs/{{docsPrefix}}user-guide/device-profiles/#mqtt-device-topic-filters){:target="_blank"}配置MQTT主题

更多MQTT信息请见[mqtt.org](https://mqtt.org/){:target="_blank"}。

<hr>

## 客户端库配置

不同平台和语言有多种MQTT客户端库可用。

本指南示例使用：   
&#8194;**&#8226;**&#8194;**Mosquitto**（命令行工具）   
&#8194;**&#8226;**&#8194;**MQTT.js**（JavaScript）

按以下说明安装命令行工具：   
&#8194;**&#8226;**&#8194;<span class="code-light">mosquitto_pub</span>   
&#8194;**&#8226;**&#8194;<span class="code-light">mosquitto_sub</span>

选择您的操作系统继续安装：

{% capture connectdevicetogglespec %}
MQTT<small>Linux or macOS</small>%,%mqtt-linux%,%templates/helloworld-pe/mqtt-linux.md%br%
MQTT<small>Windows</small>%,%mqtt-windows%,%templates/helloworld-pe/mqtt-windows.md{% endcapture %}
{% include content-toggle.html content-toggle-id="connectdevice" toggle-spec=connectdevicetogglespec %}

<hr>

## 认证方式

ThingsBoard支持多种认证方式以保护MQTT连接。

**支持的方式**：
- [Access token](/docs/{{docsPrefix}}user-guide/access-token/){:target="_blank"}。使用唯一**设备访问令牌**作为<span class="code-light">CONNECT</span>包中的MQTT **username**。   
  此方式无需证书或额外凭据即可简单、安全地认证设备。
- [X.509 certificates](/docs/{{docsPrefix}}user-guide/certificates/){:target="_blank"}。使用数字证书认证设备，基于**公钥基础设施（PKI）**建立安全通信。
- [Basic MQTT credentials](/docs/{{docsPrefix}}user-guide/basic-mqtt/){:target="_blank"}。使用MQTT <span class="code-light">CONNECT</span>包中发送的认证数据——可选的client ID、username和password组合。 

MQTT通信的主题名称和载荷格式通过**设备配置**配置。详见[此处](/docs/user-guide/device-profiles/#mqtt-transport-type){:target="_blank"}。

> 本指南示例采用**基于access token的认证**。

<hr>

## Publish a test telemetry message

使用以下命令发布测试遥测数据。

{% if docsPrefix contains 'paas/' %}

> 请将<code>$ACCESS_TOKEN</code>替换为您的设备访问令牌。

```bash
mosquitto_pub -d -q 1 -h "{{mqttHostName}}" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

**示例**   
若access token为<code>ABC123</code>，命令如下：

```bash
mosquitto_pub -d -q 1 -h "{{mqttHostName}}" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

{% endif %}
{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} 

> ⚠️ **请勿忘记替换：**   
> &#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
> &#8194;&#8226;&#8194;<code>$ACCESS_TOKEN</code> 为您的设备访问令牌。

```bash
mosquitto_pub -d -q 1 -h "{{HOST_NAME}}" -p "1883" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -m {"temperature":25}
```
{: .copy-code}

**示例**   
此例中<code>{{HOST_NAME}}</code>指您的<code>本地</code>ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge {% endif %}安装，<code>$ACCESS_TOKEN</code>设置为<code>ABC123</code>。

```bash
mosquitto_pub -d -q 1 -h "localhost" -p "1883" -t "v1/devices/me/telemetry" -u "ABC123" -m {"temperature":25}
```
{: .copy-code}

{% endif %}

成功的遥测发布会产生类似以下输出：

```text
Client mosqpub|xxx sending CONNECT
Client mosqpub|xxx received CONNACK
Client mosqpub|xxx sending PUBLISH (d0, q1, r0, m1, 'v1/devices/me/telemetry', ... (16 bytes))
Client mosqpub|xxx received PUBACK (Mid: 1)
Client mosqpub|xxx sending DISCONNECT
```

<b><font size="3">可能的MQTT连接响应</font></b>

连接过程中，MQTT代理可能返回以下响应码：

* **0x00 Connected** - 成功连接ThingsBoard MQTT服务器。
* **0x04 Connection Refused, bad username or password** - 用户名为空。
* **0x05 Connection Refused, not authorized** - 用户名包含无效access token。

<hr>

{% include templates/api/key-value-format.md %}

也可通过[Protocol Buffers](https://developers.google.com/protocol-buffers){:target="_blank"}发送数据。
详见设备配置文档中的[MQTT传输类型](/docs/{{docsPrefix}}user-guide/device-profiles/#mqtt-transport-type){:target="_blank"}配置章节。

也可使用自定义二进制格式或序列化框架。详见[协议自定义](#protocol-customization)。

<hr>

## 遥测上传API

向ThingsBoard服务节点发布遥测数据时，向以下主题发送PUBLISH消息：
 
```shell
v1/devices/me/telemetry
```

支持的最简数据格式为：

```json
{"key1":"value1", "key2":"value2"}
```

or

```json
[{"key1":"value1"}, {"key2":"value2"}]
```

{% capture difference %}
**请注意**：在此情况下，将使用服务器端时间戳作为上传数据的时间戳！
{% endcapture %}
{% include templates/info-banner.md content=difference %}

若设备能获取客户端时间戳，可使用以下格式：

```json
{"ts":1451649600512, "values":{"key1":"value1", "key2":"value2"}}
```

其中 **1451649600512** 为毫秒精度的[Unix时间戳](https://en.wikipedia.org/wiki/Unix_time)。例如 '1451649600512' 对应 'Fri, 01 Jan 2016 12:00:00.512 GMT'。

<br><b><font size="3">示例</font></b>   
以下为发布不同类型遥测数据的命令示例。

> ⚠️ 请勿忘记替换 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为您的设备访问令牌。

**示例1**。   
以对象形式发布无时间戳数据（将使用服务器端时间戳）。 

执行命令：

{% capture tabspec %}mqtt-telemetry-upload-api
A,Mosquitto,shell,resources/mosquitto-telemetry.sh,/docs/reference/resources/mosquitto-telemetry.sh
B,MQTT.js,shell,resources/mqtt-js-telemetry.sh,/docs/reference/resources/mqtt-js-telemetry.sh{% endcapture %}
{% include tabs.html %}

遥测数据：

```json
{"temperature":42}
```

**示例2**。   
以对象形式发布无时间戳数据（将使用服务器端时间戳），数据来自[telemetry-data-as-object.json](/docs/reference/resources/telemetry-data-as-object.json){:target="_blank" download="telemetry-data-as-object.json"}文件。

执行命令：

{% capture tabspec %}mqtt-telemetry-upload-api-data-as-object
A,Mosquitto,shell,resources/mosquitto-telemetry-data-as-object.sh,/docs/reference/resources/mosquitto-telemetry-data-as-object.sh
B,MQTT.js,shell,resources/mqtt-js-telemetry-data-as-object.sh,/docs/reference/resources/mqtt-js-telemetry-data-as-object.sh{% endcapture %}
{% include tabs.html %}

JSON文件内容：

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

**示例3**。   
以对象数组形式发布无时间戳数据（将使用服务器端时间戳），数据来自[telemetry-data-as-array.json](/docs/reference/resources/telemetry-data-as-array.json){:target="_blank" download="telemetry-data-as-array.json"}文件。

执行命令：

{% capture tabspec %}mqtt-telemetry-upload-api-data-as-array
A,Mosquitto,shell,resources/mosquitto-telemetry-data-as-array.sh,/docs/reference/resources/mosquitto-telemetry-data-as-array.sh
B,MQTT.js,shell,resources/mqtt-js-telemetry-data-as-array.sh,/docs/reference/resources/mqtt-js-telemetry-data-as-array.sh{% endcapture %}
{% include tabs.html %}

JSON文件内容：

```json
[{"key1":"value1"}, {"key2":true}]
```

**示例4**。   
以带时间戳的对象形式发布数据（将使用遥测时间戳），数据来自[telemetry-data-with-ts.json](/docs/reference/resources/telemetry-data-with-ts.json){:target="_blank" download="telemetry-data-with-ts.json"}文件。

执行命令：

{% capture tabspec %}mqtt-telemetry-upload-api-data-with-ts
A,Mosquitto,shell,resources/mosquitto-telemetry-data-with-ts.sh,/docs/reference/resources/mosquitto-telemetry-data-with-ts.sh
B,MQTT.js,shell,resources/mqtt-js-telemetry-data-with-ts.sh,/docs/reference/resources/mqtt-js-telemetry-data-with-ts.sh{% endcapture %}
{% include tabs.html %}

JSON文件内容：

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

## Attributes API

ThingsBoard属性API允许设备

* 将[客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性上传至服务器。
* 从服务器请求[客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}和[共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性。
* 订阅服务器的[共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性。

<hr>

### 向服务器发布属性更新

为将客户端设备属性发布至ThingsBoard服务节点，向以下主题发送PUBLISH消息：

```shell
v1/devices/me/attributes
```
{: .copy-code}

<b><font size="3">示例</font></b>   
以下为发布客户端设备属性的示例。

> ⚠️ 请勿忘记替换 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为您的设备访问令牌。

**示例1**。   
发布客户端属性更新。

遥测数据：

```json
{"attribute1": "value1", "attribute2": true}
```
{: .copy-code}

执行命令：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
mosquitto_pub -d -h "{{HOST_NAME}}" -t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -m "{"attribute1": "value1", "attribute2": true}"
```
{: .copy-code}
{% else %}
```shell
mosquitto_pub -d -h "{{mqttHostName}}" -t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -m "{"attribute1": "value1", "attribute2": true}"
```
{: .copy-code}
{% endif %}

**示例2**。   
使用[new-attributes-values.json](/docs/reference/resources/new-attributes-values.json){:target="_blank" download="new-attributes-values.json"}文件数据发布客户端属性更新。

**"new-attributes-values.json"** 文件内容：

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

执行命令：

{% capture tabspec %}mqtt-attributes-upload
A,Mosquitto,shell,resources/mosquitto-attributes-publish.sh,/docs/reference/resources/mosquitto-attributes-publish.sh
B,MQTT.js,shell,resources/mqtt-js-attributes-publish.sh,/docs/reference/resources/mqtt-js-attributes-publish.sh{% endcapture %}
{% include tabs.html %}

<hr>

### 从服务器请求属性值

为从ThingsBoard服务节点请求客户端或共享设备属性，向以下主题发送PUBLISH消息：

```shell
v1/devices/me/attributes/request/$request_id
```
{: .copy-code}

其中 **$request_id** 为整数请求标识符。
发送带请求的PUBLISH消息前，客户端需订阅

```shell
v1/devices/me/attributes/response/+
```

<br><b><font size="3">示例</font></b>   
以下示例基于mqtt.js编写。纯命令行示例不可用，因订阅与发布须在同一MQTT会话中进行。

**1.** 将[mqtt-js-attributes-request.js](/docs/{{docsPrefix}}reference/resources/mqtt-js-attributes-request.js){:target="_blank" download="mqtt-js-attributes-request.js"}文件保存到您的电脑。

{% unless docsPrefix contains 'paas/' %}

> ⚠️ 此例中主机名指**本地ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}安装**。   
> 若ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}实例部署在其他主机，请将<code>localhost</code>替换为对应主机名或IP地址。

{% endunless %}

{% capture tabspec %}mqtt-attributes-request
A,"mqtt-js-attributes-request.js"文件内容：,javascript,resources/mqtt-js-attributes-request.js,/docs/reference/resources/mqtt-js-attributes-request.js{% endcapture %}
{% include tabs.html %}

**2.** 执行命令。

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的设备访问令牌。

```shell
export TOKEN=$ACCESS_TOKEN
node mqtt-js-attributes-request.js
```
{: .copy-code}

结果：

```text
{"client":{"attribute1":"value1","attribute2":true}}
```

{% capture difference %}
**请注意**：客户端与共享设备属性键存在交集是不佳实践！ 
但仍可为client、shared甚至server-side属性使用相同键。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

### 订阅来自服务器的属性更新

为订阅共享设备属性变更，向以下主题发送SUBSCRIBE消息：

```shell
v1/devices/me/attributes
```
{: .copy-code}

当共享属性被任一服务端组件（如REST API或规则链）修改时，客户端将收到以下更新： 

```json
{"key1":"value1"}
```

> ⚠️ 请勿忘记替换 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为您的设备访问令牌。

执行命令：

{% capture tabspec %}mqtt-attributes-subscribe
A,Mosquitto,shell,resources/mosquitto-attributes-subscribe.sh,/docs/reference/resources/mosquitto-attributes-subscribe.sh
B,MQTT.js,shell,resources/mqtt-js-attributes-subscribe.sh,/docs/reference/resources/mqtt-js-attributes-subscribe.sh{% endcapture %}
{% include tabs.html %}

<hr>

## JSON值支持

{% include templates/api/json.md %}

<hr>

## RPC API

### Server-side RPC

为订阅来自服务器的RPC命令，向以下主题发送SUBSCRIBE消息：

```shell
v1/devices/me/rpc/request/+
```
{: .copy-code}

订阅后，客户端将在对应主题收到作为PUBLISH消息的单独命令：

```shell
v1/devices/me/rpc/request/$request_id
```

其中 **$request_id** 为整数请求标识符。

客户端应将响应发布至以下主题：

```shell
v1/devices/me/rpc/response/$request_id
```

<br><b><font size="3">示例</font></b>   
以下示例基于mqtt.js编写。纯命令行示例不可用，因订阅与发布须在同一MQTT会话中进行。

{% if docsPrefix == nil or docsPrefix == "pe/" %}
**1.** 将[mqtt-js-rpc-from-server.js](/docs/pe/reference/resources/mqtt-js-rpc-from-server.js){:target="_blank" download="mqtt-js-rpc-from-server.js"}文件保存到您的电脑。

> ⚠️ 此例中主机名指**本地ThingsBoard安装**。   
> 若ThingsBoard实例部署在其他主机，请将<code>localhost</code>替换为对应主机名或IP地址。

{% endif %}
{% if docsPrefix contains "paas/" %}
**1.** 将[mqtt-js-rpc-from-server.js](/docs/paas/reference/resources/mqtt-js-rpc-from-server.js){:target="_blank" download="mqtt-js-rpc-from-server.js"}文件保存到您的电脑。
{% endif %}
{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
**1.** 将[mqtt-js-rpc-from-server.js](/docs/edge/reference/resources/mqtt-js-rpc-from-server.js){:target="_blank" download="mqtt-js-rpc-from-server.js"}文件保存到您的电脑。

> ⚠️ 此例中主机名指**本地ThingsBoard Edge安装**。   
> 若ThingsBoard Edge实例部署在其他主机，请将<code>localhost</code>替换为对应主机名或IP地址。

{% endif %}

{% capture tabspec %}mqtt-rpc-from-server
A,The content of the "mqtt-js-rpc-from-server.js" file,javascript,resources/mqtt-js-rpc-from-server.js,/docs/reference/resources/mqtt-js-rpc-from-server.js{% endcapture %}  
{% include tabs.html %}

**2.** 按以下步骤操作：
- 在ThingsBoard实例中使用**RPC调试终端**部件；
- 使用以下命令执行以订阅来自服务器的RPC命令。 

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的设备访问令牌。

```shell
export TOKEN=$ACCESS_TOKEN
node mqtt-js-rpc-from-server.js
```
{: .copy-code}

- 使用**RPC调试终端**部件向设备发送RPC请求 "connect"；
- 您应能收到设备响应。

{% unless docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
{% include images-gallery.html imageCollection="server-side-rpc" %}
{% endunless %}

若MQTT设备为网关，ThingsBoard会发送关于预配置设备实体变更的服务端RPC（通知）。  
您的MQTT网关设备将收到关于设备移除或重命名的服务RPC，以便[正确处理此类事件](/docs/iot-gateway/how-device-removing-renaming-works/){:target="_blank"}。 

<hr>

### Client-side RPC

为向服务器发送RPC命令，向以下主题发送PUBLISH消息：

```shell
v1/devices/me/rpc/request/$REQUEST_ID
```
{: .copy-code}

> 其中<code>$REQUEST_ID</code>为整数请求标识符。

服务器响应将发布至以下主题：

```shell
v1/devices/me/rpc/response/$request_id
```

<br><b><font size="3">示例</font></b>   
以下示例基于mqtt.js编写。纯命令行示例不可用，因订阅与发布须在同一MQTT会话中进行。

{% if docsPrefix == nil or docsPrefix == "pe/" %}
**1.** 将[mqtt-js-rpc-from-client.js](/docs/pe/reference/resources/mqtt-js-rpc-from-client.js){:target="_blank" download="mqtt-js-rpc-from-client.js"}文件保存到您的电脑。 

> ⚠️ 此例中主机名指**本地ThingsBoard安装**。   
> 若ThingsBoard实例部署在其他主机，请将<code>localhost</code>替换为对应主机名或IP地址。

{% endif %}
{% if docsPrefix contains "paas/" %}
**1.** 将[mqtt-js-rpc-from-client.js](/docs/paas/reference/resources/mqtt-js-rpc-from-client.js){:target="_blank" download="mqtt-js-rpc-from-client.js"}文件保存到您的电脑。
{% endif %}
{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
**1.** 将[mqtt-js-rpc-from-client.js](/docs/edge/reference/resources/mqtt-js-rpc-from-client.js){:target="_blank" download="mqtt-js-rpc-from-client.js"}文件保存到您的电脑。

> ⚠️ 此例中主机名指**本地ThingsBoard Edge安装**。   
> 若ThingsBoard Edge实例部署在其他主机，请将<code>localhost</code>替换为对应主机名或IP地址。

{% endif %}

{% capture tabspec %}mqtt-rpc-from-client
A,The content of the "mqtt-js-rpc-from-client.js" file,javascript,resources/mqtt-js-rpc-from-client.js,/docs/reference/resources/mqtt-js-rpc-from-client.js{% endcapture %}
{% include tabs.html %}

**2.** 按以下步骤操作：
- 在{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}**Edge** {% endif %}**根规则链**中添加两个节点：[脚本转换](/docs/user-guide/rule-engine-2-0/nodes/transformation/script){:target="_blank"}和[RPC调用回复](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply){:target="_blank"}。将它们通过“**成功**”链接连接到"[记录来自设备的RPC](/docs/user-guide/rule-engine-2-0/nodes/action/log){:target="_blank"}"动作节点。
- 在**脚本**节点中输入函数：

```shell
return {msg: {time: new Date()}, metadata: metadata, msgType: msgType};
```
{: .copy-code}

- 向服务器发送请求。

> ⚠️ 请将<code>$ACCESS_TOKEN</code>替换为您的设备访问令牌。

```shell
export TOKEN=$ACCESS_TOKEN
node mqtt-js-rpc-from-client.js
```
{: .copy-code}

您将收到服务器响应：

```shell
{"time":"Thursday, February 5, 2026, 9:08:22 AM Coordinated Universal Time"}
```

{% unless docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
{% include images-gallery.html imageCollection="client-side-rpc" %}
{% endunless %}

<hr>

### Get session limits RPC

**getSessionLimits** RPC方法允许设备制造商和开发者获取ThingsBoard服务器强制执行的**MQTT传输限制**。

了解这些限制有助于确保设备在支持的参数范围内运行，并避免**消息拒绝、限流**或**连接丢失**等问题。

<b><font size="3">请求格式</font></b>   
为请求会话限制，设备发送以下RPC请求：

```json
{
  "method": "getSessionLimits",
  "params": {}
}
```

<b><font size="3">响应格式</font></b>   
处理请求后，ThingsBoard以以下格式在RPC响应中返回会话限制：

```json
{
  "maxPayloadSize": 65536,
  "maxInflightMessages": 100,
  "rateLimits": {
    "messages": "200:1,6000:60,14000:3600",
    "telemetryMessages": "100:1,3000:60,7000:3600",
    "telemetryDataPoints": "200:1,6000:60,14000:3600"
  }
}
```

<b><font size="3">响应字段说明</font></b>   
- **maxPayloadSize** - MQTT消息负载的最大允许大小，单位为字节。  
- **maxInflightMessages** - 任一时刻可发送但未确认（进行中）的MQTT消息最大数量。
- **rateLimits** - 嵌套对象，定义不同消息类别的速率限制：
  - **messages** - 整体消息速率限制。
  - **telemetryMessages** - 可发送的遥测消息最大数量。
  - **telemetryDataPoints** - 设备可发送的遥测数据点数量。  

<b><font size="3">速率限制格式说明</font></b>   
速率限制值例如：

```text
200:1,6000:60,14000:3600
```

- **200:1** — 每秒最多200条消息
- **6000:60** — 60秒内最多6,000条消息
- **14000:3600** — 3,600秒内最多14,000条消息

这些限制同时生效。

<b><font size="4">网关专用会话限制</font></b>   
若设备为**网关**，响应会包含适用于**通过该网关连接的**设备的额外限制。

<b><font size="3">网关响应格式</font></b>   

```json
{
  "maxPayloadSize": 65536,
  "maxInflightMessages": 100,
  "rateLimits": {
    "messages": "200:1,6000:60,14000:3600",
    "telemetryMessages": "100:1,3000:60,7000:3600",
    "telemetryDataPoints": "200:1,6000:60,14000:3600"
  },
  "gatewayRateLimits": {
    "messages": "200:1,6000:60,14000:3600",
    "telemetryMessages": "100:1,3000:60,7000:3600",
    "telemetryDataPoints": "200:1,6000:60,14000:3600"
  }
}
```

<b><font size="3">网关速率限制说明</font></b>   
- **rateLimits** - 适用于网关设备本身的速率限制。
- **gatewayRateLimits** - 适用于通过网关连接的单个设备的速率限制。

这些限制有助于在多设备通过单一网关连接通信时控制负载并确保稳定运行。

<hr>

## 设备认领

设备认领功能允许终端用户在设备部署并连接到ThingsBoard后，安全地将其与自己的账户关联。
设备认领流程及所支持场景的详细说明，请参阅{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}[设备认领](/docs/{{docsPrefix}}user-guide/claiming-devices){:target="_blank"}{% endif %}{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}[设备认领](/docs/user-guide/claiming-devices){:target="_blank"}{% endif %}文档。

为发起设备认领，向以下主题发送PUBLISH消息：

```shell
v1/devices/me/claim
```
{: .copy-code}

支持的数据格式为：

```json
{"secretKey":"value", "durationMs":60000}
```

{% capture difference %}
**请注意**：上述字段均为可选。若未指定**secretKey**，则默认使用空字符串。
若未指定**durationMs**，则使用系统参数**device.claim.duration**（位于**/etc/thingsboard/conf/thingsboard.yml**文件中）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## 设备预配置

设备预配置允许设备在无需于ThingsBoard界面手动创建的情况下动态注册。
预配置流程及所支持场景的详细说明，请参阅{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}[设备预配置](/docs/{{docsPrefix}}user-guide/device-provisioning){:target="_blank"}{% endif %}{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}[设备预配置](/docs/user-guide/device-provisioning){:target="_blank"}{% endif %}文档。

**预配置请求**   
为发起设备预配置，向以下主题发送预配置请求：

```shell
/provision
```
{: .copy-code}

同时，应将**username**或**clientId**设为*provision*。

**请求负载**   
预配置请求必须使用以下JSON格式：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "u7piawkboq8v32dmcmpp",
  "provisionDeviceSecret": "jpmwdn8ptlswmf4m29bw"
}
```

**负载字段**
- **deviceName** — 待预配置设备的名称。
- **provisionDeviceKey** — 在ThingsBoard中配置的预配置密钥。
- **provisionDeviceSecret** — 与预配置密钥关联的预配置密文。

若提供的凭证有效，ThingsBoard将自动创建设备（如尚不存在）并返回设备凭证，使设备得以开始与平台通信。

<hr>

## 固件API

当ThingsBoard发起MQTT设备固件更新时，会设置fw_title、fw_version、fw_checksum、fw_checksum_algorithm共享属性。
为接收共享属性更新，设备须订阅

```bash
v1/devices/me/attributes/response/+
```
{: .copy-code}

其中

**+** 为通配符。

当MQTT设备收到fw_title和fw_version共享属性更新后，须向以下主题发送PUBLISH消息

```bash
v2/fw/request/${requestId}/chunk/${chunkIndex} 
```
{: .copy-code}

其中

**${requestId}** - 对应固件更新次数的数字。每次固件更新${requestId}须不同。  
**${chunkIndex}** - 对应固件块索引的数字。${chunkIndex}从0开始计数。设备须在每次请求中递增块索引，直至接收到的块大小为0。  
MQTT负载应为固件块大小的字节数。

每次新的固件更新时，您需更改请求ID并订阅

```bash
v2/fw/response/+/chunk/+
```
{: .copy-code}

其中

**+** 为通配符。

<hr>

## 协议自定义

可通过修改对应的[模块](https://github.com/thingsboard/thingsboard/tree/master/transport/mqtt){:target="_blank"}，针对特定用例对MQTT传输进行完全定制。

<hr>

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
