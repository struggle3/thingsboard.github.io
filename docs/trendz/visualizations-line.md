---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 折线图
description: Trendz 折线图 
---

* TOC
{:toc}

## Video Tutorial

&nbsp; 
  
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/v2pZKQhiw8s" frameborder="0" allowfullscreen></iframe>
    </div>
</div>


## Simple Line Chart
Bar和Line chart有三个可配置区域：
* **X-axis**——定义chart横轴（水平轴）使用的值。通常为Raw Date字段，
  也可以是Topology中的任意字段或字段组合。
* **Y-axis**——定义chart纵轴（垂直轴）使用的值。可将多个telemetry字段拖入该区域并设置聚合。
* **Series**——使用单个或多个字段标准将数据分为多组


将Date字段放到**X-axis**，数值型telemetry放到**Y-axis**

![image](/images/trendz/simple-line.png)

## Line Chart with series

### Telemetry as series
若要显示所选设备/asset的多个telemetry字段，将所需字段加入**Y-asix**，**Series**区域留空。可使用**Filter**聚焦感兴趣的设备。

![image](/images/trendz/line-multi-telemetry.png)

### Group as series
若希望对比不同asset/设备或类别下同一telemetry的表现，在**Series**区域添加分组字段：

![image](/images/trendz/basic-line.png)

另一示例展示如何在单个区域组合多个字段。本例展示按星期几分组的各季度建筑总能耗。

![image](/images/trendz/multiple-bar.png)

## Vertical Lines
可将任意设备消息转换为事件，以垂直线形式呈现在折线图上用于分析。
这类事件以 chart 上的垂直线表示，telemetry 的值（数值或文本）作为垂直线标签显示。

* 在**Y-axis**区域添加所需telemetry字段
* 在telemetry卡片上将聚合类型设为**None**

![image](/images/trendz/line-vertical-annotation.png)

## Color Zones

![image](/images/trendz/line-background-example.png)

可在Bar和Line chart上添加颜色区域，以便直观识别特定阈值。

* 打开Setting卡片，选择Annotation。
* 从颜色面板选择数值和颜色，点击ok。
* 点击Build Report按钮。

单个可视化可添加多个颜色区域。


![image](/images/trendz/line-background-config.png)

## Mixed Charts

![image](/images/trendz/line-mixed.png)

Mixed charts在共享横轴、不同纵轴刻度的基础上叠加不同chart（每个子chart有各自的刻度）。
通常使用不同基础chart类型（如Bar和Line组合）来减少不同刻度的混淆。

当'Series'区域为空时，Trendz支持columns、lines和areas的组合。

* 打开所选telemetry的卡片
* 选择所需chart类型——**Area**、**Line**、**Bar**

![image](/images/trendz/line-mixed-config.png)

## Control Y-axis

默认情况下**Y-axis**中的每个timeseries字段使用独立轴。若chart上显示3个timeseries，则有3个不同的Y-axis。

若所有字段使用相同度量单位，可合并到单轴显示：

* 打开View Settings
* 选择**Enable single axis**

![image](/images/trendz/line-single-axis.png)

