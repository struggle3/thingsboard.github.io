---
layout: docwithnav-trendz
title: 异常刷新与重新处理
description: 配置 Trendz 中异常刷新和重新处理任务的文档，包括调度、遥测保存和告警创建。
---

* TOC
{:toc}

**提示：** 在先前版本中，**Refresh** 称为 **Autodiscovery**，**Reprocess** 称为 **Apply to**。

## 异常刷新

异常刷新功能使系统能自动检测持续异常，将其保存到 ThingsBoard，或基于其创建告警。

访问异常刷新设置：点击 **"JOBS"** 按钮。将看到以下选项：

* **Refresh Frequency Settings（刷新频率设置）：** 定义刷新作业重新发现异常的频率。
  * **Execute at the beginning of the time unit（在时间单位开始时执行）：** 若启用，任务将在所选时间单位开始时启动。  
    **示例：** `EVERY 1 TIME UNIT MONTH` — 任务将在每月第一天 00:00 运行。

* **Choose Items（选择设备）：** 选择将执行刷新的设备（或资产）。

* **Enable Saving Anomaly Data（启用异常数据保存）：** 若启用，将使用[输入部分](/docs/trendz/anomaly/overview#input-tab)中指定的遥测键将异常分数和异常分数指数保存到 ThingsBoard。  
  [更多关于保存遥测到 ThingsBoard 的说明](/docs/trendz/anomaly/save-to-tb)。

* **Enable Anomaly Alarms Creation（启用异常告警创建）：** 若启用，将为检测到的异常创建告警。  
  [更多关于创建异常驱动告警的说明](/docs/trendz/anomaly/alarms)。

**注意：** 异常模型重建后，刷新将自动禁用。

**注意：** 刷新频率与遥测保存频率不同。  
**示例：** 若刷新频率为 1 天，遥测保存频率为 1 小时，则作业每天运行一次，每设备每天保存 24 个分数点和 24 个分数指数点。

## 异常重新处理

异常重新处理功能允许将训练好的异常模型应用于特定时间范围和所选设备的历史数据。  
适用于评估模型在不同时段的表现，或历史记录中新增遥测数据后的分析。

访问重新处理设置：进入**任务**标签页，点击 **"Run Reprocess Task"** 按钮。将看到以下选项：

* **Date Range（日期范围）：** 重新处理异常的时间范围。
* **Items for Anomaly Reprocess（异常重新处理设备）：** 重新处理期间要处理的设备或资产。
* **Enable Anomaly Creation Toggle（启用异常创建开关）：** 若启用，将为重新处理期间发现的异常自动创建告警。
* **Enable Saving Telemetry Toggle（启用遥测保存开关）：** 若启用，遥测将保存到 ThingsBoard。仅当当前异常模型已启用刷新且保存遥测到 ThingsBoard 时，此开关才可启用。

**注意：** 仅当启用异常刷新且异常刷新设置中的 **Enable Saving Anomaly Data** 开关为活动状态时，遥测才会保存到 ThingsBoard。
**注意：** 重新处理过程中，所选时间范围内所选设备（当前模型）先前保存的所有异常将被覆盖。


## Next Steps

{% assign currentGuide = "AnomalyDetection" %}{% include templates/trndz-guides-banner.md %}
