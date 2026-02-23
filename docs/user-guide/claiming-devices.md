---
layout: docwithnav
title: 设备 Claim
description: 使用 ThingsBoard Claiming devices 功能管理 IoT 设备

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
        title: '可在 <b>Input widgets</b> 的 <b>Static widget</b> 中找到 Device Claiming 部件。'
    1:
        image: /images/user-guide/claiming-devices/claim-device-widget.png
        title: 'Claim device 部件界面简单，可输入设备名称和 Secret Key。'
    2:
        image: /images/user-guide/claiming-devices/claim-device-widget-advanced-settings.png
        title: '可在「General settings」中隐藏 Secret Key 输入框并修改标签。'
    3:
        image: /images/user-guide/claiming-devices/claim-device-widget-message-settings.png
        title: '可在「Message settings」中配置各类用户提示消息。'
    4:
        image: /images/user-guide/claiming-devices/claim-device-widget-relation-settings.png
        title: '最后，可将 claimed 设备关联到当前 dashboard 的 state 实体。<br>适用于有多个 asset 并希望将设备关联到其中之一的情况。'
---

{% include get-hosts-name.html %}
{% include docs/user-guide/claiming-devices.md %}