---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 计算到达目标值的时间
description: 基于预测遥测计算到达目标值的时间

calc-time-to-value-chart:
  0:
    image: /images/trendz/calculations/calc-time-to-value-1.png

calc-time-to-value-script:
  0:
    image: /images/trendz/calculations/calc-time-to-value-2.png

calc-time-to-value-output:
  0: 
    image: /images/trendz/calculations/calc-time-to-value-3.png

calc-time-to-value-job:
  0:
    image: /images/trendz/calculations/calc-time-to-value-4.png

calc-time-to-value-table:
  0:
    image: /images/trendz/calculations/calc-time-to-value-5.png

calc-time-to-value-alarm:
  0:
    image: /images/trendz/calculations/calc-time-to-value-6.png
  1:
    image: /images/trendz/calculations/calc-time-to-value-7.png
---

* TOC
{:toc}

预测遥测最常见的用途是估算直到特定事件发生所需的剩余时间。例如，预测油箱中的燃料何时耗尽或电池何时完全放电。
这些事件通常可定义为基于遥测值的条件。例如，燃料耗尽可表示为条件：fuel_in_tank <= minimal_fuel_threshold。电池电量或类似情况也适用相同逻辑。

此类任务的关键在于，我们评估的遥测值必须是预测值，即未来的值。获得预测后，我们可以确定值何时达到阈值，并计算直到事件发生还需多长时间。

我们还可创建告警规则，在即将达到临界值时触发通知或告警。为此，我们需要生成“倒计时遥测”，可使用 **计算字段** 实现。

**计算到达事件时间的步骤**

1. 创建所需遥测的预测模型。
2. 基于遥测值定义逻辑条件。
3. 创建计算字段以生成事件的倒计时遥测。
4. 基于倒计时遥测配置告警规则。

**示例：预测能耗阈值**

让我们考虑此功能的使用示例。今天是 2025 年 1 月 1 日，您有能源表设备，测量 kWh 单位的“能耗”遥测。我们拥有 2024 年全年的历史遥测。

## 构建预测模型

从创建具有以下参数的预测模型开始：

  * **名称：** 能耗预测
  * **业务实体：** 能源表
  * **ThingsBoard 键：** energy_consumption_prediction
  * **训练范围：** 2024/01/01 - 2024/12/31
  * **预测范围：** 30 天

模型成功训练后，您可看到未来 30 天的预测。您还构建了视图以显示这些预测（如截图中所示）。配置具有所需频率的自动化预测生成任务。

{% include images-gallery.html imageCollection="calc-time-to-value-chart" %}

## 基于遥测值定义逻辑条件

您知道能耗超过 15 kWh 对表来说过高（例如），并希望在其发生前 3 天做出反应。因此，15 kWh 为遥测阈值，3 天为时间阈值。故条件为“能耗预测”>= 15000。

## 计算到达事件时间

接下来，您需要创建 **计算字段**：
  * **名称：** 能耗预测倒计时
  * **ThingsBoard 键：** energy_consumption_prediction_countdown

在此计算字段中，您将加载所有预测遥测点并找到第一个满足阈值条件的点。使用以下设置：
* **字段类型：** BATCH
* **聚合：** AVG
* **分组间隔：** days（用于倒计时计算）
* **时间策略：** FIXED（指定加载预测遥测的未来时间范围）

我将使用“今年”来加载 2025 年所有预测点（反正我们只有 1 月的数据）。对于脚本，您可使用下面附带的通用可配置模板——需要更改一些参数才能使其工作：
* **inputTelemetry** - 指定创建的预测模型的预测遥测
* **limit** - 指定事件条件的值阈值
* **up** - 指定“true”表示上限，“false”表示下限
* **timeUnit** - 指定用于倒计时的时间单位，若要根据上下文（计算字段的时间单位）设定，则保留“groupBy”
* **timeUnitDefault** - 当计算字段依赖上下文但上下文未提供值时使用的默认时间单位

包含所需参数的模板：

```js
/// Inputs
var inputTelemetry = none(EM energy meter.Energy Consumption Prediction); // List of (ts, value), internal function

var limit = 15000;              // Options: Any number
var up = true;                  // Options: is true, check the actual value higher then limit. False - lower then limit
var timeUnit = groupBy;         // Options: "null", groupBy, "minute", "hour", "day", "week", "month"
var timeUnitDefault = "hour";   // Options: "minute", "hour", "day", "week", "month"

/// Code
var now = Date.now();

inputTelemetry = inputTelemetry
    .filter(function(point) {
        return point.ts > now;
    })
    .sort(function(a, b) {
        return a.ts - b.ts;
    });
    
var referencePoint = null;
for (var i = 0; i < inputTelemetry.length; i++) {
    if (up) {
        if (inputTelemetry[i].value >= limit) {
            referencePoint = inputTelemetry[i];
            console.log('Found top limit: ' + new Date(referencePoint.ts) + ' - ' + referencePoint.value);
            break;
        }
    } else {
        if (inputTelemetry[i].value <= limit) {
            referencePoint = inputTelemetry[i];
            console.log('Found bottom limit: ' + new Date(referencePoint.ts) + ' - ' + referencePoint.value);
            break;
        } 
    }
}

if (!referencePoint) {
    console.log('The limit is not Found!');
    return [];
}

var referenceTime = referencePoint.ts;
console.log('Reference Time: ' + new Date(referenceTime));

var timeUnits = {
    "minute": 1000 * 60,
    "hour": 1000 * 60 * 60,
    "day": 1000 * 60 * 60 * 24,
    "week": 1000 * 60 * 60 * 24 * 7,
    "month": 1000 * 60 * 60 * 24 * 30,
};

if (groupBy === 'null') {
    console.log('Aggregation is not provided by context, use simple value as result');
    
    if (typeof timeUnits[timeUnit] === 'undefined') {
        timeUnit = timeUnitDefault;
        console.log('Timeunit is not provided, use default');
    }
    if (timeUnit === null) {
        return 'Error during calculation Time To Value, you need to specify correct default time unit, actual: ' + timeUnit;
    }
    var distance = (referenceTime - now) / timeUnits[timeUnit];
    var resultPoint = {
        ts: now,
        value: distance
    };
    
    console.log("The distance is " + distance + " " + timeUnit + "s");
    return [resultPoint];
} else {
    console.log('Aggregation is provided by context: ' + groupBy);
    console.log('Used time unit: ' + timeUnit);
    
    if (typeof timeUnits[timeUnit] === 'undefined') {
        return 'Error during calculation Time To Value, unknown time unit: ' + timeUnit;
    }
    
    inputTelemetry = inputTelemetry
        .filter(function(point) {
            return point.ts <= referenceTime;
        })
        .map(function(point) {
            var timeDifference = referenceTime - point.ts;
            var unitDifference = Math.round(timeDifference / timeUnits[timeUnit]);
            return { ts: point.ts, value: unitDifference };
        })
        .sort(function(a, b) {
            return a.ts - b.ts;
        });
        
    return inputTelemetry;
}

return 'Error during calculation Time To Value'; 
```

最后，您将得到如下截图所示的计算字段。

{% include images-gallery.html imageCollection="calc-time-to-value-script" %}

您还可使用计算字段的测试功能查看结果

{% include images-gallery.html imageCollection="calc-time-to-value-output" %}

现在需要启用计算字段，以使倒计时遥测在 ThingsBoard 中可用并针对每天保持最新。

{% include images-gallery.html imageCollection="calc-time-to-value-job" %}

现在您可以返回可视化并添加带有预测的新遥测。您可将视图模板更改为表格，以便最终用户更简单地分析到达事件时间。

**警告：** 请注意，首次启动时倒计时遥测仅存在于未来时间，此后仅会更新未来的值。

{% include images-gallery.html imageCollection="calc-time-to-value-table" %}

## 配置告警生成

现在我们有了倒计时遥测，且其在 ThingsBoard 中可用，我们可以创建告警规则，让系统在未来出现问题时通知我们。为此，我们需要找到所需设备的设备/资产配置文件。

然后，进入编辑模式，打开“告警规则”选项卡，点击“添加告警规则”按钮，您将看到新告警规则的模板。

{% include images-gallery.html imageCollection="calc-time-to-value-alarm" %}
