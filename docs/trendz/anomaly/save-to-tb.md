---
layout: docwithnav-trendz
title: 将遥测保存到 ThingsBoard
description: 如何配置和管理将异常检测遥测数据保存到 ThingsBoard。
---

* TOC
{:toc}

## 概述

将遥测保存到 ThingsBoard 可将异常检测结果（如异常分数和分数指数）持久化为时序数据。  
便于在 ThingsBoard 内进行进一步分析、可视化和告警。

## 配置

在异常检测模型配置中，按以下步骤将遥测数据保存到 ThingsBoard：

### 1. 配置遥测键和存储频率

- **Telemetry Key（遥测键）：** 指定异常分数和分数指数在 ThingsBoard 中的保存键名。
- **Telemetry Storage Frequency（遥测存储频率）：** 定义遥测数据的存储频率。  
  建议将该频率设置为低于：
    - 段时间范围（固定段），或
    - 段大小与滑动步长的乘积（滑动窗口）。  
  有助于避免异常重叠。

**注意：** 不建议将遥测存储频率设为低于 1 小时，否则可能对 ThingsBoard 造成性能压力。

**警告：** 在首次刷新后更改遥测存储频率可能导致 ThingsBoard 中数据不一致或重叠。建议在启用遥测保存前确定频率设置。

### 2. 启用异常刷新

要激活遥测保存，必须在**“Enable Saving Anomaly Data”**开关中启用异常刷新。  
[更多关于启用刷新的说明](/docs/trendz/anomaly/refresh-reprocess)。

启用刷新后，Trendz 将自动创建所需实体字段。  
若之后禁用刷新，遥测保存也会自动停止，所需实体字段将被禁用。

即使删除模型，已保存的遥测数据仍保留在 ThingsBoard 中。

在**刷新**和**重新处理**过程中均可保存遥测数据，前提是在刷新设置中启用 **"Enable Saving Anomaly Data"** 标志。

## Next Steps

{% assign currentGuide = "AnomalyDetection" %}{% include templates/trndz-guides-banner.md %}
