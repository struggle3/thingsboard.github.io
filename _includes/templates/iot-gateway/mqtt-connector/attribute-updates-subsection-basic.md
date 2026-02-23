要添加新的 attribute update 映射，请按以下步骤操作：

{% assign AttributesUpdate = '
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-11-ce.png,
        title: 在 "**Requests mapping**" 部分点击 "**Add mapping**" 以添加新的 attribute 更新映射。
    ===
        image: /images/gateway/mqtt-connector/mqtt-attribute-updates-1.png,
        title: 在 **Request type** 字段选择 "**Attribute update**"，输入 "**Device name filter**"
    ===
        image: /images/gateway/mqtt-connector/mqtt-attribute-updates-2.png,
        title: 配置 **Attribute filter**、**Response value expression** 和 **Response topic expression** 字段。
        还可设置 **Retain** 选项以决定 attribute 响应消息是否由 MQTT broker 保留。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=AttributesUpdate %}
