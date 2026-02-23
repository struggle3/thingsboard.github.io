* TOC
{:toc}

所有[IoT 仪表板](/docs/{{docsPrefix}}user-guide/dashboards/)均由部件库中定义的 **ThingsBoard 部件**构成。

部件是用于在仪表板上显示特定类型信息或功能的元素。部件用于展示数据、可视化连接至 ThingsBoard 平台的设备信息、远程设备控制、告警管理以及显示静态自定义 HTML 内容。

## 部件类型

根据所提供的功能，每种部件定义代表一种特定的部件类型。共有五种部件类型：

 - [最新值](#latest-values)；
 - [时序](#time-series)；
 - [控制部件](#control-widget)；
 - [告警部件](#alarm-widget)；
 - [静态部件](#static)。

{% include images-gallery.html imageCollection="wl-dashboard-widgets" preview="false" %}
 
每种部件类型都有其特定的数据源配置以可视化数据。可用数据源类型取决于部件类型：

 - **告警源** - 此数据源类型主要用于告警部件，需要源实体来显示相关告警及其对应字段；
 - **告警数量** - 此数据源类型用于最新值部件。需指定目标实体；
 - **设备** - 此数据源类型用于时序和最新值部件。通常需指定目标设备以及时序键、属性名或实体字段；
 - **实体数量** - 此数据源类型用于最新值部件。需指定目标实体；
 - **实体** - 此数据源类型用于时序和最新值部件。通常需通过指定[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/)选择目标实体，以及时序键、属性名；
 - **函数** - 此数据源类型用于时序和最新值部件的调试。通常可指定用于模拟设备数据的 JavaScript 函数以设置可视化。

### 最新值

最新值部件类型用于展示特定实体属性或时序数据点的最新值（例如任意表盘部件或实体表部件）。此类型部件以实体属性或时序的值为数据源。示例中数字表盘显示当前温度值。
 
{% include images-gallery.html imageCollection="wl-latest-values-datasource" %}

### 时序

时序部件类型显示所选时间段内的历史值，或在特定时间窗口内的最新值（例如时序折线图或时序柱状图）。此部件类型仅以实体时序的值为数据源。要指定显示值的时间范围，需使用_时间窗口_设置。时间窗口可在仪表板页面或部件详情中指定，可为_实时_（特定最新区间的动态变化时间范围）或_历史_（固定的历史时间范围）。这些设置均为时序部件配置的一部分。示例中“时序折线图”实时显示设备的速度值。

{% include images-gallery.html imageCollection="wl-timeseries" %}

### 控制部件

控制部件允许向设备发送 RPC 命令，并处理与显示设备回复（例如 Raspberry Pi GPIO 控制）。RPC 部件通过将目标设备指定为 RPC 命令的目标端点进行配置。示例中“基本 GPIO 控制”部件发送 GPIO 开关命令并检测当前 GPIO 开关状态。

{% include images-gallery.html imageCollection="wl-control-widget" %}

### 告警部件

告警部件类型在特定时间窗口内显示与指定实体相关的告警（例如告警表）。配置告警部件时，需将某实体指定为告警源并定义相应的告警字段。与_时序部件_类似，告警部件具有_time window_配置以指定显示的告警时间范围。此外，配置还包括“告警状态”“告警严重程度”“告警类型”等参数。“告警状态”参数显示正在获取的告警状态。“告警严重程度”参数显示告警获取频率（秒）。“告警类型”参数有助于识别告警的主要来源。例如，“HighTemperature”和“LowHumidity”代表两种不同的告警。本例中“告警表”部件实时显示设备的最新告警。

{% include images-gallery.html imageCollection="wl-alarms" %}

### 静态

静态部件类型显示静态可自定义的 HTML 内容（例如 HTML 卡片）。静态部件不使用任何数据源，通常通过指定静态 HTML 内容及可选的 CSS 样式进行配置。静态部件示例为“HTML 卡片”，显示指定的 HTML 内容。

{% include images-gallery.html imageCollection="wl-static" %}

<details>

<summary>
<b>用于调整 HTML 卡片样式的 CSS 样式函数示例。</b>
</summary>

{% highlight ruby %}
.card {
font-weight: bold;
font-size: 32px;
color: #999;
width: 100%;
height: 100%;
display: flex;
align-items: center;
justify-content: center;
}
{% endhighlight %}

</details>

<details>

<summary>
<b>用于指定卡片内容的 HTML 代码示例。</b>
</summary>

{% highlight ruby %}
<h1>Static widget title</h1>
<div class='card'>Your text here</div>
{% endhighlight %}

</details>
 
## 部件库（捆绑包）

部件按用途分组到部件捆绑包中。部分部件可同时出现在多个包中。例如，告警数量部件既可在告警部件捆绑包中找到，也可在计数部件捆绑包中找到。

存在系统级和租户级部件捆绑包。初始 ThingsBoard 安装随附一套基础的系统级部件捆绑包。

系统级捆绑包可由**系统管理员**管理，系统内任意租户均可使用。租户级捆绑包可由**租户管理员**管理，仅供该租户及其客户使用。您可按照此[指南](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/)始终实现并添加自己的部件。

若要在所有部件捆绑包中查找所需部件，可使用搜索功能。

{% include images-gallery.html imageCollection="wl-bundle" %}

您也可以在“Widgets”选项卡中按名称查找部件。此处默认按字母顺序列出所有可用部件。

{% include images-gallery.html imageCollection="wl" %}

### 空气质量

此部件捆绑包包含用于可视化空气质量数据的部件。

{% include images-gallery.html imageCollection="wl-air-quality" %}

### 告警部件

告警部件捆绑包用于可视化特定实体的告警，支持实时和历史模式。

{% include images-gallery.html imageCollection="wl-alarm-bundle" %}

### 模拟表盘

模拟表盘部件捆绑包用于可视化温度、湿度、速度及其他整数或浮点值。

{% include images-gallery.html imageCollection="wl-analog-gauges-bundle" %}

### 按钮

按钮捆绑包可用于在仪表板状态间导航、向设备发送 RPC 命令、更新设备属性或时序数据。

{% include images-gallery.html imageCollection="wl-buttons-bundle" %}

### 卡片

卡片捆绑包用于在表或卡片部件中可视化时序数据或属性。

{% include images-gallery.html imageCollection="wl-cards-bundle" %}

### 图表

图表捆绑包用于在时间窗口内可视化历史或实时数据。

{% include images-gallery.html imageCollection="wl-charts-bundle" %}

### 控制部件

控制部件捆绑包用于可视化当前状态并向目标设备发送 RPC 命令。

{% include images-gallery.html imageCollection="wl-control-bundle" %}

### 计数部件

计数部件捆绑包用于根据所选筛选器统计并可视化当前告警和实体数量。

{% include images-gallery.html imageCollection="wl-count-bundle" %}

### 日期

日期部件捆绑包用于更改仪表板上其他部件的数据范围。

{% include images-gallery.html imageCollection="wl-date-bundle" %}

### 数字表盘

数字表盘捆绑包用于可视化温度、湿度、速度及其他整数或浮点值。

{% include images-gallery.html imageCollection="wl-digital-bundle" %}

### Edge 部件

Edge 部件捆绑包用于概览与指定 ThingsBoard Edge 实例相关的实体。

{% include images-gallery.html imageCollection="wl-edge-widgets-bundle" %}

### 实体管理部件

实体管理部件是复杂部件的模板，用于列出及创建/更新/删除设备和资产。

{% include images-gallery.html imageCollection="wl-entity-admin-bundle" %}

### 实体部件

实体管理部件显示实体列表及其数据、实体计数，并基于关系显示实体层次结构。

{% include images-gallery.html imageCollection="wl-entity-bundle" %}

### 文件

{% capture difference %}
**仅适用于 PE 和 PaaS。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

文件部件以表的形式显示文件或 PDF 报告列表。支持下载和删除文件。

{% include images-gallery.html imageCollection="wl-files-bundle" %}

### 网关部件

网关部件捆绑包用于管理扩展。

{% include images-gallery.html imageCollection="wl-gateway-bundle" %}

### 通用高性能 SCADA 符号

此捆绑包包含用于广泛工业监控和控制的高性能 SCADA 部件。涵盖从面板、表盘到机械资产和现场设施等元素。用于组装清晰、高对比的 HMI 界面，在混合设备仪表板上快速传达状态。

{% include images-gallery.html imageCollection="wl-scada-hp-general-symbols" %}

### GPIO 部件

GPIO 部件捆绑包用于可视化和控制目标设备的 GPIO 状态。

{% include images-gallery.html imageCollection="wl-gpio" %}

### 高性能 SCADA 能源系统

此捆绑包包含覆盖完整电力流的高性能 SCADA 符号——从可再生能源发电（太阳能、风能）和备用发电机，经过存储、转换、保护、计量，以及高/低压配电直至住宅和工业用户。适于构建可视化现代能源基础设施生产、质量和消费的交互式仪表板。

{% include images-gallery.html imageCollection="wl-scada-hp-energy-system" %}

### 高性能 SCADA 流体系统

此高性能符号捆绑包聚焦石油天然气、化工和水处理领域的流体处理工艺。涵盖钻井和井控组件、泵和管道、分离器、热交换单元、涡轮及相关设备——适用于流程图、生产仪表板和工艺安全视图。

{% include images-gallery.html imageCollection="wl-scada-hp-fluid-system" %}

### 高性能 SCADA 石油天然气

专为石油天然气领域上游和早期处理流程设计的高性能 SCADA 符号捆绑包。涵盖钻井和井控设备、人工举升和驱动单元、地面集输管线、分离器组、热交换和发电资产——可视化井口至初步处理的完整流程所需的一切，采用清晰的高性能 SCADA 风格。适用于实时跟踪陆上和海上装置钻井进度、生产效率和安全屏障的仪表板。

{% include images-gallery.html imageCollection="wl-scada-hp-fluid-oil-and-gas" %}

### 首页部件

首页部件捆绑包用于在首页自定义和显示指向平台 UI 组件、文档或任何其他资源的快速链接，显示实体数量和 API 使用等统计信息。

{% include images-gallery.html imageCollection="wl-home" %}

### HTML 部件

HTML 部件捆绑包用于注入自定义 HTML 代码，或用于显示可配置的 HTML 并支持从所选数据源注入值。

{% include images-gallery.html imageCollection="wl-html" %}

### 室内环境

室内环境部件捆绑包用于可视化室内环境相关数据。

{% include images-gallery.html imageCollection="wl-indoor-environment-bundle" %}

### 工业部件

工业部件捆绑包用于显示工业遥测数据。

{% include images-gallery.html imageCollection="wl-industrial-bundle" %}

### 输入部件

输入部件捆绑包用于修改实体的属性。

{% include images-gallery.html imageCollection="wl-input-bundle" %}

### 液位

液位部件捆绑包包含用于可视化罐内液位的部件。

{% include images-gallery.html imageCollection="wl-liquid-level-bundle" %}

### 地图

地图部件捆绑包用于在实时和历史模式下可视化设备地理位置并跟踪设备路线。

{% include images-gallery.html imageCollection="wl-maps-bundle" %}

### 导航部件

导航部件捆绑包用于定义用户的首页仪表板。

{% include images-gallery.html imageCollection="wl-navigation-bundle" %}

### 室外环境

室外环境部件捆绑包用于可视化室外环境相关数据。

{% include images-gallery.html imageCollection="wl-outdoor-environment-bundle" %}

### SCADA 符号

用于向 SCADA 仪表板上传 SVG 符号。

{% include images-gallery.html imageCollection="wl-scada-symbols-bundle" %}

### 调度

{% capture difference %}
**仅适用于 PE 和 PaaS。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

调度部件捆绑包用于通过灵活的调度配置[调度](/docs/{{docsPrefix}}user-guide/scheduler/)各类事件。

{% include images-gallery.html imageCollection="wl-scheduling-bundle" %}

### 状态指示器

状态指示器部件捆绑包包含用于可视化电量、信号强度和进度条的部件。

{% include images-gallery.html imageCollection="wl-status-indicators-bundle" %}

### 表格

表格部件捆绑包用于显示实体列表、告警信号列表以及一个或多个实体的时序数据。此外，此部件捆绑包展示基于实体别名的持久化 RPC 请求。支持可选筛选和分页以提升可用性。

{% include images-gallery.html imageCollection="wl-tables-bundle" %}

### 传统 SCADA 流体系统

此传统设计风格的 SCADA 符号捆绑包涵盖多种工业图所需的核心内容。包含直管、弯管、三通、排放口、流量和液位计、泵、过滤器、阀门、各种形状储罐、水池及其他核心组件——组装管道、液压及其他过程控制 schematic 所需的一切。

{% include images-gallery.html imageCollection="wl-scada-traditional-fluid-system" %}

## 部件操作

### 添加部件

系统管理员添加新部件后，该部件将自动成为系统部件。即仅管理员有权修改或删除该部件。租户管理员也可创建部件，但仅有权修改其创建的部件。您可按照此[指南](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/)始终实现并添加自己的部件。

添加新部件的步骤：

{% include images-gallery.html imageCollection="add-widget" showListImageTitles="true" %}

### 导出部件

您可将部件捆绑包中的特定类型部件以 JSON 格式导出，并在相同或不同的 ThingsBoard 实例中导入。

要导出部件类型，请前往部件库页面，在“Widgets”选项卡中点击具体部件卡片上的导出按钮。部件配置文件将以 JSON 格式保存到您的计算机。

{% include images-gallery.html imageCollection="export-widget" %}

### 导入部件

请注意，仅系统管理员可修改系统（默认）部件。包括在捆绑包内编辑、删除、添加或导入部件的能力。系统管理员创建新部件捆绑包时，将设置为租户的系统级项，阻止租户对其进行修改。不过，租户可添加自己的部件。此种情况下，他们拥有对捆绑包内所创建部件类型的完全管理权限。

导入部件的步骤：

{% include images-gallery.html imageCollection="import-widget" showListImageTitles="true" %}

### 删除部件

系统管理员或租户管理员可通过以下任一方式删除部件类型：

第一种方式：

{% include images-gallery.html imageCollection="delete-widget-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-widget-2" showListImageTitles="true" %}

## 部件捆绑包操作

### 添加部件捆绑包

系统管理员添加新部件捆绑包后，该捆绑包将自动成为系统部件捆绑包。即仅他们可删除、编辑捆绑包并向其添加部件。租户管理员也可创建部件捆绑包。此种情况下，他们有权修改已创建的捆绑包。您可按照此[指南](/docs/{{docsPrefix}}user-guide/contribution/widgets-development/)始终实现并添加自己的部件。

添加新部件捆绑包的步骤：

{% include images-gallery.html imageCollection="wl-add-widgets-bundle" showListImageTitles="true" %}

### 导出部件捆绑包

您可将部件捆绑包以 JSON 格式导出，并在相同或不同的 ThingsBoard 实例中导入。

导出部件捆绑包的步骤：

{% include images-gallery.html imageCollection="export-widgets-bundle" showListImageTitles="true" %}

### 导入部件捆绑包

导入部件捆绑包的步骤：

{% include images-gallery.html imageCollection="import-widgets-bundle" showListImageTitles="true" %}

### 删除部件捆绑包

系统管理员或租户管理员可通过以下任一方式删除部件捆绑包：

第一种方式：

{% include images-gallery.html imageCollection="delete-widgets-bundle-1" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-widgets-bundle-2" showListImageTitles="true" %}
