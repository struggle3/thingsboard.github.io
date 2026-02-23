要添加新的 attribute 更新，请按以下步骤操作：

{% assign attrUpdates = '
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-11-ce.png,
        title: 在 "**Attribute updates**" 部分点击 "**pencil**"（铅笔）图标以添加新的 attribute 更新；
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-12-ce.png,
        title: 在打开的窗口中点击 "**Add attribute update**"（添加 attribute 更新）；
    ===
        image: /images/gateway/opc-ua-connector/opc-ua-gateway-configuring-13-ce.png,
        title: 填写 "**Key**" 字段，选择 "**Type**"（可为 [path](#path-types)、[identifier](#identifier-types) 或 constant），填写 "**Value**" 并点击 "**Apply**" 按钮。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attrUpdates %}
