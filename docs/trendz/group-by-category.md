---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 按类别分组
description: 按类别的分组与聚合
---

使用 Trendz，您可以基于业务实体的不同属性对数据进行分组。例如，在能源计量场景中，您可以按建筑、公寓、房间等对数据进行分组。
业务实体模型中定义的任何字段都可用于分组和筛选数据。这意味着我们可以为整个组实时应用所需的遥测聚合。
您无需在分析前显式定义聚合规则或预先计算不同级别的值。

在本示例中，我们仅添加 2 个字段：**建筑名称** 和 **能耗**。规则引擎中没有任何聚合规则。
Trendz 知道每个建筑中注册了哪些能源表，因此能源表按建筑分为独立组。

![image](/images/trendz/data-grouping-simple.png)

我们可看到去年总消耗量。现在按季度分组数据——添加 **Date** 字段，类型为 **quarter**：

![image](/images/trendz/data-grouping-quarter.png)

最后，深入查看按房间号分开的总消耗量——从 **公寓** 业务实体添加 **房间号** 属性：

![image](/images/trendz/data-grouping-room.png)


## 下一步

{% assign currentGuide = "GroupAndAggregateData" %}{% include templates/trndz-guides-banner.md %}
