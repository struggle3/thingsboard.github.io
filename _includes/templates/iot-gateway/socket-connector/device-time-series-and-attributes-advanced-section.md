本 converter 面向二进制 payload。它直接解析二进制数据以获取 attribute 和 time series，使用特定字节位置进行数据提取。

| **参数** | **默认值** | **说明**                                                                                                      |
|:--------------|:------------------|----------------------------------------------------------------------------------------------------------------------|
| telemetry     |                   | 本小节包含消息中将被解释为设备 telemetry 的参数。   |
| ... key       | **temp**          | ThingsBoard 中 telemetry 的名称。                                                                                   |
| ... byteFrom  | **0**             | 用于从指定索引开始切片接收数据。                                                                 |
| ... byteTo    | **-1**            | 用于切片接收数据到指定索引。                                                                   |
| attributes    |                   | 本小节包含请求中将被解释为设备 attribute 的参数。 |
| ... key       | **hum**           | ThingsBoard 中 attribute 的名称。                                                                                   |
| ... byteFrom  | **2**             | 用于从指定索引开始切片接收数据。                                                                 |
| ... byteTo    | **4**             | 用于切片接收数据到指定索引。                                                                   |
| ---           |                   |                                                                                                                      |

attributes 部分使用与 telemetry 部分相同的参数。

示例：
```json
{
  "address": "127.0.0.1:50001",
  "deviceName": "Device Example",
  "deviceType": "default",
  "encoding": "utf-8",
  "telemetry": [
    {
      "key": "temp",
      "byteFrom": 0,
      "byteTo": -1
    },
    {
      "key": "hum",
      "byteFrom": 0,
      "byteTo": 2
    }
  ],
  "attributes": [
    {
      "key": "name",
      "byteFrom": 0,
      "byteTo": -1
    },
    {
      "key": "num",
      "byteFrom": 2,
      "byteTo": 4
    }
  ]
}
```

{% assign deviceAttrTimeseriesAdvanced = '
    ===
        image: /images/gateway/socket-connector/socket-subsection-time-series-advanced-1-ce.png,
    ===
        image: /images/gateway/socket-connector/socket-subsection-attributes-advanced-1-ce.png
    '
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=deviceAttrTimeseriesAdvanced %}
