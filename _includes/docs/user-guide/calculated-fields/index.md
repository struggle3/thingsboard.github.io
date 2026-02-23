* TOC
{:toc}

{% assign sinceVersion = "4.0.0" %}
{% include templates/since.md %}

<br>

Calculated fields 可将原始数据实时转换为可执行洞察。
可将 Calculated Fields 视为 IoT 实体的内置“逻辑层”。
不再仅存储原始数据，数据到达时即可自动生成高价值指标。

通过组合**多源**数据——如传入的 telemetry、现有 entity attributes，乃至相关 assets 的数据——可在数据到达时执行自定义逻辑。
结果输出会自动存储为 **time-series data** 或 **attributes**，确保计算洞察可立即用于可视化、报表或进一步自动化。

为支持复杂工作流，calculated field 执行可**链式**：一个字段的输出可自动触发另一个字段执行，从而逐步构建数据处理流水线。

Calculated fields 可在系统中两个层级应用：
- Entity Level：在此层级，计算应用于单一特定实体——[Device](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"} 或 [Asset](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"}。
- Profile Level：在 [Device profile](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"} 或 [Asset profile](/docs/{{docsPrefix}}user-guide/asset-profiles/){:target="_blank"} 内定义 calculated field 时，该逻辑会由关联该 profile 的每个实体继承。

此灵活性允许用户为每个实体定义独立计算，或对一组相似实体应用标准化逻辑，从而优化数据处理与管理。

除实时处理外，ThingsBoard 支持 calculated field 的 [reprocessing](#data-reprocessing)，可将相同计算逻辑应用于历史 telemetry 数据，并为所选时间范围生成缺失或更新结果。

<hr>

### Creating a calculated field

> 在 [Devices](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}、[Assets](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"}、[Device profiles](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"} 或 [Asset profiles](/docs/{{docsPrefix}}user-guide/asset-profiles/){:target="_blank"} 中创建 calculated field 的流程相同。

- 在左侧菜单中打开 "Calculated fields" 页面。
- 点击右上角 "**+**" 按钮。
- 在下拉菜单中选择 **Create new calculated field**。

{% assign createCalculatedFieldCE = '
    ===
        image: /images/user-guide/calculated-fields/create-new-calculated-field-1-ce.png
        title: Open the **Calculated fields** page from the left-hand menu.<br>Click the "**+**" button in the top-right corner and select **Create new calculated field** from the dropdown menu.
'
%}

{% assign createCalculatedFieldPE = '
    ===
        image: /images/user-guide/calculated-fields/create-new-calculated-field-1-pe.png
        title: Open the **Calculated fields** page from the left-hand menu.<br>Click the "**+**" button in the top-right corner and select **Create new calculated field** from the dropdown menu.
'
%}

{% if docsPrefix == null %}
{% include images-gallery.liquid imageCollection=createCalculatedFieldCE %}
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=createCalculatedFieldPE %}
{% endif %}

<hr>

## Types

ThingsBoard 支持多种 calculated field 类型，各自针对特定任务场景：

{% include calculated-fields-cards.liquid %}

<hr>

## Configuration

### General

"General" 区域定义 calculated field 的基本配置：
- **Title** —— 描述 calculated field 用途的名称。
- **Entity type** —— 应用 calculated field 的目标实体或 entity profile。
- **Type** —— 决定计算模型和可用配置块的 calculated field [type](#types)。

{% assign typeOfCalculatedFieldCE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-general-1-ce.png
        title: Enter a <b>descriptive name</b> for the calculated field, select the entity or entity profile to which the calculated field will be applied, and choose calculated field <b>type</b>.
'
%}

{% assign typeOfCalculatedFieldPE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-general-1-pe.png
        title: Enter a <b>descriptive name</b> for the calculated field, select the entity or entity profile to which the calculated field will be applied, and choose calculated field <b>type</b>.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=typeOfCalculatedFieldPE %}
{% else %}  
{% include images-gallery.liquid imageCollection=typeOfCalculatedFieldCE %}
{% endif %}

<hr>

### Arguments

Arguments 定义 calculated field 读取哪些数据并将其作为变量暴露给计算逻辑。每个 argument 映射到所选实体的特定数据源（attributes 或 telemetry），可在 Simple expression、TBEL script 或其它 calculated field 类型中引用。

点击 **Add argument** 按钮并填写必填字段：

<b><font size="3">Entity type</font></b>   
定义数据读取来源：
- **Current entity** —— 应用 calculated field 的同一 device/asset（device profile/asset profile）。  
  若在 **Device profile** 或 **Asset profile** 层级创建，则对关联该 profile 的每个实体执行计算。
- Another **Device / Asset** —— 特定引用实体
- **Customer** —— 与实体关联的 customer
- **Current tenant** —— tenant 实体
- **Current owner** —— 当前实体的 owner
- **Related entities**（适用于特定 calculated field 类型）—— 通过 relations 动态解析的实体

{% assign argumentsCE = '
    ===
        image: /images/user-guide/calculated-fields/argument-name-1-ce.png
        title: Click the **Add argument** button (1) and fill in the required fields:<br>Defines the data source (2) that will be used in calculations.<br>Choose the desired argument type (3).
'
%}

{% assign argumentsPE = '
    ===
        image: /images/user-guide/calculated-fields/argument-name-1-pe.png
        title: Click the **Add argument** button (1) and fill in the required fields:<br>Defines the data source (2) that will be used in calculations.<br>Choose the desired argument type (3).
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=argumentsPE %}
{% else %}  
{% include images-gallery.liquid imageCollection=argumentsCE %}
{% endif %}

<br><b><font size="3">Argument types</font></b>

Calculated fields 支持以下 argument types：

{% capture calculatedfieldsargumenttype %}
Attribute<small></small>%,%attribute%,%templates/calculated-fields/attribute-argument-type.md%br%
Latest telemetry<small></small>%,%latestTelemetry%,%templates/calculated-fields/latest-telemetry-argument-type.md%br%
Time series rolling<small>for Script-based calculations and specific aggregation modes</small>%,%timeSeriesRolling%,%templates/calculated-fields/time-series-rolling-argument-type.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="calculatedfieldsargumenttype" toggle-spec=calculatedfieldsargumenttype %}

### Calculation

Calculated fields 根据所选 type 支持多种计算模型。计算可定义为单一表达式、TBEL script、地理区域评估、向相关实体传播值或聚合。

更多能力与配置选项详见对应 calculated field [type](#types) 文档。

### Output

无论 type 如何，calculated field 都会产生一个或多个输出值，随后按配置的 [output strategy](#output-strategy) 存储为 telemetry 或 attributes 并处理（立即或通过 Rule Chains）。

结果可存储为：
- [Time series](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"} —— 函数返回 JSON 对象或 JSON 对象数组，**可带或不带 timestamp**，包含计算值。
- [Attribute](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} —— 函数返回**不含 timestamp 信息**的 JSON 对象，包含计算值。Attributes 可存储在 **Server** 或 **Shared** scope。

{% assign outputCE = '
    ===
        image: /images/user-guide/calculated-fields/output-1-ce.png
        title: Time series: function must return a JSON object or array with or without a timestamp containing the computed value.<br>To finish adding the calculated field, click **Add**.
    ===
        image: /images/user-guide/calculated-fields/output-2-ce.png
        title: Attribute: function must return a JSON object without timestamp information containing the computed value.<br>To finish adding the calculated field, click **Add**.
'
%}

{% assign outputPE = '
    ===
        image: /images/user-guide/calculated-fields/output-1-pe.png
        title: Time series: function must return a JSON object or array with or without a timestamp containing the computed value.<br>To finish adding the calculated field, click **Add**.
    ===
        image: /images/user-guide/calculated-fields/output-2-pe.png
        title: Attribute: function must return a JSON object without timestamp information containing the computed value.<br>To finish adding the calculated field, click **Add**.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=outputPE %}
{% else %}  
{% include images-gallery.liquid imageCollection=outputCE %}
{% endif %}

<hr>

{% include /docs/user-guide/calculated-fields/blocks/output-strategy.md %}

## Debug 

ThingsBoard 提供内置工具，用于实时验证和排查 calculated fields 问题。

<b><font size="3">Enable debug mode</font></b> (_&#42; 建议在开发时启用_)

每个 calculated field 可切换至 Debug 模式。启用后，ThingsBoard 会记录每次执行的详细信息，包括触发执行的输入 arguments（如传入 telemetry 或 attribute 更新）及计算结果或执行问题（script 错误、缺失 arguments、无效值等）。

{% assign enableDebugCE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-enable-debug-1-ce.png
        title: Enable/manage debug mode when creating a calculated field.
    ===
        image: /images/user-guide/calculated-fields/calculated-field-enable-debug-2-ce.png
        title: Enable/manage debug mode for an existing calculated field.
'
%}

{% assign enableDebugPE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-enable-debug-1-pe.png
        title: Enable/manage debug mode when creating a calculated field.
    ===
        image: /images/user-guide/calculated-fields/calculated-field-enable-debug-2-pe.png
        title: Enable/manage debug mode for an existing calculated field.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=enableDebugPE %}
{% else %}  
{% include images-gallery.liquid imageCollection=enableDebugCE %}
{% endif %}

{% include templates/debug-mode.md %}

<br><b><font size="3">Review debug events</font></b>

点击 calculated field 行中的 **Events** 图标查看记录的 debug events。

每个 event 包括：
- **Entity ID** —— 执行 calculated field 的实体 ID（目标实体）
- **Message ID** —— 唯一执行标识
- **Message type** —— 触发 calculated field 执行的内部请求类型
- **Arguments** —— 执行时使用的已解析 argument 值，包含时间戳（如有）
- **Result** —— calculated field 产生的输出
- **Error** —— 执行失败原因（执行失败时显示）

{% assign reviewDebugCE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-review-debug-events-1-ce.png
        title: Click the **Events** icon in the calculated field row to view recorded debug events
    ===
        image: /images/user-guide/calculated-fields/calculated-field-review-debug-events-2-ce.png
'
%}

{% assign reviewDebugPE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-review-debug-events-1-pe.png
        title: Click the **Events** icon in the calculated field row to view recorded debug events
    ===
        image: /images/user-guide/calculated-fields/calculated-field-review-debug-events-2-pe.png
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=reviewDebugPE %}
{% else %}  
{% include images-gallery.liquid imageCollection=reviewDebugCE %}
{% endif %}

<br><b><font size="4">Testing mode for script-based calculated fields</font></b>

针对基于 script 的 calculated fields（如 Script、Propagation (Calculation result mode)），ThingsBoard 提供 **Test script function (TBEL)** 模式，可在应用变更前使用真实输入数据验证执行。

此模式可：
- 使用相同输入数据重新运行计算
- 临时修改 argument 数据或 script 逻辑（_不保存配置变更_）
- 验证输出 JSON 结构和 timestamps
- 查看 script 执行的准确输出
- 快速复现错误并修正逻辑

**用法：**

在 event 行点击 **Test with this message** 运行测试函数。
- **Left panel — Script editor**   
  显示 calculated field 使用的 TBEL calculate(ctx, ...) 函数。可直接在此窗口修改 script。
- **Top-right panel — Arguments**   
  显示计算中使用的 arguments 列表。可调整 argument 值、type 和 timestamp 以模拟不同输入数据。
- **Bottom-right panel — Output** 
  显示 script 执行后的返回结果（或执行失败时的错误信息）。

{% assign reviewDebug1CE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-1-ce.png
        title: Click **Test with this message** in the event row to run the testing function.
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-2-ce.png
        title: **Left panel — Script editor**. Shows the TBEL calculate(ctx, ...) function used by the calculated field. You can modify the script directly in this window.<br>**Top-right panel — Arguments**. Displays the list of arguments used in the calculation. You can adjust the argument value, type, and timestamp to simulate different incoming data.<br>**Bottom-right panel — Output**. Shows the result returned by the script after execution (or an error message if execution fails).
'
%}

{% assign reviewDebug1PE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-1-pe.png
        title: Click **Test with this message** in the event row to run the testing function.
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-2-pe.png
        title: **Left panel — Script editor**. Shows the TBEL calculate(ctx, ...) function used by the calculated field. You can modify the script directly in this window.<br>**Top-right panel — Arguments**. Displays the list of arguments used in the calculation. You can adjust the argument value, type, and timestamp to simulate different incoming data.<br>**Bottom-right panel — Output**. Shows the result returned by the script after execution (or an error message if execution fails).
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=reviewDebug1PE %}
{% else %}  
{% include images-gallery.liquid imageCollection=reviewDebug1CE %}
{% endif %}

**流程：**
- 更新 script 和/或 argument 值。
- 点击 Test 使用提供的输入执行函数。
- 在 Output 区域核对返回的 JSON 结构和值。
- 结果正确后点击 Save 保存变更。
- 如需，将变更应用到 calculated field 配置以激活更新后的逻辑。

{% assign reviewDebug2CE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-3-ce.png
        title: **1.** Update **script** and/or **argument values**.<br>**2.** Click **Test** to run the function.<br>**3.** Review Output JSON<br>**4.** Click **Save** to apply changes.
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-4-ce.png
        title: **5.** If needed, apply changes to the calculated field configuration.
'
%}

{% assign reviewDebug2PE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-3-pe.png
        title: **1.** Update **script** and/or **argument values**.<br>**2.** Click **Test** to run the function.<br>**3.** Review Output JSON<br>**4.** Click **Save** to apply changes.
    ===
        image: /images/user-guide/calculated-fields/calculated-field-debug-test-mode-4-pe.png
        title: **5.** If needed, apply changes to the calculated field configuration.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
{% include images-gallery.liquid imageCollection=reviewDebug2PE %}
{% else %}  
{% include images-gallery.liquid imageCollection=reviewDebug2CE %}
{% endif %}

<hr>

## Rule Engine integration

Calculated fields 与 ThingsBoard [Rule Engine](/docs/user-guide/rule-engine-2-0/overview/){:target="_blank"} 集成，即平台的消息路由与处理系统。
执行无缝接入数据工作流，在以下 rule nodes 处理 telemetry 或 attributes 时自动触发：
- [Save Time Series](/docs/user-guide/rule-engine-2-0/nodes/action/save-timeseries){:target="_blank"}：新 telemetry 持久化时触发计算。
- [Save Attributes](/docs/user-guide/rule-engine-2-0/nodes/action/save-attributes){:target="_blank"}：client、shared 或 server-side attributes 更新时触发计算。
- [Calculated Fields](/docs/user-guide/rule-engine-2-0/nodes/action/calculated-fields){:target="_blank"}：专用节点，用于手动调用字段评估或实现复杂链式逻辑。

<hr>

## Data reprocessing

<table style="width:auto">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>The <b>telemetry data reprocessing</b> feature is available only in <b>ThingsBoard PE</b> and <b>ThingsBoard Cloud</b> editions.</em></strong></td>
     </tr>
   </thead>
</table> 

**Calculated field reprocessing** 用于将 calculated field 逻辑应用到历史数据。
在修改现有计算或添加新字段，并希望变更不仅作用于新数据，也作用于已收集 telemetry 时尤为有用。

> **注意：** 仅包含 attribute-based arguments 的 calculated field 无法 reprocessing。Calculated field 必须至少包含一个基于 time series 的 argument，即 "Latest telemetry" 或 "Time series rolling" 数据。

<b><font size="3">Key features</font></b>

- **历史数据重算** —— 将更新后的逻辑应用于已收集的 telemetry。
- **灵活时间范围** —— 为 reprocessing 选择特定时间段。
- **以 telemetry 存储结果** —— 处理后的数据在 ThingsBoard 中保存为 telemetry，可用于 widgets、rules 或 analytics。

<b><font size="4">How to configure</font></b>

- 选择目标 **Entity** 或 **Profile**，进入 "**Calculated fields**" 选项卡，[create a new calculated field](#creating-a-calculated-field) 或选择需历史 telemetry reprocessing 的已有字段。
- 点击对应字段旁的 "**Reprocess calculated field**" 图标。
- 在弹出窗口中定义要 reprocess 的 telemetry 时间区间。
- 点击 "**Reprocess**" —— 系统将按最新逻辑开始重算并更新历史 telemetry 数据。
- reprocessing 完成后点击 **Finish**。

{% assign dataReprocessing = '
    ===
        image: /images/user-guide/calculated-fields/how-to-configure-reprocessing-1-pe.png,
        title: Choose the target **Entity or Profile**, go to the **Calculated fields** tab, and either create a new calculated field or select an existing one that needs historical telemetry reprocessing.<br>Click the **Reprocess calculated field** icon next to the desired field.
    ===
        image: /images/user-guide/calculated-fields/how-to-configure-reprocessing-2-pe.png,
        title: In the pop-up window, define the time interval for which you want to reprocess telemetry data, and click **Reprocess** — the system will start recalculating and update historical telemetry data according to the latest logic.
    ===
        image: /images/user-guide/calculated-fields/how-to-configure-reprocessing-3-pe.png,
        title: Once the data reprocessing is complete, click **Finish**.
'
%}

{% include images-gallery.liquid imageCollection=dataReprocessing %}

<b><font size="4">Example of using the data reprocessing feature</font></b>

假设 Smart Device 实时发送温度与湿度数据。随后配置 calculated field 计算露点。
在 time series 部件上可见，露点值仅在 13:44:35 之后出现——此前未执行该计算。

{% assign reprocessingExample1 = '
    ===
        image: /images/user-guide/calculated-fields/reprocessing-example-1-pe.png,
        title: On the time series widget, you can see that dew point values start appearing only from 13:44:35 — before that moment, the calculation was not performed.
'
%}

{% include images-gallery.liquid imageCollection=reprocessingExample1 %}

要重算历史时段（calculated field 创建前）的露点，按以下步骤操作：

{% assign reprocessingExample2 = '
    ===
        image: /images/user-guide/calculated-fields/reprocessing-example-2-pe.png
        title: Go to the **Calculated fields** tab of the corresponding **Smart Device**. Click the **Reprocess calculated field** icon in the row of the required field.
    ===
        image: /images/user-guide/calculated-fields/reprocessing-example-3-pe.png,
        title: In the dialog window, specify the time interval for recalculation and click **Reprocess**.
    ===
        image: /images/user-guide/calculated-fields/reprocessing-example-4-pe.png,
        title: After the process is completed, click **Finish**.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=reprocessingExample2 %}

结果是所选历史整个时段内会生成并存储 **dewPoint** 值。

{% assign reprocessingExample3 = '
    ===
        image: /images/user-guide/calculated-fields/reprocessing-example-5-pe.png,
        title: As a result, the **dewPoint** values will be generated and stored for the entire selected historical period.
'
%}

{% include images-gallery.liquid imageCollection=reprocessingExample3 %}

<hr>

<br><b><font size="3">Task manager</font></b>

Task manager 用于查看任务状态、跟踪进度、查看结果，以及定位数据处理过程中的错误。

{% assign taskManager = '
    ===
        image: /images/user-guide/calculated-fields/task-manager-1-pe.png
        title: The Task manager allows you to view the status of tasks, track their progress, see results, and identify any errors that occurred during data processing.
'
%}

{% include images-gallery.liquid imageCollection=taskManager %}

<hr>

## Built-in methods for rolling arguments

time series rolling arguments 支持用于计算的内置函数。这些函数接受可选的 `ignoreNaN` 布尔参数。

| Method          | Default Behavior (`ignoreNaN = true`)               | Alternative (`ignoreNaN = false`)           |
|-----------------|-----------------------------------------------------|---------------------------------------------|
| `max()`         | Returns the highest value, ignoring NaN values.     | Returns NaN if any NaN values exist.        |
| `min()`         | Returns the lowest value, ignoring NaN values.      | Returns NaN if any NaN values exist.        |
| `mean(), avg()` | Computes the average value, ignoring NaN values.    | Returns NaN if any NaN values exist.        |
| `std()`         | Calculates the standard deviation, ignoring NaN.    | Returns NaN if any NaN values exist.        |
| `median()`      | Returns the median value, ignoring NaN values.      | Returns NaN if any NaN values exist.        |
| `count()`       | Counts values, ignoring NaN values.                 | Counts all values, including NaN.           |
| `last()`        | Returns the most recent value, skipping NaN values. | Returns the last value, even if it is NaN.  |
| `first()`       | Returns the oldest value, skipping NaN values.      | Returns the first value, even if it is NaN. |
| `sum()`         | Computes the total sum, ignoring NaN values.        | Returns NaN if any NaN values exist.        |

<br><b><font size="4">Assuming the following time series rolling argument</font></b>

```json
{
  "temperature": {
    "timeWindow": {
      "startTs": 1740643762896,
      "endTs": 1740644662896
    },
    "values": [
      { "ts": 1740644350000, "value": 72.32 },
      { "ts": 1740644360000, "value": 72.86 },
      { "ts": 1740644370000, "value": 73.58 },
      { "ts": 1740644380000, "value": "NaN" }
    ]
  }
}
```
<br><b><font size="4">Usage and result</font></b>

```javascript
var avgTemp = temperature.mean(); // Returns 72.92
var tempMax = temperature.max(); // Returns 73.58
var valueCount = temperature.count(); // Returns 3

var avgTempNaN = temperature.mean(false);  // Returns NaN
var tempMaxNaN = temperature.max(false);   // Returns NaN
var valueCountNaN = temperature.count(false); // Returns 4
```

**适用场景**

- **统计分析**：计算均值、中位数和标准差用于趋势分析。
- **数据筛选**：识别时间窗口内的最大最小值。
- **质量控制**：用 count() 和 std() 检测缺失值或异常值。
- **能效监控**：汇总一段时间内的功耗以评估能耗模式。

<hr>

## Merging time series arguments

time series rolling arguments 可**合并**以在多个数据集间对齐 timestamps。
merge 函数通过收集所有 arguments 的 timestamps 并按这些 timestamps 合并值，将两个或多个 rolling arguments 合并。
若某 argument 在某一 timestamp 无对应值，则使用该 argument 的前一个值；若无前值则赋 `NaN`。
结果为新的 rolling argument，包含 time window 和按每个 timestamp 对应各 argument 值的数组。

| Method                       | Description                                                                                                               | Returns                                             |
|:-----------------------------|:--------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------|
| `merge(other, settings)`     | Merges with another rolling argument. Aligns timestamps and filling missing values with the previous available value.     | Merged object with `timeWindow` and aligned values. |
| `mergeAll(others, settings)` | Merges multiple rolling arguments. Aligns timestamps and filling missing values with the previous available value.        | Merged object with `timeWindow` and aligned values. |

<b><font size="4">Parameters</font></b>

| Parameter            | Description                                                                                                                                                |
|:---------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `other` or `others`  | Another rolling argument or array of rolling arguments to merge with.                                                                                      |
| `settings`(optional) | Configuration object that supports: <br> - `ignoreNaN` - controls whether NaN values should be ignored.<br> - `timeWindow` - defines a custom time window. |

**Assuming the following arguments and their values:**

```json
{
  "humidity": {
    "timeWindow": {
      "startTs": 1741356332086,
      "endTs": 1741357232086
    },
    "values": [{
      "ts": 1741356882759,
      "value": 43
    }, {
      "ts": 1741356918779,
      "value": 46
    }]
  },
  "pressure": {
    "timeWindow": {
      "startTs": 1741356332086,
      "endTs": 1741357232086
    },
    "values": [{
      "ts": 1741357047945,
      "value": 1023
    }, {
      "ts": 1741357056144,
      "value": 1026
    }, {
      "ts": 1741357147391,
      "value": 1025
    }]
  },
  "temperature": {
    "timeWindow": {
      "startTs": 1741356332086,
      "endTs": 1741357232086
    },
    "values": [{
      "ts": 1741356874943,
      "value": 76
    }, {
      "ts": 1741357063689,
      "value": 77
    }]
  }
}
```

**Usage:**

```javascript
var mergedData = temperature.merge(humidity, { ignoreNaN: false });
```

**Output:**

```json
{
  "mergedData": {
    "timeWindow": {
      "startTs": 1741356332086,
      "endTs": 1741357232086
    },
    "values": [{
      "ts": 1741356874943,
      "values": [76.0, "NaN"]
    }, {
      "ts": 1741356882759,
      "values": [76.0, 43.0]
    }, {
      "ts": 1741356918779,
      "values": [76.0, 46.0]
    }, {
      "ts": 1741357063689,
      "values": [77.0, 46.0]
    }]
  }
}
```

**Usage:**

```javascript
var mergedData = temperature.mergeAll([humidity, pressure], { ignoreNaN: true });
```

**Output:**

```json
{
  "mergedData": {
    "timeWindow": {
      "startTs": 1741356332086,
      "endTs": 1741357232086
    },
    "values": [{
      "ts": 1741357047945,
      "values": [76.0, 46.0, 1023.0]
    }, {
      "ts": 1741357056144,
      "values": [76.0, 46.0, 1026.0]
    }, {
      "ts": 1741357063689,
      "values": [77.0, 46.0, 1026.0]
    }, {
      "ts": 1741357147391,
      "values": [77.0, 46.0, 1025.0]
    }]
  }
}
```

**适用场景**

在多个传感器以不同间隔提供数据流时，合并 time series arguments 很有用。
通过对齐 timestamps 并填充缺失值，合并可实现：

- **传感器数据同步**：对齐测量相关参数（如温湿度）的多个传感器读数。
- **异常检测**：合并多源 telemetry 以识别系统性能不一致或偏差。
- **能耗分析**：合并各设备的功耗数据以提供统一的能耗趋势视图。
- **预测性维护**：合并振动、温度和运行状态数据以预测设备故障。

<hr>

## Export / Import calculated field

可将 calculated field **导出**为 JSON 文件，并**导入**到同一或另一 ThingsBoard 实例。

<br><b><font size="4">Export calculated field</font></b>

- 进入 **Calculated fields** 页面。
- 在对应 calculated field 行中点击 **Export** 按钮。 

{% assign exportCalculatedFieldCE = '
    ===
        image: /images/user-guide/calculated-fields/export-calculated-field-1-ce.png,
        title: Navigate to the <b>Calculated fields</b> page and click the <b>Export</b> button located in the row of the specific calculated field.
'
%}

{% assign exportCalculatedFieldPE = '
    ===
        image: /images/user-guide/calculated-fields/export-calculated-field-1-pe.png,
        title: Navigate to the <b>Calculated fields</b> page and click the <b>Export</b> button located in the row of the specific calculated field.
'
%}

{% if docsPrefix == null %}
{% include images-gallery.liquid imageCollection=exportCalculatedFieldCE %}
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=exportCalculatedFieldPE %}
{% endif %}

<br><b><font size="4">Import calculated field</font></b>

可从 JSON 配置文件导入 calculated field 配置。
在实体或 profiles 间迁移 calculated field 配置时尤其有用，可保证一致性并减少手动配置。

导入步骤：

{% assign importCalculatedFieldCE = '
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-1-ce.png,
        title: Navigate to the **Calculated fields** page. Click the "**+**" icon button, and select **Import calculated field** from the dropdown menu.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-2-ce.png,
        title: In the opened window, upload the JSON file with the calculated field configuration and click **Import**.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-3-ce.png,
        title: In the dialog that opens, **specify the entity or profile** to which the calculated field will be applied.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-4-ce.png,
        title: If there are any problems with arguments, they will be highlighted.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-5-ce.png,
        title: Ensure the imported field is correctly applied and update any necessary parameters.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-6-ce.png,
        title: Click **Add** to complete the import.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-7-ce.png,
        title: You have imported the calculated field configuration.
'
%}

{% assign importCalculatedFieldPE = '
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-1-pe.png,
        title: Navigate to the **Calculated fields** page. Click the "**+**" icon button, and select **Import calculated field** from the dropdown menu.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-2-pe.png,
        title: In the opened window, upload the JSON file with the calculated field configuration and click **Import**.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-3-pe.png,
        title: In the dialog that opens, **specify the entity or profile** to which the calculated field will be applied.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-4-pe.png,
        title: If there are any problems with arguments, they will be highlighted.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-5-pe.png,
        title: Ensure the imported field is correctly applied and update any necessary parameters.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-6-pe.png,
        title: Click **Add** to complete the import.
    ===
        image: /images/user-guide/calculated-fields/import-calculated-field-7-pe.png,
        title: You have imported the calculated field configuration.
'
%}

{% if docsPrefix == null %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=importCalculatedFieldCE %}
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid showListImageTitles="true" imageCollection=importCalculatedFieldPE %}
{% endif %}

> **注意**：确保导入的字段正确应用并更新所需参数：
  - 若引用实体为当前实体，不会报错。
  - 若引用实体在 tenant 中不存在，将作为错误在使用的 argument 处高亮。
  - 若引用实体为当前 tenant 且导入到另一 tenant，将自动调整为新区 tenant 且无错误。

<hr>

## Managing calculated fields

在 "Calculated fields" 页面集中管理所有 calculated fields。

每个 calculated field 包含操作面板：
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}1. **Data reprocessing** —— 将 calculated field 逻辑应用于历史数据。{% endif %}
2. **Copy** —— 复制配置以快速创建新 calculated field。
3. **Export** —— 下载配置为 JSON 文件用于备份或迁移。
4. **Events** —— 查看执行 events，包括状态变更和错误。
5. **Debug** —— 启用 debug 模式并查看详细执行数据。
6. **Delete** —— 从系统中移除 calculated field。

{% assign calculatedFieldsParametersCE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-1-ce.png
        title: Each calculated field includes an action panel for managing the field.
'
%}

{% assign calculatedFieldsParametersPE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-1-pe.png
        title: Each calculated field includes an action panel for managing the field.
'
%}

{% if docsPrefix == null %}
{% include images-gallery.liquid imageCollection=calculatedFieldsParametersCE %}
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=calculatedFieldsParametersPE %}
{% endif %}

<br><b><font size="4">View detailed information of the calculated field</font></b>

点击 calculated field 可查看其详情。

{% assign calculatedFieldsParameters2CE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-2-ce.png
        title: Click the calculated field to view its details.
'
%}

{% assign calculatedFieldsParameters2PE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-2-pe.png
        title: Click the calculated field to view its details.
'
%}

{% if docsPrefix == null %}
{% include images-gallery.liquid imageCollection=calculatedFieldsParameters2CE %}
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=calculatedFieldsParameters2PE %}
{% endif %}

<br><b><font size="4">Modify the calculated field</font></b>

修改 calculated field 时，点击进入详情视图，再点击橙色 **pencil** 按钮。
完成修改后，点击橙色 **check** 按钮应用更新。

{% assign calculatedFieldsParameters3CE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-3-ce.png
        title: To modify the calculated field, click it to open the details view, then click the orange **pencil** button.   
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-4-ce.png
        title: After making your changes, click the orange **check** button to apply the updates.
'
%}

{% assign calculatedFieldsParameters3PE = '
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-3-pe.png
        title: To modify the calculated field, click it to open the details view, then click the orange **pencil** button.   
    ===
        image: /images/user-guide/calculated-fields/calculated-fields-parameters-4-pe.png
        title: After making your changes, click the orange **check** button to apply the updates.
'
%}

{% if docsPrefix == null %}
{% include images-gallery.liquid imageCollection=calculatedFieldsParameters3CE %}
{% endif %}
{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
{% include images-gallery.liquid imageCollection=calculatedFieldsParameters3PE %}
{% endif %}

## Calculated fields overview video

更习惯可视化学习？可观看此短视频快速了解 ThingsBoard 中的 **Calculated fields**。
涵盖核心概念、支持的计算类型，以及实时处理和转换数据的实践示例。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/wBUcWMSH4QI" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

<hr>

## Your feedback

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 为 ThingsBoard 加星。
如有疑问，请 [contact us](/docs/contact-us/){:target="_blank"}。
