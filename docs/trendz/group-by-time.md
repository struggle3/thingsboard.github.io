---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 按时间分组和聚合
description: 按时间的分组与聚合
---

在大多数情况下，数据按时间间隔分组——按小时、天、周、月等。您应使用左侧面板的 **Date** 字段
并将其拖放到 **X 轴** 部分。

Date 聚合的默认函数为 **RAW**——这意味着用户可以使用
时间范围选择器旁的 **Group By** 组合框控制聚合间隔。系统将获取时间范围选择器的完整范围，并根据所选值
将其划分为更小的间隔。然后，将选定的聚合函数应用于每个间隔。
**Group By** 字段的允许值为：
* 月
* 周
* 天
* 小时
* 分钟

![image](/images/trendz/date-raw-group.png)


您可以通过选择其他可用的 Date 聚合选项来更好地控制日期间隔：
* RAW
* MINUTE
* HOUR
* FULL_HOUR - '2020-03-01 23'
* DAY - 星期几
* DATE - 月份中的日
* FULL_DATE - '2020-03-01'
* START_OF_WEEK - 2020-03-01
* WEEK_OF_YEAR - 年中的数字周
* WEEK_OF_MONTH - 月中的数字周
* MONTH
* QUARTER
* YEAR
* YEARMONTH - '2020-Feb'

## 下一步

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
