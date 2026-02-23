Json converter 是默认 converter，根据本小节所述规则，在来自 broker 的消息中查找 deviceName、deviceType、attribute 和 telemetry：

| **参数**             | **默认值**     | **说明**                                                                                                                                                                                                                       |
|:--------------------------|:----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| type                      | **json**              | 指示 connector 使用默认 converter 转换响应数据。                                                                                                                              |
| deviceNameJsonExpression  | **SD8500**            | 用于在消息中查找设备名称的简单 JSON 表达式（字符串 "SD8500" 将作为设备名称使用）。                                                                                                           |
| deviceTypeJsonExpression  | **SD**                | 用于在消息中查找设备类型的简单 JSON 表达式（字符串 "SD" 将作为设备类型使用）。                                                                                                               |
| timeout                   | **60000**             | 触发"设备断开"事件的超时时间                                                                                                                                                                                    |
| attributes                |                       | 本小节包含消息中将被解释为设备 attribute 的参数。                                                                                                                   |
| ... type                  | **string**            | 当前 attribute 的输入数据类型。                                                                                                                                                                                        |
| ... key                   | **serialNumber**      | 将发送到 ThingsBoard 实例的 attribute 名称。                                                                                                                                                                              |
| ... value                 | **${serial}**         | 用于在消息中查找 value 的简单 JSON 表达式，将作为 key 参数的值发送到 ThingsBoard 实例。                                                                                             |
| timeseries                |                       | 本小节包含消息中将被解释为设备 telemetry 的参数。                                                                                                                    |
| ... type                  | **string**            | 当前 telemetry 的输入数据类型。                                                                                                                                                                                        |
| ... key                   | **Maintainer**        | 将发送到 ThingsBoard 实例的 telemetry 名称。                                                                                                                                                                              |
| ... value                 | **${Developer}**      | 用于在消息中查找 value 的简单 JSON 表达式，将作为 key 参数的值发送到 ThingsBoard 实例。                                                                                             |
| ... type                  | **integer**           | 当前 telemetry 的输入数据类型。                                                                                                                                                                                        |
| ... key                   | **Pressure**          | 将发送到 ThingsBoard 实例的 telemetry 名称。                                                                                                                                                                              |
| ... value                 | **${press}**          | 用于在消息中查找 value 的简单 JSON 表达式，将作为 key 参数的值发送到 ThingsBoard 实例。                                                                                             |
| ... tsField               | **${timestampField}** | **可选。** 携带日期时间字符串的字段的 JSON-path 表达式。若未指定，将使用消息中的 `ts` 或 `timestamp` 作为数据条目时间戳。                                       |                                                                                                                     
| ... dayfirst              | **false**             | **可选。** 指明第一个数字为**日**（`DD.MM.YY HH:mm:ss.SSS`）。<br>• `false` → `10.11.24 10:10:10.252` → **2024年10月11日 10:10:10.252** <br>• `true`  → `10.11.24 10:10:10.252` → **2024年11月10日 10:10:10.252** |
| ... yearfirst             | **false**             | **可选。** 指明第一个数字为**年**（`DD.MM.YY HH:mm:ss.SSS`）。<br>• `false` → 遵循 `dayfirst` 规则<br>• `true`  → `10.11.24 10:10:10.252` → **2010年11月24日 10:10:10.252**                                |
| ---                       

{% capture difference %}
**attributes 和 telemetry 部分的参数可能与上述不同，但结构相同。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}


Mapping subsection 将如下所示：

```json
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
            "value": "${press}",
            "tsField": "${timestampField}",
            "dayfirst": true
          }
        ]
      }
    }
```

{% capture tsField %}
**说明**：`Pressure` telemetry key 的 **Mapping subsection** 配置示例了 `tsField` 与 `dayfirst` 选项的用法。
{% endcapture %}
{% include templates/info-banner.md content=tsField %}

此外，可在 attribute、telemetry 和 serverSideRpc 部分组合 HTTP 请求中的值，例如：
```json
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
        "attributes": [],
        "telemetry": [
          {
            "type": "double",
            "key": "temperature",
            "value": "${temp}"
          },
          {
            "type": "double",
            "key": "humidity",
            "value": "${hum}"
          },
          {
            "type": "string",
            "key": "combine",
            "value": "${hum}:${temp}"
          }
        ]
      }
    }
```
