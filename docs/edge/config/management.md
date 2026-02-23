---
layout: docwithnav-edge
title: Edge管理
description: Edge管理

downlinks:
    0:
        image: /images/edge/edge-management/0-downlinks.webp

forceSync:
    0:
        image: /images/edge/edge-management/1-force-sync.webp

instancesSection:
    0:
        image: /images/edge/edge-management/2-instances.webp
        title: '可管理以下<a href="/docs/pe/user-guide/entities-and-relations/" target="_blank">实体</a>及事件：<ul><li><b>设为公开：</b>Edge及其所有数据将对其他用户可见。</li><li><b>分配给客户：</b>将特定客户实体关联到Edge实例。</li><li><b>设为私有：</b>Edge及其所有数据将不对其他用户可见。</li><li><b>管理资产：</b>在Edge上监控和控制资产（如建筑物、设备或其他实体）。</li><li><b>管理设备：</b>管理由Edge管理的设备。</li><li><b>管理实体视图：</b>管理Edge上实体的筛选视图以显示特定数据子集或上下文信息。详见<a href="/docs/user-guide/entity-views/" target="_blank">此文</a>。</li><li><b>管理仪表板：</b>自定义和管理Edge上的仪表板。</li><li><b>管理规则链：</b>为Edge创建、配置和管理规则链。</li><li><b>删除：</b>移除Edge及所有相关数据。</li></ul>'

edgeDetails:
    0:
        image: /images/edge/edge-management/3-edge-details.webp

edgeStatus:
    0:
        image: /images/edge/edge-management/4-edge-status.webp
        title: '<b>状态：</b>Edge当前状态（已连接、已断开）。<li><b>名称：</b>当前Edge实例的名称。</li><li><b>ID：</b>当前Edge实例的识别码。</li><li><b>类型：</b>“default” Edge类型为设计如此。</li><li><b>路由键：</b>用于安装实例的Edge密钥。</li><li><b>最近连接/断开云端时间：</b>实例连接/断开云端的日期时间，格式为 YYYY-MM-DD H:Min:Sec。</li>'

cloudEvenets:
    0:
        image: /images/edge/edge-management/5-cloud-events.webp

---

{% assign docsPrefix = "edge/" %}
{% include /docs/edge/user-guide/edge-management.md %}
