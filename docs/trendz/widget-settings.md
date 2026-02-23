---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 部件设置
description: 部件设置说明

trendz-widget-automated-refresh:
  0:
    image: /images/trendz/trendz-widget-auto-refresh-data.png
    title: 'Trendz widget data refresh settings'

trendz-widget-filter-change-event:
  0:
    image: /images/trendz/trendz-widget-filter-change-event.png
    title: 'Trendz widget filter change event'

---
* TOC
{:toc}

## Trendz部件自动刷新

可通过配置自动刷新，按您偏好的频率更新ThingsBoard dashboard上的Trendz部件。操作步骤如下：

* 向ThingsBoard dashboard添加部件。
* 打开部件的编辑模式，进入Advanced选项卡。
* 勾选"Update data in real time"。
* 选择所需的实时数据更新间隔（以分钟为单位）。
* 保存更改。

{% include images-gallery.html imageCollection="trendz-widget-automated-refresh" %}

## 部件间共享过滤器

为提升体验和易用性，我们新增了在dashboard上的Trendz视图之间共享过滤器变更事件的能力。用法如下：

1. **设置主视图：**
   
     使用最新或静态部件向dashboard添加新Trendz视图时，编辑模式下Appearance选项卡会出现三个新字段：
   * **Broadcast filter change event：** 勾选后可将过滤器值共享给其他视图。
   * **Listen filter change event：** 为主视图外的视图勾选时，主视图过滤器变化时会更新该视图的过滤器。
   * **Filter change event name：** 所有需要同步的视图必须使用相同的过滤器变更事件名称。

2. **建立连接：**
   * 先在主视图的Appearance选项卡中勾选'Broadcast filter change event'，将过滤器值共享给其他视图。
   * 再为需要跟随主视图过滤器变化的视图勾选'Listen filter change event'。
   * 确保所有连接的视图使用相同的Filter change event name以保持同步。

{% include images-gallery.html imageCollection="trendz-widget-filter-change-event" %}

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
