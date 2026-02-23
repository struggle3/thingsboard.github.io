---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: Card
description: Trendz Card 视图
---

* TOC
{:toc}


Card部件用于展示单一重要指标并监测其变化。

## Video Tutorial

&nbsp;

<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/ZXORc5nipgg" frameborder="0" allowfullscreen></iframe>
    </div>
</div>


## Simple Card

创建简单Card视图：

* 将需监测的字段拖放到**Main Value**列
* 选择所需聚合类型

![image](/images/trendz/card-simple.png)


## Compare with other value

可将主值与另一值对比。例如设备telemetry中保存了应生产的产品数量，
可与已生产数量对比。

* 在**Compared value**列添加对比值

![image](/images/trendz/card-compare.png)


对比值以百分比展示两者的差值。

## Compare with previous interval

也可将当前值与上一时间间隔对比。若要展示本月咖啡豆消耗相较上月的变化：

* 在**Compared value**区域的字段上启用**Local Date**
* 选择**Prev Month**时间范围
* 主视图时间范围设为**This Month**

![image](/images/trendz/card-local-config.png)


对比值以百分比展示两者的差值。

## Card title

创建Card时可为其命名以便快速导航。
打开右下角setting区域，在Title中填写名称。
