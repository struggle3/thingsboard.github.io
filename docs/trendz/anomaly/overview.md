---
layout: docwithnav-trendz
title: 概述
description: Trendz 异常检测简介

page-anomaly-models:
  0:
    image: /images/trendz/anomaly/page-anomaly-models.png
    title: 'Anomaly Models Tab'

page-cluster-info-tab:
  0:
    image: /images/trendz/anomaly/page-cluster-info-all.png
    title: 'Cluster Info Tab'
  1:
    image: /images/trendz/anomaly/page-cluster-info-specific.png
    title: 'Cluster Info Tab (Specific Cluster)'

page-input-tab:
  0:
    image: /images/trendz/anomaly/page-input-tab.png
    title: 'Input Tab'

page-review-tab:
  0:
    image: /images/trendz/anomaly/page-review-tab.png
    title: 'Review Tab'

page-summary-tab:
  0:
    image: /images/trendz/anomaly/page-summary-calendar.png
    title: 'Summary Tab: Calendar Mode'
  1:
    image: /images/trendz/anomaly/page-summary-dynamic.png
    title: 'Summary Tab: Dynamic Mode'
  2:
    image: /images/trendz/anomaly/page-summary-review.png
    title: 'Summary Tab: Review Mode'

page-task-tab:
  0:
    image: /images/trendz/anomaly/page-task-tab.png
    title: 'Task Tab'

---

* TOC
{:toc}

## 异常检测理论

**异常检测**是指识别遥测数据中意外行为的过程——即与正常情况显著不同的模式。这些异常可能预示着系统故障、设备退化、安全漏洞或运行低效。

在现代监测与分析中，异常检测对于以下方面至关重要：
- 预测性维护
- 早期故障检测
- 运行效率

**Trendz** 提供开箱即用的强大异常检测解决方案，能自动发现时序数据中的异常模式，无需人工设定阈值或专家标注。对于高级用户，Trendz 还提供对模型配置流程的全面控制——包括输入准备、特征提取、距离函数调优和评分逻辑——均通过便捷直观的界面完成。

您可在此了解如何使用 Trendz Analytics 创建异常检测模型：
&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/pbjXGDJ-SI0" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

### Trendz 异常检测核心概念

在 Trendz 中，异常检测基于两个核心指标：

- **异常分数（Anomaly Score）**  
  表示数据段偏离预期（正常）行为的数值，可理解为衡量异常的**强度**。

- **异常分数指数（Anomaly Score Index）**  
  将**异常分数**与异常的**持续时间**结合的综合指标，有助于优先发现随时间**影响更大**的异常。

**实际示例：泵振动分析**

以下示例展示泵启动后的振动情况：

![image](/images/trendz/anomaly/without-preview/score_vs_index.png)

- **异常 A**
  - 表现为持续约 5 秒的**剧烈振动尖峰**。
  - 因突然偏离导致**异常分数较高**。
  - 持续时间短，故**分数指数较低**。

- **异常 B**
  - 无大幅尖峰，但**偏离持续时间更长**。
  - **异常分数较低**，但因时长增加使**分数指数更高**。
  - 提示对泵健康的**长期影响更大**。

虽然**异常 A** 因尖峰乍看更严重，但**异常 B** 因持续影响往往*更需要*调查——这正是**异常分数指数**要揭示的内容。
- 使用**异常分数**检测剧烈、短期偏离。  
- 使用**异常分数指数**发现可能随时间造成更大损害的持续异常。

### 监督式与非监督式异常检测

- **监督式异常检测：**  
  需要预先标注正常与异常片段的标注数据集。  
  模型根据标签学习分类数据点。常见算法包括 KNN、SVM、逻辑回归、决策树和 LSTM。  
  *局限：* 需要大量标注数据，难以检测训练集中未出现的新异常类型。

- **非监督式异常检测：**  
  无需标注数据。模型通过将相似数据段分组为簇来学习正常行为模式，并将显著偏离这些簇的点视为异常。  
  常见算法包括 K-Means、DBSCAN、高斯混合模型和层次聚类。  
  *优势：* 自动检测未知异常类型，适用于标注数据有限的现实场景。

**Trendz 目前仅支持非监督式机器学习算法**进行异常检测，采用基于聚类的方法在时序数据中检测异常。

### Trendz 中非监督式异常检测的工作流程

1. 收集并分割遥测数据。
2. 数据规范化与预处理。
3. 提取描述各段的特征。
4. 将数据段聚类为代表正常行为的组。
5. 根据与簇质心的距离计算异常分数。
6. 实时应用模型以实现持续异常检测。

## 标签页概述

### 异常模型标签页

访问**异常模型**页面：在工作区左侧点击标有 *Anomaly Models* 的图标。

该页面展示各模型的主要属性：

- **创建日期**
- **名称**
- **类型** – 当前仅支持 *CLUSTERING*
- **状态**：
  - **READY** – 模型已就绪，可进行异常检测
  - **QUEUED** – 等待训练任务启动
  - **IN PROGRESS** – 正在训练
  - **CANCELLED** – 训练已取消，需重新构建
  - **FAILED** – 训练失败，需重新构建
- **异常自动发现** – [了解更多](/docs/trendz/anomaly/refresh-reprocess)
- **遥测保存** – [了解更多](/docs/trendz/anomaly/save-to-tb)
- **告警自动创建** – [了解更多](/docs/trendz/anomaly/alarms)

**可用操作：**

- **创建模型**
  - 点击屏幕右上角的 *Create model* 按钮创建新异常模型。
  - 将跳转到**输入**标签页配置模型。
  - [了解输入标签页详情](/docs/trendz/anomaly/overview#input-tab)

- **查看模型**
  - 点击任意模型行以打开并查看。
  - 将跳转到**输入**标签页。
  - [了解输入标签页详情](/docs/trendz/anomaly/overview#input-tab)

- **删除模型**
  - 在 *Actions* 列点击三点菜单，选择 **Delete**。
  - 在确认对话框中确认删除。

- **重命名模型**
  - 在 *Actions* 列点击三点菜单，选择 **Rename**。
  - *Name* 列将出现文本框。
  - 输入新名称并按 **Enter** 保存。

{% include images-gallery.html imageCollection="page-anomaly-models" %}

### 输入标签页

**输入**标签页可用于管理和配置异常模型的核心方面，支持：

- **重命名模型**
  - 点击模型名称旁的铅笔图标，输入新名称并按 **Enter**。
  - 要应用新名称，点击 **Save Model**。此更改**无需**重新构建。

- **恢复模型**
  - 点击屏幕右上角的 **Revert** 按钮可放弃未保存更改并恢复到上次保存状态。

- **配置作业**
  - 仅 **READY** 状态的模型可配置作业。
  - 点击屏幕上方的 **Jobs** 按钮打开作业配置弹窗。
  - 在此可配置**刷新作业**（[了解刷新作业详情](/docs/trendz/anomaly/refresh-reprocess#anomaly-refresh)）。

- **修改属性**
  - 可在**输入**标签页更新多种异常模型属性（[了解模型属性详情](/docs/trendz/anomaly/build)）。
  - 要应用更改，点击 **Save Model**。除非修改以下内容，否则**无需**重新构建：
    - **Anomaly Model Name**
    - **Telemetry key**
    - **Telemetry storage frequency**
    - **Alarm Configuration**

- **Save Model（保存模型）**
  - 使用 **Save Model** 按钮保存更改或发起重新构建。
  - 若需要重新构建，将出现确认弹窗。
  - **注意：** 重新构建模型将删除所有现有异常并禁用刷新作业。

{% include images-gallery.html imageCollection="page-input-tab" %}

### 摘要标签页

**Summary** 标签页提供按设备分组的异常概览。

您可以：

- 查看**所有设备**或**特定设备**的异常统计。
- 使用图表下方表格选择或取消选择设备。
- 使用屏幕右上角的 **Review**、**Dynamic** 和 **Calendar** 按钮选择显示模式。

**可用模式**

- **Calendar Mode（日历模式，全部设备）：**
  - 显示所有项目的每日异常指数总和。
  - 默认仅显示有异常的月份。
  - 启用 *Full Range* 开关可查看全年。

- **Dynamic Mode（动态模式，仅所选设备）：**
  - 可视化所选设备的月度异常分布。
  - 绿色柱表示**当前设备的异常分数指数总和**。
  - 蓝色线表示**所有设备**的月度**平均分数指数总和**。

- **Review Mode（审阅模式，仅所选设备）：**
  - 显示**最新检测到的异常**。
  - 可放大或缩小查看当前设备的完整异常历史。

{% include images-gallery.html imageCollection="page-summary-tab" %}

### 审阅标签页

**Review** 标签页可查看**构建**、**刷新**或**重新处理**期间检测到的所有异常。

您可在此标签页：

- **验证**异常模型发现的异常。
- 通过查看结果并在需要时重新训练来**微调**模型。
- **确定告警创建的最优阈值**（[了解更多告警说明](/docs/trendz/anomaly/alarms)）。

可按以下字段**排序异常**以便更好分析：
  - Total Duration（总持续时间）
  - Score（分数）
  - Score Index（分数指数）
  - Item（设备）
  - End Timestamp（结束时间戳）

{% include images-gallery.html imageCollection="page-review-tab" %}

### 簇信息标签页

在此标签页可验证模型构建过程中创建的簇。

**Cluster Info** 标签页显示形成了多少簇、它们代表的形状或模式，以及数据段在各簇间的分布。

**簇表**

屏幕底部显示包含以下列的表：

- **Cluster ID** – 簇的唯一标识符。
- **Segments Count** – 最接近该簇的异常段数量。
- **Segments Percent** – 落入该簇的异常段百分比。
- **Total Duration** – 最接近该簇的所有异常段的总持续时间。
- **Min Score** – 最接近该簇的段中的最小异常分数。
- **Max Score** – 最接近该簇的段中的最大异常分数。

**质心可视化**

屏幕顶部可查看所有簇的**质心**。每个质心代表属于该簇的所有段的平均模式。这些曲线有助于理解各簇捕获的典型形状或行为。

也可**点击簇表中的任意行**打开详情视图。该视图显示：

- 选中的**质心**，以及
- 属于该簇的**20+ 个随机段**。

此功能便于在簇内直观比较段的可变性并验证聚类准确性。

{% include images-gallery.html imageCollection="page-cluster-info-tab" %}

### 任务标签页

在任务标签页中可查看与当前异常模型关联的任务。可在此验证如下任务：
- 异常模型构建
- 异常模型刷新
- 异常模型重新处理

可查看其结果、上次执行时间等。[更多 Trendz 任务说明](/docs/trendz/tasks-service)。

也可通过点击屏幕右上角的 **Run Reprocess Task** 按钮，直接从此标签页运行异常模型重新处理任务（[更多异常重新处理说明](/docs/trendz/anomaly/refresh-reprocess#anomaly-reprocess)）。

{% include images-gallery.html imageCollection="page-task-tab" %}

## Next Steps

{% assign currentGuide = "AnomalyDetection" %}{% include templates/trndz-guides-banner.md %}
