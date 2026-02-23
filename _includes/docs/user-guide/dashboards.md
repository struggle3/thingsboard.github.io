* TOC 
{:toc}

{% capture difference %}
在继续阅读本指南之前，建议您先完成[入门指南](/docs/{{docsPrefix}}getting-started-guides/helloworld/){:target="_blank"}，以熟悉ThingsBoard设备和部件。这将帮助您更好地理解本文介绍的概念。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 简介

ThingsBoard提供强大功能——创建和自定义交互式可视化界面，即仪表板。仪表板是用于高效监控和管理数据与设备的工具。
借助ThingsBoard仪表板，用户可根据自身需求调整界面，更便捷地查看物联网设备和数据。每个仪表板可以放置多个部件，具有良好的灵活性和可定制性。
仪表板不限于单一数据源，可展示来自设备、资产等多种实体的数据。您还可以将仪表板分配给指定客户，确保相关人员或团队能访问所需数据。

{% if docsPrefix == null %}
![image](/images/user-guide/dashboards/overview/dashboard-introduction-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/dashboards/overview/dashboard-introduction.png)
{% endif %}

ThingsBoard仪表板为用户提供以下能力：

 - **数据可视化**：用户可创建图表、图形、表格等各种部件，可视化来自已连接设备的数据，便于运维人员和分析师分析信息、跟踪设备状态。

 - **设备管理**：仪表板可用于对设备执行管理操作，如开关设备、修改参数等。用户可设置操作并响应设备的实时数据。

 - **交互性**：仪表板可设计按钮、开关等交互元素，使用户能与设备和数据交互。

 - **显示定制**：用户可自定义部件的布局与尺寸、配色、字体等可视化选项，打造友好且信息丰富的界面。

 - **基于角色的访问**：ThingsBoard支持根据用户[角色](/docs/{{docsPrefix}}user-guide/rbac/)控制对仪表板的访问权限。这有助于保障数据安全与保密性。

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
ThingsBoard还提供便捷的物联网解决方案模板，缩短产品上市时间。
这些模板包含交互式仪表板、处理逻辑、示例设备、用户及所有其他必要实体，相当于完整的PoC/MVP。
更多关于解决方案模板的信息请参阅[此处](/docs/{{docsPrefix}}solution-templates/overview/)。
{% endif %}

本指南介绍主要概念及各种仪表板设置。

## 创建新仪表板

要添加新仪表板，请执行以下步骤：

{% include images-gallery.html imageCollection="creating-dashboard" showListImageTitles="true" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
创建仪表板时可同时指定所属所有者和仪表板分组。
如何创建新仪表板组，请参阅[此处](/docs/{{docsPrefix}}user-guide/groups/#create-new-entity-group)。

{% include images-gallery.html imageCollection="creating-dashboard-2" showListImageTitles="true" %}

默认情况下，仪表板列表显示全部仪表板，包括客户的仪表板。
若仅查看自己的仪表板，请关闭「包含客户实体」选项。

{% include images-gallery.html imageCollection="creating-dashboard-3" %}
{% endif %}

## 仪表板工具栏

开始使用仪表板前，请先熟悉界面及各功能的用途。

仪表板工具栏可让您
[添加新部件](#add-new-widget)、
管理[状态](/docs/{{docsPrefix}}user-guide/dashboards/#states)、
[布局](/docs/{{docsPrefix}}user-guide/dashboards/#layouts)、
[设置](/docs/{{docsPrefix}}user-guide/dashboards/#settings)、
[实体别名](/docs/{{docsPrefix}}user-guide/dashboards/#entity-aliases)、
[过滤器](/docs/{{docsPrefix}}user-guide/dashboards/#filters)、
[版本控制](/docs/{{docsPrefix}}user-guide/version-control/)，{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %} [从仪表板生成报告](/docs/pe/user-guide/dashboards/#generate-report-from-dashboard)，{% endif %}以及通过工具栏对应图标配置[时间窗口](/docs/{{docsPrefix}}user-guide/dashboards/#time-window)。

部分图标（状态、布局、设置、实体别名、过滤器、版本控制、添加新部件）仅在「编辑」模式下可见，其余图标在「查看」和「编辑」模式下均可见。
您可通过[设置](/docs/{{docsPrefix}}user-guide/dashboards/#settings)隐藏这些图标或将工具栏默认设为最小化。

{% include images-gallery.html imageCollection="dashboard-toolbar" %}

### 编辑模式

进入仪表板编辑模式：打开要编辑的仪表板，点击屏幕右上角的「编辑模式」按钮。

进入编辑模式后，可通过仪表板工具栏添加新元素和控件。
请使用「保存」按钮保存更改；若需放弃未保存的修改，可点击「取消」按钮。

{% include images-gallery.html imageCollection="edit-mode" %}

### 添加新部件

所有物联网仪表板均由ThingsBoard部件构成。
部件是在仪表板上展示特定信息或功能的元素。
部件用于数据可视化、远程设备控制、告警管理以及展示静态自定义HTML内容。

向仪表板添加部件的步骤：

{% include images-gallery.html imageCollection="add-new-widget" showListImageTitles="true" %}

每个部件通常都有特定设置和参数，可按需自定义其行为与外观。
更多关于部件、如何创建部件及其设置的说明，请点击下方按钮：

<br>
<p><a href="/docs/{{docsPrefix}}user-guide/widgets/" class="button">部件文档</a></p>

<br>

### 时间窗口

时间窗口用于在处理遥测数据时定义时间区间。
所有时序部件和告警部件均使用时间窗口，除非配置为使用各自的[部件时间窗口](/docs/{{docsPrefix}}user-guide/widgets/#widget-time-window){:target="_blank"}。
对于时序部件，ThingsBoard会拉取时间戳落在时间窗口内的遥测数据；对于告警部件，会拉取创建时间落在时间窗口内的告警。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/3xRWm1W1IM4" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

<br>

**时间窗口可有两种模式**：

- **实时模式**：部件持续从服务器接收更新，自动显示当前时间戳下落在时间窗口内的数据；
- **历史模式**：部件仅在首次加载时接收数据，不再通过WebSocket接收更新。

{% include images-gallery.html imageCollection="time-window" %}

<br>
**时间窗口主要参数：**

- **最近**：显示指定时间区间内的实时数据（如最近5分钟、最近1小时或最近24小时）。
- **范围**：显示固定时段的数据，如2024年12月1日至12月7日。
- **相对**：使用预设区间，如当天、前一天或前一个月。

{% include images-gallery.html imageCollection="time-window-key-parameters" %}

<br>
要显示所需时间段的数据，请在时间窗口内设置时间范围并点击「更新」。

{% include images-gallery.html imageCollection="displaying-data-for-desired-time-period" %}

{% capture difference %}
**请注意：**
<br>
**当天**区间表示24小时（当日0点到次日0点），而**当天至今**表示从当日0点到时间窗口更新的时刻。
其他区间以此类推区分。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include images-gallery.html imageCollection="time-window-interval" %}

**聚合**

数据聚合函数应用于时序数据，不适用于告警。当前提供六种聚合函数：

- **最小值**：在所选时间区间内取所有数据的最小值。适用于显示最小值，如一小时内最低温度。
- **最大值**：在所选时间区间内取所有数据的最大值。适用于显示最大值，如最高能耗。
- **平均值**：计算所选区间内所有数据的算术平均值。适用于分析平均指标，如日平均湿度。
- **求和**：计算所选时间区间内所有值的总和。适用于统计用水量、用电量等总量。
- **计数**：统计所选区间内的记录数。适用于评估接收数据量或事件数量。
- **无**：不应用任何聚合函数，传输原始数据。适用于需要每个未处理值的场景。

当您不希望将所有原始时序数据拉到用户界面、而希望在数据库层面预聚合时，可使用数据聚合。

使用聚合函数有助于节省网络带宽、降低客户端浏览器的计算负担。建议尽量使用聚合函数，尤其在处理大量原始数据点时。

{% include images-gallery.html imageCollection="time-window-aggregation" %}

<br>
**分组间隔**

按指定时间间隔对时序值分组，可在既定周期内分析数据，更清晰、更高效地处理大量数据。

例如，若设备每10分钟发送一次温度数据，但需要按小时的平均值，可将分组间隔设为1小时并选用「平均值」聚合函数，即可在客户端无需额外处理的情况下获得结果。

{% include images-gallery.html imageCollection="time-window-grouping-interval" %}

当时间区间较长且希望在不修改时间戳的前提下放大查看数据时，可进行缩放。
将两个滑块向中间移动以指定要显示数据的时段。
要恢复图表原始大小，将滑块移回默认位置即可。

{% include images-gallery.html imageCollection="time-window-zoom-in" %}

ThingsBoard支持时区配置。默认情况下，仪表板使用浏览器提供的时区。
您可以设置为浏览器时区或指定国家时区。在时区栏输入名称可快速查找所需时区。

{% include images-gallery.html imageCollection="time-window-time-zone" %}

<br>
**时间窗口设置**

可通过隐藏部分配置项为最终用户定制时间窗口。进入仪表板编辑模式，点击仪表板工具栏上的「编辑时间窗口」图标。在弹出窗口中点击「齿轮」图标，即可打开时间窗口配置界面。

{% include images-gallery.html imageCollection="time-window-settings" %}

在此可进行以下配置：

*时间窗口*：

- **向最终用户隐藏时间窗口区域**：用户无法修改已设置的时间区间。

{% include images-gallery.html imageCollection="hide-time-window-section" %}

也可向最终用户隐藏「最近」、「范围」（历史）或「相对」区间。

{% include images-gallery.html imageCollection="hide-only-last-or-relative-interval" %}

可编辑用户可用的区间列表。此外，每个区间都可配置分组间隔并设置默认分组间隔。

{% include images-gallery.html imageCollection="edit-list-of-intervals" %}

*聚合函数*：

- **向最终用户隐藏聚合**：用户无法修改或禁用您在配置阶段设置的聚合函数。

{% include images-gallery.html imageCollection="hide-aggregation" %}

可编辑可用聚合函数列表，指定最终用户可用的聚合函数。

{% include images-gallery.html imageCollection="edit-aggregation-list" %}

*分组间隔*：

- **向最终用户隐藏分组间隔**：用户无法修改配置阶段设置的分组间隔。

{% include images-gallery.html imageCollection="hide-grouping-interval" %}

- **向最终用户隐藏时区**：禁止用户修改时区。

{% include images-gallery.html imageCollection="hide-time-zone" %}

*仅在聚合为「无」时可用*：

{% if docsPrefix == null or docsPrefix == "pe/" %}
- **最大数据点数**：限制所选时间窗口内时序部件渲染的数据点数量。对于自托管安装，此限制可通过 DASHBOARD_MAX_DATAPOINTS_LIMIT [参数](/docs/user-guide/install/{{docsPrefix}}config/#ui-settings-parameters){:target="_blank"}配置。
{% endif %}

{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
- **最大数据点数**：限制所选时间窗口内时序部件渲染的数据点数量。
{% endif %}

{% include images-gallery.html imageCollection="max-values" %}

### 过滤器

实体过滤器用于为实体别名解析出的实体列表指定过滤条件。

举例：假设有数千台「温度计」设备，希望仅显示特定型号且电池电量在某一范围内的设备。
假设温度计型号存储在属性中，电池电量存储在时序数据中。
可定义过滤器：传感器型号为「DHT22」且电池电量低于20%。

{% capture difference %}
**请注意：**
<br>
添加过滤器时，可通过移动过滤器名称旁的滑块，配置用户是否可编辑该过滤器。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include images-gallery.html imageCollection="filters" showListImageTitles="true" %}

过滤器仅作用于属性或时序键的「最新」值。请勿用此功能过滤历史时序值。

可使用「复杂」过滤器在同一键上组合多个逻辑表达式，例如：「(A > 0 and A < 20) or (A > 50 and A < 100)」。
也可用「and」关系组合不同键的两个表达式，例如：「(A > 0 and A < 20) and (B > 50 and B < 100)」。
目前尚不支持对不同键使用「or」组合，例如：「(A > 0 and A < 20) or (B > 50 and B < 100)」不可用。.

更多过滤器使用示例请参见以下视频：

<br>
<div id="video">
  <div id="video_wrapper">
    <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/yTAhUpZiFkM?start=177" frameborder="0" allowfullscreen=""></iframe>
  </div>
</div>

### 实体别名

实体别名决定仪表板上要显示的实体（设备、资产等）。
可把别名视为对一个或多个设备的引用，这类引用可以是静态或动态的。

静态别名的示例：[单实体](/docs/{{docsPrefix}}user-guide/ui/aliases/#single-entity)别名。在别名对话框中一次性配置实体。
具有访问权限的用户看到的都是相同数据。

An example of a dynamic alias is the [Device type](/docs/{{docsPrefix}}user-guide/ui/aliases/#device-type) alias, which displays all devices of a certain type (e.g. "Thermometer").
This alias is dynamic because the list of devices depends on the user using the dashboard.
If you are logged in as a Tenant administrator, this alias will be allowed for all Thermometer devices.
However, if you are logged in as a Customer user, this alias will be resolved to Thermometer devices that are assigned/owned by that Customer.

下面创建一个动态别名，用于显示「智能传感器」类型的所有设备。

{% include images-gallery.html imageCollection="aliases" showListImageTitles="true" %}

更多信息请参阅[实体别名文档](/docs/{{docsPrefix}}user-guide/ui/aliases)。

### 设置

仪表板设置用于调整整体外观，可修改标题、徽标并定制工具栏。

定制仪表板时，进入[编辑模式](#edit-mode)，然后点击仪表板窗口右上角的「齿轮」图标打开仪表板设置窗口。

{% include images-gallery.html imageCollection="settings" %}

**标题设置**

若要在仪表板上显示标题，需勾选「显示仪表板标题」。默认文字颜色为黑色。
可点击色圈，通过标题颜色参数中的滑块调整颜色和透明度。
修改后的标题会显示在仪表板左上角。

{% include images-gallery.html imageCollection="title-settings" %}

**仪表板徽标设置**

可设置在全屏模式下显示的仪表板徽标：勾选「在仪表板全屏模式下显示徽标」并上传徽标图片。

{% include images-gallery.html imageCollection="dashboard-logo-settings" %}

**工具栏设置**

「显示仪表板选择」「显示实体选择」「显示过滤器」「显示时间窗口」「显示导出」和「显示更新仪表板图片」这些勾选项控制仪表板工具栏面板中对应选项的显示与否。

「显示过滤器」仅当至少创建一个过滤器后才会出现在工具栏上。
若已创建过滤器，但希望限制客户修改设备指标的能力，可取消勾选相应选项以在工具栏上隐藏过滤器。

可显示或隐藏工具栏图标。例如，在仪表板页面上隐藏「显示仪表板选择」「显示时间窗口」和「显示导出」图标。

{% include images-gallery.html imageCollection="toolbar-dashboard-1" %}

「隐藏工具栏」会将工具栏从仪表板页面隐藏。
此时屏幕右上角会出现「进入编辑模式」图标。

{% include images-gallery.html imageCollection="toolbar-dashboard-2" %}

「保持工具栏展开」控制仪表板页面上工具栏的显示方式。
若取消勾选，工具栏将收起。此时屏幕右上角会显示三点图标。
点击该图标可展开隐藏的工具栏。

{% include images-gallery.html imageCollection="toolbar-dashboard-3" %}

### 布局

布局决定部件在仪表板网格上的显示与排布方式。[更多布局说明请参阅单独文档](/docs/{{docsPrefix}}user-guide/ui/layouts/){:target="_blank"}。

### 状态

状态功能用于在仪表板中建立层级结构。要正确使用状态，需为部件分配特定操作，以便在不同状态之间快速切换。
操作步骤：进入[编辑模式](#edit-mode)，点击仪表板窗口左上角双叠方块的「管理仪表板状态」按钮，将打开管理仪表板状态配置窗口。

{% include images-gallery.html imageCollection="states-1" %}

由于尚未创建任何状态，当前只有「根状态」即仪表板本身。根状态定义层级的主状态。
创建额外状态后，可点击「铅笔」图标（编辑仪表板状态）并勾选「根状态」复选框来更改根状态。

{% include images-gallery.html imageCollection="states-root" %}

要添加新状态，点击窗口右上角的「+」图标，将打开添加仪表板状态窗口。
输入名称后，状态ID会根据名称自动生成，您也可手动修改。点击「添加」后保存所有更改。

{% include images-gallery.html imageCollection="states-2" %}

为特定部件设置对应操作后，即可在不同状态间切换。
添加操作时，点击部件右上角的「铅笔」图标（编辑部件）进入部件配置模式。
进入「操作」标签页，点击「+」图标添加新操作。

{% include images-gallery.html imageCollection="states-3" %}

将打开「添加操作」窗口。

- _操作来源_：为达成目标需执行的具体动作。
- _名称_：操作的自定义标题。
- _图标_：操作对应的符号。
- _类型_：操作的意图。

本例中，_类型_ 应选择「导航到新仪表板状态」。选择后会出现「目标仪表板状态」选项，需选择新创建的状态。
配置完成后点击「添加」。新操作将出现在操作列表中。点击窗口右上角的「应用」按钮以保存更改。

由于选择的是「行点击」操作，需点击部件的行来触发操作。点击后会立即切换到所选状态。

{% include images-gallery.html imageCollection="states-4" %}

若要让状态以实体命名，可在状态名称中使用 **${entityName}**。这样，在执行操作时，将跳转到以参与操作的实体名称命名的状态。

{% include images-gallery.html imageCollection="states-entity-name" %}

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
### 从仪表板生成报告

租户管理员或客户用户可从当前打开的仪表板以**PDF**、**PNG**或**JPEG**格式**生成报告**。
- 点击仪表板工具栏右侧的「**导出仪表板**」按钮。

<object width="40%" data="/images/user-guide/dashboards/overview/generate-report-from-dashboard-1-pe.png"></object>

- 在展开的下拉菜单中选择所需的导出格式。

<object width="40%" data="/images/user-guide/dashboards/overview/generate-report-from-dashboard-2-pe.png"></object>

- 报告生成过程将自动开始。

<object width="40%" data="/images/user-guide/dashboards/overview/generate-report-from-dashboard-3-pe.png"></object>

最后，报告文件将自动下载并保存到您的电脑。

**按计划生成仪表板报告**

报告生成也可通过[事件调度器](/docs/{{docsPrefix}}user-guide/scheduler/#generate-report){:target="_blank"}，选择「**生成仪表板报告**」事件类型实现自动化。
{% endif %}

## 管理仪表板

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
对仪表板可执行以下操作：[导出JSON格式仪表板](#export-dashboard)、[共享仪表板组](#share-dashboard-group)、[将仪表板组设为公开](#make-dashboard-group-public)、[编辑仪表板](#edit-dashboard)和[删除仪表板](#delete-dashboard)，通过仪表板旁的对应图标操作。
{% endif %}

{% if docsPrefix == null %}
对仪表板可执行以下操作：[导出JSON格式仪表板](#export-dashboard)、[将仪表板设为公开](#make-dashboard-public)、[管理已分配客户](#manage-assigned-customers)、[编辑仪表板](#edit-dashboard)和[删除仪表板](#delete-dashboard)，通过仪表板旁的对应图标操作。
{% endif %}

以下逐项说明各操作。

### 导出仪表板

在ThingsBoard中可将仪表板导出为JSON格式的配置文件。
此文件可用于将仪表板或部件配置迁移到另一实例。

导出仪表板：进入 “Dashboards” 页面， 在列表中找到要导出的仪表板，点击其名称旁的「导出仪表板」按钮。包含控制面板所有设置的JSON格式配置文件将保存到您的电脑。

{% include images-gallery.html imageCollection="export-dashboard" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
也可从工具栏直接导出：打开仪表板，点击屏幕右上角的「导出仪表板」按钮，选择「导出JSON配置」。
仪表板将导出为JSON格式的配置文件。

{% include images-gallery.html imageCollection="dashboard-toolbar-export" %}

仪表板还可导出为PDF、PNG或JPEG等其他格式。
适用于通过邮件发送或打印仪表板中显示的数据。

{% include images-gallery.html imageCollection="pro-export" %}

{% endif %}
{% if docsPrefix == null %}
也可从工具栏直接导出：打开仪表板，点击屏幕右上角的「导出仪表板」按钮。
仪表板将导出为JSON格式的配置文件。

{% include images-gallery.html imageCollection="dashboard-toolbar-export" %}

在**ThingsBoard专业版**中，除JSON格式外，仪表板还可导出为PDF、PNG和JPEG等格式。适用于通过邮件发送或打印仪表板中显示的数据。

{% include images-gallery.html imageCollection="pro-export" %}

{% endif %}

### 导入仪表板

可从JSON配置文件导入仪表板，适用于从其他实例迁移仪表板配置。

导入仪表板步骤如下：

{% include images-gallery.html imageCollection="import-dashboard" showListImageTitles="true" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
### 管理仪表板所有者和分组

可更改<b>仪表板所有者</b>，确保仅与所选客户相关的用户能访问该仪表板。

> <b>注意</b>：此步骤对维护严格的[访问控制](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}至关重要。每位客户用户仅能访问明确授予其的数据。
<b>请记住</b>：授予仪表板访问权限只会让客户访问仪表板本身，<b>不包括</b>其上显示的数据。若要让部件显示数据，还需授予客户对相应设备或其他实体的访问权限。

<b>更改仪表板所有者：</b>

- 在仪表板列表中点击「<b>铅笔</b>」图标打开仪表板详情。
- 点击「<b>管理所有者和分组</b>」按钮。
- 从列表中选择新的仪表板所有者。如需，可将仪表板加入现有分组或创建新分组。
- 确认更改以更新所有者信息。

在<b>「客户名称」列</b>中可查看仪表板当前所有者。

> <b>注意</b>：租户管理员始终有权重新分配或撤销仪表板所有权。

{% include images-gallery.html imageCollection="dashboard-manage-owner-and-groups" %}

#### 包含客户实体

「<b>仪表板</b>」页面上的「<b>包含客户实体</b>」选项决定是否在列表中显示客户拥有的仪表板。

{% include images-gallery.html imageCollection="include-customer-dashboards" showListImageTitles="true" %}

### 共享仪表板组

可将仪表板组共享给客户，授予「读取」「写入」等权限，或使用已有角色。
角色是定义用户可执行操作的权限集合。更多关于角色的信息请参阅[此处](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}。

共享仪表板组步骤如下：

{% include images-gallery.html imageCollection="share-dashboard-group" showListImageTitles="true" %}

{% endif %}

{% if docsPrefix == null %}
### 将仪表板设为公开

可将仪表板设为公开，并与他人共享链接。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
### 将仪表板组设为公开

可将仪表板组及其全部仪表板设为公开，并与他人共享这些仪表板的链接。
{% endif %}

操作步骤如下：

{% include images-gallery.html imageCollection="make-public" showListImageTitles="true" %}

若要将仪表板恢复为私有，请按以下步骤操作：

{% include images-gallery.html imageCollection="make-private" showListImageTitles="true" %}

{% capture difference %}
**请注意：**
<br>
要在公开仪表板上显示数据，关联的实体也需设为公开。专业版可将设备或资产组设为公开，社区版可将单个设备或资产设为公开。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% if docsPrefix == null %}
### 管理已分配客户

可将仪表板分配给客户。客户仅能查看仪表板，无法对其进行其他操作。

将仪表板分配给客户的步骤：

{% include images-gallery.html imageCollection="manage-assigned-customers" showListImageTitles="true" %}

也可取消客户的仪表板分配。操作如下：

{% include images-gallery.html imageCollection="manage-unassigned-customers" showListImageTitles="true" %}

要同时向客户分配/取消分配多个仪表板，可选中目标仪表板，使用「分配仪表板」和「取消分配仪表板」按钮。

{% include images-gallery.html imageCollection="assigned-multiple-dashboards" showListImageTitles="true" %}

{% endif %}

### Edit dashboard

可编辑标题、描述等字段。修改后请记得保存。
完成以上步骤即可成功更新仪表板信息。

操作步骤示例：

{% include images-gallery.html imageCollection="dashboard-details" showListImageTitles="true" %}

### 删除仪表板

可通过以下任一方式删除仪表板：

方式一：

{% include images-gallery.html imageCollection="delete-dashboard-1" showListImageTitles="true" %}

方式二：

{% include images-gallery.html imageCollection="delete-dashboard-2" showListImageTitles="true" %}

也可批量删除多个仪表板。

{% include images-gallery.html imageCollection="delete-dashboard-3" showListImageTitles="true" %}

## 后续步骤

 - [部件](/docs/{{docsPrefix}}user-guide/widgets) - 本指南介绍如何配置ThingsBoard部件。

 - [数据可视化](/docs/{{docsPrefix}}guides/#AnchorIDDataVisualization) - 这些指南介绍如何配置复杂的ThingsBoard仪表板。

 - [数据处理与操作](/docs/{{docsPrefix}}guides/#AnchorIDDataProcessing) - 了解如何使用ThingsBoard规则引擎。
