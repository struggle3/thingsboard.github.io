![image](/images/gateway/modbus-connector/values-subsection-1-ce.png)

{% capture difference %}
所有配置参数列表及详细说明请参见[高级配置](/docs/iot-gateway/config/modbus/#device-rpc-methods)部分。

更多使用示例请参见[使用示例](/docs/iot-gateway/config/modbus/#usage-examples-2)部分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

要向网关 slave 添加新值，请按以下步骤操作：

{% assign maxTemperatureAttribute = '
    ===
        image: /images/gateway/modbus-connector/add-new-value-to-gateway-slave-1-ce.png,
        title: 在所选部分的行中点击 "**pencil**"（铅笔）图标；
    ===
        image: /images/gateway/modbus-connector/add-new-value-to-gateway-slave-2-ce.png,
        title: 在打开的窗口中点击 "**Add attribute**" 或其他（取决于所选部分）；
    ===
        image: /images/gateway/modbus-connector/add-new-value-to-gateway-slave-3-ce.png,
        title: 填写 key、type、function code、objects count、address 和 value 字段。点击 "Apply"。
'
%}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=maxTemperatureAttribute %}