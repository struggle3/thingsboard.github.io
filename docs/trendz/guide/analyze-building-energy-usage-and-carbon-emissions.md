---
layout: docwithnav-trendz
assignees:
  - vparomskiy
title: 建筑能耗与排放分析追踪
description: 优化建筑能耗并降低碳排放

energy-analytic-dashboard:
  0:
    image: /images/trendz/guide/building_energy/energy_consumption_analytic_dashboard.png
    title: 'Dashboard for energy usage analysis of the building'

energy-consumption-by-source-table:
  0:
    image: /images/trendz/guide/building_energy/energy_sources_final_table.png
    title: 'Energy consumption by sources table in the building'
  1:
    image: /images/trendz/guide/building_energy/energy_sources_configuration.png
    title: 'Add required fields to the table configuration'
  2:
    image: /images/trendz/guide/building_energy/energy_sources_calculate_cost.png
    title: 'Compute total electricity cost for each energy source'
  3:
    image: /images/trendz/guide/building_energy/energy_sources_filtering.png
    title: 'Add filtering options to the table to enable drill down analytics'
  4:
    image: /images/trendz/guide/building_energy/energy_sources_default_sort.png
    title: 'Sort final table to total energy cost in descending order'

energy-consumption-by-areas-table:
  0:
    image: /images/trendz/guide/building_energy/energy_areas_final_table.png
    title: 'Table with total electricity consumption in different areas inside the building'

energy-compare-sources-bar:
  0:
    image: /images/trendz/guide/building_energy/energy_compare_sources_bar_configuration.png
    title: 'Comparison bar chart configuration'
  1:
    image: /images/trendz/guide/building_energy/energy_compare_sources_bar_chart.png
    title: 'Compare energy consumers on bar chart'
    
energy-compare-time-ranges:
  0:
    image: /images/trendz/guide/building_energy/energy_consumption_compare_time_ranges_configuration.png
    title: 'Add Month and Year date fields to compare electricity consumption in different time ranges'
  1:
    image: /images/trendz/guide/building_energy/energy_consumption_compare_time_ranges_filters.png
    title: 'Add filtering options to focus on important places'
  2:
    image: /images/trendz/guide/building_energy/energy_consumption_compare_time_ranges_bar.png
    title: 'Compare electricity consumption in different time ranges on bar chart'

co2_emission_card_with_trend:
  0:
    image: /images/trendz/guide/building_energy/co2_emission_transform_formula_for_energy.png
    title: 'Add calculated field to compute carbon emissions based on energy consumption'
  1:
    image: /images/trendz/guide/building_energy/co2_emission_compare_with_prev_interval.png
    title: 'Enable comparison with previous interval to see trend'
  2:
    image: /images/trendz/guide/building_energy/co2_emission_card_with_trend_and_dynamic.png
    title: 'CO2 emissions card with trend and dynamic over last 7 days'

building_energy_dashboard:
  0:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_new.png
    title: 'Create new dashboard in ThingsBoard'
  1:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_config.png
    title: 'Set name to - Energy consumption report'
  2:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_aliases.png
    title: 'Configure required dashboard aliases'
  3:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_all_buildings_alias.png
    title: 'Use All Asset by type aliases to display all buildings in the dashboard'
  4:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_table.png
    title: 'Add table that shows all buildings in the system'
  5:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_configure_table.png
    title: 'Connect it with buildings alias'
  6:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_row_click_for_building.png
    title: 'Add Row-click event in buildings table'
  7:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_rowclick_configuration.png
    title: 'Row click event should update filters in all widgets on the dashboard'
  8:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_trendz_views.png
    title: 'Add all views from Trendz into new dashboard'
  9:
    image: /images/trendz/guide/building_energy/building_electricity_dashboard_add_trendz_confg.png
    title: 'Configure Trendz views to enable fitlering by building'

---


* TOC 
{:toc}

## Introduction

当今竞争环境中，企业持续寻求降低成本、提高利润并践行可持续经营。
对许多企业而言，能源消耗是主要支出之一，尤其是大型建筑运营。
然而没有准确的能耗数据，很难找到改进空间。这包括碳核算等日益重要的可持续运营要素。
本文将说明如何获取能耗模式洞察、找到改进点，并通过措施降低成本、提高可持续性，
将碳核算融入日常经营。

**任务定义** - 创建分析dashboard，分析建筑能耗来源并识别改进空间。

{% include images-gallery.html imageCollection="energy-analytic-dashboard" %}

### Implementation plan
* 创建按来源（HVAC、照明、插座负载、电梯等）拆分的能耗表格
* 创建按建筑内区域（办公室、会议室、厨房、仓储等）拆分的类似表格
* stacked bar chart对比按来源的能耗
* stacked bar chart 对比当月与上月、按月拆分
* 计算建筑碳排
* 创建带过滤选项的ThingsBoard dashboard以可视化数据

## Getting started:

### Prerequisites
建筑内已安装能量表并通过MQTT API连接至ThingsBoard。为简化数据聚合和分析，每块表有2个attribute：
* `sourceType` - 能耗来源名称（HVAC、照明、插座负载、电梯等）。同来源可有多个表
* `area` - 安装区域（办公室、会议室、大厅、厨房等）。同区域可有多个表

能量表与Building asset关联。每栋建筑与Customer关联。这些关系便于在不同层级聚合分析——可跟踪特定建筑或某customer所有建筑的指标。

### Step 1: Table with energy consumption by source
建筑内有多类能耗来源。为理解能耗结构，计算各来源类型的以下指标：

* 能耗（kWh）
* 价格（USD）
* CO2排放（kg）

该表格需支持任意建筑、任意时间范围。用户可按来源类型、区域和建筑过滤。开始配置：

* 在Trendz创建table视图
* 在columns区域添加`energyMeter.sourceType`——按表的来源类型拆分读数
* 在columns区域添加`energyMeter.usageKWH`，聚合选`SUM`——显示各来源总能耗
* 添加计算字段，label为**Price**，unit设为`$`，decimals为`2`。按建筑 energy price 计算各来源总价：

```javascript
var price = uniq(building.energyPrice);
var totalUsage = sum(energyMeter.usageKWH);

return totalUsage * price;
```

* 添加计算字段，label为**CO2 emissions**，unit为`kg CO2e`，decimals为`1`

```javascript
var emissionConversionFactor = 0.21233;
var totalUsage = sum(energyMeter.usageKWH);

return totalUsage * emissionConversionFactor;
```

便于理解报告，设置默认降序排列并添加过滤：

* 在filters区域添加`energyMeter.sourceType`
* 在filters区域添加`energyMeter.area`
* 在filters区域添加`building`
* 打开view settings的`General`区域，配置默认排序
  * 点击`Sort order`
  * 启用降序
  * Sort column——`usageKWH`
* 默认时间范围——this month
* 以名称**Energy consumption by source**保存报告

报告完成后，后续将添加到dashboard。

{% include images-gallery.html imageCollection="energy-consumption-by-source-table" %}

### Step 2: Table with energy consumption by area
可创建类似表格，但按区域而非来源类型。步骤与上一步相同。
唯一区别是使用`energyMeter.area`替代`energyMeter.sourceType`。以名称**Energy consumption by area**保存视图。

{% include images-gallery.html imageCollection="energy-consumption-by-areas-table" %}

### Step 3: Compare energy usage by source type
前两步表格适合获取精确能耗数字，但不便于快速对比不同来源。为便于按来源类型对比能耗，创建stacked bar chart。

* 在Trendz创建bar chart
* 在X-axis区域添加`energyMeter.sourceType`
* 在Y-axis区域添加`energyMeter.usageKWH`
* 在filters区域添加`building`
* 默认时间范围——this month
* 打开view settings的`General`区域，配置默认排序
  * 点击`Sort order`
  * 启用降序
  * Sort column——`usageKWH`
* 在view settings中勾选`Horizontal Bar`使bar chart水平
* 以名称**Bar: energy use compare by sources**保存

该可视化可更快理解系统主要消耗来源。

{% include images-gallery.html imageCollection="energy-compare-sources-bar" %}

### Step 4: Compare current and previous year energy usage with monthly breakdown
为更好理解同比、环比能耗变化，创建按月展示能耗的bar chart。并按年份拆分为多个series以对比不同年份的月度能耗。
配置如下：

* 在Trendz创建bar chart
* 在X-axis区域添加类型为`MONTH`的`Date`字段——按月拆分数据
* 在Y-axis区域添加`energyMeter.usageKWH`
* 在Series区域添加类型为`YEAR`的`Date`字段——按年拆分
* 在filters区域添加`energyMeter.sourceType`
* 在filters区域添加`energyMeter.area`
* 在filters区域添加`building`
* 默认时间范围——last 3 years
* 以名称**Bar: compare year-to-year energy usage**保存

该可视化便于快速定位高能耗月份，并与上年对比了解同比变化。

{% include images-gallery.html imageCollection="energy-compare-time-ranges" %}


### Step 5: Calculate carbon emissions and show dynamic over last 6 months
最终卡片需展示建筑整体CO2 footprint以简化碳核算。单一指标不足以说明全貌。既然做能耗分析，为该卡片增加洞察：
一是与上一时间段的对比；二是过去6个月碳排变化的小型chart。

* 在Trendz创建`Card with line chart`视图
* 添加计算字段，label为**CO2 emissions**，unit为`kg CO2e`，decimals为`1`

```javascript
var emissionConversionFactor = 0.21233;
var totalUsage = sum(energyMeter.usageKWH);

return totalUsage * emissionConversionFactor;
```

* 默认时间范围——this month

此时卡片已有当月CO2排放及日明细，可突出异常和趋势。启用对比：

* 打开`General` view settings
* 勾选`Enable comparison`为`true`
* 卡片标题设为**CO2 emissions**
* 以名称**Card: CO2 emissions insights**保存

卡片现在显示CO2排放对比。数值为相对上一时间段的百分比。默认：高于上一时段为绿色，低于为红色。
可在view settings中启用`Reverse compariosn colors`反转颜色方案。

{% include images-gallery.html imageCollection="co2_emission_card_with_trend" %}

### Step 6: Create energy consumption analytic dashboard in ThingsBoard
最后一步将此前创建的所有视图整合到一个交互式dashboard供用户使用。该dashboard可与所有customers共享，仅显示与用户相关的数据。
用户可使用过滤器选择建筑、能耗来源和区域。首先将所有Trendz视图添加到ThingsBoard的dashboard：

* 在ThingsBoard创建名为**Energy consumption report**的dashboard
* 在Trendz：对前几步创建的每个部件：
  * 点击`Share to ThingsBoard`，复制`Add on Dashboard`
  * 选择**Energy consumption report** dashboard
  * 勾选**Create alias**
  * Filter选择`Building`
* 返回ThingsBoard **Energy consumption report** dashboard并调整布局

然后创建用于dashboard过滤的aliases：

* 创建新alias **All buildings**——保存用户可见的所有建筑
  * Filter type——**Asset type**
  * Asset type——**Building**
* 创建新alias **Selected entity**——保存用户点击的实体
  * Filter type——**Entity from dashboard state**
  * State entity parameter name——`selectedEntity`

最后添加用于显示所有建筑/楼层/区域的hierarchy部件，供用户选择特定区域。用户点击实体后，**Filtered areas** alias会刷新并加载所选实体的所有区域。
之后dashboard上所有Trendz部件会更新，因其以**Filtered areas** alias为数据源。用户将看到所选区域的能耗数据。

* 在dashboard添加ThingsBoard table部件`Cards` -> `Entities table`，显示用户可见的所有建筑
  * 数据源alias设为**All buildings**
  * Latest data key——**Name**
* 为entity table部件添加`On row click` action，更新dashboard state中的`selectedEntity`参数
  * Action type——`Update current dashboard state`
  * State entity parameter name——`selectedEntity`
* 所有dashboard上的Trendz部件的数据源alias设为`selectedEntity`
* 保存dashboard

{% include images-gallery.html imageCollection="building_energy_dashboard" %}

## Summary
降低能耗和碳排对追求提高利润和可持续性的企业至关重要。
为此，获取能耗模式洞察、找到改进空间必不可少。
按本文实施计划，企业可创建分析dashboard，按建筑内来源和区域可视化能耗数据，
按月对比当年与上年，并计算CO2排放。这些步骤有助于降低成本、提高可持续性，
并为更可持续的未来做出贡献。以主动方式管理能耗，有助于在竞争中取得长期成功。
