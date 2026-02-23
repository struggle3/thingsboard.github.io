---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 缓存设置
description: Trendz 缓存设置
---

* TOC
{:toc}

Trendz 有许多内置优化机制，用于缩短报告生成时间。大多数机制开箱即用，无需任何配置。但部分机制需由管理员显式启用。

## Trendz 缓存级别

Trendz 支持 2 个缓存级别——`View Report` 缓存和 `Metrics long term cache`。要理解它们之间的区别，首先需了解 Trendz 中报告的生成方式：

1. 用户创建 View 配置，添加所需字段，然后点击 Build Report。
2. Trendz 根据 view 配置生成查询执行计划。查询计划包含字段加载顺序和聚合策略。
3. 系统根据查询计划和配置的筛选器加载所需项（设备\资产）。
4. 系统为每项加载字段值并聚合。
5. 最后一步，生成 View Report 并传递到 UI 进行可视化。

大部分时间花在项加载和数据加载（步骤 3 和 4）。通过在这些步骤缓存中间结果，可提升系统性能。

`View Report cache` - 若查询计划未更改，可直接返回缓存的 View Report，而无需从 ThingsBoard 加载数据。
`Metrics long term cache` - 当数据可按固定间隔（如小时或日期）分组时，可从缓存加载已计算\聚合的字段值，而非从 ThingsBoard 重新加载。

## Metrics long term cache

要启用此类型缓存——打开 view settings，导航至 **Caching settings** 并勾选 **Enable caching**。

启用缓存后，系统会将聚合的项字段数据存储在缓存中。可以是遥测、状态或计算字段。若字段值已在缓存中，系统将复用。若尚未存在，系统将从 ThingsBoard 直接加载并保存到缓存。

此缓存不与特定可视化绑定，当同一字段在多个视图中使用时可以复用。

### 缓存间隔

Trendz 缓存包含特定时间间隔的聚合字段数据。用户可定义用于数据缓存的时间间隔。

**Full Date** - 遥测数据按天聚合。每天在缓存中有一个值。
**Full Hour** - 遥测数据按小时聚合。每小时在缓存中有一个值。

选择何种时间单位取决于需求，但多数情况下按天聚合即可。按小时聚合仅在最终报告具有 HOUR 维度时有用。例如，周热力图因 X 轴有 HOUR 字段而可能需要。

### 计划缓存刷新

默认情况下，缓存仅在按下 Build Report 按钮时初始化/更新。当用户首次加载每日\每周生成的重型报告时，这可能至关重要。此时缓存中可能尚无值，系统将直接从 ThingsBoard 加载数据，导致用户需等待数分钟才能看到报告。

我们可以在后台触发定期缓存刷新。这样，当需要报告时，可以确保所有值已加载到缓存中，用户无需等待原始报告生成。

* 打开 View settings
* 导航至 **Caching** 部分
* 勾选 **Auto refresh**
* 选择刷新间隔。例如每天。
* 保存更改

后台缓存刷新时，Trendz 将向 ThingsBoard 发送请求。所有此类请求需经身份验证并使用 JWT token 签名。要启用此类身份验证，管理员应在 Trendz 配置文件中定义 login\password 对——`ADMIN_LOGIN` 和 `ADMIN_PASSWORD`。若不执行此步骤，计划缓存刷新将无法工作，缓存仅在用户通过 UI 或 Rest API 请求报告时刷新。

### 清除缓存

如需可清除长期缓存。若在 ThingsBoard 中重新导入或更改历史数据，此功能可能有用。

* 点击左下角的 System settings 图标
* 打开 Settings
* 在 **Caching** 部分点击 **Clear cache** 按钮

## View Report cache

某些情况下，可以复用已计算的 View Report，而无需从头计算。当具有多状态的仪表板中添加了视图且用户在不同状态间主动切换时，此功能很有帮助。每次打开状态时，UI 将向服务器请求 View Report。

在使用缓存 Report 之前，应检查以下条件：

* 查询计划未更改。
* 时间范围未更改。
* 现有 View Report 未过期。

要启用此类型缓存：

* 在系统设置中启用——`cache.report.enabled` - 默认已启用。
* 在 View Settings -> Caching -> 勾选 **Cache Report** - 默认已启用。
