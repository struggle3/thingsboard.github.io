---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 遥测聚合与 delta
description: 遥测聚合与 delta 说明
---

## Telemetry Aggregation

下一步是定义数据如何聚合。支持的聚合类型：
* AVG
* SUM
* MIN
* MAX
* LATEST
* COUNT
* UNIQ

修改聚合类型：点击字段并选择所需值。

![image](/images/trendz/field-aggregation.png)

## Delta Aggregation

水表是典型的 pulse output 设备——telemetry值持续增长，分析中需将其转为delta值。
示例如下：

![image](/images/trendz/pulse-before.png)

对该字段应用**DELTA**聚合后的效果：

![image](/images/trendz/pulse-after.png)

Trendz按定义的时间范围和粒度自动计算该字段的delta。
若对多台设备应用**DELTA**聚合，Trendz会对聚合组应用**SUM**，从而在不同层级（城市、建筑等）看到总 consumption。

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
