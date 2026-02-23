---
layout: docwithnav-gw
title: Request 连接器配置
description: ThingsBoard IoT Gateway 的 HTTP 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 ThingsBoard IoT Gateway 的 Request 连接器配置。  
请使用 [通用配置指南](/docs/iot-gateway/configuration/) 启用此连接器。  
该连接器的用途是连接外部 HTTP(S) API 端点并从中获取数据。  
连接器还能根据 ThingsBoard 的更新或命令将数据推送到外部 HTTP(S) API。    

当您的设备有 HTTP(S) API 端点或外部资源中有数据并希望推送至 ThingsBoard 时，此连接器非常有用。    

下面将说明连接器配置文件。

## 连接器配置：request.json

连接器配置为 JSON 文件，包含如何连接外部 API 端点、读取数据时使用的 URL 以及如何处理数据的说明。
下面通过示例说明配置文件格式。

<b>Request 连接器配置文件示例。</b>

下列示例将连接到本地 5000 端口上的服务器。连接器将使用用户名和密码进行基本 HTTP 认证，然后根据 mapping 部分的 URL 从端点列表读取数据。更多说明见下文。  

{% capture requestConf %}
{
  "host": "http://127.0.0.1:5000",
  "SSLVerify": true,
  "security": {
    "type": "basic",
    "username": "user",
    "password": "password"
  },
  "mapping": [
    {
      "url": "getdata",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 5,
      "converter": {
        "type": "json",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "attributes": [
          {
            "key": "serialNumber",
            "type": "string",
            "value": "${serial}"
          }
        ],
        "telemetry": [
          {
            "key": "Maintainer",
            "type": "string",
            "value": "${Developer}"
          },
          {
            "key": "Pressure",
            "type": "integer",
            "value": "${press}"
          }
        ]
      }
    },
    {
      "url": "get_info",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 100,
      "converter": {
        "type": "custom",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "extension": "CustomRequestUplinkConverter",
        "extension-config": [
          {
            "key": "Totaliser",
            "type": "float",
            "fromByte": 0,
            "toByte": 4,
            "byteorder": "big",
            "signed": true,
            "multiplier": 1
          },
          {
            "key": "Flow",
            "type": "int",
            "fromByte": 4,
            "toByte": 6,
            "byteorder": "big",
            "signed": true,
            "multiplier": 0.01
          }
        ]
      }
    }
  ],
  "attributeUpdates": [
      {
        "httpMethod": "POST",
        "httpHeaders": {
          "CONTENT-TYPE": "application/json"
        },
        "timeout": 0.5,
        "tries": 3,
        "allowRedirects": true,
        "deviceNameFilter": "SD.*",
        "attributeFilter": "send_data",
        "requestUrlExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
  ],
  "serverSideRpc": [
    {
      "deviceNameFilter": ".*",
      "methodFilter": "echo",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "responseTimeout": 1,
      "httpMethod": "GET",
      "valueExpression": "${params}",
      "timeout": 0.5,
      "tries": 3,
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "httpMethod": "POST",
      "valueExpression": "${params}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=requestConf params="conf|.copy-code.expandable-20" %}


### 通用部分

| **参数** | **默认值**                 | **说明**                                           |
|:-|:-|-
| host          | **http://127.0.0.1:5000**         | 服务器的域名或 IP 地址。                             |
| SSLVerify     | **true**                          | 若可用，是否验证服务器上的 SSL 证书。                  |
|---


### 安全部分

本部分提供在外部服务器上进行客户端认证的配置。
 
{% capture requestconnectorsecuritytogglespec %}
Basic<small>Recommended</small>%,%username%,%templates/iot-gateway/request-connector-basic-security-config.md%br%
Anonymous<small>No security</small>%,%anonymous%,%templates/iot-gateway/request-connector-anonymous-security-config.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="requestConnectorCredentialsConfig" toggle-spec=requestconnectorsecuritytogglespec %}


### 映射部分

本配置部分包含网关连接服务器后尝试读取的端点对象数组，也包含处理传入消息（converter）的设置。请求后，将分析该 URL 的每个响应以提取设备名称、类型和数据（属性和/或时序值）。默认使用 Json 转换器，也可提供自定义转换器。参见源码中的 [示例](https://github.com/thingsboard/thingsboard-gateway/blob/master/thingsboard_gateway/extensions/request/custom_request_uplink_converter.py)。

**注意**：可在数组内指定多个映射对象。

| **参数**     | **默认值**                     | **说明**                                                   |
|:-|:-|-
| url               | **getdata**                           | 发送请求的 URL 地址。                                       |
| httpMethod        | **GET**                               | 请求的 HTTP 方法（**GET**、**POST** 等）。                 |
| httpHeaders       | **{ "ACCEPT": "application/json" }**  | 包含请求的额外 HTTP 头的对象。                              |
| allowRedirects    | **true**                              | 是否允许请求重定向。                                        |
| timeout           | **0.5**                               | 请求超时时间。                                              |
| scanPeriod        | **5**                                 | 重新扫描间隔。                                              |
|---


#### 转换器子节

本子节包含处理传入消息的配置。

请求转换器类型：  
1. json - 默认转换器  
2. custom - 自定义转换器（可自行编写，用于转换响应中的传入数据）  

{% capture requestconvertertypespec %}
json<small>Recommended if json will be received in response</small>%,%json%,%templates/iot-gateway/request-converter-json-config.md%br%
custom<small>Recommended if bytes or anything else will be received in response</small>%,%custom%,%templates/iot-gateway/request-converter-custom-config.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="RequestConverterTypeConfig" toggle-spec=requestconvertertypespec %}


### 属性更新部分

本部分配置为可选。ThingsBoard 支持预配设备属性，并可从设备应用拉取部分属性。可将其视为设备的远程配置，设备可从 ThingsBoard 请求共享属性。详见 [用户指南](/docs/user-guide/attributes/)。

「**attributeRequests**」配置用于设置相应属性请求与响应消息的格式。

| **参数**                 | **默认值**                                     | **说明**                                                                                    |
|:-|:-|-
| httpMethod                    | **GET**                                               | 请求的 HTTP 方法（**GET**、**POST** 等）。                                                  |
| httpHeaders                   | **{ "CONTENT-TYPE": "application/json" }**            | 包含请求额外 HTTP 头的对象。                                                                |
| timeout                       | **0.5**                                               | 请求超时时间。                                                                               |
| tries                         | **3**                                                 | 发送数据的重试次数。                                                                        |
| allowRedirects                | **true**                                              | 是否允许请求重定向。                                                                         |
| deviceNameFilter              | **SD.\***                                             | 设备名称的正则表达式过滤，用于确定执行哪个函数。                                             |
| attributeFilter               | **send_data**                                         | 属性名称的正则表达式过滤，用于确定执行哪个函数。                                             |
| requestUrlExpression          | **sensor/${deviceName}/${attributeKey}**              | 用于创建发送消息的 URL 地址的 JSON-path 表达式。                                             |
| valueExpression               | **{\\"${attributeKey}\\":\\"${attributeValue}\\"}**   | 用于创建将发送至 URL 的消息数据的 JSON-path 表达式。                                         |
|---

**attributeUpdates** 部分示例如下：

```json

  "attributeUpdates": [
      {
        "httpMethod": "POST",
        "httpHeaders": {
          "CONTENT-TYPE": "application/json"
        },
        "timeout": 0.5,
        "tries": 3,
        "allowRedirects": true,
        "deviceNameFilter": "SD.*",
        "attributeFilter": "send_data",
        "requestUrlExpression": "sensor/${deviceName}/${attributeKey}",
        "valueExpression": "{\"${attributeKey}\":\"${attributeValue}\"}"
      }
  ]

```

### Server side RPC section

ThingsBoard allows sending [RPC commands](/docs/user-guide/rpc/) to the device that is connected to ThingsBoard directly or via Gateway.
 
本部分提供的配置用于从 ThingsBoard 向设备发送 RPC 请求。

| **参数**                 | **默认值**                                                 | **说明**                                                                       |
|:-|:-|-
| deviceNameFilter              | **SmartMeter.\***                                                 | 设备名称的正则表达式过滤，用于确定执行哪个函数。                               |
| methodFilter                  | **echo**                                                          | 方法名称的正则表达式过滤，用于确定执行哪个函数。                               |
| requestUrlExpression          | **sensor/${deviceName}/request/${methodName}/${requestId}**       | 用于创建发送 RPC 请求的 URL 地址的 JSON-path 表达式。                          |
| responseTimeout               | **0.5**                                                           | 请求超时时间。                                                                 |
| httpMethod                    | **GET**                                                           | 请求的 HTTP 方法（**GET**、**POST** 等）。                                    |
| valueExpression               | **${params}**                                                     | 用于创建发送至外部端点数据的 JSON-path 表达式。                                |
| timeout                       | **0.5**                                                           | 请求超时时间。                                                                 |
| tries                         | **3**                                                             | 发送数据的重试次数。                                                           |
| httpHeaders                   | **{ "CONTENT-TYPE": "application/json" }**                        | 包含请求额外 HTTP 头的对象。                                                   |
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
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "responseTimeout": 1,
      "httpMethod": "GET",
      "valueExpression": "${params}",
      "timeout": 0.5,
      "tries": 3,
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    },
    {
      "deviceNameFilter": ".*",
      "methodFilter": "no-reply",
      "requestUrlExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
      "httpMethod": "POST",
      "valueExpression": "${params.hum}",
      "httpHeaders": {
        "Content-Type": "application/json"
      }
    }
  ]
```

## 下一步

探索与 ThingsBoard 主要功能相关的指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据
 - [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向/从设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据
