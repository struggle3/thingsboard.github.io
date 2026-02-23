* TOC
{:toc}

ThingsBoard 允许您在服务端应用与设备之间进行远程过程调用（RPC）的双向通信。
简而言之，该功能允许您向设备发送命令或从设备接收命令，并获取命令执行结果。
本指南介绍 ThingsBoard 的 RPC 能力。阅读后将熟悉以下主题：

- RPC 类型；
- 基本 RPC 使用场景；
- RPC 客户端与服务端 API；
- RPC 部件。

ThingsBoard 的 RPC 功能可根据远程过程调用的发起方分为两种类型：设备发起和服务端发起的 RPC。
为便于理解，我们将设备发起的 RPC 调用称为**客户端**RPC，服务端发起的 RPC 称为**服务端**RPC。

## 客户端 RPC
{: #client-side-rpc}

客户端 RPC 功能允许您**从设备向平台**发送请求，并将响应返回给设备。

让我们了解客户端 RPC 调用的典型使用场景：

* 灌溉系统通过平台从在线服务获取天气预报。
* 无系统时钟的受限设备向平台请求当前时间戳。
* 门禁读卡器向第三方安防系统发送请求，以决定是否开门并记录访问。

在底层，设备向平台发送消息，由[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)处理。
规则引擎可使用设备属性、遥测数据或平台中存储的任何其他数据进行计算。
规则引擎也可在需要时调用外部系统。消息处理完成后，结果将发送回设备。
如下图所示：

   {:refdef: style="text-align: center;"}
   ![image](/images/user-guide/client-side-rpc.svg)
   {: refdef}

客户端 RPC 请求包含两个必填字段：

* **method** - 用于区分 RPC 调用的方法名称。
  例如 "getCurrentTime" 或 "getWeatherForecast"。该参数值为字符串。
* **params** - 用于处理请求的额外参数。值为 JSON。若无需参数则使用空 JSON "{}"。

RPC 请求示例：

```json
{
   "method": "getCurrentTime",
   "params": {}
}
```
{: .copy-code}

RPC 响应可以是任意数字、字符串或 JSON。例如：

```text
1631881236974
```

### 从设备发送客户端 RPC

ThingsBoard 提供从设备发送 RPC 命令的 API。
该 API 针对每种支持的网络协议有专门实现。
您可在相应参考页面查看 API 及示例：

- [MQTT 客户端 RPC API 参考](/docs/{{docsPrefix}}reference/mqtt-api/#client-side-rpc)
- [CoAP 客户端 RPC API 参考](/docs/{{docsPrefix}}reference/coap-api/#client-side-rpc)
- [HTTP 客户端 RPC API 参考](/docs/{{docsPrefix}}reference/http-api/#client-side-rpc)

LwM2M 和 SNMP 协议尚不支持客户端 RPC。

### 平台对客户端 RPC 的处理

客户端 RPC 命令会转换为规则引擎消息，[消息类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types)为 "TO_SERVER_RPC_REQUEST"。
消息包含基于 UUID 的唯一标识符，存储在 "requestId" 元数据字段中。
您可以设计[规则链](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain)，
使用转换、丰富或其他规则节点[类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-types)处理传入消息。
将传入消息转换为响应消息后，应使用 [RPC 调用回复](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-reply/)节点向设备发送回复。

例如，修改根规则链以处理 "getCurrentTime" 客户端 RPC 并以毫秒级当前时间回复。
我们将使用 "Script" 转换节点配合以下 JavaScript 代码：

```javascript
var rpcResponse;
if (msg.method === "getCurrentTime"){
   rpcResponse = new Date().getTime();
} else {
   rpcResponse = "Unknown RPC request method: " + msg.method;  
}
return {msg: rpcResponse, metadata: metadata, msgType: msgType};
```
{: .copy-code}

{% include images-gallery.html imageCollection="client-side-rpc-rule-chain" %}

## 服务端 RPC
{: #server-side-rpc}

服务端 RPC 功能允许您**从平台向设备**发送请求，并可选择将响应返回平台。

服务端 RPC 调用的典型场景包括各类远程控制：
重启、开关引擎、改变 GPIO/执行器状态、修改配置参数等。

服务端 RPC 分为单向和双向：
 
 - 单向 RPC 请求不需要设备提供任何回复。  
   
   {:refdef: style="text-align: center;"}
   ![image](/images/user-guide/one-way-rpc.svg)
   {: refdef}
   
 - 双向 RPC 请求期望在可配置的超时时间内收到设备的响应。

   {:refdef: style="text-align: center;"}
   ![image](/images/user-guide/two-way-rpc.svg)
   {: refdef}
   

3.3 版本之前，ThingsBoard 仅支持**轻量级**RPC。
轻量级 RPC 调用生命周期短，通常在 30 秒内（即平台 REST API 调用的默认超时）。
因其短暂，无需存入数据库。
它们保存在服务端内存中，假设若服务端宕机，仪表板部件会向集群中的其他 ThingsBoard 服务端发送相同请求。
轻量级 RPC 资源消耗低，因其处理不涉及除审计日志和规则引擎消息之外的任何 I/O 操作。

自 3.3 版本起，ThingsBoard 支持 [**持久化**](#persistent-rpc) RPC 调用。
持久化 RPC 具有可配置的生命周期并存储在数据库中。
当设备可能长期不可达时，持久化 RPC 尤为有用。
这种情况通常发生在网络状况差或处于[省电模式](/docs/{{docsPrefix}}user-guide/psm)（PSM）时。

### 服务端 RPC 结构
{: #server-side-rpc-structure}

服务端 RPC 请求体包含多个字段：

* **method** - 必填，用于区分 RPC 调用的方法名称。例如 "getCurrentTime" 或 "getWeatherForecast"。参数值为字符串。
* **params** - 必填，用于处理请求的参数。值为 JSON。若无参数则使用空 JSON "{}"。
* **timeout** - 可选，处理超时毫秒数。默认 10000（10 秒）。最小 5000（5 秒）。
* **expirationTime** - 可选，纪元时间毫秒数（UTC）。若存在则覆盖 **timeout**。
* **persistent** - 可选，参见[持久化]与[轻量级]RPC。默认为 "false"。
* **retries** - 可选，定义网络和/或设备侧失败时持久化 RPC 的重发次数。
* **additionalInfo** - 可选，定义将添加至[持久化 RPC 事件]的持久化 RPC 元数据。

RPC 请求示例：

```json
{
   "method": "setGPIO",
   "params": {
     "pin": 4,
     "value": 1
   },
  "timeout": 30000
}
```
{: .copy-code}

RPC 响应可以是任意 JSON。例如：

```json
{
   "pin": 4,
   "value": 1,
   "changed": true
}
```

### 发送服务端 RPC

服务端 RPC 通常通过 REST API 或仪表板部件发送。实际上，仪表板部件使用的是同一 REST API。
平台收到 RPC 后会验证载荷并执行权限检查。
随后，服务端 RPC 命令被转换为规则引擎消息。
规则引擎可为命令添加额外参数，并最终将命令下发至设备。

下面详细说明如何发送命令：

#### 使用 REST API

要发送 RPC 请求，需向以下 URL 发起 HTTP POST 请求：

```shell
http(s)://host:port/api/plugins/rpc/{callType}/{deviceId}
```

其中

- **http(s)://host:port** 为 ThingsBoard 服务器基础 URL。例如 [{{hostName}}](https://{{hostName}})
- **callType** 为 **oneway** 或 **twoway**；
- **deviceId** 为目标[设备 ID](/docs/{{docsPrefix}}user-guide/ui/devices/#get-device-id)。

请求体应为[上文](#server-side-rpc-structure)所述 RPC 请求对象的有效 JSON。

For example:

{% capture tabspec %}mqtt-rpc-from-client
A,set-gpio-request.sh,shell,resources/set-gpio-request.sh,/docs/{{docsPrefix}}user-guide/resources/set-gpio-request.sh
B,set-gpio-request.json,json,resources/set-gpio-request.json,/docs/{{docsPrefix}}user-guide/resources/set-gpio-request.json{% endcapture %}  
{% include tabs.html %}

**请注意**，要执行此请求，需将 **$JWT_TOKEN** 替换为有效的 [JWT](https://jwt.io/) 访问令牌。
该令牌应属于拥有 **$DEVICE_ID** 所标识设备的 **TENANT_ADMIN** 或 **CUSTOMER_USER** 角色用户。
请使用以下[指南](/docs/{{docsPrefix}}reference/rest-api/#rest-api-auth)获取令牌。

用户通过 REST API 发送**轻量级**RPC 时，API 调用会包含设备回复或错误码。例如：

```json
{
   "pin": 4,
   "value": 1,
   "changed": true
}
```


用户通过 REST API 发送**持久化**RPC 时，响应会包含唯一标识符 "rpcId"。例如：

```json
{
   "rpcId": "b10bb1a0-0afd-11ec-a08f-1b3182194747"
}
```
您可使用此标识符跟踪命令状态。详见持久化 RPC [状态](#persistent-rpc-states)。


#### 使用仪表板

[控制部件](/docs/{{docsPrefix}}user-guide/ui/widget-library/#rpc-control-widget)用于向设备发送 RPC 命令。
最常用的部件有 "RPC 按钮"、"圆形开关"、"开关控件" 和 "旋钮控件"。
这些部件的高级设置允许您定义 RPC 方法名和参数。
您也可开发[自定义部件](/docs/{{docsPrefix}}user-guide/contribution/widgets-development)并使用[控制 API](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/#control-api)发送 RPC 命令。

#### 使用规则引擎

所有从部件或 REST API 发送的服务端 RPC 命令最终都会转换为规则引擎消息，
[消息类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types)为 "RPC_CALL_FROM_SERVER_TO_DEVICE"。

消息包含存储在 "requestUUID" 元数据字段中的基于 UUID 的唯一标识符。
您可以设计[规则链](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain)，
使用转换、丰富或其他规则节点[类型](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-node-types)处理传入消息。
最后，应使用 [RPC 调用请求](/docs/user-guide/rule-engine-2-0/nodes/action/rpc-call-request/)节点将消息发送至设备。

您也可以使用生成器节点创建 RPC：

```javascript
var msg = { method: "rpcCommand", params: {} };
var metadata = { 
    expirationTime: new Date().getTime() + 60000,
    oneway: true,
    persistent: false
};
var msgType = "RPC_CALL_FROM_SERVER_TO_DEVICE";

return { msg: msg, metadata: metadata, msgType: msgType };
```

{% include images-gallery.html imageCollection="server-side-rpc-rule-chain" %}

### 在设备上处理服务端 RPC

ThingsBoard 提供便于在设备上接收和处理服务端 RPC 命令的 API。
该 API 针对每种支持的网络协议有专门实现。
您可在相应参考页面查看 API 及示例：

 - [MQTT RPC API 参考](/docs/{{docsPrefix}}reference/mqtt-api/#rpc-api)
 - [CoAP RPC API 参考](/docs/{{docsPrefix}}reference/coap-api/#rpc-api)
 - [HTTP RPC API 参考](/docs/{{docsPrefix}}reference/http-api/#rpc-api) 


### 持久化 RPC
{: #persistent-rpc}

#### 状态
{: #rpc-states}

ThingsBoard 跟踪持久化 RPC 的状态。共有 7 种状态：

{% if docsPrefix contains 'paas/' %}

* **QUEUED** - RPC 已创建并保存到数据库；尚未尝试向设备发送；当设备上线或已在线时，ThingsBoard 会立即尝试发送；默认情况下平台会同时尝试发送所有待处理 RPC；在受限设备且队列中消息较多时，可能导致网络或设备过载。
* **SENT** - ThingsBoard 已尝试向设备发送 RPC。
* **DELIVERED** - 设备已确认 RPC 送达；这是**单向**RPC 处理的最后一步。  
* **SUCCESSFUL** - ThingsBoard 已收到**双向**RPC 的回复。  
* **TIMEOUT** - ThingsBoard 传输层（MQTT/CoAP/LwM2M 等）检测到 RPC 投递超时；超时由对应配置参数控制：MQTT_TIMEOUT（默认 10 秒）、COAP_TIMEOUT（默认 10 秒）、LWM2M_TIMEOUT（默认 120 秒）；默认平台不会重试，状态会变为 FAILED；可在 RPC 体中配置重试次数；默认最大重试次数为 5。
* **EXPIRED** - 在配置的过期时间内 RPC 未送达或平台未收到设备回复；
* **FAILED** - 在可配置次数的重试后仍无法送达，或设备固件不支持该命令。

{% else %}

* **QUEUED** - RPC 已创建并保存到数据库；尚未尝试向设备发送；当设备上线或已在线时，ThingsBoard 会立即尝试发送；默认情况下平台会同时尝试发送所有待处理 RPC；在受限设备且队列中消息较多时，可能导致网络或设备过载；可启用 "ACTORS_RPC_SEQUENTIAL" [配置](/docs/user-guide/install/{{docsPrefix}}config/)参数以启用 RPC 顺序投递避免过载。
* **SENT** - ThingsBoard 已尝试向设备发送 RPC。
* **DELIVERED** - 设备已确认 RPC 送达；这是**单向**RPC 处理的最后一步。
* **SUCCESSFUL** - ThingsBoard 已收到**双向**RPC 的回复。
* **TIMEOUT** - ThingsBoard 传输层（MQTT/CoAP/LwM2M 等）检测到 RPC 投递超时；超时由对应 [配置](/docs/user-guide/install/{{docsPrefix}}config/)参数控制：MQTT_TIMEOUT（默认 10 秒）、COAP_TIMEOUT（默认 10 秒）、LWM2M_TIMEOUT（默认 120 秒）；默认平台不会重试，状态会变为 FAILED；可在 RPC 体中配置重试次数；最大重试次数由 "ACTORS_RPC_MAX_RETRIES" [配置](/docs/user-guide/install/{{docsPrefix}}config/)参数控制（默认 5）。
* **EXPIRED** - 在配置的过期时间内 RPC 未送达或平台未收到设备回复；
* **FAILED** - 在可配置次数的重试后仍无法送达，或设备固件不支持该命令。

{% endif %}

{% capture sequential-rpc-deadlock-warning %}
在配置顺序 RPC 投递时，若同时增加过期时间、投递超时和重试次数需格外小心。
若启用了顺序 RPC 投递且设备无法处理某个双向 RPC 命令，其他命令将无法发送至该设备。  
{% endcapture %}
{% include templates/info-banner.md content=sequential-rpc-deadlock-warning %} 

#### 规则链事件 

[RPC 状态](/docs/{{docsPrefix}}user-guide/rpc/#rpc-states)的变化会作为独立消息推送到规则引擎。 
每种 RPC 状态都有对应的消息类型。如下图所示：

{% include images-gallery.html imageCollection="rule-chain" %}

消息包含 RPC 请求的完整信息，包括实体 id 及请求体中的 "additionalInfo"。
"RPC Successful" 消息还会包含设备回复。
若要在外部系统中处理设备回复，这些消息很有用。

成功 RPC 消息示例如下：

```json
{
    "id": {
        "entityType": "RPC",
        "id": "bea26301-1aec-11ec-9441-73a37bbb7cd2"
    },
    "createdTime": 1632236465459,
    "tenantId": {
        "entityType": "TENANT",
        "id": "ab937a40-3f98-11eb-a8d6-f5a87f07d4be"
    },
    "deviceId": {
        "entityType": "DEVICE",
        "id": "3e46db70-e480-11eb-9d0e-1f8899a6f9b3"
    },
    "expirationTime": 1632236525354,
    "request": {
        "id": "bea26301-1aec-11ec-9441-73a37bbb7cd2",
        "tenantId": {
            "entityType": "TENANT",
            "id": "ab937a40-3f98-11eb-a8d6-f5a87f07d4be"
        },
        "deviceId": {
            "entityType": "DEVICE",
            "id": "3e46db70-e480-11eb-9d0e-1f8899a6f9b3"
        },
        "oneway": false,
        "expirationTime": 1632236525354,
        "body": {
            "method": "rpcCommand",
            "params": "{}"
        },
        "persisted": true,
        "retries": null
    },
    "response": {
        "test": "passed"
    },
    "status": "SUCCESSFUL",
    "additionalInfo": "{\"param1\":\"value1\",\"param2\":\"value2\"}"
}
```


#### TTL 配置

{% if docsPrefix contains 'paas/' %}

持久化 RPC 的生存时间取决于订阅计划。详见[订阅](/docs/{{docsPrefix}}subscription/)中的 'RPC TTL' 参数。

{% else %}
持久化 RPC 的生存时间由系统管理员在[租户配置文件](/docs/{{docsPrefix}}user-guide/tenant-profiles/)中通过 **RPC TTL 天配置**参数设置。
系统管理员可使用 **SQL_TTL_RPC_ENABLED** [配置](/docs/user-guide/install/{{docsPrefix}}config/)参数完全禁用持久化 RPC 的数据库清理。
RPC 清理过程的频率由 **SQL_RPC_TTL_CHECKING_INTERVAL** 参数控制，默认为 2 小时。

{% include images-gallery.html imageCollection="tenant-profile-rpc" %}
{% endif %}
