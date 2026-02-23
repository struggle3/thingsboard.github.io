* TOC
{:toc}

**Propagation**（传播）自动将当前实体的数据传送到一个或多个通过实体关系解析出的关联实体。
可**原样复制值**，也可**发送前先计算新值**，适合在实体层级间同步遥测与属性。

在以下场景使用「Propagation」：
- 将设备遥测镜像到父级资产（如电池电量、信号强度、最近状态）
- 将配置属性从资产推送到子设备（如 HVAC 模式、设定点、运行配置）
- 共享前转换数据（如在设备上计算露点并存储到温室资产）
- 向多个实体传播（如更新某建筑或分组管理的所有设备）

<hr>

## 配置

{% assign calculatedFieldType = "**Propagation**" %}
{% include /docs/user-guide/calculated-fields/blocks/creating-calculated-field.md %}

<hr>

### 向关联实体的传播路径

<b><font size="3">关系方向</font></b>   
定义从当前实体到数据传播目标实体的路径：
- **Up to parent** — 数据传播到父实体。
- **Down to child** — 数据传播到子实体。

> Propagation 仅支持直接（单层）关系，不支持递归或多层遍历。

<b><font size="3">关系类型</font></b>   
定义目标实体与关联实体间的关系类型（如 _Contains_、_Manages_ 或任意类型）。

> 若多个实体符合所选关系方向与关系类型，数据将传播到其中每一个。

{% assign propagationPathToRelatedEntities = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-path-to-related-entities-1-ce.png
        title: Define the path to the entity to which the data will be propagated, as well as the relationship type between the entities.
'
%}

{% include images-gallery.liquid imageCollection=propagationPathToRelatedEntities %}

<hr>

### 要传播的数据

定义将传播到关联实体的数据。   
传播数据以 arguments 形式配置，详见 [Arguments](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"} 章节。

支持两种模式：

<b><font size="3">1. Arguments only</font></b>   
  直接复制数据：将 [attribute](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"} 或 [latest telemetry](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=latestTelemetry#arguments){:target="_blank"} 从_当前实体_复制到关联实体，可在存储前重命名传播的 key。

{% assign propagationArgument = '
    ===
        image: /images/user-guide/calculated-fields/propagation/data-to-propagate-1-ce.png
        title: Click **Add argument** (1).
    ===
        image: /images/user-guide/calculated-fields/propagation/data-to-propagate-2-ce.png
        title: The data source will be the current entity to which the calculated field is applied.<br>Specify the **argument type** (2), **time series key / attribute key** (3), **output key** (4), and **default value** (5), then click **Add** (6).
'
%}

{% include images-gallery.liquid imageCollection=propagationArgument %}

<b><font size="3">2. Calculation result</font></b>   
  在传播到关联实体前，基于多实体数据（_Current entity / Device / Asset / Customer / Current tenant / Current owner_）的 [attribute](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#arguments){:target="_blank"}、[latest telemetry](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=latestTelemetry#arguments){:target="_blank"} 或 [time series rolling](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=timeSeriesRolling#arguments){:target="_blank"} 进行计算或转换。

操作顺序如下：
- 配置从所选实体提供输入数据的 arguments。
- 提供 [TBEL](/docs/{{docsPrefix}}user-guide/tbel/){:target="_blank"} 脚本，根据定义的 arguments 计算新值。
- 将计算结果传播到关联实体。

> 存储计算结果的变量名须在函数体内直接定义。

{% assign propagationArgument = '
    ===
        image: /images/user-guide/calculated-fields/propagation/data-to-propagate-3-ce.png
        title: Switch to **Calculation result** mode (1). Click **Add argument** (2).
    ===
        image: /images/user-guide/calculated-fields/propagation/data-to-propagate-4-ce.png
        title: The data source will be the **current entity** (3) to which the calculated field is applied.<br>Specify the **argument type** (4), **time series key / attribute key** (5), **output key** (6), and **default value** (7), then click **Add** (8).
    ===
        image: /images/user-guide/calculated-fields/propagation/data-to-propagate-5-ce.png
        title: Provide a TBEL script that will calculate a new value based on the defined arguments.
'
%}

{% include images-gallery.liquid imageCollection=propagationArgument %}

<hr>

<b><font size="4">Script</font></b>

{% include docs/user-guide/calculated-fields/blocks/script-calculation.md %}

<hr>

### 输出

数据传播到各关联实体，并以 [time series](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"} 或 [attributes](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} 形式存储。

输出类型与处理策略详见 [Output](/docs/user-guide/calculated-fields/?calculatedfieldsargumenttype=attribute#output){:target="_blank"} 章节。

<hr>

## 示例

以下为三个常见配置模式的实用示例。

### 示例 1：将设备电池电量传播到父级资产

<b><font size="4">场景</font></b>   
Tracker A 设备以遥测形式向 ThingsBoard 发送电池电量（<span class="code-light">batteryLevel</span>）。

<b><font size="4">目标</font></b>   
自动将设备电池电量传播到关联的 Truck 1 资产，并以服务端属性存储，使用新 key：<span class="code-light">deviceBatteryLevel</span>。

<b><font size="4">计算字段配置</font></b>   
[下载「电池电量传播」计算字段配置 (JSON)](/docs/user-guide/resources/calculated-fields/propagation/battery_level_propagation_cf.json){:target="_blank" download="battery_level_propagation_cf.json"}。

<br><b><font size="4">配置步骤</font></b>

<b><font size="3">1. 导入示例设备</font></b>

导入发布电池遥测的设备。
1. Download the CSV file: [battery-level-device-data.csv](/docs/user-guide/resources/calculated-fields/propagation/battery-level-device-data.csv){:target="_blank" download="battery-level-device-data.csv"}
2. Go to the **Devices** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV 包含：**
- **Name:** Tracker A
- **Type:** tracker
- **Time series:** <span class="code-light">batteryLevel</span>

> **CSV 注意事项：** <span class="code-light">batteryLevel</span> 的列类型须设为「**Time series**」。

{% assign examplePropagateDeviceBattery1 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-1-ce.png
        title: Import a device that publishes **battery level** telemetry.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagateDeviceBattery1 %}

<br><b><font size="3">2. 导入示例资产</font></b>

导入代表被追踪卡车的资产。
1. Download the CSV file: [battery-level-asset-data.csv](/docs/user-guide/resources/calculated-fields/propagation/battery-level-asset-data.csv){:target="_blank" download="battery-level-asset-data.csv"}
2. Go to **Assets** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV 包含：**
- **Name:** Truck 1
- **Type:** truck

{% assign examplePropagateDeviceBattery2 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-2-ce.png
        title: Import the demonstration asset Truck 1.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagateDeviceBattery2 %}

<br><b><font size="3">3. 在资产与设备间创建关系</font></b>

创建关系以便计算字段能解析到目标资产。

在 **Track 1** 资产与 **Tracker A** 设备间创建关系：
- 关系方向：**From**
- 关系类型：**Contains**

Propagation 计算字段通过此关系定位父实体。

{% assign examplePropagateDeviceBattery3 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-3-ce.png
        title: The **Tracker** device linked to the **Track 1** asset via the **Contains** relation.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagateDeviceBattery3 %}

<br><b><font size="3">4. 将 Propagation 计算字段应用于设备配置</font></b>

在 **tracker** 设备配置（设备导入时自动创建）中配置 **Propagation** 计算字段，使其对 Tracker A 生效。
1. [Download the calculated field configuration file](/docs/user-guide/resources/calculated-fields/propagation/battery_level_propagation_cf.json){:target="_blank" download="battery_level_propagation_cf.json"}.
2. Go to the "Calculated fields" tab and [import](/docs/user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"} the configuration.

此配置将 <span class="code-light">batteryLevel</span> 的最新遥测值传播到父资产（**Truck 1**）。

{% assign examplePropagateDeviceBattery4 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-4-ce.png
        title: Go to the **Calculated fields** tab and import the calculated field configuration.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-5-ce.png
        title: Apply the calculated field to the **tracker** profile so it runs for all devices using it.<br>Propagation path to related entities: Relation direction: Up to parent; Relation type: Contains
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-6-ce.png
        title: Argument settings:<br>- **Entity type:** Current entity<br>- **Argument type:** Latest telemetry<br>- **Time series key:** batteryLevel<br>- **Output key:** deviceBatteryLevel<br>- **Default value:** no data.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-7-ce.png
        title: The output value will be stored as a server-side **attribute**.<br>Click **Add** to save the calculated field.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagateDeviceBattery4 %}

<br><b><font size="4">结果</font></b>

<span class="code-light">deviceBatteryLevel</span> 属性已传播并作为**服务端属性**存储在 **Truck 1** 资产上。

{% assign examplePropagateDeviceBattery5 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-1-8-ce.png
        title: The **deviceBatteryLevel** attribute is propagated and stored on the **Truck 1** asset as a **server-side attribute**.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagateDeviceBattery5 %}

<hr>

### 示例 2：露点计算并传播到父级资产

<b><font size="4">场景</font></b>   
Smart Device 向 ThingsBoard 发送 <span class="code-light">temperature</span> 与 <span class="code-light">humidity</span> 遥测，并通过 _Contains_ 关系关联到 Greenhouse A 资产。

<b><font size="4">目标</font></b>   
计算**露点**，将结果传播到关联资产（**Greenhouse A**），并以**遥测**形式存储。

<b><font size="4">Calculated field configuration</font></b>   
[Download the "Dew point propagation" calculated field configuration (JSON)](/docs/user-guide/resources/calculated-fields/propagation/dew_point_propagation_cf.json){:target="_blank" download="dew_point_propagation_cf.json"}.

<br><b><font size="4">Configuration steps</font></b>

<b><font size="3">1. Import demo device</font></b>

Import a device that publishes temperature and humidity telemetry.
1. Download the CSV file: [dew-point-calculation-device-data.csv](/docs/user-guide/resources/calculated-fields/propagation/dew-point-calculation-device-data.csv){:target="_blank" download="dew-point-calculation-device-data.csv"}
2. Go to the **Devices** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV includes:**
- **Name:** Smart Device
- **Type:** smart-device
- **Time series:** <span class="code-light">humidity</span>, <span class="code-light">temperature</span>

> **Important note about the CSV:** the column type for the <span class="code-light">humidity</span> and <span class="code-light">temperature</span> keys must be set to "**Time series**".

{% assign exampleDewPointPropagation1 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-1-ce.png
        title: Import a device that publishes **temperature** and **humidity** telemetry.
'
%}

{% include images-gallery.liquid imageCollection=exampleDewPointPropagation1 %}

<br><b><font size="3">2. Import demo asset</font></b>

Import the asset that represents the greenhouse.
1. Download the CSV file: [dew-point-calculation-and-propagation-asset-data.csv](/docs/user-guide/resources/calculated-fields/propagation/dew-point-calculation-and-propagation-asset-data.csv){:target="_blank" download="dew-point-calculation-and-propagation-asset-data.csv"}
2. Go to **Assets** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV includes:**
- **Name:** Greenhouse A
- **Type:** greenhouse

{% assign exampleDewPointPropagation2 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-2-ce.png
        title: Import the demonstration asset Greenhouse A.
'
%}

{% include images-gallery.liquid imageCollection=exampleDewPointPropagation2 %}

<br><b><font size="3">3. Create a relation between the asset and the device</font></b>

Create a relationship between the **Greenhouse A** asset and the **Smart Device**:
- Relation direction: **From**
- Relation type: **Contains**

This relation allows the calculated field to locate the parent asset when propagating output.

{% assign exampleDewPointPropagation3 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-3-ce.png
        title: Create a relationship between the **Greenhouse A** asset and the **Smart Device**.
'
%}

{% include images-gallery.liquid imageCollection=exampleDewPointPropagation3 %}

<br><b><font size="3">4. Apply the calculated field to the device profile</font></b>

Configure the calculated field on the "smart-device" device profile (created automatically during device import), so it runs for Smart Device.
1. [Download the calculated field configuration file](/docs/user-guide/resources/calculated-fields/propagation/dew_point_propagation_cf.json){:target="_blank" download="dew_point_propagation_cf.json"}.
3. Go to the "Calculated fields" tab and [import](/docs/user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"} the configuration.

This scenario calculates the dew point value from the specified input data. The value is propagated and stored as telemetry on the parent asset (**Greenhouse A**) under the <span class="code-light">dewPoint</span> key.

{% assign exampleDewPointPropagation4 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-4-ce.png
        title: Go to the **Calculated fields** tab and import the calculated field configuration.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-5-ce.png
        title: Apply the calculated field to the **smart-device** profile so it runs for all devices using it.<br>Propagation path to related entities: **Relation direction**: Up to parent; **Relation type**: Contains.<br><br>**Data to propagate:** switch to **Calculation result** mode.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-6-ce.png
        title: First argument settings:<br>- **Entity type:** Current entity<br>- **Argument type:** Latest telemetry<br>- **Time series key:** humidity<br>- **Argument name:** humidity.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-7-ce.png
        title: Second argument settings:<br>- **Entity type:** Current entity<br>- **Argument type:** Latest telemetry<br>- **Time series key:** temperature<br>- **Argument name:** temperature.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-8-ce.png
        title: This scenario calculates the dew point value from the specified input data. The value is propagated and stored as telemetry on the parent asset under the **dewPoint** key.<br>Click **Add** to save the calculated field.
'
%}

{% include images-gallery.liquid imageCollection=exampleDewPointPropagation4 %}

<br><b><font size="4">Result</font></b>

The calculated value is propagated to the **Greenhouse A** asset and stored as a **telemetry** under the key <span class="code-light">dewPoint</span>.

{% assign exampleDewPointPropagation5 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-2-9-ce.png
        title: The calculated value is propagated to the **Greenhouse A** asset and stored as a **telemetry** under the key **dewPoint**.
'
%}

{% include images-gallery.liquid imageCollection=exampleDewPointPropagation5 %}

<hr>

### 示例 3：将 HVAC 模式传播到多个子设备

<b><font size="4">场景</font></b>   
Building A 资产通过 _Manages_ 关系管理多个子 HVAC 设备。资产级 <span class="code-light">hvacMode</span> 服务端属性为所有设备定义运行模式（如 _cooling_、_heating_、_off_）。

<b><font size="4">目标</font></b>   
将 <span class="code-light">hvacMode</span> 属性从 Building A 自动传播到所有关联 HVAC 设备。

<b><font size="4">Calculated field configuration</font></b>   
[Download the "Propagate HVAC mode" calculated field configuration (JSON)](/docs/user-guide/resources/calculated-fields/propagation/cooling_propagation_cf.json){:target="_blank" download="cooling_propagation_cf.json"}.

<br><b><font size="4">Configuration steps</font></b>

<b><font size="3">1. Import demo devices</font></b>
1. Download the CSV file: [propagate-hvac-mode-device-data.csv](/docs/user-guide/resources/calculated-fields/propagation/propagate-hvac-mode-device-data.csv){:target="_blank" download="propagate-hvac-mode-device-data.csv"}
2. Go to the **Devices** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV includes:**
- **Name:** Room Sensor 1
- **Type:** sensor

{% assign examplePropagation31 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-1-ce.png
        title: Go to the **Devices** and **import** device configurations from a CSV file.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation31 %}

<br><b><font size="3">2. Import demo asset</font></b>

Import an asset that represents the building.
1. Download the CSV file: [propagate-hvac-mode-asset-data.csv](/docs/user-guide/resources/calculated-fields/propagation/propagate-hvac-mode-asset-data.csv){:target="_blank" download="propagate-hvac-mode-asset-data.csv"}
2. Go to **Assets** and [import](/docs/user-guide/bulk-provisioning/){:target="_blank"} the CSV file.

**CSV includes:**
- **Name:** Building A
- **Type:** building
- **Server attributes:** <span class="code-light">hvacMode</span>

> **Important note about the CSV:** the column type for the <span class="code-light">hvacMode</span> keys must be set to "**Server attributes**".

{% assign examplePropagation32 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-2-ce.png
        title: The imported **Building A** asset publishes the **hvacMode** value as an attribute.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation32 %}

<hr>

<b><font size="3">3. Create a relation between the asset and the devices</font></b>

Create a relationship between the **Building A** asset and the **room devices**.
- Relation direction: **From**
- Relation type: **Manages**

This relation is used by the propagation calculated field to locate the parent entity.

{% assign examplePropagation33 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-3-ce.png
        title: Create a relationship between the **Building A** asset and the **room devices**.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation33 %}

<br><b><font size="3">4. Apply the calculated field to the asset profile</font></b>

Configure a **Propagation** calculated field on the "building" asset profile (created automatically during asset import), so it runs for Building A.
1. [Download the calculated field configuration file](/docs/user-guide/resources/calculated-fields/propagation/cooling_propagation_cf.json){:target="_blank" download="cooling_propagation_cf.json"}.
3. Go to the Calculated fields tab and [import](/docs/user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"} the configuration.

This configuration propagates the attribute value of <span class="code-light">hvacMode</span> to the child devices.

{% assign examplePropagation34 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-4-ce.png
        title: Go to the **Calculated fields** tab and import the calculated field configuration.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-5-ce.png
        title: Apply the calculated field to the **building** profile so it runs for all asset using it.<br>Propagation path to related entities: **Relation direction**: Down to child; **Relation type**: Manages
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-6-ce.png
        title: Argument settings.<br>The propagated value will be stored on devices as an attribute.<br>Click <b>Add</b> to save the calculated field.
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation34 %}

<br><b><font size="4">Result</font></b>

Each HVAC device received the <span class="code-light">hvacMode</span> attribute with the value **cooling**.

{% assign examplePropagation35 = '
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-7-ce.png
        title: Each HVAC device received the **hvacMode** attribute with the value **cooling**.
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-8-ce.png
    ===
        image: /images/user-guide/calculated-fields/propagation/propagation-cf-example-3-9-ce.png
'
%}

{% include images-gallery.liquid imageCollection=examplePropagation35 %}

<hr>

## 故障排查

### 更新后传播路径设置未生效

**现象：** 编辑现有计算字段并修改 **关系方向** 或 **关系类型**（例如从 *Contains* 改为 *Manages*）时，字段忽略这些变更，仍按原路径传播数据。

**原因：** 计算字段逻辑会缓存首次创建时定义的**向关联实体的传播路径**。对关系方向或关系类型的专项修改不会被正确识别，导致路径未能重新初始化。

**解决：** 强制计算字段应用新的传播路径时，需修改 **Data to propagate** 区域配置。对 arguments 的任何改动都会触发必要的重新初始化。

可选以下两种方式之一：

1. 重新创建字段（最干净）
   若必须保持现有 arguments 不变（如不能修改默认值），则需删除原计算字段并新建一个，使用正确的传播路径设置。

2. 修改默认值（推荐变通）
   若希望在不断建字段的前提下修复，可编辑已有 argument 并修改其 **Default value**（例如由空改为有值，或更新值）。
   > 若源数据缺失，将使用新默认值。若源数据始终存在，这是最稳妥方式，可在不影响数据的前提下强制更新。

## 反馈

欢迎为 ThingsBoard 在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 加星。
如有疑问，请 [联系我们](/docs/contact-us/){:target="_blank"}。