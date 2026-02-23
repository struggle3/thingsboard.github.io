Json converter 是默认 converter，根据本小节所述规则，在来自客户端的请求中查找 deviceName、deviceType、attribute 和 telemetry：

| **参数**                 | **默认值**     | **说明**                                                                                                                                                                                                                                          |
|:------------------------------|:----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| type                          | **json**              | 指示 connector 使用默认 converter 转换来自请求的数据。                                                                                                                                     | 
| deviceNameExpression          | **Device ${name}**    | 用于构建设备名称的 JSON 表达式。本例中，connector 从请求 payload 的 name 字段取值，生成如 Device SensorA 的设备名称                                                                      |
| deviceNameExpressionSource    | **request**           | 定义 **deviceNameExpression** 的值来源：`request` 表示从请求 payload 读取；`constant` 表示将表达式视为固定值（不解析 payload）。                                   |
| deviceProfileExpressionSource | **request**           | 定义 **deviceProfileExpression** 的值来源：`request` 表示从请求 payload 读取；`constant` 表示将表达式作为固定值使用。                                                       |
| deviceProfileExpression       | **default**           | 用于解析 device profile 名称的 JSON 表达式。`default` 表示 connector 将设备分配到默认 profile（或当 **deviceProfileExpressionSource** 为 `request` 且表达式引用某字段时使用该 payload 字段）。 |
| attributes                    |                       | 本小节包含请求中将被解释为设备 attribute 的参数。                                                                                                                                     |
| ... type                      | **string**            | 当前 attribute 的输入数据类型。                                                                                                                                                                                                           |
| ... key                       | **model**             | 用于在输入数据中查找 key 的简单 JSON 表达式，将作为 attribute key 发送到 ThingsBoard 实例。                                                                                                                              |
| ... value                     | **${sensorModel}**    | 用于在输入数据中查找 value 的简单 JSON 表达式，将作为 key 参数的值发送到 ThingsBoard 实例。                                                                                                                   |
| timeseries                    |                       | 本小节包含消息中将被解释为设备 telemetry 的参数。                                                                                                                                       |
| ... type                      | **double**            | 当前 telemetry 的输入数据类型。                                                                                                                                                                                                           |
| ... key                       | **temperature**       | 用于在输入消息中查找 key 的简单 JSON 表达式，将作为 attribute key 发送到 ThingsBoard 实例。                                                                                                                           |
| ... value                     | **${temp}**           | 用于在输入消息中查找 value 的简单 JSON 表达式，将作为 key 参数的值发送到 ThingsBoard 实例。                                                                                                                |
| ... tsField                   | **${timestampField}** | **可选。** 携带日期时间字符串的字段的 JSON-path 表达式。若未指定，将使用输入消息中的 `ts` 或 `timestamp` 作为数据条目时间戳。                                                          |                                                                                                                     
| ... dayfirst                  | **false**             | **可选。** 指明第一个数字为**日**（`DD.MM.YY HH:mm:ss.SSS`）。<br>• `false` → `10.11.24 10:10:10.252` → **2024年10月11日 10:10:10.252** <br>• `true`  → `10.11.24 10:10:10.252` → **2024年11月10日 10:10:10.252**                    |
| ... yearfirst                 | **false**             | **可选。** 指明第一个数字为**年**（`DD.MM.YY HH:mm:ss.SSS`）。<br>• `false` → 遵循 `dayfirst` 规则<br>• `true`  → `10.11.24 10:10:10.252` → **2010年11月24日 10:10:10.252**                                                   |
| ---                           

{% capture difference %}
**attributes 和 telemetry 部分的参数可能与上述不同，但结构相同。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}

此外，使用 `json` converter 时也可发送 **multipart/form-data** 请求，无需额外配置。
REST connector 会将 multipart 字段合并为单一键值对象，因此可像 **application/json** 一样引用。

以下是两个等效请求示例。第一个以 `application/json` 发送数据：

```json
{
  "name": "SensorA",
  "sensorModel": "TX100",
  "temp": 23.5,
  "hum": 56.2,
  "timestampField": "10.11.24 14:30:00.000"
}
```
使用 POST 方法、Basic 认证凭据（user / passwd）向 `/test_device` 端点发送该请求：

```bash
curl -X POST http://127.0.0.1:5000/test_device \
  -H "Content-Type: application/json" \
  -u username:password \
  -d '{
        "name": "SensorA",
        "sensorModel": "TX100",
        "temp": 23.5,
        "hum": 56.2,
        "timestampField": "10.11.24 14:30:00.000"
      }'
```
{: .copy-code}

也可使用 `multipart/form-data` 请求达到相同效果，每个字段作为独立 part 发送。
注意：使用 `curl -F` 时，`curl` 会自动设置 `Content-Type: multipart/form-data; boundary=...` 头。

```bash
curl -X POST "http://127.0.0.1:5000/test_device" \
  -u "username:password" \
  -F 'name=SensorA' \
  -F 'sensorModel=TX100' \
  -F 'temp=23.5' \
  -F 'hum=56.2' \
  -F 'timestampField=10.11.24 14:30:00.000'
```
{: .copy-code}

{% capture difference %}
**说明：**
1. 设备 attribute 或 telemetry **不支持文件上传**。若 multipart 请求包含文件 part，网关将忽略并记录信息日志。
2. **Multipart 表单字段以字符串接收。** 将根据 `json` converter 中配置的字段类型转换为 boolean、integer 或 double。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

上述两个示例的 mapping 配置小节如下所示：

```json
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
      "deviceProfileExpressionSource": "request",
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
        "value": "${hum}",
        "tsField": "${timestampField}",
        "dayfirst": true
      }
    ]
  }
}
```
{: .copy-code}

{% capture tsField %}
**说明**：`humidity` telemetry key 的 **Mapping subsection** 配置示例了 `tsField` 与 `dayfirst` 选项的用法。
{% endcapture %}
{% include templates/info-banner.md content=tsField %}

此外，可在 attribute、telemetry 和 serverSideRpc 部分组合 HTTP 请求中的值，例如：

```json
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
      "deviceProfileExpressionSource": "request",
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
}
```
{: .copy-code}
