本子节的配置提供将 BACnet 设备数据作为平台实例上的时序和属性进行处理的设置。

若要添加新的时序或属性 key，请按以下步骤操作：

{% assign creatingAttrAndTimeseries = '
    ===
        image: /images/gateway/bacnet-connector/bacnet-gateway-configuring-3-ce.png,
        title: 点击 "**属性**" 部分的 "**铅笔**" 图标以添加新的属性 key；
    ===
        image: /images/gateway/bacnet-connector/bacnet-gateway-configuring-4-ce.png,
        title: 在打开的窗口中点击 "**添加属性**"；
    ===
        image: /images/gateway/bacnet-connector/bacnet-gateway-configuring-5-ce.png,
        title: 输入 **key 名称**，从下拉列表选择 "Object ID" 和 "Property ID"。点击 "**应用**"；
    ===
        image: /images/gateway/bacnet-connector/bacnet-gateway-configuring-6-ce.png,
        title: 现在点击 "**时序**" 部分的 "**铅笔**" 图标以添加新的时序 key；
    ===
        image: /images/gateway/bacnet-connector/bacnet-gateway-configuring-7-ce.png,
        title: 在打开的窗口中点击 "**添加时序**"；
    ===
        image: /images/gateway/bacnet-connector/bacnet-gateway-configuring-8-ce.png,
        title: 输入 **key 名称**，从下拉列表选择 "Object ID" 和 "Property ID"。点击 "**应用**"。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingAttrAndTimeseries %}

{% capture difference %}
完整配置参数列表及其详细说明请参阅
[高级配置](/docs/iot-gateway/config/bacnet/#device-attributes-and-time-series) 部分。

更多使用示例请参阅 [示例用法](/docs/iot-gateway/config/bacnet/#usage-examples) 部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 筛选（自 v.3.7.5 起，仅在高级配置模式下可用）

您可根据对象类型 (Object Type)、对象 ID (Object ID) 和属性 ID (Property ID) 为时序和属性设置筛选。由此可指定应收集并发送到平台的数据。以下为各筛选选项说明：

**对象类型筛选**

此筛选可指定应从哪些类型的 BACnet 对象收集数据。例如，可选择仅从 "**Analog Input**" 或 "**Binary Output**" 对象类型或两者收集数据：
- `"objectType": "*"` - 从所有[支持的对象类型](/docs/iot-gateway/config/bacnet/#supported-object-types)收集数据；
- `"objectType": "analogValue"` - 仅从 Analog Value 对象收集数据；
- `"objectType": ["analogValue", "binaryInput"]` - 从 "Analog Value" 和 "Binary Input" 对象收集数据。

**对象 ID 筛选**

此筛选可指定用于数据收集的特定对象 ID。可定义单个对象 ID 或对象 ID 列表：
- `"objectId": 1234` - 仅从 ID 为 1234 的对象收集数据；
- `"objectId": "*"` - 从所有对象 ID 收集数据；
- `"objectId": "0-10"` - 从 0 到 10（含）范围内的对象 ID 收集数据；
- `"objectId": ["0-10", "12-15"]` - 从 0 到 10 和 12 到 15（含）范围内的对象 ID 收集数据。

**属性 ID 筛选**

此筛选可指定用于数据收集的特定属性 ID。可定义单个属性 ID 或属性 ID 列表：
- `"propertyId": "presentValue"` - 仅读取 "presentValue" 属性；
- `"propertyId": "*"` - 读取所有[支持的属性](/docs/iot-gateway/config/bacnet/#supported-property-identifiers)；
- `"propertyId": ["presentValue", "location"]` - 读取 "presentValue" 和 "location" 属性。

{% capture info %}
<div>
  <p>
    <b style="color:red">警告：</b>
    <span style="color:black">不允许将对象类型列表（"*" 除外）与对象 ID 范围或范围列表一起使用。</span>
  </p>
</div>
{% endcapture %}
{% include templates/warn-banner.md content=info %}

筛选配置示例：

```json
{
  "timeseries": [
    {
      "key": "${objectName} - ${objectType} | ${units}",
      "objectType": "analogInput",
      "objectId": "*",
      "propertyId": ["presentValue", "statusFlags"]
    }
  ]
}
```

{% capture difference %}
更多使用示例请参阅 [示例用法](/docs/iot-gateway/config/bacnet/#usage-examples) 部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 上报策略

对于每个时序或属性，您可启用特定的上报策略。该策略定义向 ThingsBoard 服务器发送数据的频率。可用策略如下：

- **按上报周期** - 在上报周期后向 ThingsBoard 发送数据；
- **按值变化** - 当值发生变化时向 ThingsBoard 发送数据；
- **按值变化或上报周期** - 当值发生变化或在上报周期后向 ThingsBoard 发送数据；
- **按接收** - 从设备接收数据后向 ThingsBoard 发送数据（默认策略）。

![image](/images/gateway/bacnet-connector/bacnet-gateway-configuring-10-ce.png)

{% capture difference %}
有关上报策略的更多信息请参阅[此处](/docs/iot-gateway/features-overview/report-strategy){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}
