---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 清除、过滤、分组与聚合数据
description: 在 Trendz Analytics 中自定义聚合、过滤与清除数据集 
---

本指南描述如何为可视化准备数据集

* TOC
{:toc}

数据分析中常需定义大数据集的聚合方式。
该任务可分为2个阶段：定义分析中使用的分组，以及定义分组的聚合函数。

## Define Groups for analysis
在此步骤中，定义数据的逻辑层级。以能源计量场景为例，可在城市、区域、建筑、公寓或具体能量表等不同层级分析。
Trendz实时自动提供此分组，无需在分析前显式定义聚合规则或预计算各层级值。

本示例只需添加2个字段——**Building name**和**Energy Consumption**。Rule Engine中无聚合规则。
Trendz知道每栋建筑下注册了哪些Energy Meter，因此按建筑将能量表分为不同组。

![image](/images/trendz/data-grouping-simple.png)

可看到去年总 consumption。现按季度分组，添加类型为**quarter**的**Date**字段：

![image](/images/trendz/data-grouping-quarter.png)

进一步按房间号查看 consumption，添加**Apartment** Business Entity的**Room Number** attribute：

![image](/images/trendz/data-grouping-room.png)


## Aggregate telemetry and groups
下一步是定义数据如何聚合。支持的聚合类型：
* AVG
* SUM
* MIN
* MAX
* LATEST
* COUNT
* UNIQ
* DELTA - 特殊情况，本指南后文说明

修改聚合类型：点击字段并选择所需值。
![image](/images/trendz/field-aggregation.png)


## Work with pulse output telemetry
水表是典型的 pulse output 设备——telemetry值持续增长，分析中需将其转为delta值。
示例如下：
 
![image](/images/trendz/pulse-before.png)

对该字段应用**DELTA**聚合后的效果：

![image](/images/trendz/pulse-after.png)

Trendz按定义的时间范围和粒度自动计算该字段的delta。
若对多台设备应用**DELTA**聚合，Trendz会对聚合组应用**SUM**，从而在不同层级（城市、建筑等）看到总 consumption。

## Filter Data
为获得更好的分析结果，需过滤噪声源或聚焦特定实体子集。
将要过滤的字段拖入**Filter**区域并应用所需过滤条件。

可对未用于可视化的字段应用过滤器。例如能耗分析中过滤空公寓，聚焦二、三层公寓，配置示例如下：

![image](/images/trendz/filter-example.png)

可过滤任意字段类型（string、numeric、date等）。修改过滤条件：点击过滤字段并选择所需选项：

![image](/images/trendz/filter-dialog.png)


