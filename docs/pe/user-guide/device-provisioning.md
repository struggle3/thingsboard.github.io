---
layout: docwithnav-pe
title: 设备预配置
description: 使用 ThingsBoard 设备预配置功能进行 IoT 设备管理
deviceProfileConfiguration:
    0:
        image: /images/user-guide/device-provisioning/device-provisioning-step-1.png 
        title: '您可创建新设备档案或打开现有档案。创建新档案时，请打开设备档案页面并点击表头的「+」图标。'
    1:
        image: /images/user-guide/device-provisioning/device-provisioning-step-2.png 
        title: '输入新设备档案名称并点击「添加设备档案」向导的第 4 步。本例使用「Device Provisioning Test」作为名称，通常应为您的设备型号或类似名称。' 
    2:
        image: /images/user-guide/device-provisioning/device-provisioning-step-3.png 
        title: '选择预配置策略之一，复制预配置密钥和密钥，最后点击「添加」。' 
         
---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/device-provisioning.md %}