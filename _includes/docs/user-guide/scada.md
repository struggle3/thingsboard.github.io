* TOC
{:toc}

{% assign sinceVersion = "3.8.0" %}
{% include templates/since.md %}

[SCADA](https://en.wikipedia.org/wiki/SCADA)（Supervisory Control and Data Acquisition）指用于监控和控制各类机器与制造过程的架构。
在该系统中，ThingsBoard 作为监控计算机单元，从各类 PLC（Programmable Logic Controller）和 RTU（Remote Terminal Unit）采集数据，
通常借助 [IoT Gateway](/docs/iot-gateway/what-is-iot-gateway/){:target="_blank"} 软件或物理网关设备。
此外，ThingsBoard 提供完善的 [alarm](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"} 和 [notification](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"} 系统，是任何 IoT 系统的重要组成部分。

自 3.8.0 版本起，ThingsBoard 引入类 SCADA HMI dashboard 支持，本文档将介绍相关内容。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/kBMcsg7YEcQ" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## SCADA dashboard layout

ThingsBoard 中的 SCADA dashboard 提供典型平台 [Dashboard](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"} 的全部功能，并配有专用 SCADA [layout](/docs/{{docsPrefix}}user-guide/dashboards/#layouts){:target="_blank"}，
便于创建 SCADA HMI（人机界面）。

SCADA dashboard 通常由称为 SCADA symbol 的特殊可缩放部件组成。
每个 symbol 可表示阀门、泵、电机、罐体或管道等物理对象的状态。
用户还可与这些部件交互，向物理对象发送命令，如启停泵、开关阀门。
此外，您可在同一 dashboard 上组合使用 SCADA 部件与 500 多个现有 ThingsBoard [widgets](/docs/{{docsPrefix}}user-guide/widgets/){:target="_blank"}。

SCADA layout 的主要特性包括：

- **Margin**  
  SCADA layout 中，部件之间无 margin。此设计确保管道及其他 SCADA symbol 正确连接。

- **Widget appearance**  
  默认情况下，常规部件以透明背景且无阴影放置，可与 SCADA dashboard 无缝融合。

## Building a SCADA dashboard

要开始构建 SCADA dashboard，请先创建新 dashboard：
{% include images-gallery.html imageCollection="scada-dashboard-layout-1" showListImageTitles="true" %}

### Layout settings

Layout 设置决定 dashboard 的背景配置及部件排列方式。
在 "Manage layouts" 窗口中点击 "gear" 图标，将打开包含 layout 设置的小窗口。

{% include images-gallery.html imageCollection="layout-settings-1" showListImageTitles="true" %}

SCADA layout 的主要设置如下：

**Columns count**。layout 设置中的列数必须能被 24 整除（如 24、48、72，最多 1008）。
该值定义屏幕如何划分为部件占位矩阵，并决定 dashboard 的粒度。
您可为各 layout 断点（xl、lg、md、sm、xs）配置不同的 layout 设置。

{% include images-gallery.html imageCollection="scada-columns-count-1" %}

**Minimum layout width**。默认最小列数为 24。您可增加或减少该值。最小列数为 10。建议该设置值大于或等于 *columns count* 值。

{% include images-gallery.html imageCollection="scada-minimum-layout-width-1" %}

<br>
**Background color**。"Background color" 设置允许您自定义 dashboard 背景颜色。
要更改背景色，请点击背景色区域右侧小方块中的颜色。
在弹出窗口中选择颜色和透明度，然后点击 "Select"。随后应用 layout 设置。

{% include images-gallery.html imageCollection="scada-background-color-1" %}

<br>
**Background image** 与 **Background size mode**。该选项允许您将图片设为 dashboard 背景。可从 [Image gallery](/docs/{{docsPrefix}}user-guide/image-gallery/){:target="_blank"} 选择图片或设置直链。

要从图库选择图片，点击 "Browse from gallery"。选择已上传图片或添加新图片。
**Background size mode**。要更精确调整图片位置，点击 "Background size mode" 区域的下拉菜单，选择图片如何填充背景空间。
例如，选择 "Cover" 并点击 "Save" 查看背景变化。

{% include images-gallery.html imageCollection="scada-background-image-1" %}

### Multi-state dashboards

熟练用户可知，一个 dashboard 可包含多个 [states](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}。
单个 dashboard 可同时包含常规 dashboard state 与 SCADA state。
例如，主 state 可展示 SCADA 系统概览，点击特定元素可打开常规 dashboard state 或 popup widget。

以下 [sample dashboard](/docs/user-guide/resources/multi-state-scada-dashboard.json){:target="_blank"} 不显示真实数据，但您可 [import](/docs/{{docsPrefix}}user-guide/dashboards/#import-dashboard){:target="_blank"} 到环境中，体验 state 间导航的实现方式。

{% include images-gallery.html imageCollection="multi-state-scada-dashboard-example-1" %}

## SCADA symbol

ThingsBoard SCADA symbol 基于 [SVG](https://en.wikipedia.org/wiki/SVG){:target="_blank"}（Scalable Vector Graphics）文件。
使用矢量图确保 SCADA symbol 可无缝缩放到任意屏幕尺寸。
ThingsBoard 工程师扩展了 SVG 格式，使这些 symbol 具有交互性。
具体而言，我们定义 SVG 对象如何根据用户配置的属性和 device 数据变化。
我们还定义 SVG 对象的可点击区域，允许用户在 symbol 添加到 dashboard 后配置可触发的操作。

{% capture difference %}
ThingsBoard 3.9 版本在传统 SCADA symbol 之外，新增了高性能 SCADA symbol。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

ThingsBoard 中的高性能 SCADA symbol 是经过优化的图形元素，用于在 ThingsBoard 平台上创建的 SCADA 系统中展示流程和设备状态信息。旨在提高信息感知效率和操作员决策速度。

ThingsBoard 高性能 SCADA symbol 的主要特性：

- Simplified Design：极简 symbol，去除多余装饰。优先考虑信息量与可读性。
- Color Coding：主要状态（正常）通常用中性色（如灰色）表示。关键状态（紧急、错误）用红色或黄色等醒目颜色突出。
- Dynamic Changes：symbol 可根据状态改变颜色（如阀门开/关、泵启/停）。
- Standardization：对不同类型的 device 或流程使用标准化 symbol 集，缩短用户培训时间。
- Compatibility：symbol 易适配不同屏幕尺寸和设备类型（桌面、平板、手机）。

{% include images-gallery.html imageCollection="high-performance-scada-symbols" %}

<br>
我们目前提供 100+ 开箱即用的 SCADA symbol，计划在后续版本中增至 500+。
若所需 symbol 不可用，建议按以下 [guide](/docs/{{docsPrefix}}user-guide/scada/scada-symbols-dev-guide/){:target="_blank"} 自行创建。

## SCADA symbol widget

SCADA symbol 部件用于将任意 SCADA symbol 放置到 dashboard 上。它充当通用 SCADA symbol 与 dashboard 之间的桥梁。

SCADA symbol 部件包含五个配置块，下面以 "Horizontal wheel valve" symbol 为例说明：

首先将该部件添加到 dashboard：

{% include images-gallery.html imageCollection="add-scada-symbol-widget-1" showListImageTitles="true" %}

### Target entity

该设置将部件指向单个实体：device、asset 等。
它定义用于控制 symbol 行为的实体。
若不需要交互行为，可省略目标实体参数。
熟练用户可使用解析为单个实体的 [entity aliases](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}。
这在高级场景中很有用，例如将目标实体配置为 asset 而非 device。

本示例中，我们选择控制阀门的 smart device。通常该 device 通过 IoT Gateway 使用 Modbus connector 连接，但为简化本指南将略过这些细节。

{% include images-gallery.html imageCollection="scada-selected-target-device-1" %}

### SCADA symbol

该设置指向库中的特定 SCADA [symbol](#scada-symbol)。
本例中选择库中的 "Horizontal wheel valve"。
若库中看不到该 symbol，请确保勾选 "Include system symbols"。

{% include images-gallery.html imageCollection="scada-symbol-device-1" %}

### Behavior

行为参数列表由所选 SCADA symbol 决定，完全由 symbol 作者控制。

{% include images-gallery.html imageCollection="scada-behavior-settings-1" %}

<br>
行为参数有三种类型："Value"、"Action" 和 "Widget action"。

- "**Value**" 参数通常控制 symbol 的视觉表现，可根据接收值随时间变化；
- "**Action**" 参数定义特定事件发生时对目标实体执行的操作；
- "**Widget action**" 参数定义用户点击 SCADA symbol 组件时触发的操作。

用于获取 **value** 的 action 类型：

- "**Do nothing**" action 仅使用用户定义的常量。

{% include images-gallery.html imageCollection="scada-action-do-nothing-1" %}

- "**Execute RPC**" action 会向目标 device 发送命令以获取值。该值在创建部件时解析一次。

{% include images-gallery.html imageCollection="scada-action-execute-rpc-1" %} 

- "**Get attribute**" action 将订阅目标实体属性的值。属性值变更时部件会收到更新。

{% include images-gallery.html imageCollection="scada-action-get-attribute-1" %}

- "**Get time series**" action 将订阅目标实体的 time series 字段值。新 time series 数据到达时部件会收到更新。

{% include images-gallery.html imageCollection="scada-action-get-time-series-1" %}

- "**Get alarm status**" action 订阅 alarm 状态字段。部件会根据 alarm 类型收到更新。

{% include images-gallery.html imageCollection="scada-action-get-alarm-status-1" %}

- "**Get dashboard state**" action 使用当前 dashboard 状态的名称。适用于与目标 device 状态无关的特定场景。

{% include images-gallery.html imageCollection="scada-action-get-dashboard-state-1" %}

<br>
平台支持对目标实体的三类 **actions**：

- "**Execute RPC**" 会向目标 device 发送命令。您可定义方法及参数。
  {% include images-gallery.html imageCollection="scada-action-execute-rpc-to-target-device-1" %}
    
- "**Set attribute**" 会向目标 device 发送命令。您可定义要设置的 attribute 的 scope、key 和 value。
  {% include images-gallery.html imageCollection="scada-action-set-attribute-1" %}
 
- "**Add time series**" 会向目标 device 添加新的 time series 值。您可定义新 time series 数据的 key 和 value。
  {% include images-gallery.html imageCollection="scada-action-add-time-series-1" %}

<br>

**Widget action** 参数 "On click" 定义用户点击组件时触发的操作。
本示例中阀门 symbol 没有 widget action 参数，但您可在 "Left motor pump" 等 symbol 中找到此类操作。
可能的 action 类型参见 [here](/docs/{{docsPrefix}}user-guide/ui/widget-actions/#action-types){:target="_blank"}。

{% include images-gallery.html imageCollection="scada-action-left-motor-pump-1" %}

<br>
下面以 "Horizontal Wheel Valve" symbol 参数为例：

- 首个参数 "Opened" 控制 SCADA symbol "Horizontal Wheel Valve" 的视觉表现，通常根据 device 的 attribute 或 time series 值动态变化。对于本阀门，该参数决定阀门为 "Open" 还是 "Closed"；

- 第二、第三参数确定用户与阀门交互时应对目标对象执行的操作。对于 horizontal wheel valve，有两种 action："Open" 和 "Close"。"Open" action 将 "open" attribute 设为 "true"，"Close" action 将 "open" attribute 设为 "false"。

{% include images-gallery.html imageCollection="example-of-parameters-scada-symbol-1" %}

### Appearance

所有 SCADA symbol 均有通用外观参数（如 symbol 标题和图标）。
其他参数由所选 SCADA symbol 决定，由 symbol 作者控制。
对于本阀门，您可定义阀门在开启和关闭状态下的颜色。
还可通过设置旋转角度配置轮盘动画。
外观参数类型多样，对最终用户而言较为直观。
详见 symbol 开发 [guide](/docs/{{docsPrefix}}user-guide/scada/scada-symbols-dev-guide/){:target="_blank"}。

{% include images-gallery.html imageCollection="scada-appearance-1" %}

### Card Appearance

Card 外观设置为所有 SCADA symbol 通用，包括背景（默认透明）、启用的 card 按钮列表、card 圆角和内边距等参数。

{% include images-gallery.html imageCollection="scada-card-appearance-1" %}
