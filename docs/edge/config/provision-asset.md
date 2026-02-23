---
layout: docwithnav-edge
title: Edge资产
description: Edge资产概述

createAssetOnEdge:
  0:
    image: /images/edge/config/edge-asset-ce/1-add-new-asset.webp
    title: '点击<b>"+"</b>按钮并选择<b>"添加新资产"</b>选项。<ul><li><b>"导入资产"</b>选项支持 <a href="/docs/user-guide/bulk-provisioning/#bulk-provisioning-overview" target="_blank">批量部署</a>（使用CSV文件）。</li></ul>'
  1:
    image: /images/edge/config/edge-asset-ce/2-fill-in-required-fields.webp
    title: '在<b>"添加资产"</b>弹出窗口中：<ul><li>在<b>"名称"</b>框中输入资产名称。</li><li>在<b>"资产配置"</b>框中选择<a href="/docs/user-guide/asset-profiles/" target="_blank">资产配置</a>（默认："default"）。</li><li>其他字段为可选项。</li><li>点击<b>"添加"</b>按钮。</li></ul>'
  2:
    image: /images/edge/config/edge-asset-ce/3-asset-provisioned-to-cloud.webp
    title: '创建后，<b>资产</b>将<b>自动配置</b>至云端。'

deviceToAsset:
  0:
    image: /images/edge/config/edge-asset-ce/4-relation-tab.webp
    title: '点击资产打开<b>"资产详情"</b>页面，选择<b>"关系"</b>选项卡。然后选择<b>"出站关系 - 方向：来自"</b>选项。'
  1:
    image: /images/edge/config/edge-asset-ce/5-add-relation.webp
    title: '要添加关系，点击<b>"+"（添加）</b>按钮。<ul><li>在<b>"添加关系"</b>弹出窗口中填写以下字段：</li><ul><li><b>关系类型：</b>选择<b>"Manages"</b>选项。</li><li><b>目标实体：</b>选择类型为<b>"设备"</b>，从下拉菜单添加相应设备。</li></ul><li>点击<b>"添加"</b>按钮。</li></ul>'
  2:
    image: /images/edge/config/edge-asset-ce/6-confirm-relations.webp
    title: '新创建的关系将显示在<b>"关系"</b>选项卡中。'

alias:
  0:
    image: /images/edge/config/edge-asset-ce/7-create-alias.webp
    title: '在仪表板<b>"编辑模式"</b>下，点击<b>"实体别名"</b>按钮创建别名。在<b>"实体别名"</b>弹出窗口中，点击<b>"添加别名"</b>按钮。'
  1:
    image: /images/edge/config/edge-asset-ce/8.1-add-alias.webp
    title: '在<b>"添加别名"</b>弹出窗口中填写以下字段：<ul><li><b>别名名称：</b>输入别名。</li><li><b>筛选类型：</b>选择<b>"Relations query"</b>选项。</li><p><b>根实体</b>块：</p><li><b>类型：</b>选择<b>"资产"</b>实体。</li><li><b>资产：</b>从下拉菜单选择资产（如<i>"Asset A"</i>）。</li><li><b>方向：</b>选择<b>"From"</b>选项。</li><li><b>最大关系层级：</b>输入表示实体关系深度的数字。</li></ul>'
  2:
    image: /images/edge/config/edge-asset-ce/8-add-alias.webp
    title: '向下滚动至<b>关系筛选器</b>块创建筛选：<ul><li>点击<b>"添加筛选器"</b>按钮添加数据筛选条件。</li><li><b>关系类型：</b>选择<b>"Manages"</b>选项。</li><li><b>实体类型：</b>选择<b>"设备"</b>实体类型。</li></ul><p>如此，由该资产管理的设备数据将显示在仪表板上。</p><p>点击<b>"添加"</b>按钮添加别名。</p>'
  3:
    image: /images/edge/config/edge-asset-ce/9-save-alias.webp
    title: '点击<b>"保存"</b>按钮保存别名。'
    
dashboard:  
  0:
    image: /images/edge/config/edge-asset-ce/10-widget-configuration.webp
    title: '选择<b>"实体别名"</b>选项卡。从下拉菜单选择<b>新创建的别名</b>作为<b>数据源</b>。点击<b>"添加"</b>按钮。'
  1:
    image: /images/edge/config/edge-asset-ce/11-result.webp
    title: '部件将显示关联设备的实时数据。'

provisioning:
  0:
    image: /images/edge/config/edge-asset-ce/12-instances-on-cloud.webp
    title: '点击<b>"管理资产"</b>按钮。'
  1:
    image: /images/edge/config/edge-asset-ce/13-edge-assets.webp
    title: '在<b>Edge资产</b>页面，点击<b>"+"</b>按钮，在<b>"分配资产至Edge"</b>弹出窗口的下拉菜单中选择要分配的资产。点击<b>"分配"</b>按钮。'
  2:
    image: /images/edge/config/edge-asset-ce/14-confirm.webp
    title: '要确认已分配的资产已在Edge上，请进入<b>实体 > 资产</b>区域。'
---

{% assign docsPrefix = "edge/" %}
{% include docs/edge/user-guide/config/edge-asset.md %}

