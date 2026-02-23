* TOC
{:toc}

{% capture difference %}
在阅读本指南前，建议先完成[快速入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/){:target="_blank"}以熟悉 ThingsBoard 设备和仪表板，有助于更好理解本文所述概念。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

**部件**是仪表板中用于展示特定类型数据或提供功能的元素。  
部件可用于：
- 可视化设备数据（遥测与属性）
- 远程控制设备（RPC）
- 处理告警（创建/查看/确认）
- 显示静态自定义 HTML 内容

### 部件类型

ThingsBoard 提供五类主要部件：

- **时序部件**。按选定时间窗口展示数据，窗口可为：
  - **实时** — 滚动区间，如最近 5 分钟或 24 小时
  - **历史** — 固定过去区间

  *示例：*折线图、柱状图或面积图部件

  **注意**：时序部件面向遥测（时序）数据，而非属性。

- **最新值部件**。显示所选[属性](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"}或[遥测](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"}键的最新值。  
*示例：*设备型号属性、最新温度读数

- **控制部件**。向设备发送[RPC 命令](/docs/{{docsPrefix}}user-guide/rpc/){:target="_blank"}  
  *示例：*设置温控器目标温度

- **告警部件**。展示和管理[告警](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"}及通知
- **静态部件**。展示静态内容，如平面图或公司信息（含自定义 HTML）

更多部件类型说明见[此处](/docs/{{docsPrefix}}user-guide/ui/widget-library/){:target="_blank"}。

## 向仪表板添加部件

要向仪表板添加新部件，请按以下步骤操作：

{% include images-gallery.html imageCollection="add-widget" showListImageTitles="true" %}

## 部件设置

部件配置包括设置一个或多个[数据源](#data-source-types)（部分部件可能无数据源），以及配置**外观**、**部件卡片参数**、**操作**和**布局**。

创建部件时，可通过部件对话框右上角的开关在**基础**和**高级**模式间切换。

<br><b><font size="4">基础模式</font></b>

使用**基础**模式可快速配置单一数据源，无需额外过滤器。您将配置：

- [时间窗口](#widget-time-window)（或继承自仪表板）
- 数据源（[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}或指定[设备](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}）
- 取决于部件类型的最简外观选项。

{% include images-gallery.html imageCollection="add-widget-basic-mode" %}

<br><b><font size="4">高级模式</font></b>

**高级**模式支持多个数据源（若部件支持）、[过滤](#filters){:target="_blank"}以及五个配置选项卡以精细控制：[数据](#data-settings)、[外观](#appearance)、[部件卡片](#widget-card)、[操作](#widget-actions)和[布局](#layout-settings)。

高级模式提供额外数据源类型（取决于部件）：[函数](#function-as-datasource)、[实体数量](#entities-count)和[告警数量](#alarms-count)。

{% include images-gallery.html imageCollection="add-widget-advanced-mode" %}

### 数据设置

#### 部件时间窗口

部件的**时间窗口**定义了获取遥测或告警数据使用的时间区间和聚合函数。

默认情况下，每个部件使用其**自身**时间窗口。可通过启用对应选项改为使用**仪表板时间窗口**。

要对此部件隐藏时间窗口选择器，需关闭**显示时间窗口**选项。

详见[时间窗口指南](/docs/{{docsPrefix}}user-guide/dashboards/#time-window){:target="_blank"}。

{% include images-gallery.html imageCollection="timewindow" %}

#### 数据源类型

部件数据设置允许添加一个或多个数据源。

数据源由数据源类型、[可选过滤器](#filters){:target="_blank"}以及数据键列表（[属性](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} / [遥测](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"}）组成，用于定义部件从哪些实体获取并显示数据。

**可用类型：**
- [设备](#device-as-datasource) — 从单个指定设备读取数据
- [实体](#entity-as-datasource) — 从[实体别名](/docs/{{docsPrefix}}user-guide/dashboards/#entity-aliases){:target="_blank"}解析的实体及可选过滤器读取数据
- [函数](#function-as-datasource) — 生成数据（如随机值）以在无实时遥测时预览部件
- [实体数量](#entities-count) — 显示匹配别名/过滤器的实体数量
- [告警数量](#alarms-count) — 显示匹配所选过滤器的告警数量

<hr>

##### 设备作为数据源

用于从单个设备获取遥测数据。

**示例：**假设某设备发布室内温度数据，希望将其显示在部件中，可使用**温度计刻度**部件进行可视化。

{% include images-gallery.html imageCollection="data-source-type-device" showListImageTitles="true" %}

<hr>

##### 实体作为数据源

用于从[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}解析的实体获取数据（例如：全部设备、按类型设备、分组资产等）。

**示例：**在[实体表](/docs/{{docsPrefix}}user-guide/ui/entity-table-widget/){:target="_blank"}中列出所有设备。

{% include images-gallery.html imageCollection="data-source-type-entity" showListImageTitles="true" %}

<hr>

##### 函数作为数据源

当尚无数据但需要测试部件可视化时可使用此类型。

**示例：**在**数值卡片**上显示随机值。

{% include images-gallery.html imageCollection="data-source-type-random" showListImageTitles="true" %}

<hr>

##### 实体数量

显示匹配别名/过滤器的实体数量（如设备总数）。

**示例：**在**数值卡片**上显示设备总数。

{% include images-gallery.html imageCollection="data-source-type-entities-count" showListImageTitles="true" %}

<hr>

##### 告警数量

显示匹配所选别名/过滤器的告警数量（如全部设备告警、严重程度、状态）。

**示例：**在**数值卡片**上显示告警总数。

{% include images-gallery.html imageCollection="data-source-type-alarms-count" showListImageTitles="true" %}

<hr>

#### 数据键（Data keys）

数据键用于标识部件应使用的遥测、属性或实体字段。

<b><font size="3">键的来源</font></b>
- **Attributes** — 所选实体的 Client、Server 和 Shared [属性](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"}的并集。若所需属性尚不存在，仍可添加该键；设备上报后部件将显示数据。
- **Time series** — 设备上报或由 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/){:target="_blank"} / [REST API](/docs/{{docsPrefix}}reference/rest-api/){:target="_blank"} 写入的遥测键。
- **Entity fields** — 依赖实体类型且可能随版本变化的元数据字段（如 created time、entity type、name、type、label）。

数据源的数据键列表取决于[部件类型](/docs/{{docsPrefix}}user-guide/widgets/#widget-types){:target="_blank"}：
- **时序部件** 可选择时序数据键；此外可配置[时间窗口](/docs/{{docsPrefix}}user-guide/widgets/#widget-time-window){:target="_blank"}；
- **最新值部件** 可选择时序、属性和实体字段；
- **静态部件与控制部件** 不需要数据键；
- **告警部件** 可选择全部数据键：时序、属性、实体字段和告警字段，此外可配置[时间窗口](#widget-time-window)和[告警过滤](#alarm-filter)。

<b><font size="3">添加键</font></b>

点击 **Data keys** 行并从下拉列表选择键。若键尚不存在于数据库中，可输入名称并选择类型（**Attribute**、**Entity field** 或 **Time series**）。数据可用后部件将显示对应值。

{% include images-gallery.html imageCollection="add-data-key" %}

<b><font size="3">配置数据键</font></b>

数据键可在两种模式下配置：

- **General** — **基础模式**及部件创建时显示的常用选项。
- **Advanced** — 逐键完整控制；在**高级**部件设置中点击键旁的**铅笔**图标可打开。

<b><font size="3">基础选项（因部件而异）</font></b>

在 **Basic** 模式下，以下设置会出现在 **Add widget** 对话框中。
- **Key** — 指定要显示其数据的键。
- **Label** — 部件中显示的人类可读名称（如表列标题或图例项）。
- **Units** — 显示在数值旁的符号或单位。  
  **注意：**自 ThingsBoard 4.1 起，部件支持根据所选单位制进行自动数据转换和[单位切换](/docs/{{docsPrefix}}user-guide/ui/unit-conversion/){:target="_blank"}。
- **Decimals** — 小数点后的位数。
- **Color** — 多数图表部件用于系列样式。

{% include images-gallery.html imageCollection="edit-basic-key-configuration" %}

<b><font size="3">Advanced options</font></b>

In **Advanced** mode, open settings via the key&#39;s **pencil** icon.

{% include images-gallery.html imageCollection="edit-key-configuration" %}

下面以「Tables」捆绑包中的「Entities table」部件为例说明基本数据键设置：

- **Key。** 可修改键的名称。此时将显示在「Key」行中指定键名所对应键的数据。修改键名后点击「Save」。

{% capture difference %}
**请注意：** 键共有四类：Attributes、Time Series、Entity Field 和 Alarm Field（仅告警部件）。要正确显示数据，需将键名改为同类型中已存在的键名。 若数据库中尚无所需遥测或属性键，仍可向数据源添加该键；设备发送到 ThingsBoard 后部件即会显示数据。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include images-gallery.html imageCollection="data-key-configuration-key" %}

- **Label。** 数据列名称即为标签名。按需修改标签名，在对话框右下角点击「Save」。

{% include images-gallery.html imageCollection="data-key-configuration-label" %}

- **Units。** 可指定显示在数值旁的符号。在 units 字段输入所需字符后点击「Save」。

{% include images-gallery.html imageCollection="data-key-configuration-units" %}

> 自 ThingsBoard 4.1 起，部件还支持根据所选单位制进行自动数据转换和单位切换。详见[此处](/docs/{{docsPrefix}}user-guide/ui/unit-conversion/){:target="_blank"}。

- **Decimals。** 指定浮点数后要显示的位数，然后点击「Save」。

{% include images-gallery.html imageCollection="data-key-configuration-decimals" %}

- **Color。** 每个键分配不同颜色。在部分部件（如图表）中，部件内图表线条的颜色即为该键的颜色。可修改键的颜色：点击彩色圆点，选择颜色并点击「Select」。

{% include images-gallery.html imageCollection="data-key-configuration-color" %}

- [**Use data post-processing function**](#data-post-processing-function) — 启用自定义函数，在显示前对原始值进行转换。

##### 键的聚合

默认情况下，最新值部件没有时间窗口。若在 **Latest values** 部件中为任意数据键启用聚合，时间窗口控件将出现。可为每个遥测键单独设置聚合，用于显示而无需存入数据库。时间窗口配置仅限于实时区间（**Current Hour/Day/Month**）和 **History** 时间区间。出于性能考量，不支持如 **last 30 minutes** 或 **last 24 hours** 等实时区间。若需将聚合结果作为遥测存储，详见[此处](https://thingsboard.io/docs/user-guide/rule-engine-2-0/nodes/analytics/){:target="_blank"}。

{% include images-gallery.html imageCollection="data-key-configuration-aggregation" %}

**聚合选项：**

- **Min** 或 **Max**：
  <br>
  从给定区间选取最小或最大值，用于检测负向或正向峰值。例如：电缆功率 surges、空气污染、设备负载等。
  {% include images-gallery.html imageCollection="aggregation-min-max" %}
- **Average：**
  <br>
  计算所选区间的平均值（先求和，再除以区间内遥测条数）。例如：周油耗、dB 声噪、风扇转速、信号质量等。
  {% include images-gallery.html imageCollection="aggregation-average" %}
- **Sum：**
  <br>
  对指定时段内的全部遥测求和。例如：里程（km）、用水量、空闲时间等。
  {% include images-gallery.html imageCollection="aggregation-sum" %}
- **Count：**
  <br>
  计算所选时段内传输消息的总数。适用于电池供电设备调优或评估传感器激活灵敏度等场景。
  {% include images-gallery.html imageCollection="aggregation-count" %}

  **Delta function：**

用于计算当前时间窗口与相对时间窗口聚合值之间的差值。

  **Comparison period** — 以历史区间为基准，并根据所选选项进行换算的参数。可选值如下。
- **Previous interval**（默认）— 计算时不仅考虑时间，还考虑区间类型（**Current day** 或 **Current day so far** 等）。
  <br>
  示例：**History** - **Current month so far** 若为 1.09.22 至 25.09.22，则前一区间为 1.08.22 至 25.08.22。

  {% include images-gallery.html imageCollection="aggregation-previous-interval" %}

- **Day ago** — 以历史区间起止时间为基准，减去 24 小时。
  <br>
  例如：用水量 **Current day** 与 **Delta** - **Day ago**：
  {% include images-gallery.html imageCollection="aggregation-day-ago" %}

- **Week ago** — 历史区间前移一周（168 小时）。
  <br>
  示例：平均值，历史区间 **Current day**，Delta **Week ago**：
  {% include images-gallery.html imageCollection="aggregation-week-ago" %}

- **Month ago** — 与历史区间天数相同，从当前历史区间前移。例如当前为 2 月（28 天），则 **Month ago** 为前 28 天，而非整月。
  <br>
  示例：用水量总和，历史 **Current day**，**Delta** - **Month ago**：

  {% include images-gallery.html imageCollection="aggregation-month-ago" %}

- **Year ago** — 当前历史区间前 365 天的区间。
  <br>若需对比上月与去年同月的聚合。
  {% include images-gallery.html imageCollection="aggregation-year-ago" %}

- **Custom interval** — 设置自定义区间。最大允许值受 **int** 类型限制。示例：43200000 = 12 小时。

  {% include images-gallery.html imageCollection="aggregation-custom-interval" %}

**Delta calculation result：**

用于指定结果的显示方式：
<br>
- **Previous Value** — 显示对比区间（非当前历史区间）的聚合值。

- **Delta (absolute)** — 显示两区间的差值（默认）。

- **Delta (percent)** — 以相对前一区间的百分比显示 <br>公式：**(IntervalValue - prevIntervalValue)/prevIntervalValue*100**

##### Data post-processing function（数据后处理函数）
数据后处理函数可在遥测值于部件中显示前对其进行实时转换。可通过自定义 JavaScript 逻辑处理每个数据点，如单位换算、异常过滤或衍生指标计算，而无需修改上游数据源。

  **使用方法：**
 - 在部件中 → 进入 **Data keys** 区域 → 点击目标数据键旁的 **Pencil** 图标。
 - 启用 **Use data post-processing function** 开关。
 - 在函数体中输入代码。平台会自动注入函数头：
<br>     **function** (time, value, prevValue, timePrev, prevOrigValue) {
<br>        **`YOUR_JS_CODE`**
<br>     }
 - 点击 **Save** 按钮。

**启用后，函数可访问以下参数：**

- **time** — 当前值的时间戳；
- **value** — 当前值；
- **prevValue** — 上次函数调用的返回值；
- **timePrev** — 前一值的时间戳；
- **prevOrigValue** — 原始前一值。

函数须 **return** 一个值（**number** | **string** | **boolean** | **null**）。
返回 **null** 会将该数据点排除在可视化之外。

{% include images-gallery.html imageCollection="data-key-configuration-settings-post-processing" %}

**高级数据键设置**

高级数据键配置用于控制部件中特定数据键列的可见性、样式和外观。
实体表部件、告警表部件和实体管理部件捆绑包共用同一套高级数据键配置。
图表部件捆绑包有独立的高级数据键配置。其他部件捆绑包仅提供基础数据键配置。

更多详见[此处](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/){:target="_blank"}。

#### Filters

**Filters** 用于限定部件从数据源获取的数据范围。通过添加键并为这些键定义条件来构建过滤器，支持组合多个键和条件。

**键类型：**

添加过滤器时，可选择下列键类型之一：

- **Entity field**. 实体内置字段 （如 **device name**、**type**、**label**、**createdTime** 等），适用于按元数据而非遥测筛选实体。
- **Attribute**。通用属性键，无需区分属性存储位置时使用。
- **Client attribute**。由设备/Edge 客户端设置或上报的属性（通常经 MQTT/HTTP/CoAP）。示例：设备运行时上报的固件 **build**。
- **Server attribute**。平台存储且通常由用户或服务配置的属性。示例：**targetTemperature**、**threshold**。
- **Shared attribute**。常用于从服务器向设备下发配置（如 **displayUnits**）。
- **Time series**。表示随时间变化的遥测键（如 **temperature**、**humidity**、**voltage**），适用于基于近期或历史读数的条件。

**Operations**

使用运算定义键与值的比较方式：**equal**、**not equal**、**greater than**、**less than**、**greater or equal**、**less or equal**。

比较值可使用**固定字面量**或 **Dynamic source type**。动态源使过滤器在运行时从上下文获取值，例如："temperature **greater or equal** than **targetTemperature**（server attribute）"或"voltage **less than** 用户在 **control widget** 中选择的值"。

{% capture difference %}
**提示：** 对于可能变化的阈值，优先使用 **Dynamic source**，以免每次值更新时都需修改过滤器。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

##### 告警过滤（Alarm filter）

告警部件可按[状态](/docs/{{docsPrefix}}user-guide/alarms/#lifecycle){:target="_blank"}、[严重程度](/docs/{{docsPrefix}}user-guide/alarms/#severity){:target="_blank"}和[类型](/docs/{{docsPrefix}}user-guide/alarms/#type){:target="_blank"}筛选[告警](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"}。
可组合选择告警状态和严重程度，也可指定告警类型并启用[传播](/docs/{{docsPrefix}}user-guide/alarms/#propagation){:target="_blank"}告警的搜索。

{% include images-gallery.html imageCollection="alarm-filters" %}

### 外观（Appearance）

假设已添加「Timeseries Line Chart」部件，仅通过数据配置[步骤](/docs/{{docsPrefix}}user-guide/widgets/#data-settings){:target="_blank"}展示温度计数据。
应能看到类似部件（需发送或模拟数据才能看到图表中的实际线条）：

![image](/images/user-guide/widgets/overview/widget-example.png)

下面使用基础部件设置定制部件，并说明每项设置对部件的影响。

#### Data settings（数据设置）

可设置显示在数值旁的符号及浮点数的小数位数。若要为所有坐标轴应用相同设置，可使用此处配置。

- **Units by default**。若为多台设备展示温度读数，可添加符号（如 °C 或 °F）。若同时展示温度和湿度，需在数据键设置中分别配置。

- **Decimals by default**。当数据键无自定义格式时，控制显示的小数位数。

- **"No data to display" message**。当部件在所选时间窗口内无数据或无法渲染（如缺少键）时显示的自定义提示，用于引导下一步操作。<br>
**示例：**<br>
• "No data to display"<br>
• "No data for the selected time range"<br>
• "No telemetry received yet — check the device connection or time range"

{% include images-gallery.html imageCollection="default-data-settings" %}

#### 通用设置（Common settings）

**Stacking mode（堆叠模式）**

此选项适用于「Timeseries Bar Chart」部件。
Stacking mode 将实体值求和显示以避免重叠，不同值以不同颜色区分。
仅当数据聚合函数**未**设为 None 时可用。
未启用「Enable stacking mode」时，柱状图将按各实体值拆分显示。
需将鼠标悬停在柱子上方能查看所有实体的值。

{% include images-gallery.html imageCollection="appearance-stacking-mode-1" %}

若需将某键排除出堆叠，请前往[高级数据键配置](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#exclude-from-stacking){:target="_blank"}，勾选「Exclude from stacking」。

{% include images-gallery.html imageCollection="appearance-stacking-mode-2" %}

#### 图例设置（Legend settings）

<b>legend</b> 显示统计值，包括 <b>minimum、maximum、average、total</b> 和 <b>latest</b>。

默认仅图表部件启用 <b>show legend</b>。其他部件可于部件设置中切换 <b>Legend</b> 开关以启用。

在图例设置中可：
- 配置标签、数值和列标题的<b>字体</b>和<b>颜色</b>。
- 选择<b>图例位置</b>。
- 选择要显示的统计值（<b>minimum、maximum、average、total、latest</b>）。
- 启用<b>数据键排序</b>或保持无序。

{% include images-gallery.html imageCollection="appearance-legend-settings-1" %}

图例为每个[数据键](/docs/{{docsPrefix}}user-guide/widgets/#data-keys)显示标签。当部件包含多台设备数据或多个设备共用同一数据键名（如 temperature）时，图例或提示中难以区分各键值对应的设备。

为使图例更清晰，可在数据键配置的 **Label** 字段使用 **${entityName}** 或 **${entityLabel}**。

- **${entityName}** — 在图例中自动插入实体系统名称的变量，便于标识对象，尤其当技术名称或唯一标识重要时。  
  示例：设备名称为 **sensor-101** 时，在 **${entityName}** 处将显示 **sensor-101**。

{% include images-gallery.html imageCollection="entity-name-legend" %}

- **${entityLabel}** — 在图例中插入实体标签的变量，常用于显示人类可读的设备或实体名称。  
  示例：设备具有：
    - **Name** = **sensor-101**
    - **Label** = **Temperature Sensor, Warehouse #1**

    在 **${entityLabel}** 处将显示更易读的 **Temperature Sensor, Warehouse #1**。

{% include images-gallery.html imageCollection="entity-label-legend" %}

#### 坐标轴设置（Axis settings）

配置坐标轴参数。

可设置垂直轴和水平轴标题、最小/最大刻度值，以及刻度颜色、小数位数和刻度间距。

**垂直轴设置**：

{% include images-gallery.html imageCollection="appearance-vertical-axis" %}

**水平轴设置**：

{% include images-gallery.html imageCollection="appearance-horizontal-axis" %}

**Ticks formatter function, f(value)**

若遥测值为很大数值且带有单位符号，而仪表板空间有限需缩小图表时，可使用 ticks-formatter 函数将刻度值转换为更紧凑的形式。

```ruby
return value.toExponential(1) + " C";
```
{: .copy-code}

{% include images-gallery.html imageCollection="appearance-ticks-formatter-function" %}

#### 图表背景设置（Chart background settings）

可调整图表网格外观：自定义背景色、网格边框和刻度颜色，或关闭网格线显示。

{% include images-gallery.html imageCollection="appearance-chart-background" %}

#### 提示框设置（Tooltip settings）

- **Hover individual points**。勾选「Hover individual points」时，线条上不显示数值点。

- **Show cumulative values in stacking mode**。启用堆叠模式时，可勾选「Cumulative values」以显示所有实体值的总和。

**f(value, latestData)** 提示框格式化函数用于自定义提示框显示内容。

为使提示框更清晰，可在数据键配置的 **Label** 字段使用 **${entityName}** 或 **${entityLabel}**。

- **${entityName}** — 在提示框中自动插入实体系统名称。  
  示例：设备名为 **Sensor 1** 时，**${entityName}** 处将显示 **Sensor 1**。

{% include images-gallery.html imageCollection="entity-name-tooltip" %}

- **${entityLabel}** — 在提示框中插入实体标签。  
  示例：设备 **Name** = **Sensor 1**，**Label** = **Sensor 1 Label** 时，**${entityLabel}** 处将显示 **Sensor 1 Label**。

{% include images-gallery.html imageCollection="entity-label-tooltip" %}

可通过提示框设置或[高级数据键配置](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#tooltip-settings){:target="_blank"}自定义提示框显示内容。
通过 Settings 的提示框配置为基础配置，会同时应用于所有实体。在高级数据键配置中设置时，仅应用于特定时序数据，并会覆盖基础提示框函数。

在 State Chart 中，可根据实体值配置在提示框中显示的实体状态。

以下示例使用函数将摄氏度转换为华氏度并并排显示：

```ruby
let celsiusValue = parseFloat(value).toFixed(2);
let farenheitValue = parseFloat(celsiusValue*1.8 + 32).toFixed(2);
return celsiusValue + ' °C (' + farenheitValue + ' °F)';
```
{: .copy-code}

{% include images-gallery.html imageCollection="appearance-tooltip-function" showListImageTitles="true" %}

#### 对比设置（Comparison settings）

可显示用于对比的历史数据。

{% include images-gallery.html imageCollection="appearance-comparison" showListImageTitles="true" %}

#### 自定义图例设置（Custom legend settings）

当需展示不适合图表形式的数据（如特定属性），或仅需在图表图例中显示部分时序时，可使用 Custom Legend Settings。
例如，active/inactive 等属性可显示在 Table 部件中，但无法直接显示在图表上。

{% include images-gallery.html imageCollection="appearance-custom-legend-settings" showListImageTitles="true" %}

### 部件卡片（Widget card）

#### 部件标题设置（Widget title settings）

可输入自定义部件标题、提示文本和标题样式，也可添加图标并控制图标颜色与大小。参见下方配置与效果。

{% include images-gallery.html imageCollection="widget-card-title" %}

上方界面中的标题样式示例：

```json
{
  "fontSize": "15px",
  "fontWeight": 600
}
```
{: .copy-code}

#### 部件样式设置（Widget style settings）

可使用 CSS 属性自定义部件样式，样式将应用于部件的主 div 元素。

可通过「Drop shadow」关闭阴影，通过「Enable fullscreen」关闭全屏。以上选项默认均启用。

可修改背景色、文字颜色、内边距和外边距。参见下方配置与效果。

注意：示例中的样式和背景色仅供参考，非官方规范。

{% include images-gallery.html imageCollection="widget-card-style" %}

上方界面中的部件样式示例：

```json
{
  "border": "3px solid #2E86C1",
  "cursor": "pointer"
}
```
{: .copy-code}

#### 部件按钮设置（Widget buttons settings）

{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}

**Enable data export（启用数据导出）**

「Enable data export」用于启用或关闭部件数据的导出。
默认已启用。点击部件右上角「Export widget data」图标可下载数据。支持导出为 csv、xls 或 xlsx 格式。

{% include images-gallery.html imageCollection="enable-data-export" %}

{% endif %}

**Enable fullscreen（启用全屏）**

可通过「Enable fullscreen」复选框关闭全屏。默认启用。

以上设置默认均为启用。

{% include images-gallery.html imageCollection="enable-fullscreen" %}

<hr>

### 部件操作（Widget actions）

操作可用于快速配置切换到已创建状态、跳转到其他仪表板或更新当前仪表板。不同部件的操作来源不同，但可选操作类型一致。
在对应部件的编辑模式下配置操作。
要完整掌握操作用法，需先[为部件添加状态](/docs/{{docsPrefix}}user-guide/dashboards/#manage-dashboard-states){:target="_blank"}。

更多详见[部件操作](/docs/{{docsPrefix}}user-guide/ui/widget-actions/){:target="_blank"}文档。

### 布局设置（Layout settings）

通过 **Layout** 选项卡控制部件在桌面和移动端仪表板网格中的行为。

<b><font size="3">调整大小选项</font></b>

- **Resizable**。允许在编辑模式下由用户调整部件大小。禁用后部件保持当前尺寸，调整柄隐藏。
- **Preserve aspect ratio**。调整大小时保持部件宽高比，有助于图表和媒体在不同屏幕与网格断点下避免变形。禁用后可独立调整宽高。

{% capture difference %}
**提示：** 对图表、图片和视频启用 **Preserve aspect ratio**；对需要更多垂直空间的表格和列表则禁用。{% endcapture %}
{% include templates/info-banner.md content=difference %}

<b><font size="3">Mobile</font></b>

These options control visibility and sizing in **mobile mode** (responsive layout):

- **Hide widget in mobile mode**. Do not render this widget when the dashboard is viewed on a mobile layout. Useful for large visualizations that don’t fit small screens.
- **Hide widget in desktop mode**。仅在移动端显示此部件，桌面端隐藏，适用于为复杂桌面部件设计简洁的移动端替代。
- **Order**。设置部件在移动端布局中相对其他部件的位置，数值越小越靠前（左上）。使用整数（如 1、2、3…）。
- **Height**. Defines the widget’s height in the mobile grid (in grid rows). Increase the value to give lists and cards more space on phones; reduce it for small KPIs.

**Best practices:**
- Keep mobile **Order** consistent across related widgets to maintain reading flow.
- Test with real devices or the dashboard’s mobile preview to validate **Height** and scrolling behavior.

{% include images-gallery.html imageCollection="mobile-settings" %}

## 部件的导入与导出（Import and Export widget）

### 导入部件（Import widget）

可从 **JSON** 文件导入部件。

{% include images-gallery.html imageCollection="import-widget" showListImageTitles="true" %}

{% capture difference %}
**提示：** 若导入的部件使用当前环境中不存在的实体别名或键，请在编辑部件时进行映射。{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 导出部件（Export widget）

导出将部件配置保存为 **JSON**，以便在其他处复用。

**步骤：**
- 打开包含该部件的仪表板并切换到 **Edit mode**。
- 在部件右上角工具栏点击 **Export widget**。
- 包含部件配置的 **JSON** 文件将下载到本地。

{% include images-gallery.html imageCollection="export-widget" %}

{% capture difference %}
**注意：** 导出仅包含部件设置，不包含数据。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}
