* TOC
{:toc}

{% assign sinceVersion = "4.2" %}
{% include templates/since.md %}

{% assign feature = "Reporting" %}{% include templates/pe-feature-banner.md %}

在ThingsBoard中，**报表**是用于以报表形式收集、整理并自动分发数据的强大而灵活的工具。

ThingsBoard的报表基于**两个关键组件**：
- **已配置的报表模板** — 定义报表的结构、内容和格式。模板可以是**PDF**或**CSV**格式，可包含任意支持的组件，如表格、图表、文本块、图像等。
- **调度器事件** — 在指定时间自动触发报表生成，并通过可用推送渠道（如**email**、**Slack**及其他集成）发送给所选收件人。

<b><font size="3">主要特性：</font></b><br>
- **自动调度** — 预配置的调度器事件可按设定时间表发送报表，无需用户操作。
- **可重用模板** — 单个模板可通过应用筛选器和参数用于不同收件人。
- **基于事件的交付** — 在特定事件发生时发送报表（例如设备上的活动告警）。
- **富内容支持** — 可包含文本块、表格、图表、图像等。
- **通知集成** — 将生成的报表附加到系统通知（Email、Slack）。

<b><font size="3">适用场景：</font></b><br>
- 定期监控设备指标。
- 与合作伙伴或管理层共享汇总数据。
- 以易读格式归档数据。
- 在事件期间自动化沟通。

<br><b><font size="5">核心概念</font></b>

<br><b><font size="4">报表模板</font></b>

ThingsBoard中的**报表模板**定义由系统使用调度器生成的报表的结构、布局和内容。它作为创建以下两种格式之一的视觉丰富且功能性报表的基础：
- **PDF** — 可包含图表、表格、图像和公司品牌的可视化样式报表。
- **CSV** — 面向数据的表格报表，便于在Excel或BI工具中分析。

**示例**：

**报表模板**及其**生成的报表**

{% include images-gallery.html imageCollection="report-example" %}

## 如何创建报表模板 {#how-to-create-a-report-template}

- 从左侧边栏打开"**报表**"页面。您将自动进入"**模板**"标签页。
- 点击右上角的"**+ 添加报表模板**"按钮。
- 选择"**创建新报表模板**"。
- 在弹窗中填写以下内容：
    - **名称** — 报表模板的描述性名称。
    - **格式**：选择**PDF**或**CSV**报表格式。
    - **类型**：
        - **报表** - 完整的独立报表模板。
        - [子报表](/docs/{{docsPrefix}}user-guide/reporting/subreport/){:target="_blank"} - 可嵌入另一报表的模块化组件。
    - 点击"**添加**"以创建报表模板并打开**报表构建器**界面，您可以在其中设计报表的结构、布局和内容。

{% include images-gallery.html imageCollection="create-new-report-template" %}

## 报表构建器

**报表构建器**是一种拖放式编辑器，让您使用视觉和数据组件设计报表模板。您可完全控制报表的外观和结构。

报表构建器外观如下：

{% include images-gallery.html imageCollection="report-builder" %}

## 组件与交互

模板由可自定义的组件组成，每个组件作为视觉或功能块。这些组件决定最终报表中显示的内容及其呈现方式。

<b><font size="4">主要组件类型：</font></b><br>

- **文本与图像** — 向报表添加**文本块**、**标题**和**图像**。文本块支持纯文本或富文本，可包含[动态占位符](#variables--dynamic-content)用于时间戳、实体名称、用户详情等。
- **表格** — 以表格形式显示**结构化数据（如告警、实体及其遥测）**。每个表格的样式可通过布局配置标签页自定义 — 调整列宽、字体大小、边框和分页。
- [**子报表**](/docs/{{docsPrefix}}user-guide/reporting/subreport/){:target="_blank"} 是嵌入主报表的模块化报表模板，继承其上下文并根据其生成内容。
- [**仪表盘**](/docs/{{docsPrefix}}user-guide/reporting/embedding-dashboards-widgets/){:target="_blank"} - 将指定仪表盘的截图以图像形式嵌入报表。
- [**图表**](/docs/{{docsPrefix}}user-guide/reporting/embedding-charts/){:target="_blank"} - 使用可配置的**折线和柱状图**可视化时序数据，或使用不同类型的**饼图和环形图**展示最新值。
- **品牌** - 添加**徽标**、**页眉**和**页脚**以自定义报表外观。
- **报表信息与布局** - 支持组件（**分屏视图**、**页码**、**创建时间**、**分隔线**、**分页符**）用于组织报表结构并显示系统元数据。

<b><font size="4">组件配置</font></b><br>

每个组件有两个主要配置部分：
- **数据配置** — 定义组件将显示的数据及其筛选方式。支持[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}和用于动态数据绑定的筛选器。
- **布局配置** — 控制最终文档中的视觉样式和格式。

## 支持的实体别名

报表模板完全支持与ThingsBoard中[仪表盘](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}相同的[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}模型。此外，新增了以下实体筛选器：

- **源实体** - 发起发送至"生成报表"规则节点的消息或触发创建通知的实体。
- **源实体的所有者** - 发起发送至"生成报表"规则节点的消息的实体的所有者，或触发创建通知的实体的所有者。

{% include images-gallery.html imageCollection="reporting-new-entity-aliases-1" %}

## 变量与动态内容 {#variables--dynamic-content}

在ThingsBoard中，报表组件将数据作为**变量**提供，可直接在组件元素内引用。您可在允许文本的任何位置插入这些变量 — 例如在文本块、表头、图表标签或其他动态字段中。这使您能够创建高度个性化、情境感知的报表。

<b><font size="3">系统变量：</font></b><br>
系统变量在任何报表或子报表中可用，与连接的数据源无关。

示例：
- **${pageNumber}** — 显示报表中的当前页码。
- **${totalPages}** — 显示报表的总页数。
- **${reportCreatedTime}** — 保存报表创建时的日期和时间，格式为**yyyy-MM-dd HH:mm:ss**。
- **${entityName}** - 报表中使用的实体的技术或系统名称。
- **${entityLabel}** - 实体的人类可读名称。
- **${rowCount}** - 显示表格中包含的记录（行）数量（仅适用于表格组件）。

<b><font size="3">数据源变量：</font></b><br>
数据源变量基于连接到组件的**数据源**（设备、资产等）的指定**数据键**（属性或遥测）生成。
每个选定的键自动变为可作为变量插入报表中任意文本字段的变量。

示例：
- **${status}** — 键为*status*的属性或遥测的值。
- **${temperature}** — 键为*temperature*的遥测的值。
- **${voltage}** — 键*voltage*的值。

> **注意：** 如果连接的数据源不包含指定键的值，报表中的变量将保持为空。

<b><font size="4">在编辑器中的使用变量：</font></b><br>

- 在**报表构建器**中，添加组件（例如富文本），在"**数据**"标签页中指定其数据源（目标实体和数据键）。
- 接下来，在组件的文本字段中，在要插入变量值的位置输入 `$` 符号。这将打开当前上下文中所有可用变量的列表。
- **选择变量**（例如 ${reportCreatedTime}），其值将在生成期间插入报表。
- 根据需要继续输入文本并添加变量。
- 完成后，点击右上角的"**保存**"按钮应用更改。

{% include images-gallery.html imageCollection="variables-and-dynamic-content-1" %}

要验证结果，请点击右上角的相应按钮生成测试报表示例。

{% include images-gallery.html imageCollection="variables-and-dynamic-content-2" %}

## 导入报表模板 {#importing-report-template}

有现成的`.json`格式报表模板？只需点击"**导入报表模板**"并上传您的文件 — 所有配置和组件将自动导入。

{% include images-gallery.html imageCollection="import-report-template" %}

## 调度器

ThingsBoard中的<b>调度器</b>是用于生成报表的自动化机制。
它让您基于预构建的报表模板配置在指定时间自动创建和交付报表。

有关分步指导，请参阅：[调度报表](/docs/{{docsPrefix}}user-guide/reporting/scheduling-reports/){:target="_blank"}。

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
