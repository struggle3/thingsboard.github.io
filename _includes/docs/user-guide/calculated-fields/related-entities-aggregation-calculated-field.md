* TOC
{:toc}

关联实体聚合从与目标实体相关的多个实体（设备、资产、客户或租户）收集**最新遥测**或**属性**值，应用一个或多个聚合函数，并将聚合结果存储到目标实体。

仅对**直接（单层）关系**进行聚合，确保实体选择可预期。

在需要从多实体计算「组级」指标时使用「Related entities aggregation」，例如：
- **车队/建筑仪表板**：所有传感器平均温度、所有电表总功率、所有机器最大振动
- **运营 KPI**：活跃设备数、告警数、在线率
- **占用/存在追踪**：统计处于某状态的设备数（如 motion = true）
- **能耗与用量合计**：多设备或区域的能耗总和
- **质量监控**：组内最小/最大读数（如最低冷冻温度、最高湿度）
- **筛选聚合**：仅对实体子集聚合（如仅「active」设备或超出阈值的读数）

<hr>

## 配置

{% assign calculatedFieldType = "**Related entities aggregation**" %}
{% include /docs/user-guide/calculated-fields/blocks/creating-calculated-field.md %}

<hr>

### Aggregation path to related entities

ThingsBoard will collect data for aggregation from all entities that match the selected relationship direction and relationship type.

<b><font size="3">关系方向</font></b>   
定义读取数据的实体路径：
- **Down to child** — data is aggregated from child entities.
- **Up to parent** — data is aggregated from parent entities.

Aggregation works only with direct (single-level) relationships, without recursion or multi-level traversal.

<b><font size="3">关系类型</font></b>   
定义目标实体与关联实体间的关系类型（如 Contains、Manages 或任意类型）。

{% assign relatedPathToRelatedEntities = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-aggregation-path-to-related-entities-1-ce.png
        title: Define the path to the entities from which the data will be read for aggregation, as well as the relationship type between the target entity and the related entities.
'
%}

{% include images-gallery.liquid imageCollection=relatedPathToRelatedEntities %}

<hr>

### 参数

Arguments 定义从各关联实体获取的聚合数据。

点击 **Add argument** 并填写必填项：
- **Argument type**：[Latest telemetry](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=latestTelemetry#arguments){:target="_blank"} 或 [Attribute](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"}
- **Time series key / Attribute key**：要读取的 key
- **Argument name**：在 metrics 中使用的变量名
- **Default value**：数据缺失时的回退值

参数与配置详见 [Arguments](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"} 章节。

{% assign relatedArgument = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-aggregation-argument-1-ce.png
        title: Click **Add argument** (1) and fill in the required fields:<br>select the **Argument type** (2), specify the **Time series key / Attribute key** (3) to read data from, enter the **Argument name** (4) that will be used in the metrics, and set the **Default value** (5).<br>Then click **Add** (6).”
'
%}

{% include images-gallery.liquid imageCollection=relatedArgument %}

<hr>

### 指标

定义应用于 arguments 指定数据的函数类型（聚合）以及存储聚合结果的 key。

每个 metric 包含：
- **Metric name**：在目标实体上存储聚合结果的输出 key 名。
- **Aggregation**：Average / Min / Max / Sum / Count / Count unique
- **Filter**（可选）：聚合前包含/排除实体值
- **Value source**：使用直接 argument 值（Key）或函数结果（Function）
- **Argument name**：被聚合数据的 [argument](#arguments)

<b><font size="3">Filter</font></b>   
Filter 是返回 <span class="code-light">true/false</span> 的函数，可使用任意已定义 arguments。返回 <span class="code-light">true</span> 时，实体值参与聚合；否则跳过。

Example:

```js
return temperature > 10 && status == "active";
```
{:.copy-code}

{% assign relatedMetrics = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-aggregation-metrics-1-ce.png
        title: Click **Add metric** (1) and configure the following:<br>specify the **metric name** (2), select the **aggregation type** (3), optionally enable a **filter** (4), choose the **value source** (Key or Function) (5), and enter the **argument name** (6) that will be used as the data source.<br>Then click **Add** (7).
'
%}

{% include images-gallery.liquid imageCollection=relatedMetrics %}

<br><b><font size="4">Deduplication interval</font></b>

The Deduplication interval limits how often aggregation is executed when many related entities send frequent updates.

How it works:
- the first update triggers aggregation
- additional updates arriving within the interval do not trigger aggregation again
- after the interval ends, aggregation run again using the latest available data

> Minimum time between telemetry aggregations: 10 seconds.

This prevents excessive reprocessing and reduces system load in high-frequency environments.

{% assign relatedDeduplicationInterval = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-aggregation-metrics-2-ce.png
        title: **Deduplication interval** is the minimum time period between repeated aggregations. It limits how often a calculated field can re-aggregate data from related entities in response to frequent updates.
'
%}

{% include images-gallery.liquid imageCollection=relatedDeduplicationInterval %}

<hr>

### 输出

计算结果以 [time series](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"} 或 [attribute](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} 形式存储。   
如需要，可设置 Decimals 进行舍入。

> **[仅适用于 Time series]**   
启用 **Use latest timestamp** 以使用最新 argument 时间戳而非服务器时间存储结果。

输出类型与处理策略详见 [Output](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#output){:target="_blank"} 章节。

<hr>

## 示例：汇总多个子设备的温度值

<b><font size="4">场景</font></b>   
多台温度传感器设备安装在 **Building A** 中，并持续发布遥测值。

<b><font size="4">目标</font></b>   
从与 Building A 相关的所有传感器收集温度遥测并计算：
- <span class="code-light">avgTemperature</span> — average temperature in the building
- <span class="code-light">maxTemperature</span> — maximum temperature in the building

Store both values as **telemetry** on the **Building A** asset.

What you will configure

You will apply an "Aggregation" calculated field to the Building A asset that:
- reads the latest temperature value from related devices (child sensors)
- computes average and maximum
- writes the results back to Building A as telemetry keys <span class="code-light">avgTemperature</span> and <span class="code-light">maxTemperature</span>.

<b><font size="4">Calculated field configuration</font></b>   
[Download the "Related entities aggregation" calculated field configuration (JSON)](/docs/user-guide/resources/calculated-fields/related-entities-aggregation/temperature_aggregation_cf.json){:target="_blank" download="temperature_aggregation_cf.json"}.

<br><b><font size="4">Configuration steps</font></b>

<b><font size="3">1. Import demo devices</font></b>

Import multiple smart devices that publish <span class="code-light">temperature</span> telemetry.
1. Download the CSV file: [device-data-with-temperature-telemetry.csv](/docs/user-guide/resources/calculated-fields/related-entities-aggregation/device-data-with-temperature-telemetry.csv){:target="_blank" download="device-data-with-temperature-telemetry.csv"}
2. Go to the **Devices** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file

**CSV includes:**
- **Name:** Smart Device 1
- **Type:** sensor
- **Time series:** <span class="code-light">temperature</span>

> **Important note about the CSV:** the column type for the <span class="code-light">temperature</span> key must be set to "**Time series**".

{% assign exampleRelatedEntities1 = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-1-ce.png
        title: Go to the **Devices** and **import** device configurations from a CSV file.
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-2-ce.png
        title: Name: Smart Device 1<br>Type: sensor<br>Time series: temperature
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-3-ce.png
        title: Imported smart devices that publish **temperature** telemetry.
'
%}

{% include images-gallery.liquid imageCollection=exampleRelatedEntities1 %}

<br><b><font size="3">2. Import demo asset</font></b>

Import the asset that represents the building.
1. Download the CSV file: [building-asset-data.csv](/docs/user-guide/resources/calculated-fields/related-entities-aggregation/building-asset-data.csv){:target="_blank" download="building-asset-data.csv"}
2. Go to **Assets** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV includes:**
- **Name:** Building A
- **Type:** building

{% assign exampleRelatedEntities2 = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-4-ce.png
        title: Import the demonstration asset Building A.
'
%}

{% include images-gallery.liquid imageCollection=exampleRelatedEntities2 %}

<br><b><font size="3">3. Create relations between the asset and devices</font></b>

Create relationships between Building A and all smart sensors:
- **Relation direction:** From (Device &#8702; Building A)
- **Relation type:** Manages

These relations define the set of related entities whose telemetry will be aggregated.

{% assign examplePropagation33 = '
    ===
        image: /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-5-ce.png
        title: Create relationships between Building A and all smart sensors: Relationship direction: From (Devices &#8702; Building A); Relationship type: Manages

'
%}

{% include images-gallery.liquid imageCollection=examplePropagation33 %}

<br><b><font size="3">4. Apply the calculated field to the asset</font></b>

Apply the **Related Entities Aggregation** calculated field to the **Building A** asset.
1. [Download the calculated field configuration file](/docs/user-guide/resources/calculated-fields/related-entities-aggregation/temperature_aggregation_cf.json){:target="_blank" download="temperature_aggregation_cf.json"}.
2. Go to the "Calculated fields" tab and [import](/docs/user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"} the configuration.

The field will:
- read latest temperature value from all child devices
- compute avg/max
- store results on Building A

{% assign examplePropagation34 = '
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-6-ce.png
        title: Go to the **Calculated fields** tab and import the calculated field configuration.
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-7-ce.png
        title: Apply the calculated field to the **building** asset profile.<br>Propagation path to related entities: **Relation direction**: Down to child; **Relation type**: Manages.
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-8-ce.png
        title: Argument settings:<br>- **Argument type:** Latest telemetry<br>- **Time series key:** temperature<br>- **Argument name:** temperature<br>- **Default value:** 0.
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-9-ce.png
        title: First metric settings:<br>- **Metric name:** avgTemperature<br>- **Aggregation:** Average<br>- **Value source:** key<br>- **Argument name:** temperature.
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-10-ce.png
        title: Second metric settings:<br>- **Metric name:** maxTemperature<br>- **Aggregation:** Maximum<br>- **Value source:** key<br>- **Argument name:** temperature.
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-11-ce.png
        title: Deduplication interval: 10 seconds.<br>The output value will be stored as a telemetry. Click **Add** to save the calculation field.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation34 %}

> (Optional) Enable [Debug mode](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#debug){:target="_blank"} and review execution events using the **Events** icon.

<br><b><font size="4">Result</font></b>

The Building A asset stores aggregated telemetry such as:
- <span class="code-light">avgTemperature</span> — average temperature across all sensors
- <span class="code-light">maxTemperature</span> — maximum temperature reported by any sensor

Example:
```json
{ "avgTemperature": 22.7, "maxTemperature": 25.1 }
```

{% assign examplePropagation33 = '
    ===
        /images/user-guide/calculated-fields/related-entities/related-entities-cf-example-1-12-ce.png
        title: The Building A asset stores the aggregated telemetry values, such as:<br>- **avgTemperature** — average temperature across all sensors<br>- **maxTemperature** — maximum temperature measured by one of the sensors
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation33 %}

<hr>

## 反馈

欢迎为 ThingsBoard 在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 加星。
如有疑问，请 [联系我们](/docs/contact-us/){:target="_blank"}。