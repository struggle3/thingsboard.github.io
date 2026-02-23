---
layout: docwithnav-edge
title: 云端事件
description: 云端事件
cloudEvents:
    0:
        image: /images/edge/cloud-events.png
---

**云端事件**页面显示ThingsBoard Edge推送到云端的事件。

{% include images-gallery.html imageCollection="cloudEvents" %}

查看**状态**列以了解事件是否已推送到云端。
共有两种状态类型：
* **已部署** - 事件已推送到ThingsBoard CE/PE服务器。
* **待处理** - 事件已在ThingsBoard Edge上创建并存储至本地数据库，将在连接恢复后推送到云端。

可能的云端操作列表：
* 添加
* 删除
* 更新
* 属性已更新
* 属性已删除
* 时序已删除
* 时序已更新
* RPC调用
* 凭据已更新
* 关系添加或更新
* 关系已删除
* 关系已批量删除
* 告警确认
* 告警清除
* 属性请求
* 规则链元数据请求
* 关系请求
* 凭据请求

## 下一步

{% assign currentGuide = "CloudEvents" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}
