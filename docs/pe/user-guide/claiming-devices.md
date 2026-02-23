---
layout: docwithnav-pe
title: 认领设备
description: 使用 ThingsBoard 设备认领功能进行 IoT 设备管理

device-claiming-permissions-in-pe-carousel:
    0:
        image: /images/user-guide/claiming-devices/claiming-generic-role.png
        title: '创建通用角色。'
    1:
        image: /images/user-guide/claiming-devices/assign-claiming-role.png
        title: '将该角色分配给用户组。'
device-claiming-widget-carousel:
    0:
        image: /images/user-guide/claiming-devices/claiming-widget-location.png
        title: '您可在<b>输入部件</b>的<b>静态部件</b>部分找到设备认领部件。'
    1:
        image: /images/user-guide/claiming-devices/claim-device-widget.png
        title: '认领设备部件较为简洁，可输入设备名称和密钥。'
    2:
        image: /images/user-guide/claiming-devices/claim-device-widget-advanced-settings.png
        title: '可在「常规设置」中「隐藏」密钥输入框并修改标签。'
    3:
        image: /images/user-guide/claiming-devices/claim-device-widget-message-settings.png
        title: '也可在「消息设置」中配置面向用户的各种消息。'
    4:
        image: /images/user-guide/claiming-devices/claim-device-widget-relation-settings.png
        title: '最后，您可将认领的设备关联到仪表板的当前实体。<br>若您有多个资产并希望将设备关联到其中之一，这很有用。'
---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/claiming-devices.md %}