---
layout: docwithnav-pe
assignees:
- ashvayka
title: 使用 IoT 设备属性
description: 使用 ThingsBoard 属性功能进行 IoT 设备管理 
server-side-attrs-ui:
    0:
        image: /images/user-guide/attributes/add-server-side-pe-src.png
        title: '进入实体 → 设备，点击要编辑的设备行打开设备详情。在设备详情中打开「属性」选项卡，选择「服务端属性」范围，点击「+」图标添加新属性。'
    1:
        image: /images/user-guide/attributes/add-server-side-pe2-src.png
        title: '在对话框中输入属性键、选择值类型（例如字符串）并填写值。'
    2:
        image: /images/user-guide/attributes/add-server-side-pe3-src.png
        title: '保存后，新属性将出现在列表中，并显示其键、值和最后更新时间。可使用「最后更新时间」排序快速定位新创建的属性。'

shared-attrs-ui:
    0:
        image: /images/user-guide/attributes/add-shared-pe-src.png
        title: '进入实体 → 设备，点击要编辑的设备行打开设备详情。在设备详情中打开「属性」选项卡，选择「共享属性」范围，点击「+」图标添加新属性。'
    1:
        image: /images/user-guide/attributes/add-shared-pe2-src.png
        title: '在对话框中输入属性键、选择值类型（例如双精度）并填写值。'
    2:
        image: /images/user-guide/attributes/add-shared-pe3-src.png
        title: '保存后，新属性将出现在列表中，并显示其键、值和最后更新时间。'

---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/attributes.md %}