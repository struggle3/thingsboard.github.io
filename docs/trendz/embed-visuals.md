---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 在仪表板添加 Trendz 部件
description: 在仪表板上添加 Trendz 部件
---

* TOC
{:toc}

使用 Trendz Analytics 平台创建的所有交互式可视化均可分享给其他用户，并嵌入 ThingsBoard 仪表板或外部站点。本指南将说明具体操作。

## 在 ThingsBoard 仪表板添加可视化

### 使用分享向导添加

* 点击可视化右上角的 **Share** 按钮。
* 选择是在新仪表板还是现有仪表板上添加视图。
* 选择视图应添加到的仪表板状态。
* 启用 `Create alias from filter`：如需创建用于在视图中筛选数据的仪表板别名，请启用此选项。例如，若视图显示多设备数据，可使用仪表板状态别名按设备名称筛选。别名值变更后，Trendz 视图内的筛选器会自动更新。
* 点击 Save 按钮。

### 通过直接链接添加 Trendz 视图

导入部件包并已保存 Trendz 可视化后，按以下步骤添加到仪表板：
* 在 Trendz 中打开目标可视化
* 点击 **Share** 按钮，再点击 `Copy link` 按钮，可分享 URL 将复制到剪贴板
* 打开目标 ThingsBoard 仪表板并点击 Edit 按钮
* 从 **Advanced analytics Bundle** 选择 **Advanced analytics View Static** 部件并添加到仪表板
* 切换到部件的 **Advanced** 标签页，粘贴第 1 步复制的 URL
* 保存仪表板

![image](/images/trendz/embed-trendz.gif) 

## 使用仪表板时间窗口

默认情况下，所有 Trendz 可视化使用独立时间范围。也可修改此行为，将部件配置为从 ThingsBoard 仪表板获取时间。
该选项对 Static Trendz 部件和带别名的 Trendz View 均可用。

* 打开仪表板编辑模式
* 选择目标 Trendz 部件
* 切换到 **Advanced** 标签页
* 勾选 **Use Dashboard Time Window**

## 在外网嵌入可视化
也可通过添加指向目标可视化的 iFrame 将 Trendz 可视化嵌入您的网站。

在网站中添加以下 URL 格式的 iFrame：**http://{TRENDZ_URL}/viewMode/{VIEW_ID}?jwt={JWT_TOKEN}**。其中：
* TRENDZ_URL - Trendz 服务地址
* VIEW_ID - Trendz 中已保存可视化的 ID
* JWT_TOKEN - 用于 ThingsBoard 认证的 JWT 令牌

## 视图被屏蔽问题

若 Trendz 未启用 HTTPS，分享到第三方网站或 ThingsBoard 仪表板的可视化可能为空白。

原因是多数浏览器会屏蔽混合内容请求：若 ThingsBoard 使用 HTTPS 而 Trendz 未使用，浏览器会屏蔽对 Trendz 的请求。可在浏览器控制台查看具体错误。

解决办法：为 Trendz UI 启用 HTTPS。具体步骤见 Trendz 安装指南。

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
