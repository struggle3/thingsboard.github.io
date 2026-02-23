* TOC
{:toc}

别名是指向单个实体或实体组的引用，用于部件中。别名可以是静态的或动态的。

可简单引用单个设备，也可进行针对列表中特定资产的复杂搜索查询。

本教程中，别名将按下图所示方案在系统中使用。所有设备均传输遥测值——“temperature”。

![image](/images/user-guide/ui/alias/alias-scheme.png)

## 前置条件

在继续本指南之前，建议先阅读[入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/)指南，以熟悉 ThingsBoard 设备、仪表板和部件。这将有助于您理解本文所述概念。

## 创建别名

要创建别名，需要定义从中提取数据的实体。

然后按以下步骤操作：

{% include images-gallery.html imageCollection="create-alias" showListImageTitles="true" %}

现在，让我们在部件中使用已添加的别名：

{% include images-gallery.html imageCollection="use-alias-in-widget" showListImageTitles="true" %}

## 别名类型

{% if docsPrefix == null %}
ThingsBoard 中有多种别名类型，各有不同配置能力：[单个实体](#single-entity)、[实体列表](#entity-list)、[实体名称](#entity-name)、[实体类型](#entity-type)、[来自仪表板状态的实体](#entity-from-dashboard-state)、[资产类型](#asset-type)、[设备类型](#device-type)、[实体视图类型](#entity-view-type)、[Edge 类型](#edge-type)、[API 使用状态](#api-usage-state)、[关系查询](#relations-query)、[资产搜索查询](#asset-search-query)、[设备搜索查询](#device-search-query)、[实体视图搜索查询](#entity-view-search-query)和[Edge 搜索查询](#edge-search-query)。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
ThingsBoard 中有多种别名类型，各有不同配置能力：[单个实体](#single-entity)、[实体组](#group-entities)、[实体列表](#entity-list)、[实体名称](#entity-name)、[实体类型](#entity-type)、[实体组列表](#entity-group-list)、[按组名的实体](#entities-by-group-name)、[来自仪表板状态的实体](#entity-from-dashboard-state)、[来自仪表板状态实体的所有者](#owner-of-entity-from-dashboard-state)、[资产类型](#asset-type)、[设备类型](#device-type)、[实体视图类型](#entity-view-type)、[Edge 类型](#edge-type)、[API 使用状态](#api-usage-state)、[关系查询](#relations-query)、[资产搜索查询](#asset-search-query)、[设备搜索查询](#device-search-query)、[实体视图搜索查询](#entity-view-search-query)、[Edge 搜索查询](#edge-search-query)和[调度器事件](#scheduler-events)。
{% endif %}

它们为在 ThingsBoard 中高效组织和可视化各类数据源提供灵活且强大的仪表板配置能力。

下面逐一介绍。

### 单个实体

{% if docsPrefix == null %}
此别名允许选择单个实体。可以是设备、资产、实体视图、租户、客户、用户、仪表板、Edge、当前客户、当前租户、当前用户或当前用户所有者。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名允许选择单个实体。可以是设备、资产、实体视图、租户、客户、仪表板、用户、数据转换器、集成、调度器事件、blob 实体、角色、Edge、当前客户、当前租户、当前用户或当前用户所有者。
{% endif %}

添加别名：在“添加别名”对话框中输入别名名称，选择“单个实体”筛选类型。然后选择实体类型并指定具体实体。

{% include images-gallery.html imageCollection="single-alias-1" %}

本例中，已创建一个筛选单个设备 Thermometer A1 的别名。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“单个实体”别名，在“Columns”部分指定“temperature”数据键。点击“Add”并应用更改。
已添加显示单个设备 Thermometer A1 的 Entities table 部件。

{% include images-gallery.html imageCollection="single-alias-2" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
### 实体组

此别名允许选择一个实体组作为数据源。可以是设备组、资产组、实体视图组、客户组、仪表板组、用户组或 Edge 组。

添加别名：在“添加别名”对话框中输入别名名称，选择“实体组”筛选类型。然后选择实体类型并选择实体组。

{% include images-gallery.html imageCollection="group-entities-1" %}

本例中，已创建一个显示属于“Thermostats”设备组的所有设备的别名。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体组”别名，在“Columns”部分指定“temperature”数据键。点击“Add”并应用更改。
已添加显示属于“Thermostats”设备组的所有设备的 Entities table 部件。

{% include images-gallery.html imageCollection="group-entities-2" %}
{% endif %}

### 实体列表

{% if docsPrefix == null %}
此别名允许显示多个实体。可以是设备、资产、实体视图、租户、客户、仪表板、用户或 Edge。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名允许显示多个实体。可以是设备、资产、实体视图、租户、客户、仪表板、用户、数据转换器、集成、调度器事件、blob 实体、角色或 Edge。
{% endif %}

添加别名：在“添加别名”对话框中输入别名名称，选择“实体列表”筛选类型。然后选择实体类型并指定要在部件上显示其数据的实体。

{% include images-gallery.html imageCollection="entity-list-1" %}

{% if docsPrefix == null %}
此别名筛选指定设备列表：Thermometer A1、Thermometer A2 和 Thermometer A3。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名筛选指定设备列表：Thermometer A1、Compressor BC-10 和 Compressor QA-32。
{% endif %}

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体列表”别名，在“Columns”部分指定“temperature”数据键。点击“Add”并应用更改。

{% if docsPrefix == null %}
已添加显示多个设备列表的 Entities table 部件，本例为 Thermometer A1、Thermometer A2 和 Thermometer A3。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
已添加显示多个设备列表的 Entities table 部件，本例为 Compressor BC-10、Compressor QA-32 和 Thermometer A1。
{% endif %}


{% include images-gallery.html imageCollection="entity-list-2" %}

### 实体名称

{% if docsPrefix == null %}
此别名允许显示名称以输入表达式开头的实体。可以是设备、资产、实体视图、租户、客户、用户、仪表板或 Edge。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名允许显示名称以输入表达式开头的实体。可以是设备、资产、实体视图、租户、客户、仪表板、用户、数据转换器、集成、调度器事件、blob 实体、角色或 Edge。
{% endif %}

添加别名：在“添加别名”对话框中输入别名名称，选择“实体名称”筛选类型。然后选择实体类型并输入用于筛选显示实体名称的表达式。

{% include images-gallery.html imageCollection="entity-name-1" %}

此别名筛选名称以“Compressor”开头的设备。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体名称”别名，在“Columns”部分指定“temperature”数据键。点击“Add”并应用更改。
已添加按名称以“Compressor”开头的设备筛选的 Entities table 部件。

{% include images-gallery.html imageCollection="entity-name-2" %}

### 实体类型

{% if docsPrefix == null %}
此别名允许显示您及客户指定类型的所有实体。可以是设备、资产、实体视图、租户、客户、用户、仪表板或 Edge。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名允许显示您及客户指定类型的所有实体。可以是设备、资产、实体视图、租户、客户、仪表板、用户、数据转换器、集成、调度器事件、blob 实体、角色或 Edge。
{% endif %}

添加别名：在“添加别名”对话框中输入别名名称，选择“实体类型”筛选，并选择实体类型。

{% include images-gallery.html imageCollection="entity-type-1" %}

此别名显示您及客户的所有设备。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体类型”别名，在“Columns”部分指定“temperature”数据键。点击“Add”并应用更改。
已添加显示您及客户所有设备的 Entities table 部件。

{% include images-gallery.html imageCollection="entity-type-2" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
### 实体组列表

此别名允许显示实体组列表，可包含设备组、资产组、实体视图组、客户组、仪表板组、用户组或 Edge 组。

添加别名：在“添加别名”对话框中输入别名名称，选择“实体组列表”筛选。然后选择实体类型并指定要在部件上显示的实体组。

{% include images-gallery.html imageCollection="entity-group-list-1" %}

此别名显示设备组列表，本例为“Compressors”和“Thermostats”。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体组列表”别名。点击“Add”并应用更改。
已添加显示设备组列表的 Entities table 部件。

{% include images-gallery.html imageCollection="entity-group-list-2" %}

### 实体组名称

此别名允许显示以输入查询开头的多个实体组名称。可包含设备组、资产组、实体视图组、客户组、仪表板组、用户组或 Edge 组。

添加别名：在“添加别名”对话框中输入别名名称，选择“实体组名称”筛选类型。然后选择实体类型并输入用于筛选显示实体组名称的表达式。

{% include images-gallery.html imageCollection="entity-group-name-1" %}

此别名显示名称以“Compressor”开头的设备组。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体组名称”别名。点击“Add”并应用更改。
已添加显示名称以输入查询开头的设备组的 Entities table 部件。

{% include images-gallery.html imageCollection="entity-group-name-2" %}

### 按组名的实体

此别名允许通过输入要显示实体的组的完整名称来筛选实体。可包含设备组、资产组、实体视图组、客户组、仪表板组、用户组或 Edge 组。

“按组名的实体”别名与“[实体组](#group-entities)”别名的区别在于：前者通过指定名称解析组，后者使用硬编码的组 ID。更重要的是，在查找实体时，此别名将使用当前用户信息。因此，若将仪表板分享给多个客户，且希望每位客户仅看到属于自己的设备，应使用此别名而非“实体组”。

添加别名：在“添加别名”对话框中输入别名名称，选择“按组名的实体”筛选类型。然后选择实体类型并输入要显示其实体的组的完整名称。

{% include images-gallery.html imageCollection="entities-by-group-name-1" %}

此别名按名称筛选设备组——“Compressors”。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。
进入“Entity alias”选项卡。在“Entity alias”字段指定“按组名的实体”别名，在“Columns”部分指定“temperature”数据键。点击“Add”并应用更改。
已添加显示按输入的实体组完整名称筛选实体的 Entities table 部件。

{% include images-gallery.html imageCollection="entities-by-group-name-2" %}
{% endif %}

### 来自仪表板状态的实体

{% if docsPrefix == null %}
此别名允许从仪表板状态中选择一个或多个实体。可以是设备、资产、实体视图、租户、客户、用户、仪表板、Edge、当前客户、当前租户、当前用户或当前用户所有者。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名允许从仪表板状态中选择一个或多个实体。可以是设备、资产、实体视图、租户、客户、仪表板、用户、数据转换器、集成、调度器事件、blob 实体、角色、Edge、当前客户、当前租户、当前用户或当前用户所有者。
{% endif %}

例如，若在[根仪表板状态](/docs/{{docsPrefix}}user-guide/dashboards/#states)上创建了显示多个实体的 Entities table 部件，且希望创建一个显示点击实体详情部件的新仪表板状态，则需使用此别名。

添加别名：在“添加别名”对话框中输入别名名称，选择“来自仪表板状态的实体”筛选类型。然后点击“Add”。

{% include images-gallery.html imageCollection="entity-from-dashboard-state-1" %}

此别名用于为其他仪表板状态筛选数据。

{% if docsPrefix == null %}
下一个示例需要两个别名：前述“[实体类型](#entity-type)”别名和“来自仪表板状态的实体”别名。开始如下：

首先创建一个显示实体列表的 Entity table 部件：添加一个显示实体列表的 Entities table 部件。使用“实体类型”别名作为数据源。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
下一个示例需要两个别名：前述“[实体组](#group-entities)”别名和“来自仪表板状态的实体”别名。开始如下：

首先创建一个显示实体列表的 Entity table 部件：添加一个显示实体列表的 Entities table 部件。使用“实体组”别名作为数据源。
{% endif %}

{% include images-gallery.html imageCollection="entity-from-dashboard-state-2" %}

添加 Entities table 部件后，添加新的[状态](/docs/{{docsPrefix}}user-guide/dashboards/#states)：

{% include images-gallery.html imageCollection="entity-from-dashboard-state-3" showListImageTitles="true" %}

接下来为根仪表板部件添加[操作](/docs/{{docsPrefix}}user-guide/ui/widget-actions)，并在所创建状态的部件上使用来自仪表板状态的实体别名执行：

{% include images-gallery.html imageCollection="entity-from-dashboard-state-4" showListImageTitles="true" %}

现在，点击任意实体旁的操作按钮。将跳转到内部状态，其中包含选中实体详情的部件。

{% include images-gallery.html imageCollection="entity-from-dashboard-state-5" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
### 来自仪表板状态实体的所有者

此别名用于显示设备、资产、实体等的所有者。通常用于存在客户层次结构时，了解设备归属。

添加别名：在“添加别名”对话框中输入别名名称，选择“来自仪表板状态实体的所有者”筛选类型。然后点击“Add”。

{% include images-gallery.html imageCollection="owner-of-entity-from-dashboard-state-1" %}

学习如何在部件中使用“来自仪表板状态实体的所有者”别名显示设备所有者。

下一个示例需要两个别名：前述“[实体类型](#entity-type)”别名和“来自仪表板状态实体的所有者”别名。

首先添加一个显示所有设备列表的 Entity table 部件。使用“实体类型”别名作为数据源。

{% include images-gallery.html imageCollection="owner-of-entity-from-dashboard-state-2" %}

再添加一个显示选中设备所有者的 Entities table 部件。在“Entity alias”字段指定“来自仪表板状态实体的所有者”别名。点击右下角“Add”按钮；

{% include images-gallery.html imageCollection="owner-of-entity-from-dashboard-state-3" %}

现在需要添加用于更新仪表板当前状态的[操作](/docs/{{docsPrefix}}user-guide/ui/widget-actions)。

{% include images-gallery.html imageCollection="owner-of-entity-from-dashboard-state-4" showListImageTitles="true" %}

点击“Entities”部件中设备名称所在行。将执行操作，选中设备的所有者将显示在“Device Owner”部件中。

{% include images-gallery.html imageCollection="owner-of-entity-from-dashboard-state-5" %}
{% endif %}

### 资产类型

此别名允许按指定的资产配置（asset profile）筛选资产（可选：按名称以输入查询开头的筛选）。

添加别名：在“添加别名”对话框中输入别名名称，选择“资产类型”筛选类型。然后指定资产配置（asset profile）并输入用于筛选显示资产名称的表达式。

{% include images-gallery.html imageCollection="asset-type-1" %}

此别名筛选资产配置为“buildings”且名称以“Build”开头的资产。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“资产类型”别名。点击“Add”并应用更改。已添加显示资产配置为“buildings”且名称以“Build”开头的资产的 Entities table 部件。

{% include images-gallery.html imageCollection="asset-type-2" %}
 
### 设备类型

此别名允许按指定的设备配置（device profile）筛选设备（可选：按名称以输入查询开头的筛选）。

添加别名：在“添加别名”对话框中输入别名名称，选择“设备类型”筛选类型。然后指定设备配置（device profile）并输入用于筛选显示设备名称的表达式。

{% include images-gallery.html imageCollection="device-type-1" %}

此别名筛选设备配置为“thermometers”且名称以“Therm”开头的设备。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“设备类型”别名。点击“Add”并应用更改。已添加显示设备配置为“thermometers”且名称以“Therm”开头的设备的 Entities table 部件。

{% include images-gallery.html imageCollection="device-type-2" %}
 
### 实体视图类型

此别名允许按指定的实体视图类型筛选设备（可选：按名称以输入查询开头的筛选）。

添加别名：在“添加别名”对话框中输入别名名称，选择“实体视图类型”筛选类型。然后指定实体视图类型并输入用于筛选显示实体视图名称的表达式。

{% include images-gallery.html imageCollection="entity-view-type-1" %}

此别名筛选类型为“Compressors Entity View Type”且名称以“Compressor”开头的实体视图。

示例：已创建名为“Compressor BC-10 Entity View”和“Compressor QA-32 Entity View”的实体视图，类型为“Compressors Entity View Type”，可访问 Compressor BC-10 和 Compressor QA-32 的“Power”时序。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体视图类型”别名。点击“Add”并应用更改。已添加显示实体视图类型为“Compressors Entity View Type”且名称以“Compressor”开头的 Entities table 部件。

{% include images-gallery.html imageCollection="entity-view-type-2" %}

### Edge 类型

此别名允许按指定的 Edge 类型筛选设备（可选：按名称以输入查询开头的筛选）。

添加别名：在“添加别名”对话框中输入别名名称，选择“实体视图类型”筛选类型。然后指定实体视图类型并输入用于筛选显示实体视图名称的表达式。

{% include images-gallery.html imageCollection="edge-type-1" %}

此别名筛选 Edge 类型为“edge instance”且名称以“Edge”开头的 Edge。

让我们在部件中使用该别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“Edge 类型”别名。点击“Add”并应用更改。已添加显示 Edge 类型为“edge instance”且名称以“Edge”开头的 Entities table 部件。

{% include images-gallery.html imageCollection="edge-type-2" %}

### API 使用状态

TB 平台主菜单中有 API Usage 布局。API Usage 显示平台完整统计。API 使用状态别名允许仅从用户仪表板统计中获取所需数据。

{% include images-gallery.html imageCollection="api-usage-state-1" %}

学习如何在部件中使用“API 使用状态”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“API 使用状态”别名，并在“Columns”部分添加从 API 使用中获取统计的数据键。点击“Add”并应用更改。已添加显示 API 使用统计的 Entities table 部件。

{% include images-gallery.html imageCollection="api-usage-state-2" %}

### 关系查询

此别名允许显示与指定发起方在指定级别和方向上相关的实体。

添加别名：在“添加别名”对话框中输入别名名称，指定“关系查询”筛选类型。然后选择实体类型和要显示关系的实体。将方向设为“From”或“To”并设置最大关系级别。

{% include images-gallery.html imageCollection="relations-query-1" %}

本例中别名显示与资产“District A”在关系级别 3 内有任意关系的实体。

学习如何在部件中使用“关系查询”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“关系查询”别名，在“Columns”部分添加“entityType”数据键。点击“Add”并应用更改。已添加显示与资产“District A”在关系级别 3 内有任意关系的实体及其类型的 Entities table 部件。

{% include images-gallery.html imageCollection="relations-query-2" %}

### 资产搜索查询

此别名允许显示指定资产配置（asset profile）中与指定实体在指定级别和方向上相关的资产。

添加别名：在“添加别名”对话框中输入别名名称，选择“资产搜索查询”筛选类型，选择实体类型及要显示关系的实体。将方向设为“From”或“To”，设置最大关系级别，并指定用于筛选资产的资产配置（asset profile）。

{% include images-gallery.html imageCollection="asset-search-query-1" %}

此别名显示资产配置为“buildings”和“district”且与设备“Compressor QA-32”在方向“From”和关系级别 2 上有任意关系的资产。

学习如何在部件中使用“资产搜索查询”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“资产搜索查询”别名，在“Columns”部分添加“name”和“type”数据键。点击“Add”并应用更改。已添加显示与设备“Compressor QA-32”在关系级别 2 上有任意关系的资产的 Entities table 部件。

{% include images-gallery.html imageCollection="asset-search-query-2" %}

### 设备搜索查询

此别名允许显示指定设备配置（device profile）中与指定发起方在指定级别和方向上相关的设备。

添加别名：在“添加别名”对话框中输入别名名称，选择“设备搜索查询”筛选类型，选择实体类型及要显示关系的实体。将方向设为“From”或“To”，设置最大关系级别，并指定用于筛选设备的设备配置（device profile）。

{% include images-gallery.html imageCollection="device-search-query-1" %}

{% if docsPrefix == null %}
此别名显示设备配置为“thermometers”且与资产“Building A”在方向“From”和关系级别 1 上有任意关系的设备。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名显示设备配置为“compressors”且与资产“Building A”在方向“From”和关系级别 1 上有任意关系的设备。
{% endif %}

学习如何在部件中使用“设备搜索查询”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“设备搜索查询”别名，在“Columns”部分添加“name”、“type”和“temperature”数据键。点击“Add”并应用更改。已添加显示与资产“Building A”在关系级别 1 内有任意关系的设备的 Entities table 部件。

{% include images-gallery.html imageCollection="device-search-query-2" %}

### 实体视图搜索查询

此别名允许显示指定类型中与指定发起方在指定级别和方向上相关的实体视图。

已创建与设备“Compressor BC-10”存在关系的“Compressor BC-10 Entity View”实体视图，类型为“compressors entity view type”，可访问 Compressor BC-10 的“temperature”时序。

添加别名：在“添加别名”对话框中输入别名名称，选择“实体视图搜索查询”筛选类型，选择实体类型及要显示关系的实体。将方向设为“From”或“To”，设置最大关系级别，并指定用于筛选实体视图的实体视图类型。

{% include images-gallery.html imageCollection="entity-view-search-query-1" %}

{% if docsPrefix == null %}
此别名筛选类型为“compressors entity view type”且与资产“Building A”在方向“From”和关系级别 1 上有任意关系的实体视图。
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
此别名筛选类型为“Compressors Entity View Type”且与资产“Building A”在方向“From”和关系级别 1 上有任意关系的实体视图。
{% endif %}

学习如何在部件中使用“实体视图搜索查询”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“实体视图搜索查询”别名，在“Columns”部分添加“name”、“type”和“temperature”数据键。点击“Add”并应用更改。已添加显示与资产“Building A”在关系级别 1 内有任意关系的实体视图的 Entities table 部件。

{% include images-gallery.html imageCollection="entity-view-search-query-2" %}

### Edge 搜索查询

此别名允许显示指定类型中与指定发起方在指定级别和方向上相关的 Edge。

添加别名：在“添加别名”对话框中输入别名名称，选择“Edge 搜索查询”筛选类型，选择实体类型及要显示关系的实体。将方向设为“From”或“To”，设置最大关系级别，并指定用于筛选 Edge 的 Edge 类型。

{% include images-gallery.html imageCollection="edge-search-query-1" %}

此别名筛选类型为“edge instance”且与资产“Building A”在方向“From”和关系级别 1 上有任意关系的 Edge。

学习如何在部件中使用“Edge 搜索查询”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“Edge 搜索查询”别名，在“Columns”部分添加“name”和“type”数据键。点击“Add”并应用更改。已添加显示与资产“Building A”在关系级别 1 内有任意关系的 Edge 的 Entities table 部件。

{% include images-gallery.html imageCollection="edge-search-query-2" %}

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
### 调度器事件

此别名允许显示与指定实体关联的调度器事件。

添加别名：在“添加别名”对话框中输入别名名称，选择“调度器事件”筛选类型，并选择要显示调度器事件的实体。

{% include images-gallery.html imageCollection="scheduler-events-1" %}

此别名显示设备“Compressor BC-10”的调度器事件。

学习如何在部件中使用“调度器事件”别名。在“Tables”部件捆绑包中选择“Entities table”部件。进入“Entity alias”选项卡。在“Entity alias”字段指定“调度器事件”别名，在“Columns”部分添加“name”、“type”和“schedule”数据键。点击“Add”并应用更改。已添加显示设备“Compressor BC-10”调度器事件的 Entities table 部件。

{% include images-gallery.html imageCollection="scheduler-events-2" %}

{% endif %}
