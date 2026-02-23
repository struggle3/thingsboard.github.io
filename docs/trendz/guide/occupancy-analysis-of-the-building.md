---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 酒店预测性入住率监控
description: 分析并预测建筑物内不同区域、空间的人流与入住率

building-occupancy-dashboard:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_dashboard.png
    title: 'Real time occupancy tacking dashboard'

building-occupancy-weakly-heatmap:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_heatmap_create.png
    title: 'Create heatmap view in Trendz'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_add_dates.png
    title: 'Add date fields into heatmap view to group data by hour and day'
  2:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_calcualtion.png
    title: 'Calculate occupancy rate for each hour of the day'
  3:
    image: /images/trendz/guide/building_occupancy/hotel_hourly_occupansy_filtering.png
    title: 'Add filtering options to focus on specific area of the hotel'
  4:
    image: /images/trendz/guide/building_occupancy/hotel_weakly_occupansy_heatmap.png
    title: 'Hourly occupancy rate heatmap for the last 7 days'

building-occupancy-forecast-configuration:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_forecast_create.png
    title: 'Create building occupancy line chart'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_forecast_configuration.png
    title: 'Enable prediction and configure forecast settings'
  2:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_forecast_for_next_weak.png
    title: 'Building occupancy forecast for the next week'

building-occupancy-top-crowded-areas:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancu_top_crowded_areas_sorting.png
    title: 'Enable descending sorting by occupancy rate to find top crowded areas'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_occupancu_top_crowded_areas.png
    title: 'Top 5 overcrowded areas in the building'

building-occupancy-dashboard-configuration:
  0:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_create_dashboard.png
    title: 'Create dashboard for analyzing building occupancy'
  1:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_aliases.png
    title: 'Configure dashboard aliases to filter entities by building, floor and area'
  2:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_filter_alias.png
    title: 'Configure alias for showing all available buildings'
  3:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_add_hierarchy_widget.png
    title: 'Add hierarchy widget to the dashboard'
  4:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_hierarchy.png
    title: 'Configure hierarchy widget to show all floors in the building'
  5:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_enable_rowclick.png
    title: 'Enable row click event to apply filtering by selected entity'
  6:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_configure_filter_by_building.png
    title: 'Configure row click event'    
  7:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_share_view.png
    title: 'Add Trendz views on the occupancy dashboard'
  8:
    image: /images/trendz/guide/building_occupancy/hotel_occupancy_add_on_dashboard.png
    title: 'Configure Trendz views to show occupancy rate for the selected building'

---

* TOC
{:toc}

## Introduction

某中型酒店希望提升客户体验、降低运营成本，因此引入occupancy monitoring。
希望通过分析不同区域的受欢迎程度和时段，更合理地调配人力和资源。
同时希望减少能耗、识别HVAC系统潜在问题，降低环境影响。

**任务定义** - 分析酒店内不同区域的occupancy rate，并预测未来一周的 hourly occupancy rate。

{% include images-gallery.html imageCollection="building-occupancy-dashboard" %}

### Implementation plan
* 计算各区域按最大容量百分比的hourly occupancy rate
* 计算整层、整栋建筑的occupancy rate
* 构建未来一周occupancy rate预测
* 展示各区域/楼层/建筑的周heatmap
* 显示top-5拥挤区域
* 显示top-5低利用率区域
* 在ThingsBoard创建occupancy分析dashboard

### Key outcomes
* 公共事业成本降低12%
* 人力成本降低15%
* 正面客户评价提升10%

## Getting started:

### Prerequisites
本指南聚焦数据分析和可视化，传感器安装与配置从简。系统概况如下：

* 酒店各区域已安装occupancy sensors，通过LoRaWAN integration连接ThingsBoard
* ThingsBoard中有3种asset类型：building、floor、area。Building关联多个floor，floor关联多个area，每个area关联occupancy sensor
* 传感器上报当前区域内人数
* Occupancy sensor payload——`{"ts": 1651419204000, peopleCnt": 5}`
* 每个area有最大容量attribute。用于计算occupancy rate。provision时设置初始值

### Step 1: Compute hourly occupancy rate as a percent from max capacity for each area
先计算各区域的occupancy rate。使用Trendz calculated field，基于区域最大容量和传感器上报的历史occupancy定义公式。
使用heatmap展示过去7天各小时的occupancy rate。用户可切换时间范围，聚焦实时或历史数据。

* 创建Heatmap视图
* 在`X-axis`区域添加**Date(Hour)**
* 在`Y-axis`区域添加**Date(Day)**
* 在`Value`区域添加**Calculated**字段，Label改为**Occupancy rate**
* 编写返回按最大容量百分比的occupancy rate的函数

```javascript
var peopleCnt = sum(occupancySensor.peopleCnt);
var maxCapacity = uniq(area.maxCapacity);

return peopleCnt / maxCapacity * 100;
```

* 计算字段**Unit**设为**%**
* 在`filter`区域添加Area、Floor、Building字段，便于聚焦酒店特定区域
* 默认时间范围——**Last 7 days**
* 以名称**Weekly occupancy rate heatmap**保存

{% include images-gallery.html imageCollection="building-occupancy-weakly-heatmap" %}

### Step 2: Compute occupancy rate for the whole floor and building
Step 1创建的heatmap包含filter字段。未选择filter时，heatmap显示全系统的occupancy rate。所有区域、楼层、建筑的数据会聚合显示。

实际中通常聚焦特定建筑或区域。使用filter实现。例如在filter中选择特定建筑，heatmap仅显示该建筑的occupancy rate。
Trendz在后台会：
* 拉取所选建筑的所有floor
* 拉取各floor的所有area
* 拉取各area内sensor的occupancy数据
* 对每个sensor应用计算
* 在建筑层面聚合结果

因此查看整层或整栋建筑的occupancy rate时，可使用同一视图，只需在filter中选择楼层或建筑即可。

### Step 3: Predict an occupancy rate for the upcoming week with hourly breakdown
此前使用历史数据。现在使用Trendz prediction工具构建未来一周预测。先创建展示过去7天、按小时拆分的occupancy rate折线图。

* 创建Line chart视图
* 在`X-axis`区域添加**Date(Full Hour)**
* 在`Y-axis`区域添加**Calculated**字段，Label改为**Occupancy rate**
* 编写返回按最大容量百分比的occupancy rate的函数

```javascript
var peopleCnt = sum(occupancySensor.peopleCnt);
var maxCapacity = uniq(area.maxCapacity);

return peopleCnt / maxCapacity * 100;
```

* 勾选`Prediction`
  * Prediction method——**Fourier transformation**
  * Prediction range——7
  * Prediction unit——days
* 计算字段**Unit**设为**%**
* 在`Series`区域添加Area name——各区域occupancy rate显示为独立线
* 在`filter`区域添加Area、Floor、Building，便于聚焦酒店特定区域
* 默认时间范围——**Last 7 days**

最后，对计算字段**Occupancy rate**预测未来7天。使用**Fourier transformation** prediction method，对季节性时序效果较好。

* 点击`Y-axis`区域中的**Occupancy rate**字段
* 勾选`Prediction`
  * Prediction method——**Fourier transformation**
  * Prediction range——7
  * Prediction unit——days
* 以名称**Hourly occupancy forecast**保存

各区域历史数据以实线显示，预测以虚线显示。

{% include images-gallery.html imageCollection="building-occupancy-forecast-configuration" %}

### Step 4: Bar chart with top-5 overcrowded/underutilized areas in the hotel
Top-5 bar chart便于在较大时间范围内理解系统、对比asset、识别拥挤与低利用率区域。先从拥挤区域开始。

* 创建Bar chart视图
* 在`X-axis`区域添加**Area name**
* 在`Y-axis`区域添加**Occupancy rate**。复用Step 1的计算字段
* 打开View settings
  * 排序——**Descending**
  * `Limit`——5
  * 启用Horizontal bar chart
* 在`filter`区域添加Area、Floor、Building，便于聚焦酒店特定区域
* 默认时间范围——**Last 7 days**
* 以名称**top-5 overcrowded areas**保存

top-5低利用率区域的bar chart步骤几乎相同。仅将排序改为**Ascending**，视图名称改为**top-5 underutilized areas**。

{% include images-gallery.html imageCollection="building-occupancy-top-crowded-areas" %}

### Step 5: Create occupancy analysis dashboard in ThingsBoard
所有Trendz分析chart已就绪，可在ThingsBoard创建用户dashboard。注意用户可能访问多家酒店，需创建适用于所有酒店的dashboard。用户应能选择酒店、楼层、区域。
首先添加所有Trendz视图到dashboard：

* 在ThingsBoard创建名为**Occupancy analysis**的dashboard
* 在Trendz：对前几步创建的每个部件：
  * 点击`Share to ThingsBoard`，复制`Add on Dashboard`
  * 选择**Occupancy analysis** dashboard
  * 勾选**Create alias**
  * Filter选择**Area name**
* 返回ThingsBoard **Occupancy analysis** dashboard并调整布局

然后创建用于dashboard过滤的aliases：

* 创建新alias **All buildings**——保存用户可见的所有建筑
  * Filter type——**Asset type**
  * Asset type——**Building**
* 创建新alias **Selected entity**——保存用户点击的实体
  * Filter type——**Entity from dashboard state**
  * State entity parameter name——**selectedEntity**
* 创建新alias **Filtered areas**——保存用户要聚焦的Area
  * Filter type——**Asset search query**
  * 勾选**Root entity**，entity parameter name——**selectedEntity**
  * 勾选**Fetch last level relation only**
  * Direction——From
  * Max relation level——3
  * Asset types——**Area**

最后添加hierarchy部件，展示酒店内所有建筑/楼层/区域，供用户选择。用户点击实体后，**Filtered areas** alias会刷新并加载所选实体的所有区域。
之后dashboard上所有Trendz部件会更新，因其以**Filtered areas** alias为数据源。用户将看到所选区域的occupancy数据。

* 在dashboard添加hierarchy部件`Cards` -> `Entities hierarchy`，展示酒店内所有建筑/楼层/区域
  * 数据源alias——**All buildings**
  * Latest data key——**Name**
* 为hierarchy部件添加`On node selected` action，更新dashboard state中的`selectedEntity`参数
  * Action type——**Update current dashboard state**
  * State entity parameter name——**selectedEntity**
* 所有dashboard上的Trendz部件的数据源alias设为**Filtered areas**
* 保存dashboard

{% include images-gallery.html imageCollection="building-occupancy-dashboard-configuration" %}

## Summary
综上所述，occupancy monitoring技术的实施帮助客户实现了提升客户体验、降低运营成本、减少环境影响的目标。
借助实时数据和预测分析，他们优化了人员配置、更有效地分配资源、降低了能耗。
实施的主要成效包括公共事业和人力成本下降，以及正面客户评价提升。
