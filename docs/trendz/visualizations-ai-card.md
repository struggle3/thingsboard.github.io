---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: AI Card
description: Trendz AI Card 视图类型
---

* TOC
{:toc}

AI Card在选择时间范围内展示累计telemetry数据全貌，包含预测和AI生成的摘要。适用于监测能耗、销售指标、设备性能或任何需要同时理解历史趋势与未来预测的累计指标。

主要特性：
* **Cumulative Telemetry：** chart展示累计值，每个数据点代表所选 period 内当前及之前所有读数的总和。
* **Forecasting：** 卡片包含下一 period 的预测趋势，基于历史模式预判未来数值。
* **AI Summary：** 自动生成的数据解读，无需手工分析即可获得洞察。

## Base AI Card

按以下步骤创建Base AI Card：

**Step 1: 选择Telemetry字段。** 选择要分析的telemetry字段（如能耗、温度、销量）。

**Step 2: 配置Value列。** 将所选telemetry字段拖放到Value列。

**Step 3: 选择时间范围。** 选择分析的时间范围。系统据此确定展示的数据和预测 period。*示例：* 若今天是10月27日且选择*This Month*，chart将显示前27天的真实数据及剩余4天（10月28–31日）的预测。

**Step 4: Build the Report。** 配置好telemetry和时间范围后，点击Build Report按钮生成卡片。

AI Card包含以下关键元素（截图中编号）：
1. **Current Cumulative Value：** 所选时间范围内的总累计值（含预测数据）。根据性能阈值着色
2. **Difference from Previous Period：** 与上一等价 period 相比，当前累计值的绝对变化和百分比变化
3. **Historical Data（实线）：** 截至当日的实际累计telemetry数据
4. **Predicted Data（虚线）：** 超出当前日期，展示所选 period 剩余部分的预测趋势
5. **Previous Period Trend Area（阴影区）：** 上一等价 period 的累计趋势，作为与当前数据对比的视觉基线
6. **AI Summary：** 基于上一 period、当前数据和预测自动生成的解读。使用所选AI prompt生成。
![image](/images/trendz/base-ai-card.png)

## AI Card Configuration

### Prediction Configuration

**Prediction Method**

AI Card默认使用**Fourier Transformation**作为预测方法，可根据数据特性切换为其他方法。

修改预测方法：
1. 点击Value列中的telemetry字段打开settings
2. 进入Prediction区域
3. 从可用选项中选择所需方法
   
![image](/images/trendz/ai-card-prediction.png)

**Prediction Time Range**

AI Card的主要目标是为特定 period 提供完整分析（历史数据+预测数据）。

建议使用预定义范围如*This Month*或*This Year*，以便真实数据与预测数据覆盖易于解读的 period。也可选择任意自定义时间范围。
系统仅对当前时间戳之后、该范围内的日期生成预测。

示例场景：
* **This Month范围：** 从月初到当天的真实数据，加上剩余天数的预测
* **自定义范围（10月1日–11月15日）：** 若今天为10月27日，显示10月1–27日的真实数据和10月28日–11月15日的预测

### AI Summary Configuration

AI Summary根据累计telemetry数据和趋势自动生成解读。可控制其可见性和分析方式。

若不希望卡片使用AI功能：

1. 进入**Chart settings → AI Assistant菜单**
2. 取消勾选**Show AI summary**

AI prompt决定生成摘要的重点和内容，因此可选最能解读数据的prompt：
1. 进入**Chart settings → AI Assistant菜单**
2. 从**Prompt**下拉选择所需prompt

可创建针对用例的自定义prompt。详见[Trendz AI Prompts Overview](/docs/trendz/ai-assistance-prompts)

![image](/images/trendz/ai-card-summary.png)

### Value Color Threshold Logic

AI Card使用颜色编码对当前累计值相对上一 period 的表现提供即时视觉反馈。

卡片顶部的当前累计值根据与上一 period 相比的变化幅度着色：

* **Blue（正常表现）：** 当绝对百分比变化在阈值范围内（默认10%）时显示蓝色，表示稳定、符合预期。

![image](/images/trendz/ai-card-threshold-normal.png)

* **Red（显著偏离）：** 当绝对百分比变化超过阈值（默认>10%）时显示红色，提示需要关注的显著偏离或表现变化。

![image](/images/trendz/ai-card-threshold-deviation.png)

**Customizing the Threshold**

可通过**Value Color Logic**设置调整颜色编码的敏感度：
* Default：使用标准10%阈值进行所有颜色计算
* Custom：设置符合监测需求的特定阈值百分比
  * 示例：设为5%以获得更敏感的偏离告警
  * 示例：设为20%以仅在较大变化时告警
* Unset：完全禁用颜色编码。无论百分比差值如何，当前累计值均不以颜色高亮显示。

![image](/images/trendz/ai-card-threshold-config.png)
