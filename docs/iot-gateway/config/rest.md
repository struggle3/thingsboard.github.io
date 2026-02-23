---
layout: docwithnav-gw
title: REST 连接器配置
description: ThingsBoard IoT Gateway 的 REST API 端点支持

---

* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard IoT Gateway 的 REST 连接器配置。  
请使用 [通用配置指南](/docs/iot-gateway/configuration/) 启用此连接器。  
该连接器用于创建 API 端点并从收到的请求中获取数据。  
连接器还可根据 ThingsBoard 的更新或命令将数据推送至外部 HTTP(S) API。    

当您的设备有 HTTP(S) API 端点或外部资源中有数据并希望推送至 ThingsBoard 时，此连接器非常有用。    

下面将说明连接器配置文件。

## 连接器配置：rest.json

连接器配置为 JSON 文件，包含如何创建 API 端点以及如何处理数据的说明。下面通过示例说明配置文件格式。

<b>REST 连接器配置文件示例。</b>

下列示例将在本地 5000 端口创建服务器。连接器将使用用户名和密码进行基本 HTTP 认证，然后根据 mapping 部分的端点创建端点列表。更多说明见下文。  

```json
{
  "server": {
    "host": "127.0.0.1",
    "port": 5000,
    "SSL": false,
    "security": {
      "cert": "~/ssl/cert.pem",
      "key": "~/ssl/key.pem"
    }
  },
  "mapping": [
    {
      "endpoint": "/test_device",
      "HTTPMethods": [
        "POST"
      ],
      "security": {
        "type": "basic",
        "username": "username",
        "password": "password"
      },
      "converter": {
        "type": "json",
        "deviceInfo": {
          "deviceNameExpression": "Device ${name}",
          "deviceNameExpressionSource": "request",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "default"
        },
        "attributes": [
          {
            "key": "model",
            "type": "string",
            "value": "${sensorModel}"
          }
        ],
        "timeseries": [
          {
            "key": "temperature",
            "type": "double",
            "value": "${temp}"
          },
          {
            "key": "humidity",
            "type": "double",
            "value": "${hum}"
          },
          {
            "key": "combine",
            "type": "string",
            "value": "${hum}:${temp}"
          }
        ]
      }
    },
    {
      "endpoint": "/anon2",
      "HTTPMethods": [
        "POST"
      ],
      "security": {
        "type": "anonymous"
      },
      "converter": {
        "type": "custom",
        "deviceInfo": {
          "deviceNameExpression": "SuperAnonDevice",
          "deviceNameExpressionSource": "constant",
          "deviceProfileExpressionSource": "constant",
          "deviceProfileExpression": "default"
        },
        "extension": "CustomRestUplinkConverter",
        "extensionConfig": {
          "key": "Totaliser",
          "datatype": "float",
          "fromByte": 0,
          "toByte": 4,
          "byteorder": "big",
          "signed": true,
          "multiplier": 1
        }
      }
    }
  ],
  "requestsMapping": {
    "attributeRequests": [],
    "attributeUpdates": [],
    "serverSideRpc": []
  }
}
```
{:.copy-code.expandable-15}

### 通用部分
{% capture restconnectorsecuritytogglespec %}
With SSL<small>Recommended</small>%,%accessToken%,%templates/iot-gateway/rest-connector-ssl-security-config.md%br%
Without SSL<small>No security</small>%,%anonymous%,%templates/iot-gateway/rest-connector-no-ssl-security-config.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="restConnectorCredentialsConfig" toggle-spec=restconnectorsecuritytogglespec %}  

### 映射部分

本配置部分包含网关将创建的端点对象数组，也包含处理传入消息（converter）的设置。收到请求后，将分析请求中的消息以提取设备名称、类型和数据（属性和/或时序值）。默认使用 Json 转换器，也可提供自定义转换器。

**注意**：可在数组内指定多个映射对象。

| **参数** | **默认值**                     | **说明**                                             |
|:--------------|:-|-------------------------------------------------------------
| endpoint      | **/test_device**                      | 端点的 URL 地址。                                      |
| HTTPMethods   | **GET**                               | 端点允许的 HTTP 方法（**GET**、**POST** 等）。         |
| ---           

#### 安全部分

本部分提供每个端点在网关上进行客户端认证的配置。
 
{% capture restconnectorsecuritytogglespec2 %}
Basic<small>Recommended</small>%,%username%,%templates/iot-gateway/rest-connector-basic-security-config.md%br%
Anonymous<small>No security</small>%,%anonymous%,%templates/iot-gateway/rest-connector-anonymous-security-config.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="restConnectorCredentialsConfig" toggle-spec=restconnectorsecuritytogglespec2 %}


#### 转换器子节

本子节包含处理传入消息的配置。

请求转换器类型：  
1. json - 默认转换器  
2. custom - 自定义转换器（可自行编写，用于转换传入数据）  

{% capture difference %}
**连接器不会传递转换器返回的 None 值**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% capture restconvertertypespec %}
json<small>Recommended if json will be received in the request</small>%,%json%,%templates/iot-gateway/rest-converter-json-config.md%br%
custom<small>Recommended if bytes or anything else will be received in the request</small>%,%custom%,%templates/iot-gateway/rest-converter-custom-config.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="restConverterTypeConfig" toggle-spec=restconvertertypespec %}

{% capture difference %}
**使用 GET 请求时，也可解析 URL 中的查询参数。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### 响应

REST 连接器的响应可有三种配置方式：
1. 默认响应（无额外配置，仅返回 HTTP 状态码）；
2. 硬编码响应体，需指定新节和 2 个新的可选参数，如下例：

    | **参数**                 | **默认值**                                     | **说明**                                                       |
    |:-|:-|-
    | response                      |                                                       | 每次请求服务器时返回的响应                                             |
    | ... successResponse           | **OK**                                                | 仅在响应状态为 200 时                                                 |
    | ... unsuccessfulResponse      | **Error**                                             | 仅在响应状态非 200 时                                                 |
    |---

3. **高级**：由 ThingsBoard 返回的远程响应。
   1. 要配置该方式，需在配置文件中指定新节，如下例：

       | **参数**                 | **默认值**                                     | **说明**                                                       |
       |:-|:-|-
       | response                      |                                                       | 是否返回响应的布尔值                                                   |
       | ... responseExpected          | **true**                                              | 是否期望响应。                                                        |
       | ... timeout                   | **120**                                               | 请求超时时间。                                                        |
       | ... responseAttribute         | **result**                                            | 将返回响应的共享属性名称                                               |
       |---

   2. 在 ThingsBoard 中配置规则链：
      ![image](/images/gateway/custom-response-rule-chain-config.png)
      最后，需配置规则节点：
      1. Yellow Rule Node
          ![image](/images/gateway/custom-response-yellow-rule-node.png)
      2. Blue Rule Node
          ![image](/images/gateway/custom-response-blue-rule-node.png)

### 属性请求部分

本部分配置为可选。

为向 ThingsBoard 服务节点请求客户端或共享设备属性，网关支持发送属性请求。

| **Parameter**                 | **Default value**                                     | **Description**                                                       |
|:-|:-|-
| endpoint                      | **/sharedAttributes**                                 | Url address of the endpoint.                                          |
| type                          | **shared**                                            | The type of requested attribute can be “shared” or “client”.          |
| HTTPMethods                   | **[”POST”]**                                          | Allowed methods                                                       |
| security                      |                                                       | Security for request:                                                 |
| ... type                      | **basic**                                             | Security type for request to the server (**basic** or **anonymous**). |
| ... username                  | **user**                                              | Username for basic type of the security.                              |
| ... password                  | **passwd**                                            | Password for basic type of the security.                              |
| timeout                       | **10.0**                                              | Timeout for request.                                                  |
| deviceNameExpression          | **${deviceName}**                                     | JSON-path expression, for looking the device name.                    |
| attributeNameExpression       | **${attribute}**                                      | JSON-path expression, for looking the attribute name.                 |
|---

The **attributeRequests** section will look like:
```json
"attributeRequests": [
  {
    "endpoint": "/sharedAttributes",
    "type": "shared",
    "HTTPMethods": [
      "POST"
    ],
    "security": {
      "type": "anonymous"
    },
    "timeout": 10.0,
    "deviceNameExpression": "${deviceName}",
    "attributeNameExpression": "${attribute}"
  }
]
```
{: .copy-code}

Also, you can request multiple attributes at once. Simply add one more JSON-path to 
attributeNameExpression parameter. For example, we want to request two shared attributes in one request, our config 
will look like:
```json
"attributeRequests": [
  {
    "endpoint": "/sharedAttributes",
    "type": "shared",
    "HTTPMethods": [
      "POST"
    ],
    "security": {
      "type": "anonymous"
    },
    "timeout": 10.0,
    "deviceNameExpression": "${deviceName}",
    "attributeNameExpression": "${pduAttribute}, ${versionAttribute}"
  }
]
```
{: .copy-code}

### 属性更新部分

本部分配置为可选。ThingsBoard 支持预配设备属性，并可从设备应用拉取部分属性。可将其视为设备的远程配置，设备可从 ThingsBoard 请求共享属性。详见 [用户指南](/docs/user-guide/attributes/)。

「**attributeUpdates**」配置用于设置相应属性更新消息的格式。 

| **Parameter**                 | **Default value**                                     | **Description**                                                                                    |
|:-|:-|-
| httpMethod                    | **POST**                                              | HTTP method for request (**GET**, **POST** etc.).                                                  |
| SSLVerify                     | **false**                                             | Verify or no SSL certificate on the server if available.                                           |
| httpHeaders                   | **{ "CONTENT-TYPE": "application/json" }**            | Object contains additional HTTP headers for request.                                               |
| security                      |                                                       | Security for request:                                                                              |
|   type                        | **basic**                                             | Security type for request to the server (**basic** or **anonymous**).                              |
|   username                    | **user**                                              | Username for basic type of the security.                                                           |
|   password                    | **passwd**                                            | Password for basic type of the security.                                                           |   
| timeout                       | **0.5**                                               | Timeout for request.                                                                               |
| tries                         | **3**                                                 | Count of tries to send data                                                                        |
| allowRedirects                | **true**                                              | Allow request redirection.                                                                         |
| deviceNameFilter              | **.\*REST$**                                          | Regular expression device name filter, uses to determine, which function to execute.               |
| attributeFilter               | **data**                                              | Regular expression attribute name filter, uses to determine, which function to execute.            |
| requestUrlExpression          | **sensor/${deviceName}/${attributeKey}**              | JSON-path expression uses for creating url address to send a message.                              |
| valueExpression               | **{\\"${attributeKey}\\":\\"${attributeValue}\\"}**   | JSON-path expression uses for creating the message data that will send to url.                     |
|---

The **attributeUpdates** section will look like:

```json
  "attributeUpdates": [
      {
        "HTTPMethod": "POST",
        "SSLVerify": false,
        "httpHeaders": {
          "CONTENT-TYPE": "application/json"
        },
        "security": {
          "type": "basic",
          "username": "user",
          "password": "passwd"
        },
        "timeout": 0.5,
        "tries": 3,
        "allowRedirects": true,
        "deviceNameFilter": ".*REST$",
        "attributeFilter": "data",
        "requestUrlExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
  ],
```
{: .copy-code}

### 服务端 RPC 部分

ThingsBoard 支持向直接连接或经网关连接的设备发送 [RPC 命令](/docs/user-guide/rpc/)。
 
本部分提供的配置用于从 ThingsBoard 向设备发送 RPC 请求。

| **Parameter**                 | **Default value**                                                 | **Description**                                                                       |
|:-|:-|-
| deviceNameFilter              | **.\***                                                           | Regular expression device name filter, uses to determine, which function to execute.  |
| methodFilter                  | **echo**                                                          | Regular expression method name filter, uses to determine, which function to execute.  |
| requestUrlExpression          | **http://127.0.0.1:5001/${deviceName}**                           | JSON-path expression, uses to create url address to send RPC request.                 |
| responseTimeout               | **1**                                                             | Timeout for request.                                                                  |
| httpMethod                    | **GET**                                                           | HTTP method for request (**GET**, **POST** etc.).                                     |
| valueExpression               | **${params}**                                                     | JSON-path expression, uses for creating data for sending.                             |
| timeout                       | **0.5**                                                           | Timeout for request.                                                                  |
| tries                         | **3**                                                             | Count of tries to send data                                                           |
| httpHeaders                   | **{ "CONTENT-TYPE": "application/json" }**                        | Object contains additional HTTP headers for request.                                  |
| security                      |                                                                   | Security for request:                                                                 |
|   type                        | **anonymous**                                                     | Security type for request to the server (**basic** or **anonymous**).                 |
|---

{% capture rpc_variants %}
**RPC 调用有两种类型：**  
1. 带回复：发送请求后网关将等待响应并发送至 ThingsBoard。
2. 无回复：发送请求后网关不等待响应。

以下提供两种方法的示例。

{% endcapture %}
{% include templates/info-banner.md content=rpc_variants %}

```json
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "echo",
      "requestUrlExpression": "http://127.0.0.1:5001/${deviceName}",
      "responseTimeout": 1,
      "HTTPMethod": "GET",
      "valueExpression": "${params}",
      "timeout": 0.5,
      "tries": 3,
      "httpHeaders": {
        "Content-Type": "application/json"
      },
      "security": {
        "type": "anonymous"
      }
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "HTTPMethod": "POST",
      "valueExpression": "${params.hum}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
```
{: .copy-code}

此外，每个遥测和属性参数均内置 GET 和 SET RPC 方法，don’t 。使用前请确保已设置所有必需参数 （REST 连接器中为：**requestUrlExpression**、**responseTimeout**、**HTTPMethod**、**valueExpression**）。参见 [指南](/docs/iot-gateway/guides/how-to-use-get-set-rpc-methods)。

## 下一步

探索与 ThingsBoard 主要功能相关的指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据
