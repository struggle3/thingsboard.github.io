---
layout: docwithnav
assignees:
- ashvayka
title: IoT 设备属性管理
description: 使用 ThingsBoard 属性功能管理 IoT 设备
server-side-attrs-ui:
    0:
        image: /images/user-guide/attributes/add-server-side-ce-src.png
        title: '进入 Entities → Devices，点击要编辑的设备行打开详情。在设备详情中打开「Attributes」选项卡，选择「Server attributes」scope，点击「+」添加新属性。'
    1:
        image: /images/user-guide/attributes/add-server-side-ce2-src.png
        title: '在弹窗中输入 attribute key，选择 value type（如 String），并填写 value。'
    2:
        image: /images/user-guide/attributes/add-server-side-ce3-src.png
        title: '保存后，新属性将出现在列表中，包含 key、value 和 last update time。可按「Last update time」排序快速找到新建属性。'

shared-attrs-ui:
    0:
        image: /images/user-guide/attributes/add-shared-ce-src.png
        title: '进入 Entities → Devices，点击要编辑的设备行打开详情。在设备详情中打开「Attributes」选项卡，选择「Shared attributes」scope，点击「+」添加新属性。'
    1:
        image: /images/user-guide/attributes/add-shared-ce2-src.png
        title: '在弹窗中输入 attribute key，选择 value type（如 Double），并填写 value。'
    2:
        image: /images/user-guide/attributes/add-shared-ce3-src.png
        title: '保存后，新属性将出现在列表中，包含 key、value 和 last update time。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/attributes.md %}
