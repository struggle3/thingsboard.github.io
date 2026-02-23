* TOC
{:toc}

## 简介

高级数据 key 配置负责图表部件上特定数据 key 列或线条的可见性、样式和外观。

“**Alarms table**”部件及“**Tables**”、“**Entity widgets**”和“**Entity admin widgets**”bundle 使用[相同的高级数据 key 配置](#advanced-data-key-configuration)。

“**Charts**”部件 bundle 有[独立的高级数据 key 配置](#advanced-data-key-configuration-for-charts-widget-bundle)。

其它所有部件 bundle 仅支持[基础数据 key 配置](/docs/{{docsPrefix}}user-guide/widgets/#data-keys)。

<br>
要进入数据 key 配置，点击需调整的特定数据 key 旁铅笔图标。

{% if docsPrefix == null %}
![image](/images/user-guide/widgets/advanced-data-key/enter-data-key-configuration-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/widgets/advanced-data-key/enter-data-key-configuration-pe.png)
{% endif %}

## 高级数据 key 配置 {: #advanced-data-key-configuration }

“Alarms table”部件、“Tables”、“Entity widgets”和“Entity admin widgets”bundle 使用相同的高级数据 key 配置。
下面以“Tables”bundle 中的“Entities table”部件为例说明高级数据 key 配置。

请按下列步骤开始 key 的高级配置。

{% include images-gallery.html imageCollection="entity-table-example" showListImageTitles="true" %}

### 自定义列标题

默认列名与 key 名相同。_"Custom header title"_ 选项允许将列标题改为任意文本。

{% include images-gallery.html imageCollection="custom-header-title" %}

### 列宽（px 或 %）

_"Column width"_ 功能允许以像素或百分比调整列宽。可手动输入所需宽度（如 200px）。
同样可改为百分比宽度。

{% include images-gallery.html imageCollection="column-width" %}

### 单元格样式函数

_"Cell style function"_ 允许根据值、实体或 [ctx](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/#basic-widget-api) 调整行颜色。
配置时需勾选 _Use cell style function_，并在下方 _Cell style function_ 字段中输入函数。

{% include images-gallery.html imageCollection="style-function" %}

单元格颜色随值变化的 Cell style function 示例：

```ruby
if(value < 0) {
   return {"background-color" : "#5F4DEB"};
} else if (value < 35) {
    return {"background-color" : "#62c5e3", "color" : "#19154a"};
} else if (value < 45) {
    return {"background-color" : "#b50232", "color" : "#f7e18f"};
} else if (value < 55) {
    return {"background-color" : "#e6b500", "color" : "#ff2200"};
} else if (value < 65) {
    return {"background-color" : "#ff9419"};
} else if (value < 75) {
    return {"background-color" : "#d0ff00"};
} else if (value < 85) {
    return {"background-color" : "#35c433"};
} else { 
    return { "background-color" : "red" };
}
```
{: .copy-code}

### 单元格内容函数

_"Cell content function"_ 允许根据值、实体或 [ctx](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/#basic-widget-api) 修改数据 key 列文本。
配置时需勾选 _Use cell content function_，并在下方 _Cell content function_ 字段中输入函数。

示例中设备有两种返回：true 或 false。Cell content function 可修改返回文本显示，适用于设备数量不多的场景。

{% include images-gallery.html imageCollection="content-function-1" %}

```ruby
if (value == "true") {
    return "Active";
} else {
    return "Inactive";
}
```
{: .copy-code}

但有时通过返回文本来判断设备是否在线并不方便。
Cell content function 提供更友好的方式，可通过自定义函数以图标等形式展示设备的在线/离线状态（参见下方示例）。

{% include images-gallery.html imageCollection="content-function-2" %}

用于显示在线/离线状态的函数示例：

```ruby
if (value == "true") {
    return '<div style="border-radius:50%;background-color:green;width:18px;height:18px"></div>';
} else {
    return '<div style="border-radius:50%;background-color:red;width:18px;height:18px"></div>';
}
```
{: .copy-code}

### 默认列可见性 {: #default-column-visibility }

_"Default column visibility"_ 用于选择数据 key 列在部件中是否默认可见或隐藏。
导出部件需排除特定数据 key 时特别有用。

{% include images-gallery.html imageCollection="column-visibility" %}

### 「Column to display」中的列选择

_"Column selection in 'Column to display'"_ 用于选择该列是否出现在可见性选择菜单中。无权限的客户端将无法隐藏该列。

{% include images-gallery.html imageCollection="column-to-display" %}

### 导出时包含列

{% assign feature = "Include in column in export" %}{% include templates/pe-feature-banner.md %}

_"Include column in export"_ 用于选择在何种条件下导出部件时包含该数据 key 列。
选项包括：always、仅当列可见时（可在 [default column visibility](#default-column-visibility) 中修改可见性）和 never。

{% include images-gallery.html imageCollection="column-export" %}

## "Charts" 部件 bundle 的高级数据 key 配置 {: #advanced-data-key-configuration-for-charts-widget-bundle }

“Charts”部件 bundle 的高级数据 key 配置与其它 bundle 不同。

下面以“Charts”bundle 中的“Timeseries Line Chart”部件为例说明数据 key 配置。

请按下列步骤开始数据 key 的高级配置。

{% include images-gallery.html imageCollection="timeseries-line-chart-example" showListImageTitles="true" %}

### 默认隐藏数据

默认情况下，数据源中指定 key 的所有数据会显示在图表上。

启用所选 key 的 _"Data hidden by default"_ 功能后，该 key 的数据默认在图表上隐藏。

{% include images-gallery.html imageCollection="data-is-hidden-by-default" %}

### 禁用数据隐藏

启用所选 key 的 _"Disable data hide"_ 功能后，你及用户将无法通过点击 key 名称在图表上隐藏该数据。

{% include images-gallery.html imageCollection="disable-data-hiding" %}

### 从图例移除 datakey

启用 _"Remove datakey from legend"_ 功能，可禁止所选 key 在图例中显示。

{% include images-gallery.html imageCollection="remove-datakey-from-legend" %}

### Exclude from stacking

可将特定 key 排除出堆叠。该功能仅在“Stacking”模式下可用。
有关 stacking 模式及用法请参阅[此处](/docs/{{docsPrefix}}user-guide/widgets/#common-settings)。

### 显示线条

可通过 _"Show line"_ 功能在图表上显示或隐藏线条，并设置线条宽度（像素）。

{% include images-gallery.html imageCollection="show-line" %}

#### 填充线条

启用 _"Fill line"_ 功能，可填充线条与图表下边界的区域。可指定填充透明度（0 到 1）。

{% include images-gallery.html imageCollection="fill-line" %}

### 显示数据点

启用 _"Show points"_ 功能，在图表上显示数据点。
可指定点的线条宽度（像素）、半径（像素）和形状。

{% include images-gallery.html imageCollection="show-points" %}

### Tooltip 设置

通过高级部件设置自定义 _tooltip_ 是同时应用于所有数据 key 的基础设置。
有关部件的 Tooltip 设置请参阅[此处](/docs/{{docsPrefix}}user-guide/widgets/#tooltip-settings)。

通过所选数据 key 的 _"Tooltip value format function"_，可单独配置该 key 在 tooltip 中显示的值，此配置会覆盖基础 tooltip 函数。

{% include images-gallery.html imageCollection="tooltip-settings" %}

### 垂直轴

启用 _"Show separate axes"_ 可为该数据 key 显示独立坐标轴。可为该轴设置标题、刻度最小/最大值、小数位数以及垂直轴刻度步长。

{% include images-gallery.html imageCollection="vertical-axis-1" %}

在 _"Ticks formatter function"_ 窗口中指定用于格式化 Y 轴刻度显示值的函数。

{% include images-gallery.html imageCollection="vertical-axis-2" %}

### 阈值

使用该功能为所选 key 设置 _threshold_ 值。阈值将作为水平线显示在图表上。
可指定该线的颜色和宽度。

{% include images-gallery.html imageCollection="thresholds" %}

### 对比设置

在图表上显示历史数据，便于比较不同时间段的数据。
该功能在部件设置中激活 _comparison mode_ 时生效。
有关 comparison 设置及用法，请参阅[此处](/docs/{{docsPrefix}}user-guide/widgets/#comparison-settings)。
