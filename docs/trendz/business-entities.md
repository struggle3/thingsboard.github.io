---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 业务实体
description: 业务实体
---

本指南介绍 Trendz 如何使用 ThingsBoard 中的实体，如资产、设备、关系等。

* TOC
{:toc}

## 业务实体拓扑

假设我们有一个智能楼宇解决方案。我们的拓扑包含建筑物、公寓和不同的表计，它们通过关系相互连接。拓扑结构如下：

![image](/images/reference/pe-demo/smart-metering-model.svg)

实际上，Trendz 将此拓扑作为扁平表处理，表中包含此拓扑内所有设备/资产的属性和遥测的列。实体之间的关系用于连接来自不同业务实体的字段。

## 工作原理

下面通过以下报告检查 Trendz 如何从 ThingsBoard 解析数据：我们仅使用智能楼宇拓扑中的 2 个字段：

- 属于 Building 资产的 `building name`
- 属于 Energy Meter 设备的 `energy` 遥测
- 聚合类型 `SUM`
- 时间范围 - 上月

* Trendz 将在 ThingsBoard 中找到所有可用建筑物。
* 然后找到每个建筑物的所有公寓。
* 最后找到属于公寓的所有 Energy Meter。
* 之后，对于每个建筑物的所有 Energy Meter，Trendz 将加载上月所有 energy 遥测
* Trendz 使用 `SUM` 聚合加载的所有遥测。
* 最终可以查看每个建筑物的能耗。

以上并非精确的算法描述，后台有大量优化。但这有助于理解 Trendz 内部处理的复杂性，让您专注于分析而非数据获取。

## 管理业务实体之间的关系

ThingsBoard 允许用户在设备和资产之间创建多种关系且无限制。然而在 Trendz Analytics 中，关系基于底层 ThingsBoard 关系在业务实体（设备/资产配置）之间建立。这种方法对 Trendz 中关系的处理引入了一些限制，特别是关于设备/资产配置之间允许的关系数量。

在 Trendz Analytics 中，存在一个关键约束：**设备/资产配置之间仅允许一种关系类型**。此限制对于确保稳定的项加载顺序是必要的。当同一设备/资产配置之间存在多种关系时，Trendz 无法确定使用哪种关系，导致影响数据检索的未定义行为。

**示例场景：**

考虑以下配置和关系的示例：

* **配置：**
  * `Building`
  * `Apartment`
  * `EnergyMeter`
* **关系：**
  * `contains (Building → Apartment)`
  * `contains (Apartment → EnergyMeter)`
  * `connected (Apartment → EnergyMeter)`

在此场景中，若查询要获取与特定 `Building` 关联的所有 `EnergyMeter`，Trendz 将面临不确定性——是包含直接连接至 `Building` 的 `EnergyMeter`，还是包含 `Building` 通过中间 `Apartment` 所包含的 `EnergyMeter`。这种不确定性源于 `Apartment` 与 `EnergyMeter` 之间的多种关系。

**解决方案：**

要解决此问题并确保正确的查询结果，用户必须使用业务实体页面上的 **Enabled** 复选框功能审视和配置业务实体的关系。请按以下步骤操作：

1. **导航至业务实体页面：** 点击页面左下角的按钮访问业务实体配置。
2. **选择相关业务实体：** 选择要修改关系的业务实体（如 `EnergyMeters` 和 `Apartment`）。
3. **打开关系选项卡：** 进入所选业务实体后，进入 `Relations` 选项卡查看所有关联关系。
4. **禁用不需要的关系：** 对于每个不需要的关系，取消勾选 **Enabled** 复选框以停用。
5. **保存更改：** 点击 **Save** 按钮应用更改。

![image](/images/trendz/be-enable-relation.png)

此过程确保仅必要的关系处于活动状态，避免冲突并支持准确生成报告。

按照以上步骤，您可以消除不确定性并稳定 Trendz Analytics 中的数据查询，有效利用“Enabled”复选框功能管理关系。

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
