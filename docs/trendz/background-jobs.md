---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 后台处理作业
description: Trendz Analytics 中的后台处理作业
---

* TOC
{:toc}

在 Trendz 中，可创建在固定时间间隔自动执行特定数据处理任务的后台作业。  
支持的作业类型有三种：`cache refresh job`（缓存刷新作业）、`save telemetry job`（保存遥测作业）和 `anomaly autodiscovery job`（异常自动发现作业）。  
这些作业在后台运行，无需用户干预。但需在 ThingsBoard 中为后台作业配置认证方式，以保证执行安全。

## 作业认证
后台作业通过 API 周期性从 ThingsBoard 获取数据，这些请求需要认证。要实现此功能，须将 JWT 签名密钥存入 Trendz 配置文件。  
具体步骤及签名密钥校验说明见[安装后步骤页面](/docs/trendz/post-installation-steps/#signing-key)。

## 缓存作业
Trendz 中的缓存自动刷新作业用于定期更新数据源缓存。  
该预取方式可加快从 ThingsBoard 获取数据，支持预聚合和后台计算。  
定期刷新缓存后，可视化所需数据在用户请求时即可可用，提升数据展示的速度与效率。

## 保存遥测作业
Trendz 提供转换原始遥测、计算新指标、预测时序行为和检测异常的工具。  
可将计算结果以新遥测形式保存到 ThingsBoard 中的设备或资产。该能力支持构建复杂数据处理流水线，并按预设条件触发操作。  
Save Telemetry 作业支持在 Trendz 中按计划周期执行，确保新上报遥测得到处理并将结果写回 ThingsBoard，实现数据处理自动化并增强 IoT 应用能力。

## 异常自动发现作业
在 Trendz 中构建的异常检测模型用于识别设备和资产采集数据集中的异常。  
模型配置完成后，可按既定计划用于检测实时异常。  
Trendz 从 ThingsBoard 拉取新数据、应用异常检测模型并保存新发现的异常。  
该自动化流程保证对 IoT 数据的持续监控与及时异常检测，为主动决策提供支撑。

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
