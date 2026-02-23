---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 批量计算字段
description: 批量计算字段
---

* TOC
{:toc}


当批量计算选项被禁用时——您编写的是每次处理 1 个值的函数。但当批量
计算启用时，您将处理整个原始遥测数组。启用 `Batch calculation` 复选框后，
您可以更好地控制如何将原始遥测转换为所需指标。例如，您可以编写可访问前一遥测值的函数，可根据需要筛选或排除遥测值参与计算，可按时间戳对遥测分组并对组应用转换。

原始遥测数组在计算函数中转换并返回后，系统将对该数组应用所需的聚合。

## 基本语法

假设您为遥测数据创建以下变量：

```javascript
var temperatureReadings = none(thermostat.temperature);
```

在这种情况下，`temperatureReadings` 变量将是遥测对象数组：

```json
[
	{
		"ts": 1622505600000,
		"value": 17
	},
	{
		"ts": 1622592000000,
		"value": 21
	},
	{
		"ts": 1622678400000,
		"value": 35
	}
]
```

对于属性，您也会得到一个包含 1 个表示属性的对象的数组。以下是在脚本中使用属性的示例：

```javascript
var unit = uniq(thermostat.measureUnit);
if(unit.length) {
    unit = unit[0].value;
}
```


**注意**：使用批量计算字段时，仅支持以下聚合类型：
* NONE（适用于遥测数据）
* UNIQ（适用于属性）

## 示例

### 筛选原始遥测

您可以从指标计算中排除部分遥测值。在此示例中，我们将排除所有大于 40 的温度值：

```javascript
var temperatureReadings = none(thermostat.temperature);

var filteredReadings = [];

for (var i = 0; i < temperatureReadings.length; i++) {
    var tsValue = temperatureReadings[i];
    if(tsValue.value <= 40) {
        filteredReadings.push(tsValue);
    }
}

return filteredReadings;
```

### 修改原始遥测

以下是根据属性值转换原始遥测数组的示例：

```javascript
var temperatureReadings = none(thermostat.temperature);

var unit = uniq(thermostat.measureUnit);
if(unit.length) {
    unit = unit[0].value;
}

for (var i = 0; i < temperatureReadings.length; i++) {
    var tsValue = temperatureReadings[i];
    if(unit === 'Fahrenheit') {
        tsValue.value = 5 / 9 * (tsValue.value - 32);
    }
}

return temperatureReadings;
```

### 按时间戳对多个遥测分组

```javascript
var voltageTelemetry = none(energyMeter.voltage);
var temperatureTelemetry = none(energyMeter.temperature);
var pressureTelemetry = none(energyMeter.pressure);

var groupedTelemetry = {};

groupTelemetryByTime(voltageTelemetry, groupedTelemetry, 'voltage');
groupTelemetryByTime(temperatureTelemetry, groupedTelemetry, 'temperature');
groupTelemetryByTime(pressureTelemetry, groupedTelemetry, 'pressure');

// ... execute transformation

groupTelemetryByTime = function (telemetry, groupedTelemetry, keyName) {
    for (var i = 0; i < telemetry.length; i++) {
        var ts = telemetry[i].ts;
        if(!groupedTelemetry[ts]) {
            groupedTelemetry[ts] = {ts: ts};
        }
        groupedTelemetry[ts][keyName] = telemetry[i].value;
    }
};

```
 
### 填充遥测流中的间隙

在此示例中，我们演示如何检测时间序列流中的间隙并用 `0` 值填充：

```javascript
var temperatureReadings = none(thermostat.temperature);

var timeGap = 30 * 60 * 1000; // 30 minutes
for (var i = 1; i < temperatureReadings.length; i++) {
    var tsDelta = temperatureReadings[i].ts - temperatureReadings[i - 1].ts;
    if (tsDelta > timeGap) {
        var newTs = (temperatureReadings[i].ts + temperatureReadings[i - 1].ts) / 2;
        temperatureReadings.splice(i, 0, {ts: newTs, value: 0})
    }
}

return temperatureReadings;
``` 

## 下一步

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}
