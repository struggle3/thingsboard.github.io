---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 工业厂房综合设备效率（OEE）追踪
description: 使用 IoT 传感器数据追踪制造厂的实时 OEE 得分，从 Availability、Performance、Quality 指标着手优化产线并应对停机原因。  

oee-score-dashboard:
  0:
    image: /images/trendz/guide/oee_score/oee_score_industrial_plant.png
    title: 'Dashboard with OEE score tracking on factory'

oee-score-availability-calculation:
  0:
    image: /images/trendz/guide/oee_score/OEE_create_view_St1_1.png
    title: 'Create line chart in Trendz'
  1:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St1_2.png
    title: 'Configure availability chart to track downtime events'
  2:
    image: /images/trendz/guide/oee_score/OEE_calculated_St1_3.png
    title: 'Use States to track how much time assembly line was operational'
  3:
    image: /images/trendz/guide/oee_score/OEE_final_view_St1_4.png
    title: 'Dynamic of amount of time machines were operational'

oee-score-downtime-reasons: 
  0:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St2_1.png
    title: 'Create bar chart with top 5 downtime reasons for each assembly line'
  1:
    image: /images/trendz/guide/oee_score/OEE_settings_St2_2.png
    title: 'Set calculated field to compute top 5 downtime reasons'
  2:
    image: /images/trendz/guide/oee_score/OEE_final_view_St2_3.png
    title: 'Top 5 downtime reasons for each assembly line'

oee-score-production-speed-vs-planned:
  0:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St3_1.png
    title: 'Create line chart with production speed comparison to planned production'
  1:
    image: /images/trendz/guide/oee_score/OEE_batch_calculation_St3_2.png
    title: 'Set calculated field to compute performance metric'
  2:
    image: /images/trendz/guide/oee_score/OEE_final_view_St3_3.png
    title: 'Hourly production speed of the plant'
    
oee-score-quality-score:
  0:
    image: /images/trendz/guide/oee_score/OEE_add_fields_St4_1.png
    title: 'Create line chart that shows percent of damaged parts'
  1:
    image: /images/trendz/guide/oee_score/OEE_calculated_St4_2.png
    title: 'Set calculated field to compute quality score based on amount of damaged parts'
  2:
    image: /images/trendz/guide/oee_score/OEE_final_view_St4_3.png
    title: 'Track amount of rejected details and overall quality score of the plant'

---

* TOC
{:toc}

## Introduction
某制造厂生产汽车零部件，24/7运行。工厂有3条组装线，OEE分别为85%、90%、75%。
利用smart factory组装线旁iot sensors的数据，分析组装线实时数据，可跟踪全厂及单条线的Availability、Performance和Quality指标。
实时、按日跟踪这些指标后，可分析设备downtime原因、定位低OEE根因，如计划外停机、低performance或低质量。

**任务定义：** 实时、按日跟踪全厂及每条组装线的OEE。

{% include images-gallery.html imageCollection="oee-score-dashboard" %}


### Implementation plan
* 通过跟踪downtime事件的数量和原因，计算组装线的**Availability**指标
* 确定每条组装线的top 5 downtime原因，进行根因分析
* 通过跟踪实际生产速度与计划速度的对比，分析**Performance**指标
* 基于不合格件数量及不合格原因计算**Quality**指标


## Getting started:

### Prerequisites
先了解方案涉及的ThingsBoard实体及其关系、传感器上报的原始telemetry。
实体的provision及传感器配置不在本指南范围内。可参考文档。领域模型如下：

* `Manufacturing plant`在ThingsBoard中注册为asset
* `Assembly line`在ThingsBoard中注册为device，与manufacturing plant asset关联
* 现场Gateway通过modbus协议从组装线采集数据，作为telemetry发送至ThingsBoard
* 组装线上报的指标：
  * `powerUsageWh` - 能耗（Wh）
  * `producedParts` - 产量
  * `rejectedParts` - 质检不合格数
  * `status` - 当前状态（running、stopped、maintenance等）
  * `reason` - 停机原因（maintenance、lack of materials等）

### Step 1: Analyze equipment downtime duration and compute Availability metric
组装线提供了计算停机时长和原因所需的信息。每30秒收到能耗数据，
格式`{powerUsageWh: 10, ts: 1675421880000}`。设备停机时操作员选择原因，ThingsBoard收到状态变更事件，
格式`{status: "stopped", reason: "maintenance", ts: 1675421880000}`。

分析组装线运行或停机时长时，使用Trendz **state fields**。State field可根据简单布尔条件表示设备处于某state的时长。
开始配置：

* 在Trendz创建Line chart
* 在X-axis区域添加`Date`字段——按月、周、日或小时拆分数据
* 在Series区域添加`assemblyLine`字段——按组装线拆分
* 在Y-axis区域添加State字段
  * 聚合改为`Duration percent`——显示每条组装线运行时间占比
  * 标签改为`Availability score`
  * 用下列javascript公式定义运行state

```javascript
var state = none(assemblyLine.status);
return state == "running";
```

* 以名称**OEE Availability line chart**保存视图

可得到展示各组装线OEE Availability score的实时折线图。后续可添加阈值，当Availability score低于目标时高亮，以便快速响应。

{% include images-gallery.html imageCollection="oee-score-availability-calculation" %}


### Step 2: Build bar chart with top 5 downtime reasons for each assembly line.
分析不同设备的最常见停机原因。数据以stacked bar chart展示，每根柱代表一条组装线，每根柱按top 5停机原因拆分。

* 在Trendz创建Bar chart
* 在X-axis区域添加`assemblyLine`——按组装线拆分
* 在Series区域添加`assemblyLine.status`，聚合选`UNIQ`——按status分组
* 在Values区域添加`assemblyLine.status`，聚合选`COUNT`——统计各status事件数
* 在Filters中添加`assemblyLine.status`，选择代表downtime的所有status
* 打开view settings
  * 排序设为`Descending`
  * 排序列设为`assemblyLine.status`
  * `Limit`设为5
  * 勾选`Stacked bar`
* 以名称**Availability: Top 5 downtime reasons**保存

{% include images-gallery.html imageCollection="oee-score-downtime-reasons" %}

### Step 3: Compare current and planned production speed
OEE框架中，Performance score为实际生产速度与计划速度之比。每条组装线的计划速度存于attribute，实际速度可根据产量计算。
组装线传感器每60秒上报产量，格式`{producedParts: 10, ts: 1675421880000}`。创建展示各线performance score的折线图。

* 在Trendz创建Line chart
* 在X-axis区域添加`Date`——按月、周、日或小时拆分
* 在Series区域添加`assemblyLine`——按组装线拆分
* 在Y-axis区域添加Calculated字段
  * 标签改为`Perfromance score`
  * 勾选`Batch calculation`——使用原始telemetry计算performance score
  * 使用AVG聚合——因用户可切换hour、day、week、month，需计算各时间间隔的平均performance score
  * 用下列javascript公式计算performance score
 
```javascript
var plannedSpeed = uniq(assemblyLine.plannedSpeed)[0].value;
var rawProducedPartsArray = none(assemblyLine.producedParts);

var performanceScore = [];
for (var i = 0; i < rawProducedPartsArray.length; i++) {
  var point = rawProducedPartsArray[i];
  var score = point.value * 100 / plannedSpeed;
  performanceScore.push({ts: point.ts, value: score});
}

return performanceScore;
```

* 以名称**OEE Performance score line chart**保存

本视图使用batch calculated fields以访问传感器上报的原始值。
transformation完成后，Trendz对结果数组应用所选聚合函数（本例为AVG），得到每个时间间隔、每条线的单一值。
而简单calculated field在transformation前先应用聚合。

{% include images-gallery.html imageCollection="oee-score-production-speed-vs-planned" %}

### Step 4: Compute Quality score based on amount of rejected parts
最后分析Quality score——不合格件数量及各组装线差异。部分设备可能有机械损耗或操作员经验不足导致更多不合格件。
传感器上报格式：`{rejectedParts: 10, ts: 1675421880000}`。创建展示各线quality score的折线图。

* 在Trendz创建Line chart
* 在X-axis区域添加`Date`——按月、周、日或小时拆分
* 在Series区域添加`assemblyLine`——按组装线拆分
* 在Y-axis区域添加Calculated字段
  * 标签改为`Quality score`
  * 用下列javascript公式计算quality score

```javascript
var producedParts = sum(assemblyLine.producedParts);
var rejectedParts = sum(assemblyLine.rejectedParts);

var qualityScore = 100 - rejectedParts * 100 / producedParts;
return qualityScore;
```

* 以名称**OEE Quality score line chart**保存

计算字段公式中，计算的是组装线生产合格件的百分比。

{% include images-gallery.html imageCollection="oee-score-quality-score" %}

## Summary
通过跟踪每条组装线的OEE及其构成，可定位影响效率的具体因素、找到改进空间。
工厂管理者可针对每条线实施针对性方案，最终提升效率和生产能力。
分析Availability、Performance、Quality数据可定位低OEE根因并制定改进措施。
通过持续监测和改进，可优化组装线、减少停机、提高产量和质量。
随着技术发展，实时数据采集与分析对制造厂的成功和竞争力将更加重要。
