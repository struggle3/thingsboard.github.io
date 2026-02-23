---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 表格
description: Trendz 表格视图 
---

* TOC
{:toc}

## Video Tutorial

&nbsp; 
  
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/oFYlDUGS0mI" frameborder="0" allowfullscreen></iframe>
    </div>
</div>


## Simple Table
此模式下，仅需将字段拖放到**Columns**区域。每个字段对应表格一列。
可排序、过滤行，调整列顺序等。
 
Telemetry字段聚合：
* 若列中无**Date**字段——Trendz对整个时间范围应用聚合函数。

![image](/images/trendz/simple-table.png)

* 若列中有**Date**字段——系统将时间范围拆分为多个时间段，分别对每个时间段应用聚合。

![image](/images/trendz/simple-table-with-date.png)

## Table With Dynamic Columns
此表格变体可将telemetry聚合作为额外列显示，而非单独行。
操作：将telemetry字段加入**Dynamic Value**区域，将Date字段加入**Dynamic Column**区域并设置日期分组。
 
![image](/images/trendz/table-dynamic-columns.png)
 
可将任意字段（date/attribute）加入**Dynamic Column**区域构建所需表格。例如：每栋建筑的能耗作为一列，楼层作为行。

![image](/images/trendz/table-dynamic-building.png)

**注意**：使用Dynamic Columns时，**Dynamic Value**和**Dynamic Column**区域仅允许一个字段。
若任一区域添加了多个字段，表格将为空。但**Columns**区域仍可添加多个字段。

## Table with Individual Time Range for Column
有时为看到更大图景，需要对比同一实体在不同时间范围的数据。例如：今日、昨日和过去一个月的能耗。
此时将telemetry字段加入**Dynamic Value**区域，为字段启用并选择**local date**，**Dynamic Column**区域留空。注意可将同一telemetry字段多次添加并设置不同local date。

![image](/images/trendz/table-local-date.png)

## Default Sorting
为快速区分原始数据，可在构建表格时配置列排序。

设置列排序：

* 进入Setting区域
* 选择列并应用排序方式：descending或ascending

![image](/images/trendz/table-sort.png)

## Cell Colors
使用颜色规则根据单元格值着色。

在所选telemetry的卡片上激活Color function，选择颜色类型：Auto或Manual。可创建多个自定义颜色范围。

* 选择要着色的字段
* 打开**Color Function**菜单
* 启用Colors
* 选择颜色类型：Auto或Manual

Trendz支持两种颜色规则：

* Auto Color Rule——自动将数据范围划分为四个等级并相应着色。
* Manual Color Rule——对指定取值范围应用特定颜色。

![image](/images/trendz/table-color.png)


## Total Row

当字段聚合类型为**SUM**或**COUNT**时，表格底部显示Total行。
此时系统会对每列所有单元格求和并显示合计值。

## On row click action
Trendz Table view支持onRowClick action。可配置嵌入ThingsBoard Dashboard后用户点击表格行时的行为，
例如将实体保存到Dashboard state alias或打开新的dashboard state。

启用行点击事件：
* 在ThingsBoard dashboard上添加Trendz Table View。
* 打开部件编辑模式，切换到**Actions**选项卡。
* 点击**Add action**按钮。
* 在**Action source**中选择**On row click**。
* 按标准部件action配置。

每行可能包含来自一个或多个设备/assets的多个字段，即一行可与多个实体关联。
若使用'onRowClick' action，需定义点击行时选中的实体。
* 在Trendz View编辑模式下打开**View Settings**。
* 打开**View Mode fields**区域。
* 在**Row click entity**下拉中选择所需Device/Asset类型。
* 保存更改。
