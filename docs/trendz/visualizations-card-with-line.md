---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 带折线图的 Card
description: 使用 Card 内折线图展示数据趋势
---

* TOC
{:toc}


Card with line chart部件用于展示单一重要指标，并可在需要时与上一相似时段对比变化趋势。

## Simple Card with line chart

创建简单Card with line chart视图：

* 将需监测的字段拖放到Value列
* 选择所需聚合类型
* 点击"Build Report"

![image](/images/trendz/card-with-line-simple.png)

## Comparison with the previous period

与上一相似时段对比可比较数值及变化趋势。
例如过去7天用水量可与再前7天用水量对比。

* 在settings中开启**Enable comparison**
* 点击**Build Report**

![image](/images/trendz/card-with-line-comparison.png)

对比值以百分比展示两者的差值。chart同时展示两个时段的趋势线。

## Fast setting the visualization colors of the value difference

默认情况下，两时段对比结果：若趋势为负显示红色警告数字，若为正显示绿色无警告数字。

* 要反转颜色，在settings中启用或禁用**Reverse comparison colors**
* 点击**Build Report**

![image](/images/trendz/card-with-line-reverse-colors.png)

## Manual setting the visualization of the value difference
也可手动设置差值可视化，指定normal、warning和dangerous值范围及对应颜色。

* 在字段settings中设置各范围的最小值和最大值
* 点击**Build Report**

注意此时将忽略**Reverse comparison colors**设置。

![image](/images/trendz/card-with-line-custom-colors.png)
