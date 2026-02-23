---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 预测设备下次维护的剩余时间
description: 工业设备预测性维护系统

predictive-maintenance-dashboard:
  0:
    image: /images/trendz/guide/predictive_maintenance/predict_remaining_time_to_next_maintenance_of_the_equipment.png
    title: 'Predict remaining time to next maintenance of the equipment'
    
predictive-maintenance-forecast-next-maintenance-time:
  0:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_create_table_St1_1.png
    title: 'Create table view in Trendz Analytics'
  1:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_add_fields_St1_2.png
    title: 'Add Machine and calculated field into columns section'
  2:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_prediction_calculated_St1_3.png
    title: 'Calculate remaining time to next maintenance based on production forecast'

predictive-maintenance-save-remaining-time-as-telemetry:
  0:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_rename_St2_1.png
    title: 'Define key name for calculated telemetry'
  1:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_TB_calculated_telemetry_save_St2_2.png
    title: 'Enable telemetry save in Tb calculated telemetry save section'
  2:
    image: /images/trendz/guide/predictive_maintenance/Remaining_time_row_click_entity_St2_3.png
    title: 'Set Machine entity as row click entity'

predictive-maintenance-create-alarm:
  0:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_open_machine_device_St3_1.png
    title: 'Go to Alarm rules section in ThingsBoard'
  1:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_create_alarm_rule_St3_2.png
    title: 'Define Alarm that will be raised when remaining time less than 14 days'
  2:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_less_than_St3_3.png
    title: 'Set threshold condition to create an alarm'
  3:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_clear_alarm_rule_St3_4.png
    title: 'Add clear condition to close active alarm'    
  4:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_save_alarm_St3_6.png
    title: 'Save alarm rule'

predictive-maintenance-notify-maintenance-team:
  0:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_open_root_rule_chain_St4_1.png
    title: 'Go to default rule chain in ThingsBoard'
  1:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_to_email_St4_2.png
    title: 'Add toEmail node with email properties'
  2:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_to_email_setup_St4_3.png
    title: 'Set dynamic email body to notify maintenance team'
  3:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_alarm_add_link_St4_4.png
    title: 'Connect node with device profile node'
  4:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_send_email_St4_5.png
    title: 'Add send email node'
  5:
    image: /images/trendz/guide/predictive_maintenance/Predict_remaining_rule_chain_view_St4_6.png
    title: 'Final rule chain view'

---

* TOC
{:toc}

## Introduction

FRTB-ZH3瓶盖组装设备每小时可生产200–350件，但负载波动使预防性维护排期困难。
为减少计划外停机、降低故障风险，计划在每台设备生产50万个瓶盖后进行维护。
为有足够时间订购配件和安排维护团队，需在计划维护前两周收到通知。
借助Trendz Analytics，我们实现了可预测每台设备维护时间并在足够提前量下接收通知的预测性维护方案，
使设备保持高效运行、减少计划外停机。

**任务定义** - 预测每台瓶盖组装设备生产50万个瓶盖的天数，并创建提前14天通知的告警。

{% include images-gallery.html imageCollection="predictive-maintenance-dashboard" %}

### Implementation plan
* 使用Trendz Analytics创建每台设备瓶盖产量预测
* 计算每台设备生产50万个瓶盖的剩余天数
* 将计算出的剩余天数保存为设备telemetry
* 在ThingsBoard创建剩余时间小于14天时的告警
* 告警触发后向维护团队发送邮件

### Key outcomes
* 计划外停机减少24%
* 维护成本降低10%
* 维护团队效率提升18%

## Getting started:

### Prerequisites

组装设备已通过OPC-UA integration连接ThingsBoard，telemetry数据可在ThingsBoard中获取。详见[connectivity guides](https://thingsboard.io/docs/pe/guides/#AnchorIDConnectYourDevice)。
设备上报多种telemetry，本例仅使用`capsProduced`。


### Step 1: Create a forecast for the amount of caps produced by machine
首先创建每台设备的瓶盖产量预测。设备每5分钟上报一次产量，格式为`{ts: 1675421880000, values: { capsProduced: 738}}`。
该值持续累加，维护后重置。我们先预测未来3个月的`capsProduced` telemetry。

* 创建table
* 在columns区域添加`machine name`——为每台设备生成独立预测
* 在columns区域添加计算字段
* 勾选batch calculation
* 勾选`Prediction`
    * Prediction method——**Fourier transformation**
    * Prediction range——3
    * Prediction unit——months

为batch calculated字段启用prediction后，Trendz会基于设备原始telemetry构建预测，并将其作为计算函数的输入。
在计算函数中需找到达到阈值的时点并返回距该点的剩余天数。若未来3个月内未达到阈值则返回-1。

* 编写返回下次维护剩余时间的函数

```javascript
var threshold = 500000;
var remainingDays = -1;

var data = none(machine.capsProduced);
for(var i = 0; i < data.length; i++) {
    var point = data[i];
    if(point.value >= threshold) {
        var timeDeltaMillis = point.ts - Date.now();
        remainingDays = timeDeltaMillis / 1000 / 60 / 60 /24;
        break;
    }
}

return [{ts: 1, value: remainingDays}];
```

点击`Build Report`后，将看到每台设备的预计下次维护剩余天数。

{% include images-gallery.html imageCollection="predictive-maintenance-forecast-next-maintenance-time" %}

### Step 2: Save remaining time as a machine telemetry
下一步将计算出的剩余时间保存为设备telemetry。Trendz会定期对新数据执行计算函数，并将结果作为设备telemetry写回ThingsBoard。
需设置计算函数的执行频率。本例为每小时一次。

* 将计算字段的label改为**capsForecast**——Trendz会以该名称将计算结果保存为telemetry
* 在view settings的`Tb calculated telemetry save`中启用telemetry保存
    * Enabled——true
    * Save interval——1
    * Save unit——hours
* 在settings中打开`View mode fields`区域，在`Row click entity`下拉选择**Machine**——告诉Trendz计算telemetry应保存到哪个实体下
* 默认时间范围——**Last 7 days**
* 以名称**Machine maintenance remaining days forecast job**保存视图

视图保存后，Trendz会安排后台任务定期执行计算函数并将结果保存为设备telemetry。每次运行会从ThingsBoard拉取新数据并在其上执行计算。

{% include images-gallery.html imageCollection="predictive-maintenance-save-remaining-time-as-telemetry" %}

### Step 3: Create alarm if remaining time less than 14 days
此时每台设备在ThingsBoard已有`capsForecast` telemetry，表示距下次维护的天数。可在ThingsBoard创建Alarm Rule，当剩余时间小于14天时告警。

* 在ThingsBoard打开设备device profile，添加Alarm Rule
* Alarm type——**Maintenance required**
* Create alarm rule
  * Severity——`Warning`
  * Condition——`capsForecast`小于`14`
* Clear alarm rule
  * Condition——`capsForecast`大于`14`

Alarm rule创建后，剩余时间小于14天时ThingsBoard会触发告警，大于14天时清除。

{% include images-gallery.html imageCollection="predictive-maintenance-create-alarm" %}

### Step 4: Send notification once alarm created
最后一步是告警触发后通知维护团队。使用ThingsBoard Rule Engine发送邮件。
若device profile中的Alarm Rule触发告警，可捕获该事件并添加发送邮件步骤。

* 在ThingsBoard打开Root rule chain
* 在`Device profile`节点后添加`toEmail` rule node，并与`Alarm Created` relation连接
* 打开`toEmail`节点settings，配置向维护团队发送邮件
  * `From template`——info@testmail.org
  * `To template`——maintenance@testmail.com
  * `Subject template`——Maintenance required for ${entityName}
  * `Body template`——Maintenance required for ${entityName}. Remaining time: ${capsForecast} days
* 在`toEmail`节点后添加`send email` rule node，并与`Successfull` relation连接
* 保存rule chain

如此配置后，告警触发时ThingsBoard会向维护团队发送通知。

{% include images-gallery.html imageCollection="predictive-maintenance-notify-maintenance-team" %}

## Summary
使用Trendz Analytics实施预测性维护策略，有助于减少制造现场设备计划外停机、提高瓶盖组装设备效率。
通过预测每台设备何时生产50万个瓶盖，并在计划维护前14天通知维护团队，
可确保配件和资源就位，完成维护并预防设备故障。

总体而言，借助Trendz Analytics等高级分析工具的预测性维护策略，
能通过事前识别潜在问题、减少设备停机、降低计划外维护需求，帮助企业降低成本、提升运营效率。
