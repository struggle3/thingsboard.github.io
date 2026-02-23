* TOC
{:toc}

## 概述

本指南将介绍图表部件：其功能、特性、部件的基本和高级设置，以及部件的数据键。

图表部件允许您使用可自定义的折线图和柱状图显示时序数据。此外，您还可使用多种饼图显示最新值。

## 如何创建图表部件

要将任意图表部件添加到仪表板，请执行：

{% include images-gallery.html imageCollection="charts-addwidget" showListImageTitles="true" %}

## 图表部件类型

图表部件分为时序部件和最新值部件。时序部件用于可视化时序数据随时间的变化。当需要查看多个实体的最新属性值或时序数据时，使用最新值部件。

### 时序部件

时序部件可视化时序数据随时间的变化。此处了解如何[设置时间窗口](/docs/{{docsPrefix}}user-guide/dashboards/#time-window)。

#### 柱状图

[柱状图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#timeseries-bar-chart)部件显示时序数据随时间的变化。示例显示温度读数。

{% include images-gallery.html imageCollection="charts-bar" %}

#### 折线图

[折线图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#timeseries-line-chart)部件显示时序数据随时间的变化。示例显示温度和湿度读数。

{% include images-gallery.html imageCollection="charts-line" %}

#### 状态图

[状态图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#state-chart-1)部件显示实体状态随时间的变化。
例如，设备开关时其状态和条件。

{% include images-gallery.html imageCollection="charts-state" %}

### 最新值部件

最新值部件渲染多个实体的属性或时序数据的最新值。最新值部件主要支持数值。

#### 雷达图

雷达图部件在雷达图中显示多个实体的最新属性或时序数据值。仅支持数值。

示例中，部件显示三个设备的最新压力时序数据。

{% include images-gallery.html imageCollection="charts-radar" %}

#### 极区图

极区图部件在极区图中显示多个实体的最新属性或时序数据值。仅支持数值。

示例中，部件显示三个设备的最新压力时序数据。

{% include images-gallery.html imageCollection="charts-polar" %}

#### 饼图 - Chart.js

饼图 - Chart.js 部件在饼图中显示多个实体的最新属性或时序数据值。仅支持数值。

示例中，部件显示三个设备的最新温度时序数据值。

{% include images-gallery.html imageCollection="charts-piejs" %}

#### 饼图 - Flot

[饼图 - Flot](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#latest-values-pie---flot)部件在饼图中显示多个实体的最新属性或时序数据值。
仅支持数值。

示例中，部件显示三个设备的最新压力时序数据值。

{% include images-gallery.html imageCollection="charts-pieflot" %}

#### 环形图

[环形图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#latest-values-doughnut)部件在环形图中显示多个实体的最新属性或时序数据值。
仅支持数值。

示例中，部件显示三个设备的最新湿度时序数据值。

{% include images-gallery.html imageCollection="charts-doughnut" %}

#### 条形图

条形图部件以独立条形显示多个实体的属性或时序数据的最新值。
是唯一不仅支持数值的最新值图表部件。

示例中，部件显示三个设备的最新压力时序数据值。

{% include images-gallery.html imageCollection="charts-bars" %}

## 图表部件设置

### 基本部件设置 

基本部件设置负责部件的外观和样式：从标题样式和图例配置到移动设备设置。
ThingsBoard 所有部件的基本设置相同，此处了解如何[自定义](/docs/{{docsPrefix}}user-guide/dashboards/#basic-widget-settings)。

### 高级部件设置

不同部件类型的高级设置各不相同。高级设置负责配置特定部件的独特功能。
要进入部件编辑模式并开始配置其高级设置，请先进入仪表板编辑模式。然后执行：

{% include images-gallery.html imageCollection="charts-bar-advanced" showListImageTitles="true" %}

#### 时序柱状图

##### 1. 常用设置

**1.1.** 堆叠

若数据聚合函数**未**设为 None，可使用此功能。
若勾选“堆叠”框，柱形将根据所用实体的值进行拆分。
若不勾选，部件将显示所用实体值的总和。要查看所有实体的值，需将鼠标悬停在柱形上。

{% include images-gallery.html imageCollection="charts-bar-adv-stacking" showListImageTitles="true" %}

若数据未聚合，可通过更改数值调整**非聚合数据的默认柱宽（毫秒）**。此操作使图表柱形更宽。

**柱形对齐**负责柱形在图表部件上相对于时间点的位置。

**所有阈值的默认线宽**、**阴影大小**、**字体颜色和大小**适用于时序折线图和状态图部件。

**Tooltip 值格式函数 f(value)** 用于手动自定义 tooltip。可通过[设置](/docs/{{docsPrefix}}user-guide/dashboards/#5-other-settings)或
[高级数据键配置](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#2-charts)自定义将在 tooltip 中显示的值。
通过设置配置 tooltip 为基础配置，同时应用于所有实体。在高级数据键配置中配置时，
仅应用于特定时序数据，基础 tooltip 函数将被子配置覆盖。

但若部件需要特殊效果，可使用 Tooltip 值格式函数。
假设有温度读数，希望在部件上看到摄氏和华氏值，并以两位小数显示。

{% include images-gallery.html imageCollection="bars-tooltipfunction" showListImageTitles="true" %}

**1.2.** 网格设置

可更改图表网格的外观：自定义背景颜色、网格边框及其刻度；更改线条宽度及开启/关闭可见性。

{% include images-gallery.html imageCollection="bars-grid" showListImageTitles="true" %}

**1.3.** 坐标轴设置

{% include images-gallery.html imageCollection="bars-axis" showListImageTitles="true" %}

**1.4.** 刻度格式化函数 f(value)

假设遥测值非常大，尤其数值旁有特殊符号时。然而需要绘制小图（仪表板上空间有限）。
因此，可使用刻度格式化函数将刻度值转换为更紧凑的形式。

{% include images-gallery.html imageCollection="bars-ticksfun" showListImageTitles="true" %}

##### 2. 对比设置

对比设置允许比较特定时间段内的值差异。仅在历史时间窗口中有效。

{% include images-gallery.html imageCollection="bars-comparison" showListImageTitles="true" %}

##### 3. 自定义图例设置

自定义图例设置用于在图表图例中显示无法在图表中显示的数据（如属性）或仅显示特定时序。例如，active/inactive 属性无法在图表中显示，只能在表格部件中显示。

{% include images-gallery.html imageCollection="bars-legend" showListImageTitles="true" %}

#### 时序折线图

_时序折线图_部件的高级设置与时序柱状图相同。可在此[上文](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#timeseries-bar-chart)了解这些设置。

##### 1. 显示平滑（曲线）线 

{% include images-gallery.html imageCollection="lines-smooth" showListImageTitles="true" %}

###### 2. 所有阈值的默认线宽

{% include images-gallery.html imageCollection="lines-thresholds" showListImageTitles="true" %}

#### 状态图

##### 1. 常用设置

**1.1.** 堆叠

堆叠模式适用于需要查看实体值的部件。

**1.2.** 显示平滑（曲线）线仅适用于折线图。

**1.3.** 悬停单个点

勾选**悬停单个点**框时，线条上不会显示数值点。

**1.4.** 堆叠模式中的累积值

堆叠模式开启时，可勾选“累积值”框使图表显示所有实体值的总和。

**1.5. Tooltip 值格式函数 f(value)** 用于手动自定义 tooltip。可通过[设置](/docs/{{docsPrefix}}user-guide/dashboards/#5-other-settings)或
[高级数据键配置](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#2-charts)自定义将在 tooltip 中显示的值。
通过设置配置 tooltip 为基础配置，同时应用于所有实体。在高级数据键配置中配置时，
仅应用于特定时序数据，基础 tooltip 函数将被子配置覆盖。

在状态图中，可根据实体值配置在 tooltip 中显示的实体状态。

<summary>
<b>使用函数设置所需配置：</b>
</summary>

{% highlight ruby %}
let celsiusValue = parseFloat(value).toFixed(2);
let farenheitValue = parseFloat(celsiusValue*1.8 + 32).toFixed(2);
return celsiusValue + ' °C (' + farenheitValue + ' °F)';
{% endhighlight %}

{% include images-gallery.html imageCollection="state-tooltipfunction" showListImageTitles="true" %}

**1.6. 网格设置**

网格设置与[时序柱状图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#1-common-settings)相同。

**1.7. 坐标轴设置**

坐标轴设置与[时序柱状图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#1-common-settings)相同。

**1.8. 刻度格式化函数**

{% include images-gallery.html imageCollection="state-ticksfun" showListImageTitles="true" %}

##### 2. 对比设置

{% include images-gallery.html imageCollection="state-comparison" showListImageTitles="true" %}

##### 3. 自定义图例设置

自定义图例设置与[时序柱状图](/docs/{{docsPrefix}}user-guide/ui/chart-widget/#3-custom-legend-settings)相同。

#### 最新值饼图 - Flot

##### 1. 半径

设置饼图的半径。若值在 0 到 1（含）之间，则按可用空间（容器大小）的百分比使用。否则将直接以像素长度使用该值。

{% include images-gallery.html imageCollection="pieflot-radius" showListImageTitles="true" %}

##### 2. 内半径

设置环形孔半径。若值在 0 到 1（含）之间，则按半径的百分比使用。否则将直接以像素长度使用该值。

{% include images-gallery.html imageCollection="pieflot-innerradius" showListImageTitles="true" %}

##### 3. 启用饼图动画

实体值变化时饼图 - Flot 会移动，但移动较生硬。饼图动画可使移动更平滑柔和。

{% include images-gallery.html imageCollection="pieflot-animation" showListImageTitles="true" %}

##### 4. 倾斜

倾斜百分比范围 0 到 1，1 表示无变化（完全垂直），0 表示完全平坦（完全水平，此时不绘制任何内容）。
倾斜值现用于计算饼图相对于容器高度的最大半径。
可防止饼图在某些情况下过小，并减少饼图上下方产生的额外空白。

{% include images-gallery.html imageCollection="pieflot-tilt" showListImageTitles="true" %}

##### 5. 描边

{% include images-gallery.html imageCollection="pieflot-stroke" showListImageTitles="true" %}

#### 最新值环形图

##### 1. 边框

{% include images-gallery.html imageCollection="donut-border" showListImageTitles="true" %}

##### 2. 图例设置

{% include images-gallery.html imageCollection="donut-legend" showListImageTitles="true" %}

