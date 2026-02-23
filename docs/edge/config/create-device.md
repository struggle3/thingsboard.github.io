---
layout: docwithnav-edge
title: Edge设备管理
description: 在Edge上创建设备并分配至云端

create-device:
    0:
        image: /images/edge/config/devices/0-go-to-devices-section.webp
        title: '拥有<b>租户管理员</b>权限的用户可在<b>Edge实例</b>上创建<b>设备</b>实体。进入<b>实体 > 设备</b>区域，点击<b>"添加新设备"</b>按钮。'
    1:
        image: /images/edge/config/devices/1-add-new-device.webp
        title: '在弹出窗口中填写必填的<b>设备详情</b>字段，如<b>"名称"</b>和<b>"设备配置"</b>，点击<b>"添加"</b>按钮确认。'
    2:
        image: /images/edge/config/devices/2-check-connectivity.webp
        title: '要检查连接性，请按屏幕提示使用shell代表该<b>设备</b>发送遥测数据。'
    3:
        image: /images/edge/config/devices/3-confirm-on-cloud.webp
        title: '要确认新<b>设备</b>是否已部署到<b>云端（服务器）</b>，请登录<b>云端（服务器）</b>并进入<b>实体 > 设备</b>区域：新创建的<b>设备</b>将自动分配至<b>云端（服务器）</b>。'

assignment-from-cloud:
    0:
        image: /images/edge/config/devices/0-assignment-from-cloud.webp
        title: '<b>"实例"</b>页面上的多种按钮可帮助您管理各类<a href="/docs/user-guide/entities-and-relations/" target="_blank">实体</a>并分配给<b>Edge实例</b>。要分配<b>设备</b>，请点击<b>"管理设备"</b>按钮。'
    1:
        image: /images/edge/config/devices/1-assign-devices-from-cloud.webp
        title: '在<b>"Edge设备"</b>页面，点击<b>"+"</b>图标，从弹出窗口的下拉列表中选择<b>设备</b>，点击<b>"分配"</b>按钮确认。'
    2:
        image: /images/edge/config/devices/2-confirm-on-edge.webp
        title: '要确认<b>设备</b>已分配至<b>Edge实例</b>，请登录<b>Edge实例</b>并进入<b>实体 > 设备</b>区域。'

---

{% assign docsPrefix = "edge/" %}
{% include docs/edge/user-guide/config/device-on-edge.md %}

