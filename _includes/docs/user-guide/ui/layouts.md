* TOC
{:toc}

仪表板布局决定部件在仪表板网格上的呈现方式。
每个仪表板状态可拥有自己的布局类型、设置和断点，
便于针对不同 IoT 用例和屏幕分辨率打造定制化的视觉呈现。

要修改特定[状态](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}的布局，请按以下步骤操作：

1. 点击窗口右上角的“Edit mode”按钮进入[仪表板编辑模式](/docs/{{docsPrefix}}user-guide/dashboards/#edit-mode){:target="_blank"}；
2. 点击仪表板窗口左上角的“Layouts”按钮。将打开布局管理窗口。

{% include images-gallery.html imageCollection="layout-1" %}

在“Manage layouts”窗口中，可选择适合需求的布局类型：

- **Default** - 灵活的通用布局；
- **SCADA** - 最适合显示 SCADA HMI（人机界面）；
- **Divider** - 用于视觉分隔区块。

{% include images-gallery.html imageCollection="select-layout-type-1" %}

<br>
断点允许创建可适应不同屏幕尺寸的响应式布局。
可添加和配置断点，以确保仪表板在任何设备上都能完美呈现。
下文将详细讨论各布局类型的设置及断点配置。

{% include images-gallery.html imageCollection="breakpoints-1" %}

## 布局类型

平台支持三种布局类型：Default、SCADA 和 Divider。每个仪表板[状态](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}仅配置一种布局类型。

### 默认布局

**Default**布局是适用于大多数仪表板的通用布局。
此布局类型支持响应式设计的屏幕断点。

{% include images-gallery.html imageCollection="layout-default-1" %}

### SCADA

**SCADA**布局专为创建 SCADA HMI（人机界面）设计。
SCADA HMI 通常由名为 SCADA 符号的可缩放部件组成。
但也可在同一布局上将[SCADA 符号](/docs/{{docsPrefix}}user-guide/scada){:target="_blank"}与 500 多个 ThingsBoard [部件](/docs/{{docsPrefix}}user-guide/widgets/){:target="_blank"}结合使用。
此布局类型同样支持响应式设计的屏幕断点。

{% include images-gallery.html imageCollection="layout-scada-1" %}

### 分隔布局

旧版**Divider**布局可将一个“Default”布局拆分为左右两个子布局。
可使用固定像素值或屏幕宽度百分比配置这些子布局的宽度。
“Default”布局的大多数布局参数同样适用于子布局。
但目前子布局不支持断点。

{% include images-gallery.html imageCollection="layout-divider-1" %}

为展示效果，让我们以完全不同的方式配置左右布局。为左侧布局添加背景图，为右侧布局应用新的背景色。
并以一定百分比比例调整窗口大小（仅为示例，非推荐做法）。设置参数后，点击 Layouts 窗口中的“Save”按钮查看更改。

{% include images-gallery.html imageCollection="layout-divider-2" %}

## 断点

ThingsBoard 3.8.0 引入了断点。
允许根据最终用户的屏幕宽度定义不同的布局设置和部件。

每个仪表板[状态](/docs/{{docsPrefix}}user-guide/dashboards/#states){:target="_blank"}拥有一个`Default`断点。
若没有其他断点匹配当前屏幕分辨率，则使用此布局。

可定义以下断点：

* Desktop (xl) - 最小 1920px，最大 5000px；
* Desktop (lg) - 最小 1280px，最大 1919px；
* Laptop (md) - 最小 960px，最大 1279px；
* Tablet (sm) - 最小 600px，最大 959px；
* Mobile (xs) - 最大 599px。

### 添加断点

要添加断点，打开“Manage layouts”窗口并点击断点表中的“+”按钮。
添加新断点时，可选择对应的屏幕分辨率，并可从其他断点复制部件和布局设置。

{% include images-gallery.html imageCollection="adding-breakpoint-1" %}

可点击“齿轮”图标打开该断点的布局设置。布局设置决定仪表板的背景配置及部件在仪表板上的排列方式。

{% include images-gallery.html imageCollection="adding-breakpoint-2" %}

也可点击“垃圾桶”图标删除断点。在对话框中确认删除断点。

{% include images-gallery.html imageCollection="adding-breakpoint-3" %}

### 切换断点

用户打开仪表板时，将根据屏幕分辨率自动选择对应的断点布局。

编辑仪表板时，用户可使用屏幕左上角的下拉框在布局间切换。

{% include images-gallery.html imageCollection="switching-between-breakpoints-1" %}

### 断点示例仪表板

我们准备了配置了若干断点的[示例仪表板](/docs/user-guide/resources/example_of_breakpoints_on_my_dashboard.json){:target="_blank"}。可[导入](/docs/{{docsPrefix}}user-guide/dashboards/#import-dashboard){:target="_blank"}到您的环境中，在编辑模式下探索如何在不同断点间切换。
还可在浏览器开发者工具中更改屏幕分辨率，观察跨越特定屏幕分辨率断点时布局的变化。

查看同一仪表板在不同屏幕类型上的效果：

{% include images-gallery.html imageCollection="breakpoints-demo-dashboard-1" %}

### 部件引用与部件副本

**部件引用**

使用多个断点时，理解部件引用与部件副本的区别很重要。

默认情况下，创建新断点布局时，源布局中的所有部件均按引用复制。
例如，若 Default 和 Desktop (xl) 两个断点引用同一图表部件，对部件配置的任何更改将在两个布局间同步。
但部件的位置和大小在各布局中独立设置。

- 要按引用复制部件，右键点击部件并选择“Copy reference”（Ctrl+R）；
- 要将部件作为引用粘贴到另一断点布局，右键点击空白处并选择“Paste reference”（Ctrl+I）。

{% include images-gallery.html imageCollection="copy-widget-by-reference-1" %}

在编辑模式下，可通过部件编辑面板中的“Reference”按钮识别引用部件。

{% include images-gallery.html imageCollection="identify-referenced-widget-1" %}

要将引用替换为部件副本，点击部件编辑面板上的“Reference”按钮，或右键点击部件并选择“Replace reference with widget copy”。

{% include images-gallery.html imageCollection="replace-reference-with-widget-copy-1" %}

<br>
**部件副本**

部件副本是部件配置的完整独立副本。对副本部件的更改不会影响原始部件。

- 要复制部件，右键点击部件并选择“Copy”（Ctrl+C）；
- 要将部件粘贴到另一断点布局，右键点击空白处并选择“Paste”（Ctrl+V）。

{% include images-gallery.html imageCollection="copy-widget-1" %}

## 布局设置

点击断点旁的“齿轮”图标打开布局设置。

{% include images-gallery.html imageCollection="layout-settings-1" %}

### 列数

编辑仪表板尤其是调整部件大小和间距时，可看到灰色背景上的浅色网格。
这些是决定仪表板水平方向可容纳部件数量的列。默认列数为 24。可增加或减少列数。最小列数为 10，最大为 1000 列。

{% include images-gallery.html imageCollection="layout-settings-columns-count-1" %}

### 最小布局宽度

默认最小列数为 24。可增加或减少该数值。最小列数为 10。建议此参数值大于或等于列数。

{% include images-gallery.html imageCollection="layout-settings-minimum-layout-width-1" %}

### 部件间距

此边距类型决定部件之间的间距。
默认边距为 10。可将“**部件间距**”设为 0 移除边距，或增加边距（即部件间的距离）。最大允许边距为 50。

{% include images-gallery.html imageCollection="layout-settings-margin-between-widgets-1" %}

### 将边距应用到布局两侧

此参数决定是否应将“部件间距”值应用到布局两侧。

{% include images-gallery.html imageCollection="layout-settings-apply-margin-to-sides-of-layout-1" %}

### 自动填充布局高度

默认情况下，“**自动填充布局高度**”复选框未勾选，以便自由调整部件大小。
勾选此选项后，仪表板上的所有部件将在屏幕空间内垂直填充。

{% include images-gallery.html imageCollection="layout-settings-auto-fill-layout-height-1" %}

### 背景颜色

“背景颜色”设置允许自定义仪表板的背景颜色。
要更改背景颜色，点击背景颜色部分右侧小方框中的颜色。
在弹出窗口中选择所需颜色和透明度。然后点击“Select”。之后应用布局设置。保存后即可看到自定义背景。

{% include images-gallery.html imageCollection="layout-settings-background-color-1" %}

### 背景图片

此选项允许将图片设为仪表板背景。可从[图片库](/docs/{{docsPrefix}}user-guide/image-gallery/){:target="_blank"}选择图片或设置直链。

要从图库选择图片，点击“Browse from gallery”。选择已上传的图片或添加新图片。
要更精确地调整图片位置，点击“**背景尺寸模式**”部分的下拉菜单，选择图片如何填充背景区域。
例如，选择“Cover”并点击“Save”查看背景变化。

{% include images-gallery.html imageCollection="layout-settings-background-image-1" %}

### 移动布局设置

默认情况下，“**自动填充布局高度**”复选框未勾选，以便自由调整移动设备的部件大小。
勾选此选项后，仪表板上的所有部件将在屏幕空间内垂直填充。

{% include images-gallery.html imageCollection="layout-mobile-settings-auto-fill-layout-height-1" %}

#### 移动行高

移动行高决定移动设备上部件的高度。
默认高度为 70px，可调大或调小。最小移动行高为 5px，最大允许值为 200px。

{% include images-gallery.html imageCollection="layout-mobile-settings-auto-fill-layout-height-2" %}
