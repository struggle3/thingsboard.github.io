* TOC
{:toc}

{% assign sinceVersion = "4.1" %}
{% include templates/since.md %}

自 ThingsBoard 4.1 起，部件支持根据所选单位制自动进行数据转换和单位切换。
这在全球 IoT 方案中尤为有用，可显著改善使用不同测量标准（如公制 °C、km、kg 与英制 °F、miles、lbs）的各地用户的数据交互体验。

<br><b><font size="4">主要优势：</font></b>

- 在部件内自动将数值转换为适当单位，无需额外数据处理。
- 灵活的部件配置，无需为采用不同地区单位标准的用户重复创建部件或单独 dashboard。
- 支持多种测量单位，用户可按最熟悉和便捷的单位查看数值。

<b><font size="4">单位转换功能适用于哪些场景？</font></b>

所有用于展示 telemetry 数据的部件均包含单位转换选项。
单位转换适用于 telemetry 数据、Y 轴刻度和阈值设置。

> **注意：** 若部件包含多个 telemetry key，需为每个 key 单独配置单位转换。

## 启用单位转换

单位转换在部件设置的 **telemetry keys**、**Y-axis** 和 **thresholds** 配置中的 **unit settings** 中配置。

- 指定 **source unit** — 即来自服务器且需正确转换为目标单位的 telemetry 数值单位。
- 通过切换“**Enable unit conversion**”开关启用单位转换。
- 系统会按单位制自动建议常用目标单位（如 Metric 为 °C、Imperial 为 °F、Hybrid 为 °C）。也可从下拉列表选择其他单位进行覆盖。

> **注意**：所有可用单位按类别分组（如温度、长度、质量）。目标单位只能选择与 source unit 同类的单位。

> **注意**：若未为某单位制指定单位，该单位制将回退使用 **Source unit** 字段中的单位。

- 点击“**Apply**”保存更改。

启用单位转换后，单位字段旁会出现图标，表示该功能已启用。

{% include images-gallery.html imageCollection="unit-conversion-configuring" %}

### Range color settings

**Range color settings** 使用从服务器接收的 **原始 telemetry 值**（在应用任何单位转换之前的 **units**）。

例如，若设备发送温度值 **22 °C** 且已启用单位转换，部件可能显示为 **71 °F**。
但 **范围逻辑仍使用原始 22 °C** 判定颜色。

因此，若定义 **18 至 24 °C** 的绿色范围，则该范围内的所有温度读数都将显示为绿色 —— 无论是 22 °C 还是 71 °F。

这样可确保 **范围着色保持一致**，切换单位制时亦然。

{% include images-gallery.html imageCollection="range-color-settings" %}

## Changing the unit system

更改 ThingsBoard 账户使用的单位制：
- 点击屏幕右上角 **三点图标**，选择“**Account**”。
- 在 **Profile** 设置中，从下拉列表选择所需单位制：
  - **Auto** - 根据用户浏览器区域或地区设置自动选择合适单位制。
  - **Metric** - 全球最广泛使用，基于米 (m)、千克 (kg)、秒 (s) 等单位。
  - **Imperial** - 常用于美国，基于英寸 (in)、英尺 (ft)、英里 (m)、磅 (lb)、加仑 (gal) 等单位。
  - **Hybrid** - 混合测量制，常见于英国。通常根据上下文混用公制和英制。例如：距离用英里 (mi)、温度用摄氏度 (°C)、体重用千克 (kg) 或英石 (st)。
- 应用更改。

{% include images-gallery.html imageCollection="changing-unit-system" %}

## Example

下面以 **Temperature & Humidity** dashboard 为例配置单位转换。
该 dashboard 包含显示 **摄氏度 (°C)** 的 **temperature** 和 **百分比 (%)** 的 **humidity** 的部件。

{% include images-gallery.html imageCollection="unit-conversion-example-1" %}

将为单位转换应用到 **temperature telemetry 值**、**temperature 图表的 Y 轴**和 **temperature 阈值**。
**humidity** 值保持不变，因为湿度测量单位为 **percentage (%)**，与所选 **unit system** 无关。

<b><font size="3">Step 1: Edit the Chart widget</font></b>

切换到“**Temperature and Humidity history**”图表部件的编辑模式。

首先，为“**temperature**” telemetry key 配置单位转换：
- 在“**temperature**” key 字段中点击“**Units**”行。可见 **source unit** 已设为 **Celsius** (°C)，符合需求。
- 启用转换：打开“**Enable unit conversion**”选项，并为各单位制指定目标单位（如 Imperial 为 °F，Metric 和 Hybrid 为 °C）。
- 点击“**Apply**”。

{% include images-gallery.html imageCollection="unit-conversion-example-2" %}

对 **Y-axis** 和 **threshold** 的温度值重复同样步骤——启用单位转换并为各测量制指定目标单位。
完成后应用所有更改。

{% include images-gallery.html imageCollection="unit-conversion-example-3" %}

<b><font size="3">Step 2: Edit the Temperature Card widget</font></b>

切换到“**Temperature**”卡片部件的编辑模式。

在“**Unit settings**”对话框中，如前启用单位转换并为各单位制提供合适单位。
应用更改并保存 dashboard。

{% include images-gallery.html imageCollection="unit-conversion-example-4" %}

由于当前单位制为 **Metric**，温度以摄氏度 (**°C**) 显示。

{% include images-gallery.html imageCollection="unit-conversion-example-5" %}

<b><font size="3">Step 3: Changing the unit system</font></b>

要查看单位转换效果，请将单位制改为 **Imperial**。
进入 **Account** 设置，找到“**Unit system**”下拉列表，选择 **Imperial**。

{% include images-gallery.html imageCollection="unit-conversion-example-6" %}

返回 dashboard，可看到温度值、Y 轴标签和阈值已根据所选单位制从摄氏度转换为华氏度。

{% include images-gallery.html imageCollection="unit-conversion-example-7" %}
