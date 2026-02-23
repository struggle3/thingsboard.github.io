---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 日历热力图
description: Trendz 日历视图 
---

* TOC
{:toc}

Heatmap Calendar部件以逐日明细展示一年内指标变化概览。

![image](/images/trendz/calendar_heatmap.png)

## Single field configuration

将所需指标加入**Value**区域，点击**Build Report**。可添加telemetry、state或计算字段。

calendar中每个单元格的颜色由当天数值决定。无值时单元格为空白。
可在View Settings中更改颜色方案。

## Multiple fields

可在**Value**区域添加多个字段。此时可通过单选按钮切换显示的字段。

![image](/images/trendz/calendar_heatmap_multiple.png)

## Select date action

Trendz calendar view支持日期点击事件。适用于选择感兴趣日期并进一步下钻分析。

例如在ThingsBoard创建包含多个部件的dashboard。所有部件使用dashboard的时间范围。
通过配置calendar部件上的date click事件，可设置dashboard的时间范围，使其他部件自动更新并显示所选日期的数据。

* 在ThingsBoard dashboard上添加Trendz calendar view
* 打开部件编辑模式，切换到**Actions**选项卡
* 点击**Add action**按钮
* 在**Action source**中选择**date-selected**
* 在**Type**中选择**Custom action**，使用下列函数

```javascript
var newTimeRange = {
    aggregation: {
        limit: 30000,
        type: "NONE"
    },
    hideAggInterval: false,
    hideAggregation: false,
    hideInterval: false,
    history: {
        historyType: 1,
        fixedTimewindow: {
            startTimeMs: additionalParams.startTs,
            endTimeMs: additionalParams.endTs
        }
    },
    selectedTab: 1
}
    
// apply new time range 
widgetContext.dashboard.dashboardTimewindowChangedSubject.next(newTimeRange);

var params = {
    entityId: entityId,
    entityName: entityName,
    entityLabel: entityLabel,
}

// open new dashboard state        
widgetContext.stateController.updateState('consumption_details', additionalParams.params);
```
 
通过此custom action可将dashboard时间范围改为所选日期，并导航到名为**consumption_details**的新dashboard state。

## Switch field action

当**Value**区域添加了多个字段时，会激活Switch field选择器。用户可从部件中选择要显示的字段。
Trendz View在用户切换字段时触发特殊事件。可在switch事件触发时执行所需action。

* 在ThingsBoard dashboard上添加Trendz calendar view
* 打开部件编辑模式，切换到**Actions**选项卡
* 点击**Add action**按钮
* 在**Action source**中选择**changed-radio-button**
* 按标准部件action配置

所选字段名称在**additionalParams.radioButton**属性中。
