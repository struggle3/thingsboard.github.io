要添加新的 attribute request 映射，请按以下步骤操作：

{% assign AttributesRequest = '
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-11-ce.png,
        title: 在 "**Requests mapping**" 部分点击 "**Add mapping**" 以添加新的 attribute request 映射。
    ===
        image: /images/gateway/mqtt-connector/mqtt-attribute-requests-1.png,
        title: 在 **Request type** 字段选择 "**Attribute request**"，输入 "**Topic filter**"
    ===
        image: /images/gateway/mqtt-connector/mqtt-attribute-requests-2.png,
        title: 配置 **Device name expression**、**Response topic expression** 和 **Attribute name expression** 字段。 
        为每个字段选择来源类型（`Message`、`Topic` 或 `Constant`）并输入对应值。 
        还可设置 **Retain** 选项以决定 attribute 响应消息是否由 MQTT broker 保留。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=AttributesRequest %}
