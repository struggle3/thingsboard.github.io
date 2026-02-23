此转换器专为二进制 payload 设计，通过解释二进制数据并利用特定字节位置提取数据，从而获取属性和时序数据。

| **参数**  | **描述**                                                                                                |
|----------------|----------------------------------------------------------------------------------------------------------------|
| timeseries     | 该子节包含将被解释为设备时序数据的设备数据参数。 |
| ... key        | 平台中的时序名称。                                                                           |
| ... objectType | BACnet 设备中的对象类型。                                                                              |
| ... objectId   | BACnet 设备中的对象 ID。                                                                                |
| ... propertyId | BACnet 设备中的属性 ID。                                                                              |
| attributes     | 该子节包含将被解释为设备属性的设备数据参数。 |
| ... key        | 平台中的属性名称。                                                                            |
| ... objectType | BACnet 设备中的对象类型。                                                                              |
| ... objectId   | BACnet 设备中的对象 ID。                                                                                |
| ... propertyId | BACnet 设备中的属性 ID。                                                                              |
| ---            | ---                                                                                                            |

示例：

```json
"timeseries": [
  {
    "key": "temperature",
    "objectType": "analogInput",
    "objectId": 2,
    "propertyId": "presentValue"
  }
],
"attributes": [
  {
    "key": "voltage",
    "objectType": "analogInput",
    "objectId": 1,
    "propertyId": "presentValue"
  }
],
```

{% assign deviceAttrTimeseriesAdvanced = '
    ===
        image: /images/gateway/bacnet-connector/bacnet-subsection-time-series-advanced-1-ce.png,
    ===
        image: /images/gateway/bacnet-connector/bacnet-subsection-attributes-advanced-1-ce.png
    '
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=deviceAttrTimeseriesAdvanced %}
