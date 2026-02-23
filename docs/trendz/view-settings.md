---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 视图设置
description: Trendz 视图设置
---

* TOC
{:toc}

**View Settings**图标位于每个视图右下角。通过这些设置可控制可视化的展示方式及不同视图类型下的数据行为。

## General Settings

- **Title** – 视图顶部显示的文本
- **Size** – 标题字体大小（vh单位，默认：1）

多数视图通用：

- **Enable filter auto refresh** – 实时更新过滤器值。默认仅在点击"Build"时加载
- **Remove empty series** – 隐藏无telemetry的条目
- **Hide legend** – 切换图例显示  
  若显示：
  - **Legend position** – top、right、bottom或left

- **Show toolbox export** – 添加导出选项（CSV、XLS、XLSX）  
  若启用：
  - **Show date range and filters** – 在导出文件中包含过滤器上下文
    - **Filter to show in XLS** – 选择要包含的过滤器
  - **Rotate export result** – 导出结果行列互换

### Card View

- **Size Content** – 主内容字体大小（vh单位，默认：1）
- **Show label** – 在卡片上显示字段标签
- **Show icon** – 在卡片上显示所选图标

### Table View

- **Sort order** – 启用按列排序。单击一次启用，再击禁用  
  选项：
  - **Order way** – 升序或降序
  - **Sort column** – 选择排序列
  - **Select top** – 按排序显示前N行

- **Column fit** – 调整列宽  
  选项：
  - Fit headers – 基于列标题
  - Fit cells – 基于内容
  - Fit screen – 填满全宽

- **Show total row** – 为数值列添加合计行

### Bar View

- **Dashed line** – 使柱 outline 为虚线
- **Horizontal bar** – 水平显示柱
- **Stacked bar** – 将值堆叠  
  若启用：
  - **100% stacked** – 将柱归一为相同高度（比例显示）

- **Tooltip type** – 悬停时tooltip行为  
  选项：
  - axis – 按X-axis值显示
  - item – 按X-axis和series显示
  - none – 不显示tooltip

- **Show labels** – 在柱上直接显示数值
- **Show timeline** – 添加时间选择timeline（配合date字段使用）
- **Use single Y-axis** – 若数值单位相同则共享同一刻度
  - **Y-axis label** – 共享Y-axis的标签

- **Hide Y-axis label** – 隐藏Y-axis标签
- **Hide X-axis label** – 隐藏X-axis标签  
  若显示：
  - **X-axis position** – 选择top或bottom

- **Sort bars** – 启用柱排序  
  选项：
  - **Order way** – 升序或降序
  - **Target field** – 选择排序字段
  - **Select top** – 限制为前N个柱

- **Manual Y/X axis range** – 设置轴边界
  - **Y-axis min / max** – 纵轴范围
  - **X-axis min / max** – 显示的柱范围

### Line View

- **Dashed line** – 线条边框使用虚线
- **Stroke type** – 数据点连接方式  
  选项：
  - smooth – 曲线连接
  - straight – 直线连接
  - stepline – 90°阶梯连接（阶梯状）

- **Show labels** – 在线上直接显示数值
- **Show timeline** – 添加时间选择timeline（配合date字段使用）
- **Use single Y-axis** – 若数值单位相同则共享同一刻度
  - **Y-axis label** – 共享Y-axis的标签

- **Hide Y-axis label** – 隐藏Y-axis标签
- **Hide X-axis label** – 隐藏X-axis标签  
  若显示：
  - **X-axis position** – 选择top或bottom

- **Trend line** – 添加表示整体趋势的直线

- **Manual Y/X axis range** – 设置轴边界
  - **Y-axis min / max** – 纵轴范围
  - **X-axis min / max** – 横轴范围

### Pie View

- **Show labels** – 在每个扇区旁显示数值  
  若启用：
  - **Show sector name** – 标签上显示扇区名称
  - **Show sector value** – 标签上显示扇区值
  - **Show sector percent** – 标签上显示扇区百分比

- **Sort order** – 启用按字段排序。单击一次启用，再击禁用  
  选项：
  - **Order way** – 升序或降序
  - **Target field** – 选择排序字段
  - **Select top** – 按排序显示前N个值

### Scatter Plot View

- **Tooltip type** – 悬停时tooltip行为  
  选项：
  - axis – 显示特定X-axis值下series中所有item的值
  - item – 显示特定item的值
  - none – 不显示tooltip

- **Hide Y-axis label** – 隐藏Y-axis标签
- **Hide X-axis label** – 隐藏X-axis标签  
  若显示：
  - **X-axis position** – 选择top或bottom

- **Trend line** – 添加表示整体趋势的直线

- **Manual Y/X axis range** – 设置轴边界
  - **Y-axis min / max** – 纵轴范围
  - **X-axis min / max** – 横轴范围

### Heat Map

- **Show labels** – 在每个单元格上直接显示数值
- **Hide Y-axis label** – 隐藏Y-axis标签
- **Hide X-axis label** – 隐藏X-axis标签  
  若显示：
  - **X-axis position** – 选择top或bottom

- **Sort order** – 启用按列排序。单击一次启用，再击禁用  
  选项：
  - **Order way** – 升序或降序
  - **Target field** – 选择排序字段
  - **Select top** – 按排序显示X-axis前N个值

### Heat Map Calendar

- **Range** – 显示的数据范围  
  选项：
  - full – 全部数据
  - trim to current day – 不显示当前日之后的数据
  - trim all – 不显示空月份（无边框）

- **Stretch** – 若启用，heat map calendar占满视图宽度

### Card With Line

- **Size Content** – 主内容字体大小（vh单位，默认：1）
- **Enable comparison** – 若启用，显示定义时间范围内最后一个值与第一个值相比的百分比增减  
  若启用：
  - **Reverse comparison colors** – 若启用，正向变化显示红色，负向显示绿色

## Query Params

假设ThingsBoard中已注册2栋建筑和2个传感器，关系如下：

- **Building A**包含**Sensor_1**
- **Building B**无传感器
- **Sensor_2**未分配到任何建筑

要创建显示每栋建筑传感器数量的视图。结果取决于计算所用的**root entity**：

- 若**Building**为root——Building A显示1个，Building B显示0个
- 若**Sensor**为root——Sensor_1关联1栋建筑，Sensor_2未分配

可通过以下参数控制查询构建：

- **Preview mode** – 加载有限数据集预览视图效果
  - **Preview item count** – 预览时加载的root item数量

- **Entities Root** – 覆盖Trendz自动选择的默认root entity

- **Topology Entities** – Trendz通过Topology Graph查找所有已用实体间最短路径构建查询计划  
  对于复杂图，最短路径可能不是最优——可手动指定包含的实体

- **Raw data loading** – 直接从ThingsBoard加载未聚合数据

- **Enable multi-root items loading** – 允许同一视图中处理多个root级实体

## View Mode Fields

这些设置仅在视图全屏显示或嵌入ThingsBoard dashboard的Trendz部件时生效。[更多说明](/docs/trendz/widget-actions/)

- **Hide filters** – 隐藏过滤器区域
- **Hide date filters** – 隐藏日期选择器
- **Hide group by** – 隐藏group-by下拉
- **Hide AI Summary button** – 隐藏AI summary选项
- **Get filter values from URL** – 从浏览器URL查询参数加载过滤器
- **Set filter values to URL** – 将所选过滤器值保存到浏览器URL
- **Hidden filters** – 隐藏指定过滤器
- **Row click entities** – 点击chart或表格项时，将选中实体发送到ThingsBoard alias  
  常用于触发其他部件的过滤器更新  
  [详见](/docs/trendz/widget-actions/#configure-onrowclick-action)

### Anomalies View

- **Hide anomalies list** – 隐藏视图中的anomalies列表
- **Hide anomalies chart** – 隐藏视图中的anomalies chart

## AI Assistant

- **Prompt** – 选择点击**AI Summary**按钮时使用的AI prompt  
  更多关于AI Summary按钮[见](/docs/trendz/ai-widget-summary#trendz-widgets)  
  自定义prompt见[本指南](/docs/trendz/ai-assistance-prompts)

## Colors

- **Annotations** – 在chart上高亮背景范围以表示级别  
  可添加多个annotations，每个包含：
  - **From Y** – Y-axis上的起始值
  - **To Y** – Y-axis上的结束值
  - **Color** – annotation的背景色

- **Theme** – 选择部件主题：
  - **Default**、**Light**、**Dark**或**Custom**
  - 若选**Custom**：
    - **Background** – 部件背景色
    - **Text** – 文本颜色

## Cache

[cache说明](/docs/trendz/cache-settings/)

- **Cache Report** – 当查询计划和时间范围未变时使用缓存的View Report（默认启用）
- **Enable caching** – 启用Metrics Long-Term Cache
  - **Caching Time Unit** – 选择数据聚合粒度
  - **Auto Refresh** – 按计划在后台预加载cache：
    - **Every** – 间隔值
    - **Time Unit** – 时间单位（如hour、day）

## Chart Option

可使用JSON格式微调所有chart设置。

**左侧面板（Editor）：**
- **Merged** – 显示完整chart配置，可直接编辑
- **Delta** – 仅显示相对默认配置的变更
- **Cancel changes** – 清除所有未保存修改
- **Hide data** – 隐藏item中的实际数值。适用于隐私或分享配置
- **Save** – 应用并保存修改

**右侧面板（Preview）：** 实时预览JSON修改对chart的影响。

## Next Steps

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}
