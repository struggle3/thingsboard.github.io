---
layout: docwithnav-trendz
title: 异常可视化
description: 可视化已检测到的异常。
---

* TOC
{:toc}

## 异常视图报告

异常视图报告是为异常可视化设计的完整解决方案。其功能与异常模型详情中的 Review 标签页类似（[Review 标签页详情](/docs/trendz/anomaly/overview#review-tab)）。

可通过以下设置自定义视图：
- **Default Anomaly Selection（默认异常选择）：** 设置打开视图时默认选中的异常。
  - 选项：`last`、`max score index`
  - 位置：*Settings → General → Default anomaly selection*

- **Hide Anomalies List（隐藏异常列表）：** 在视图中隐藏异常列表部件。
  - 位置：*Settings → View mode fields → Hide anomalies list*

- **Hide Anomalies Chart（隐藏异常图表）：** 在视图中隐藏异常图表部件。
  - 位置：*Settings → View mode fields → Hide anomalies chart*

- **Timerange（时间范围）：** 设置异常视图使用的时间范围。
  - 位置：视图中部上方

- **Filters（筛选器）：** 选择在部件中显示的设备。
  - 位置：视图左上角

## 异常字段

Trendz 通过**异常字段（Anomaly Fields）** 提供异常可视化的底层工具，可用于构建自定义仪表板和洞察。

使用异常字段：

1. 打开任意视图（如时序图、卡片、柱状图）。
2. 将 **Anomaly Field** 拖放到画布上。
3. 点击配置其属性。

### 字段属性

- **Anomaly（异常）：**（`SCORE`、`SCORE_INDEX`）选择要可视化的异常指标：
  - `SCORE`：类似*温度*，显示某时刻的异常强度。
  - `SCORE_INDEX`：类似*面积*，在异常持续时间内累积，显示总体影响。

- **Model（模型）：** 选择活动异常模型。仅活动模型可用于可视化。

- **Aggregation（聚合）：** 定义跨时间或实体的值的组合方式：
  - 对于 **SCORE**：
    - 推荐：`MAX`、`LATEST`、`COUNT`
    - 不推荐：`SUM`、`AVG`、`MIN`、`UNIQ`
  - 对于 **SCORE_INDEX**：
    - 推荐：`COUNT`、`SUM`、`UNIQ`、`LATEST`
    - 可用但灵敏度较低：`AVG`、`MIN`

  对 `SCORE` 使用 `MAX` 可捕获峰值异常强度。
  对 `SCORE_INDEX` 使用 `SUM` 可可视化完整异常影响。

- **Label (Anomaly)（标签）：** 图表图例中显示的名称。

- **Chart Type（图表类型）：** 可选：`bar`、`line` 或 `area`

异常字段适用于在不将异常保存到 ThingsBoard 的情况下跨时间和设备构建灵活的可视化。

## 异常业务实体字段

**仅在启用“Save to TB”时可用**（保存到 ThingsBoard 的说明见[此处](/docs/trendz/anomaly/save-to-tb.md)）。

使用方法：
1. 打开任意视图。
2. 导航至与异常模型关联的业务实体。
3. 拖放以下字段：
  - `{Model Name} SCORE`
  - `{Model Name} SCORE INDEX`

- 当需要**统计异常**或避免保存到 TB 时，使用**异常字段**。
- 当异常已保存且需要精确控制时，使用**业务实体字段**。

## 最佳实践

根据以下建议选择适合的异常可视化与分析工具：

- **若需要简单即插即用的异常可视化：**  
  - 使用**异常报告**。
- **若需要灵活可视化且不希望将异常保存到 ThingsBoard：**  
  - 使用**异常字段**。
- **若需要精确控制保存到 ThingsBoard 的异常：** 
  - 使用**异常业务实体字段**。

## Next Steps

{% assign currentGuide = "AnomalyDetection" %}{% include templates/trndz-guides-banner.md %}
