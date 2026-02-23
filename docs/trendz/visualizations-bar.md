---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 柱状图与直方图
description: 柱状图与直方图
---

* TOC
{:toc}

Bar chart基础详情见[Line Chart Configuration](/docs/trendz/visualizations-line/)
Line和Bar chart的核心概念相同。本教程侧重差异说明。

## Video Tutorial

&nbsp; 
  
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/Sc6vySTadCQ" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## Horizontal Bars

默认Bar chart为竖向。若需以水平柱状图展示数据：

* 打开View Settings
* 启用**Horizontal Bar**模式

![image](/images/trendz/bar-horizontal.png)
![image](/images/trendz/bar-horizontal-conf.png)

**注意**：仅当**Y-axis**包含一个字段时支持水平模式。若**Y-axis**有多个字段且**Series**区域有字段，则不显示水平柱状图。

## Stacked Bars

当Bar chart包含多个timeseries或series字段时，每个series独立显示。可为Bar chart启用stacked模式。示例如下： stacking关闭、stacking开启、100% stacked bars。

![image](/images/trendz/bar-stack-off.png)
![image](/images/trendz/bar-stack-onn.png)
![image](/images/trendz/bar-stack-100.png)

可在View Settings中控制stack选项

![image](/images/trendz/bar-stack-conf.png)

## Group By telemetry value

当需要按telemetry字段值分组和聚合数据时使用该选项。
例如设备生产不同杯子，上报的telemetry包含：

* 生产数量(amount)
* 产品类型(product category)
* 消耗资源(energy)

原始payload格式如下：

{% highlight javascript %}
  {
    "ts": 1540892498884,
    "amount": 12,
    "product": "glass",
    "energy": 218,
  }
{% endhighlight %}

目标：按不同产品类型统计产量，或统计特定类型产品的能耗。

两种情况均需按**product**值分组telemetry，然后应用所需聚合（本例为SUM）：

* 将**product**字段加入**Series**区域，聚合选**UNIQ**——分组telemetry
* 将**product**字段加入**Y-axis**区域，聚合选**SUM**——对每组应用聚合
* 将**Machine**字段加入**X-axis**区域——按机器拆分展示

即可看到不同机器生产各类型产品的数量。

![image](/images/trendz/bar-group-ts.png)

## Labels
可在View Settings中通过复选框添加/隐藏Bar chart的标签。

![image](/images/trendz/bar-labels.png)
