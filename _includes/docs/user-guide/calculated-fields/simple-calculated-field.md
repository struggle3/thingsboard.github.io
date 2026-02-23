* TOC
{:toc}

Simple 计算字段使用单个**数学表达式**进行实时计算。
支持基本算术运算（<span class="code-light">+</span>、<span class="code-light">-</span>、<span class="code-light">*</span>、<span class="code-light">/</span>）及标准函数如 <span class="code-light">sqrt</span>、<span class="code-light">pow</span>、<span class="code-light">abs</span>、<span class="code-light">min</span>、<span class="code-light">max</span>。
适用于轻量转换与派生值，无需脚本。

在需要快速、声明式计算时使用 Simple 计算字段，例如：
- 归一化与缩放（乘数、偏移、校准系数）
- 派生传感器指标（如露点、热指数、功率 = 电压 × 电流）
- 基于阈值的值（限幅、简单评分、差值）
- 跨实体计算（如合并设备遥测与资产属性）

<hr>

## 配置

{% assign calculatedFieldType = "**Simple**" %}
{% include /docs/user-guide/calculated-fields/blocks/creating-calculated-field.md %}

<hr>

### 参数

Simple 计算字段的 arguments 可为 [latest telemetry](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=latestTelemetry#arguments){:target="_blank"} 或 [attribute](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"}。   
数据源可为 **Current entity**、另一 **Device/Asset**、**Customer**、**Current tenant** 或 **Current owner**。

参数类型与配置详见 [Arguments](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"}。

<hr>

### 表达式

在 **Expression** 区域使用单个数学公式定义计算。
- 按名称直接引用 [argument](#arguments) 变量（如 temperature、humidity）
- 支持算术运算（<span class="code-light">+</span>、<span class="code-light">-</span>、<span class="code-light">*</span>、<span class="code-light">/</span>）及标准函数如 <span class="code-light">abs</span>、<span class="code-light">sqrt</span>、<span class="code-light">pow</span>、<span class="code-light">min</span>、<span class="code-light">max</span>。
- 产生**单个结果值**，保存在配置的输出 key 下

<hr>

### 输出

计算结果以 [time series](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"} 或 [attribute](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} 形式存储。

在 Output 中指定：
- **Key** — 存储计算值的名称
- **Decimals** — 可选舍入

> **[仅适用于 Time series]**   
**Use latest timestamp** — 使用最新 argument 时间戳而非服务器时间存储结果。

输出类型与处理策略详见 [Output](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#output){:target="_blank"}。

<hr>

## 示例：露点计算

<b><font size="4">场景</font></b>   
Smart Device 实时发送 <span class="code-light">temperature</span> 与 <span class="code-light">humidity</span> 遥测。

<b><font size="4">目标</font></b>   
计算露点，并将结果以遥测形式存储在同一设备的 <span class="code-light">dewPoint</span> key 下。

<b><font size="4">Calculated field configuration</font></b>   
[Download the "Dew point calculation" calculated field configuration (JSON)](/docs/user-guide/resources/calculated-fields/simple/dew_point_calculation_simple_cf.json){:target="_blank" download="dew_point_calculation_simple_cf.json"}.

<br><b><font size="4">Configuration steps</font></b>

<b><font size="3">1. Import demo device</font></b>

Import a device that publishes temperature and humidity telemetry.
1. Download the CSV file: [dew-point-calculation-device-data.csv](/docs/user-guide/resources/calculated-fields/propagation/dew-point-calculation-device-data.csv){:target="_blank" download="dew-point-calculation-device-data.csv"}
2. Go to the "Devices" and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV includes:**
- **Name:** Smart Device
- **Type:** smart-device
- **Time series:** <span class="code-light">humidity</span>, <span class="code-light">temperature</span>

> **Important note about the CSV:** the column type for the <span class="code-light">humidity</span> and <span class="code-light">temperature</span> keys must be set to "**Time series**".

{% assign exampleSimple1 = '
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-1-ce.png
        title: Import a device that publishes **temperature** and **humidity** telemetry.
'
%}

{% include images-gallery.liquid imageCollection=exampleSimple1 %}

<br><b><font size="3">2. Apply the calculated field to the device profile</font></b>

During the Smart Device import, a "smart-device" profile is automatically created and assigned to it.   
Apply the calculated field to this profile so it runs for all devices that use the same profile.
1. [Download the calculated field configuration file (JSON)](/docs/user-guide/resources/calculated-fields/simple/dew_point_calculation_simple_cf.json){:target="_blank" download="dew_point_calculation_simple_cf.json"}.
2. Go to the "Calculated fields" tab and [import](/docs/user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"} the configuration.   

Expression used in this example:

```bash
(243.04 * (ln(humidity / 100) + 17.625 * temperature / (243.04 + temperature)) /
(17.625 - (ln(humidity / 100) + 17.625 * temperature / (243.04 + temperature))))
```
{:.copy-code}

Output settings:
- **Output type:** Time series
- **Key:** <span class="code-light">dewPoint</span>

{% assign exampleSimple2 = '
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-2-ce.png
        title: Go to the **Calculated fields** tab and import the calculated field configuration.
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-3-ce.png
        title: Apply the calculated field to the **smart-device** profile so it runs for all devices using it.
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-4-ce.png
        title: First argument settings:<br>- **Entity type:** Current entity<br>- **Argument type:** Latest telemetry<br>- **Time series key:** humidity<br>- **Argument name:** humidity.
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-5-ce.png
        title: Second argument settings:<br>- **Entity type:** Current entity<br>- **Argument type:** Latest telemetry<br>- **Time series key:** temperature<br>- **Argument name:** temperature.
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-6-ce.png
        title: The specified **mathematical expression** calculates the dew point.<br>The output value is stored as a time series under the **dewPoint** key.<br>Click **Add** to save the calculated field.
'
%}

{% include images-gallery.liquid imageCollection=exampleSimple2 %}

<br><b><font size="4">Result</font></b>

The dew point is calculated and saved as telemetry on the Smart Device under the <span class="code-light">dewPoint</span> key.

{% assign exampleSimple3 = '
    ===
        image: /images/user-guide/calculated-fields/simple/simple-example-7-ce.png
        title: The dew point is calculated and saved as telemetry on the Smart Device under the **dewPoint** key.
'
%}

{% include images-gallery.liquid imageCollection=exampleSimple3 %}

<hr>

## 反馈

欢迎为 ThingsBoard 在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 加星。
如有疑问，请 [联系我们](/docs/contact-us/){:target="_blank"}。