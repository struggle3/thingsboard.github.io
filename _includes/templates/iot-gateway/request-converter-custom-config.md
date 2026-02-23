Custom converter 是为特定设备编写的 converter：



|**参数**|**默认值**|**说明**|
|:-|:-|-
| type                        | **custom**                         | 指示 connector 使用 custom converter 转换响应数据。                                  |
| extension                   | **CustomRequestUplinkConverter**   | Custom converter 类名。                                                                                                       |
| extension-config            |                                    | 本小节为 custom converter 的配置。默认示例中包含解析响应字符串的设置。      |
| key                         | **Totaliser**                      | 本例中值 "Totaliser" 将作为 ThingsBoard 实例中的 telemetry key 解释。                                     |
| type                        | **float**                          | 本例中数据的类型。                                                                                                     |
| fromByte                    | **0**                              | 本例中响应字符串的起始字节位置。                                                                           |
| toByte                      | **4**                              | 本例中响应字符串的结束字节位置。                                                                           |
| byteorder                   | **big**                            | 本例中响应字符串的字节序。                                                                                        |
| signed                      | **true**                           | 本例中用于表示响应中的数据是否为有符号数。                                                                     |
| multiplier                  | **1**                              | 本例中响应中的每个数据应乘以的系数。                                                 | 
|--- 

{% capture difference %}
<br>
  
**当需要从未采用常规响应结构的设备采集数据，或数据在发送到 ThingsBoard 前需处理时，通常需要 custom converter。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}


配置中的 Mapping subsection 将如下所示：
```json
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
```
