Custom converter 是为特定设备编写的 converter：



| **参数**                 | **默认值**             | **说明**                                                                                                                 |
|:------------------------------|:------------------------------|---------------------------------------------------------------------------------------------------------------------------------
| type                          | **custom**                    | 指示 connector 使用 custom converter 转换请求数据。                          |
| deviceNameExpression          | **SuperAnonDevice**           | 设备名称。                                                                                                                    |
| deviceNameExpressionSource    | **constant**                  | 设备名称来源。                                                                                                             |
| deviceProfileExpressionSource | **constant**                  | Device profile 来源。可为 constant 或 request。                                                                           |
| deviceProfileExpression       | **default**                   | Device profile 名称。可为 constant 或 request。                                                                                                           |
| extension                     | **CustomRESTUplinkConverter** | 自定义 converter 类名。                                                                                                 |
| extension-config              |                               | Custom converter 的配置（可放置任意内容，初始化时会传递给 converter 对象）。 |
| key                           | **Totaliser**                 |                                                                                                                                 |
| datatype                      | **float**                     |                                                                                                                                 |
| fromByte                      | **0**                         |                                                                                                                                 |
| toByte                        | **4**                         |                                                                                                                                 |
| byteorder                     | **big**                       |                                                                                                                                 |
| signed                        | **true**                      |                                                                                                                                 |
| multiplier                    | **1**                         |                                                                                                                                 | 
| ---                           

{% capture difference %}
  
**当需要从未采用常规响应结构的设备采集数据，或数据在发送到 ThingsBoard 前需处理时，通常需要 custom converter。**  
{% endcapture %}  
{% include templates/info-banner.md content=difference %}  

**注意：置于 "converter" 部分的全部内容将作为配置传递给 custom converter。**  

配置中的 Mapping subsection 如下所示：  

```json
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
```
{: .copy-code}
