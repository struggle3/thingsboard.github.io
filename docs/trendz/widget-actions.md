---
layout: docwithnav-trendz
assignees:
  - vparomskiy
title: Trendz 部件操作
description: Trendz 部件操作说明

---

* TOC
{:toc}

## Configure OnRowClick action
Trendz Table view支持onRowClick action。可配置用户点击表格行时的行为，
例如将实体保存到Dashboard state alias或打开新的dashboard state。

启用行点击事件：
* 在ThingsBoard dashboard上添加Trendz Table View。
* 打开部件编辑模式，切换到**Actions**选项卡。
* 点击**Add action**按钮。
* 在**Action source**中选择**On row click**。
* 按标准部件动作进行配置。

每行可能包含来自一个或多个设备/asset的多个字段，即一行可与多个实体关联。
若使用'onRowClick' action，需定义点击行时选中的实体。
* 在Trendz View编辑模式下打开**View Settings**。
* 打开**View Mode fields**区域。
* 在**Row click entity**下拉中选择所需Device/Asset类型。
* 保存更改。

## Configure OnRowClick action for Anomaly

若在dashboard上使用Anomaly Table并希望创建不仅设置选中实体、还会更新时间窗口的action，请按以下步骤操作：
1. **配置Row Click Entity。** 在Trendz中打开chart settings，设置"Row click entity"。

   ![image](/images/trendz/row-click-anomaly.png)

2. **创建Row Click Action。** 在dashboard上Anomaly view settings的Actions选项卡中创建新action。选择"On Row click"作为Action source，类型设为"Custom action"。  
   然后添加自定义代码以将所选实体设为dashboard上的选中实体。先获取新state entity的state ID和参数。本示例使用"selectedDevice"，
   可按实际需求修改名称。最后更新时间窗口和state。

```javascript
let stateId = widgetContext.stateController.getStateId();
let stateParams = widgetContext.stateController.getStateParams();
stateParams.selectedDevice = {
    'entityId': entityId,
    'entityName': entityName
}

widgetContext.dashboard.onUpdateTimewindow(additionalParams.startTs, additionalParams.endTs); 
widgetContext.stateController.updateState(stateId, stateParams);
```
## Configure Date selected action

Trendz Calendar和Anomaly table支持date-selected action，可根据在calendar或anomaly timerange中选择的日期动态更新ThingsBoard dashboard的时间窗口。
启用date-select事件：
1. 在dashboard上添加Trendz View。
2. 进入部件编辑模式，打开Actions选项卡。
3. 点击"Add action"按钮。
4. 在"Action source"中选择"date-selected"。
5. 类型设为"Custom action"。自定义函数会通过additionalParams参数接收startTs和endTs。可使用下列代码更新dashboard时间窗口：

```javascript
widgetContext.dashboard.onUpdateTimewindow(additionalParams.startTs, additionalParams.endTs);
```

[//]: # (#### Configure Switch Field action)

## Configure Row Click to Select Multiple Entities

要在Trendz view中实现行点击选择多个实体，请按以下步骤操作。本例中表格显示建筑列表，每行有能量表数量和聚合能耗。
目标：点击某一行时，将能量表列表发送到dashboard上的alias。

![image](/images/trendz/row-click-select-entities.png)

**Step 1. 设置Trendz View**
1. 设置要发送到alias的实体的实体类型。本例为EM能量表。

   ![image](/images/trendz/set-up-trendz-view.png)
2. 将该视图发送到ThingsBoard Dashboard。

**Step 2. 在Dashboard上创建新Alias**
1. 命名Alias（记住名称以备后用）。
2. 开启"Resolve as multiple entities"。
3. Filter Type选择"Entity list"。
4. 在Entity Type中选择可通过行点击选择的实体类型。
5. 选择初始显示的默认实体。

![image](/images/trendz/create-new-alias.png)

**Step 3. 在Trendz View中配置Action**
1. Action source选择"On Row Click"。
2. 为action命名。
3. Action Type选择"Custom action"。

   ![image](/images/trendz/configure-action.png)
4. 编写自定义代码，将id写入此前创建的alias：

* 查找alias：
```javascript
let entityAlias = 
Object.values(widgetContext.aliasController.entityAliases).find(el => el.alias 
=== "Selected entities");
```

* Trendz view会在additionalParams中发送实体数组。将其转换为仅包含entity ID的数组，并赋给alias的entityList。
```javascript
if(entityAlias && additionalParams["entityIds"] && additionalParams["entityIds"].length) {
    let devices = additionalParams["entityIds"].map(entity => entity.entityId.id);
    entityAlias.filter.entityList = devices;

    widgetContext.updateAliases();    
}
```

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
