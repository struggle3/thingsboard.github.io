* TOC
{:toc}

本指南演示如何在 ThingsBoard 中基于两台不同设备的遥测数据计算遥测 delta，并将结果存储为 asset telemetry。

以仓库中安装的室内和室外温度计之间的温度差为例。计算得到的值作为新的遥测键存储，可用于监控、可视化或告警。

本指南为入门级，重点演示平台核心能力，而非从零构建配置。   
因此，在设置过程中将提供并导入预设的 calculated field 配置。

将上述配置导入 ThingsBoard 实例后，可查看其结构、逻辑和行为，并据此适配自己的使用场景。

<hr>

## 使用场景

假设仓库配备两台温度传感器：
- Indoor Thermometer
- Outdoor Thermometer

目标是：
- 从两台设备采集遥测
- 计算室内与室外读数的绝对温度差
- 将结果作为仓库 asset 的遥测存储
- 实时可视化和监控该值

该示例展示跨实体数据聚合，即在 asset 层级处理来自多台设备的遥测。

<hr>

## 前置条件

在继续前，建议先阅读 ThingsBoard [Calculated fields](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"} 文档。

该主题提供了理解本示例中实体关系与数据处理机制所需的基础。

<hr>

## 1. 创建 asset 与设备

在 ThingsBoard 中，asset 是用于表示建筑物、仓库或生产线等逻辑对象的抽象实体。   
本示例中，asset 代表仓库，用于存储来自多台设备的聚合遥测。

**创建 asset：**
1. 进入 **Entities** **&#8702;** **Assets**。
2. 点击右上角 **「&#43; Add asset」** 按钮，选择 **「Add new asset」** 并创建：   
&#8194;&#8226;&#8194;**Asset name**: Warehouse A   
&#8194;&#8226;&#8194;**Asset profile**: warehouse

**创建两台设备：**
1. 下载包含设备配置的 CSV 文件：   
   [thermometers_device_data.csv](/docs/user-guide/resources/guides/thermometers_device_data.csv){:target="_blank" download="thermometers_device_data.csv"}
2. 进入 **Entities** **&#8702;** **Devices**。
3. 点击右上角 **「&#43; Add device」** 按钮，选择 **「Import device」**。
4. [上传 CSV 文件](/docs/{{docsPrefix}}user-guide/bulk-provisioning/#upload-file){:target="_blank"} 并按照导入向导操作。

**CSV 配置详情：**
- **CSV delimiter**：<span class="code-light">,</span>
- **Column mapping**:
   - **Name**: Indoor Thermometer, Outdoor Thermometer
   - **Type**: thermometer

<hr>

## 2. 使用 Rule Engine 模拟遥测

由于本示例使用虚拟设备，遥测需 artificially 生成。

使用 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/){:target="_blank"} 定期发布随机温度值。

> 为简化说明，将 generator 添加到 Root Rule Chain，但在生产环境中应使用 dedicated rule chain。

- 进入 **Rule chains**。
- 打开 **Root Rule Chain**。 
- 将 [Generator node](/docs/user-guide/rule-engine-2-0/nodes/action/generator){:target="_blank"} 拖拽到画布上。 
- 选择 **Indoor Thermometer** 作为 originator。 
- 使用相应的模拟脚本替换 generator 函数。 
- 对 **Outdoor Thermometer** 设备重复上述步骤。 
- 使用 **Success** 关系将两个 Generator 节点连接到 [Entity type filter node](/docs/user-guide/rule-engine-2-0/nodes/filter/entity-type-filter){:target="_blank"}。
- 应用更改。

**Indoor Thermometer 模拟脚本：**
```javascript
var indoorTemperature = toFixed(Math.random()*10 + 18, 2);
var msg = { indoorTemperature: indoorTemperature };
var metadata = { data: 40 };
var msgType = "POST_TELEMETRY_REQUEST";
return { msg: msg, metadata: metadata, msgType: msgType };
```
{:.copy-code}

该 generator 模拟约 18–28 °C 范围内的室内温度。

**Outdoor Thermometer 模拟脚本：**
```javascript
var outdoorTemperature = toFixed(Math.random()*10 + 16, 2);
var msg = { outdoorTemperature: outdoorTemperature };
var metadata = { data: 40 };
var msgType = "POST_TELEMETRY_REQUEST";
return { msg: msg, metadata: metadata, msgType: msgType };
```
{:.copy-code}

该 generator 模拟约 16–26 °C 范围内的室外温度。

**验证**

Generator 运行后：
1. 打开 **Entities &#8702; Devices &#8702; Indoor Thermometer &#8702; Latest telemetry**。
2. 打开 **Entities &#8702; Devices &#8702; Outdoor Thermometer &#8702; Latest telemetry**。

应能看到持续更新的 <span class="code-light">temperature</span> 值。

<hr>

## 3. 在 asset 上导入 calculated field

计算两台温度计的温度差，并将其作为 asset telemetry 存储。
1. 下载 calculated field 配置文件：   
   [temperature_delta_based_on_2_devices_cf.json](/docs/user-guide/resources/guides/temperature_delta_based_on_2_devices_cf.json){:target="_blank" download="temperature_delta_based_on_2_devices_cf.json"}。
2. 进入 **Calculated fields** 页面。
3. 点击右上角 **「&#43; Add calculated field」** 按钮，选择 **「Import calculated field」**。
4. [上传 calculated field 配置文件](/docs/{{docsPrefix}}user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"}。
5. 选择 **warehouse** [asset profile](/docs/{{docsPrefix}}user-guide/asset-profiles/){:target="_blank"} 作为目标实体，以便 calculated field 自动应用到所有相关 assets。
6. 按如下方式更新 calculated field 参数：   
   &#8226;&#8194;**First argument**:   
   &#8194;&#8194;&#8226;&#8194;**Entity type**: Device   
   &#8194;&#8194;&#8226;&#8194;**Device name**: Indoor Thermometer   
   &#8194;&#8194;&#8226;&#8194;**Argument type**: Latest telemetry   
   &#8194;&#8194;&#8226;&#8194;**Time series key**: indoorTemperature   
   &#8194;&#8194;&#8226;&#8194;**Argument name**: indoorTemperature   
   &#8226;&#8194;**Second argument**:   
   &#8194;&#8194;&#8226;&#8194;**Entity type**: Device   
   &#8194;&#8194;&#8226;&#8194;**Device name**: Outdoor Thermometer   
   &#8194;&#8194;&#8226;&#8194;**Argument type**: Latest telemetry   
   &#8194;&#8194;&#8226;&#8194;**Time series key**: outdoorTemperature   
   &#8194;&#8194;&#8226;&#8194;**Argument name**: outdoorTemperature
7. 点击 **Add** 完成导入。

<b><font size="3">计算逻辑</font></b>

```javascript
abs(indoorTemperature - outdoorTemperature)
```
{: .copy-code}

无论哪个值更高，都会计算绝对温度差。

保存后，asset 会自动接收更新后的 deltaTemperature 遥测。

<hr>

## 4. 验证配置

1. 打开 **Entities &#8702; Assets &#8702; Warehouse A &#8702; Latest telemetry**。
2. 确认存在 <span class="code-light">deltaTemperature</span> 键并实时更新。

这表明：
- 两台设备的遥测均被接收
- Calculated field 正确执行
- 结果存储在 asset 上

<hr>

## 5. 使用 dashboard 可视化数据（可选）

要可视化监控温度差：
- [下载准备好的 Warehouse dashboard JSON 文件](/docs/user-guide/resources/guides/warehouse_dashboard.json){:target="_blank" download="warehouse_dashboard.json"}。
- [导入](/docs/{{docsPrefix}}user-guide/dashboards/#import-dashboard){:target="_blank"} 到 ThingsBoard。
- 导入后，更新 [entity alias](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}，将 Warehouse A 设为目标实体以正确显示数据。

Dashboard 应显示室内与室外温度计之间温度差的实时图表和表格。

<hr>

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}
