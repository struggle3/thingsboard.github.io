---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 将计算值保存为 ThingsBoard 中的遥测
description: 将计算值保存为 ThingsBoard 中的遥测

save-calc-to-tb:
  0:
    image: /images/trendz/save-calc-to-tb-1.png
    text: 点击 JOBS 按钮打开保存计算遥测任务参数对话框。
  1: 
    image: /images/trendz/save-calc-to-tb-2.png
    text: 1. 启用/禁用将计算结果保存到 ThingsBoard。2. 指定保存计算遥测的起始点。3. 定义遥测更新频率。4. 选择将保存计算遥测的特定设备。
---

Trendz 中的计算字段可根据现有遥测和属性计算各种指标。
这些指标可服务于不同目的，从报告可视化到触发操作或在其他计算中重用。
此外，Trendz 允许您将这些计算的指标作为设备或资产遥测保存回 ThingsBoard，从而增强您的 IoT 应用功能。
以下为此功能的几个使用示例：

* 通过将计算指标用作进一步计算或预测的输入参数，您可以提高后续分析的准确性和有效性。
  这使您能够基于可靠数据做出更明智的决策。
* 基于计算遥测创建告警可实现主动监控和及时响应。
  通过设置阈值或条件，当计算值达到临界水平时可触发告警。这确保及时采取适当措施。
* 利用计算遥测，您可以设置向相关方提供实时更新或告警的通知。
* 性能优化 - 指标计算并保存为遥测后，您可以优化 Trendz 服务器性能。
  无需在每次需要时加载原始遥测并重新计算指标，可直接从 ThingsBoard 加载预计算指标。
  这减轻了服务器负载，实现更快、更高效的操作。

## 计算任务

保存计算字段后，可激活以启动两个主要任务并将数据作为遥测存储在 ThingsBoard：
1. *重处理历史数据：*
* 此任务运行一次，以分析选定时间范围内的数据。
* 激活后立即启动。
2. *实时刷新：*
* 此任务允许您指定数据更新频率并选择要刷新的项目。
* 任务按固定间隔计划运行，确保数据保持最新。

要计划保存计算结果的任务，请按以下步骤操作：
* 点击 JOBS 按钮打开保存计算遥测任务参数对话框。
* 在对话框中，可配置以下参数：
  1. 启用/禁用将计算结果保存到 ThingsBoard。
  2. 指定保存计算遥测的起始点。
  3. 定义遥测更新频率。
  4. 选择将保存计算遥测的特定设备。
* 配置参数后，点击保存应用更改。

{% include images-gallery.html imageCollection="save-calc-to-tb" %}

### 将计算存储为遥测

保存这些设置后，您的计算将以键名前缀为 \_ECD_ 的遥测形式记录在 ThingsBoard 中，计算状态设置为“已启用”

生成的数据在业务实体列表中的视图字段构建下以创建时分配给计算的名称显示，
如果已激活，将根据创建任务时指定的频率进行更新。创建的计算将在视图字段下以创建时赋予的名称显示。

![image](/images/trendz/calculations/name-calculation-field.png)

如果计算未激活，仍可在构建视图字段时使用，但用户将收到提醒，表明尚未为此计算创建任务。

您可随时在保存后使用 ENABLE 按钮激活计算字段。



## 下一步

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}
