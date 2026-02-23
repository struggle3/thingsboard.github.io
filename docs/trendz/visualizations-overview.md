---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 可视化概览
description: Trendz Analytics 内置可视化类型 
---

Trendz为IoT数据分析提供主要可视化类型。

* [**Tables**](/docs/trendz/visualizations-tables)
* [**Line Chart**](/docs/trendz/visualizations-line)
* [**Bar Chart & Histogram**](/docs/trendz/visualizations-bar)
* [**Pie Chart**](/docs/trendz/visualizations-pie)
* [**Scatter Plot**](/docs/trendz/visualizations-scatter)
* [**Heat Map**](/docs/trendz/visualizations-heatmap)
* [**Calendar**](/docs/trendz/visualizations-calendar)
* [**Card**](/docs/trendz/visualizations-card)

## First visualisation

<div class="image-block">
    <div class="image-wrapper">
       <video poster="/images/trendz/simple-line.png" autoplay="" loop="" preload="auto" muted="" style="width: 750px">
            <source src="https://tb-videos.s3-us-west-1.amazonaws.com/trndz-first-view.webm" type="video/webm">                 
        </video> 
    </div>
</div>

* 打开Trend UI首页，点击**Create View**按钮
* 选择**Line** chart
* 从左侧导航面板选择**Date**字段，拖放到**X axis**区域
* 从左侧导航面板选择任意telemetry字段，拖放到**Y axis**区域

此时将看到ThingsBoard中所有实体的平均测量值

* 将**Entity Name**添加到**Series**区域——每个实体将显示为独立series

## Video Tutorial

我们很高兴呈现关于ThingsBoard Trendz Analytics功能的系列网络研讨会。
了解更多Trendz Analytics特性，以及如何将IoT数据转化为价值以支持决策。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/8a4cPI-XOkI" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## Next Steps

{% assign currentGuide = "AvailableVisualizations" %}{% include templates/trndz-guides-banner.md %}
