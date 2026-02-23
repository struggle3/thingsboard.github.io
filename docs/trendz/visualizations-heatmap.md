---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 热力图
description: Trendz 热力图 
---

* TOC
{:toc}

Heatmap是描述可重复模式、发现离群点的简便方式之一。与表格类似，但单元格根据数值以不同颜色高亮。
* **X axis**——定义表格列（横轴）
* **Y axis**——定义表格行（纵轴）
* **Value**——定义单元格值

## Video Tutorial

&nbsp; 
  
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/XJjC3xdTJq4" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## Day, Week, Month Heat Maps

时间范围旁的**By**字段为heat map提供若干预定义模板：
* Hour VS Day of Week
* Minute VS Hour
* Day Vs Month
* Hor VS Day of Month

示例展示每周能耗模式，可知哪天何时能耗最高。

![image](/images/trendz/heat-week-pattern.png) 

## Custom Axis 

可按场景自由配置，将所需字段作为Heat Map的维度。

示例展示：
* 每栋公寓作为独立行
* 每列代表一年中的月份
* 总能耗作为单元格值
 
便于识别离群点及其变化趋势。

![image](/images/trendz/complex-heatmap.png) 
