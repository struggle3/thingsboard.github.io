要添加新的 disconnect request 映射，请按以下步骤操作：

{% assign DisconnectRequest = '
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-configuring-11-ce.png,
        title: 在 "**Requests mapping**" 部分点击 "**Add mapping**" 以添加新的 disconnect request 映射。
    ===
        image: /images/gateway/mqtt-connector/mqtt-gateway-disconnect-configuring-12-ce.png,
        title: 在 **Request type** 字段选择 "**Disconnect request**"，输入 "**Topic filter**"，并为 **Name** 字段选择来源类型（`Message`、`Topic` 或 `Constant`）。根据所选来源类型输入对应的 [json path](/docs/iot-gateway/config/mqtt/#json-path)、[regex](/docs/iot-gateway/config/mqtt/#regular-expressions) 或常量值。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=DisconnectRequest %}
