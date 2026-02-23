---
layout: docwithnav-edge
title: Edge信息页面
description: Edge信息页面
edgeInfo:
    0:
        image: /images/edge/edge-status.png
---

**Edge信息**页面用于提供基本Edge配置及ThingsBoard CE服务器信息（URL和服务器版本）：
* 名称、ID、类型、路由键
* 与云端的连接状态：**已连接 / 已断开**
* 最近连接/断开云端时间

{% include images-gallery.html imageCollection="edgeInfo" %}

## 下一步

{% assign currentGuide = "EdgeStatus" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}
