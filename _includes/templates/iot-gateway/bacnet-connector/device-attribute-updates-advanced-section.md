"attributeUpdates" 配置用于设置将发送到 BACnet 设备的对应属性数据格式。

| **参数** | **描述**                                    |
|---------------|----------------------------------------------------|
| key           | 平台实例上的共享属性名称。 |
| objectType    | BACnet 设备中的对象类型。                  |
| objectId      | BACnet 设备中的对象 ID。                    |
| propertyId    | BACnet 设备中的属性 ID。                  |
| ---           | ---                                                |

配置文件中该子节示例如下：

```json
"attributeUpdates": [
  {
    "key": "brightness",
    "objectType": "analogOutput",
    "objectId": 1,
    "propertyId": "presentValue"
  }
],
```

![image](/images/gateway/bacnet-connector/bacnet-subsection-attribute-updates-advanced-1-ce.png)
