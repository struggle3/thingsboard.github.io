{% if docsPrefix == nil or docsPrefix == "pe/" %}
{% assign HOST_NAME = "$THINGSBOARD_HOST_NAME" %}
{% endif %}
{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
{% assign HOST_NAME = "$THINGSBOARD_EDGE_HOST_NAME" %}
{% endif %}

* TOC
{:toc}

[CoAP](https://en.wikipedia.org/wiki/Constrained_Application_Protocol){:target="_blank"}是一种面向受限物联网设备的轻量级、基于UDP的协议。
虽采用类似HTTP的请求-响应模型，CoAP针对低功耗、低带宽网络进行了优化。   
更多CoAP信息请见[此处](https://tools.ietf.org/html/rfc7252){:target="_blank"}。

CoAP Observe [选项](https://tools.ietf.org/html/rfc7641){:target="_blank"}支持订阅资源并在资源变更时接收通知。

ThingsBoard服务节点充当CoAP服务器，同时支持常规和Observe请求。

<hr>

## 客户端库配置

不同平台和语言有多种CoAP客户端库可用。

本指南示例基于命令行CoAP客户端[CoAP cli](https://www.npmjs.com/package/coap-cli){:target="_blank"}。

**安装CoAP CLI（Linux/macOS）**
```bash
npm install coap-cli -g
```
{: .copy-code}

{% capture difference %}
**注意**：CoAP CLI不支持查询参数。若需查询参数，请使用[coap-client](https://manpages.ubuntu.com/manpages/focal/man5/coap-client.5.html){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**安装coap-client**
- **Ubuntu 20.04+** 
  ```bash
  sudo apt install libcoap2-bin
  ```
  {: .copy-code}

- **Ubuntu 18.04** 
  ```bash
  sudo apt install libcoap1-bin
  ```
  {: .copy-code}

<hr>

## 认证方式

ThingsBoard支持两种认证方式以保护CoAP连接。

**支持的方式**：
- [Access token](/docs/{{docsPrefix}}user-guide/ssl/coap-access-token/){:target="_blank"}。每次CoAP请求的路径参数中包含唯一设备访问令牌。
- [X.509 certificates](/docs/{{docsPrefix}}user-guide/ssl/coap-x509-certificates/){:target="_blank"}。使用数字证书认证设备，基于**公钥基础设施（PKI）**建立安全通信。

> 本指南示例采用**基于access token的认证**。

**错误码及原因**：
- **4.00 Bad Request** - URL、参数或载荷无效
- **4.01 Unauthorized** - **access token**无效
- **4.04 Not Found** - 请求的资源不存在

<hr>

{% include templates/api/key-value-format.md %}

也可通过[Protocol Buffers](https://developers.google.com/protocol-buffers){:target="_blank"}发送数据。
详见设备配置文档中的[CoAP传输类型](/docs/{{docsPrefix}}user-guide/device-profiles/#coap-transport-type){:target="_blank"}配置章节。

也可使用自定义二进制格式或序列化框架。详见[协议自定义](#protocol-customization)。

<hr>

## 遥测上传 API

向ThingsBoard服务节点发布遥测数据时，发送POST请求。

首先选择认证方式：

{% capture coapAuthenticationCredentials %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/telemetry-upload-api-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/telemetry-upload-api-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapAuthenticationCredentials" toggle-spec=coapAuthenticationCredentials %}

支持的最简数据格式为：

```json
{"key1":"value1", "key2":"value2"}
```

or

```json
[{"key1":"value1"}, {"key2":"value2"}]
```

{% capture difference %}
**请注意** 
<br>
在此情况下，将使用服务器端时间戳作为上传数据的时间戳！
{% endcapture %}
{% include templates/info-banner.md content=difference %}

若设备能获取客户端时间戳，可使用以下格式：

```json
{"ts":1451649600512, "values":{"key1":"value1", "key2":"value2"}}
```

其中 **1451649600512** 为毫秒精度的[Unix时间戳](https://en.wikipedia.org/wiki/Unix_time){:target="_blank"}。例如 '1451649600512' 对应 'Fri, 01 Jan 2016 12:00:00.512 GMT'。

<br><b><font size="3">示例</font></b>   
以下为发布不同类型遥测数据的命令示例。

> ⚠️ 请勿忘记替换 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。   
&#8194;&#8226;&#8194;{% endunless %}<code>$ACCESS_TOKEN</code> 为您的设备访问令牌。

**示例1**。   
以对象形式发布无时间戳数据（将使用服务器端时间戳），数据来自[telemetry-data-as-object.json](/docs/reference/resources/telemetry-data-as-object.json){:target="_blank" download="telemetry-data-as-object.json"}文件。

{% capture tabspec %}coap-telemetry-upload
A,执行命令：,shell,resources/coap-telemetry.sh,/docs/reference/resources/coap-telemetry.sh{% endcapture %}
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
{: .copy-code}

**示例2**。   
以对象数组形式发布无时间戳数据（将使用服务器端时间戳），数据来自[telemetry-data-as-array.json](/docs/reference/resources/telemetry-data-as-array.json){:target="_blank" download="telemetry-data-as-array.json"}文件。

{% capture tabspec %}coap-telemetry-upload-data-as-array
A,执行命令：,shell,resources/coap-telemetry-data-as-array.sh,/docs/reference/resources/coap-telemetry-data-as-array.sh{% endcapture %}
{% include tabs.html %}

JSON文件内容：

```json
[{"key1":"value1"}, {"key2":true}]
```
{: .copy-code}

**示例3**。   
以带时间戳的对象形式发布数据（将使用遥测时间戳），数据来自[telemetry-data-with-ts.json](/docs/reference/resources/telemetry-data-with-ts.json){:target="_blank" download="telemetry-data-with-ts.json"}文件。

{% capture tabspec %}coap-telemetry-upload-data-with-ts
A,执行命令：,shell,resources/coap-telemetry-data-with-ts.sh,/docs/reference/resources/coap-telemetry-data-with-ts.sh{% endcapture %}
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
{: .copy-code}

<hr>

## Attributes API

ThingsBoard属性API允许设备

* 将[客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性上传至服务器。
* 从服务器请求[客户端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}和[共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性。
* 订阅服务器的[共享](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types){:target="_blank"}设备属性。

<hr>

### 向服务器发布属性更新

为将客户端设备属性发布至ThingsBoard服务节点，发送POST请求。

首先选择认证方式：

{% capture coapPublishAttributeUpdate %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/publish-attribute-update-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/publish-attribute-update-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapPublishAttributeUpdate" toggle-spec=coapPublishAttributeUpdate %}

<hr>

### 从服务器请求属性值

为从ThingsBoard服务节点请求客户端或共享设备属性，发送GET请求。

首先选择认证方式：

{% capture coapRequestAttributeValues %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/request-attribute-values-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/request-attribute-values-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapRequestAttributeValues" toggle-spec=coapRequestAttributeValues %}

结果：

```shell
{"client":{"attribute1":"value1","attribute2":true}}
```

{% capture difference %}
**请注意：**
<br>
客户端与共享设备属性键存在交集是不佳实践！ 
但仍可为client、shared甚至server-side属性使用相同键。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

### 订阅来自服务器的属性更新

为订阅共享设备属性变更，发送带Observe选项的GET请求。

首先选择认证方式：

{% capture coapSubscribeToAttributeUpdates %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/subscribe-to-attribute-updates-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/subscribe-to-attribute-updates-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapSubscribeToAttributeUpdates" toggle-spec=coapSubscribeToAttributeUpdates %}

结果：

```shell
{"client":{"attribute1":"value1","attribute2":true}}
```

<hr>

## JSON value support

{% include templates/api/json.md %}

<hr>

## RPC API

### Server-side RPC

为订阅来自服务器的RPC命令，发送带observe标志的GET请求。

首先选择认证方式：

{% capture coapServerSideRPC %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/server-side-rpc-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/server-side-rpc-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapServerSideRPC" toggle-spec=coapServerSideRPC %}

<hr>

### Client-side RPC

为向服务器发送RPC命令，发送POST请求。

首先选择认证方式：

{% capture coapClientSideRPC %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/client-side-rpc-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/client-side-rpc-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapClientSideRPC" toggle-spec=coapClientSideRPC %}

<hr>

## Claiming devices

设备认领功能允许最终用户在设备部署并连接至ThingsBoard后，安全地将设备关联到其账户。
设备认领流程及支持场景的详细说明请参见{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}[认领设备](/docs/{{docsPrefix}}user-guide/claiming-devices){:target="_blank"}{% endif %}{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}[认领设备](/docs/user-guide/claiming-devices){:target="_blank"}{% endif %}文档。

为启动设备认领，发送POST请求。

首先选择认证方式：

{% capture coapClaimingDevices %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/claiming-devices-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/claiming-devices-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapClaimingDevices" toggle-spec=coapClaimingDevices %}

支持的数据格式为：

```json
{"secretKey":"value", "durationMs":60000}
```

{% capture difference %}
**请注意** 
<br>
上述字段均为可选。**secretKey**未指定时，默认使用空字符串。
**durationMs**未指定时，使用系统参数**device.claim.duration**（位于**/etc/thingsboard/conf/thingsboard.yml**）。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<hr>

## Device provisioning

设备预配置支持设备动态注册，无需在ThingsBoard界面手动创建。
预配置流程及支持场景的详细说明请参见{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix contains "paas/" %}[设备预配置](/docs/{{docsPrefix}}user-guide/device-provisioning){:target="_blank"}{% endif %}{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}[设备预配置](/docs/user-guide/device-provisioning){:target="_blank"}{% endif %}文档。

**预配置请求**   
为启动设备预配置，向以下URL发送POST请求：

{% if docsPrefix == nil or docsPrefix == "pe/" or docsPrefix == "edge/" or docsPrefix == "pe/edge/" %}
```shell
coap://{{HOST_NAME}}/api/v1/provision
```
{: .copy-code}

其中 **{{HOST_NAME}}** 为您的ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %}主机名或IP地址。

{% endif %}
{% if docsPrefix contains "paas/" %}

```shell
coap://{{coapHostName}}/api/v1/provision
```
{: .copy-code}

{% endif %}

**请求载荷**   
预配置请求须使用以下JSON格式：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "u7piawkboq8v32dmcmpp",
  "provisionDeviceSecret": "jpmwdn8ptlswmf4m29bw"
}
```

**载荷字段**
- **deviceName** — 待预配置设备的名称。
- **provisionDeviceKey** — ThingsBoard中配置的预配置密钥。
- **provisionDeviceSecret** — 与预配置密钥关联的预配置密钥。

若提供的凭据有效，ThingsBoard将自动创建设备（若不存在）并返回设备凭据，使设备可与平台通信。

<hr>

## Firmware API

选择认证方式：

{% capture coapFirmwareAPI %}
Access token<small></small>%,%accesstoken%,%templates/api/coap/firmware-api-access-token.md%br%
X.509 Certificate<small></small>%,%certificate%,%templates/api/coap/firmware-api-certificate.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="coapFirmwareAPI" toggle-spec=coapFirmwareAPI %}

<hr>

## 协议自定义

可通过修改对应[模块](https://github.com/thingsboard/thingsboard/tree/master/transport/coap){:target="_blank"}，针对特定用例完全自定义CoAP传输。

<hr>

## 下一步

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}