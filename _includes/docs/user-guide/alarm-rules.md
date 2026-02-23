* TOC
{:toc}

**Alarm rules** 定义告警触发条件、严重级别设置逻辑以及清除和自动关闭通知的规则，便于管理员和开发者在实时系统中保持控制并快速响应异常。

自 ThingsBoard **4.3** 起，告警规则配置能力显著增强。规则可在 [Device](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}、[Asset](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"}、**其 Profiles** 甚至 [Customer](/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"} 级别定义，形成尊重组织结构与上下文逻辑的多层监控。可在全局、profile 或具体设备/实体上精确控制告警产生。

告警唯一性、严重级别、时间戳和告警传播的统一机制，保证数据处理一致，帮助运维高效分析、筛选和处理关键事件。

<hr>

## 创建告警规则

**alarm rules 页面** 可集中管理系统中的全部告警规则（适用于单个实体和 profile）。

> **说明：** 在 [Devices](/docs/{{docsPrefix}}user-guide/ui/devices/){:target="_blank"}、[Assets](/docs/{{docsPrefix}}user-guide/ui/assets/){:target="_blank"}、[Device profiles](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}、[Asset profiles](/docs/{{docsPrefix}}user-guide/asset-profiles/){:target="_blank"} 和 [Customers](/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"} 中创建告警规则的流程相同。
 
- 在左侧菜单中打开 **Alarms** 页面
- 进入 **Alarm rules** 选项卡
- 点击右上角「**+**」按钮
- 在下拉菜单中选择 **Create new alarm rule**

{% include images-gallery.html imageCollection="step-1-add-alarm-rule-1" %}

> **建议：** 在 **Device profiles** 或 **Asset profiles** 中创建告警规则，避免在多个实体间重复配置。

<hr>

### General（常规）

「General」部分定义告警规则的基本配置：
- **Alarm type** — 告警的名称和唯一标识符（如「High Temperature」）。用于标识告警代表的事件，并决定是创建新告警还是更新已有活动告警。
- **Entity type** — 告警规则将应用的目标实体或 entity profile。

{% include images-gallery.html imageCollection="step-2-general-section-1" %}

<br>

{% assign feature = "alarm rule" %}
{% include templates/debug-mode.md %}

<hr>

### Arguments（参数）

定义告警条件前，需至少添加一个 **argument** — 规则评估时使用的数据源。

点击 **Add argument** 并配置以下参数：

{% include images-gallery.html imageCollection="step-3-arguments-1" %}

<b><font size="3">Entity type</font></b>

定义 argument 值的来源：
- **Current entity** — 当前配置的实体（device、asset、customer 或 profile）。  
  若规则在 **Device profile** 或 **Asset profile** 级创建，将应用于使用该 profile 的所有实体。
- Another **Device or Asset** — 引用其他设备或资产的 telemetry 或 attributes
- **Customer** — 从关联的 customer 实体获取数据
- **Current tenant** — 使用 tenant 实体的数据
- **Current owner** — 使用当前实体所有者的数据

{% include images-gallery.html imageCollection="step-3-arguments-2" %}

<b><font size="3">Argument type</font></b>

定义 argument 代表的数据类型：
- **Attribute**，使用实体上存储的 key-value attribute（如 model、max temperature），  
  需指定：
  - **Attribute scope**：**Server** attributes、**Client** attributes 或 **Shared** attributes
  - **Attribute key**
  - 可选：**Default value**（attribute 值缺失时使用）
- **Latest telemetry**，使用实体的最新时间序列值（如 temperature、speed、voltage），
  需指定：
  - **Time series key**
  - 可选：**Default value**

{% include images-gallery.html imageCollection="step-3-arguments-3" %}

<b><font size="3">Argument name</font></b>

输入 argument 名称 — 在公式和条件中使用的标识符（如 temperature、maxThreshold、deviceEnabled）。

配置完成后点击 **Add**。

{% include images-gallery.html imageCollection="step-3-arguments-4" %}

<hr>

### Trigger conditions

本步骤定义告警规则的核心逻辑：
- 告警**何时**创建
- **何种严重级别**
- 基于 schedule 的**规则生效时间**

点击 **Add trigger condition** 并配置以下参数：

{% include images-gallery.html imageCollection="step-4-creation-conditions-1" %}

<hr>

#### Severity

在 ThingsBoard 中，**alarm severity** 表示告警条件的严重程度，用于确定处理优先级。  
可选严重级别：
- <span style="color:#d12730">Critical</span> — 表示需要**立即处理**的严重情况，如设备故障、安全风险或可能导致数据丢失或系统停机的状态。
- <span style="color:#f66716">Major</span> — 表示对系统运行有较大影响、但**非立即严重**的问题，如性能下降或超出推荐参数运行。
- <span style="color:#faa405">Minor</span> — 用于**稍后监控或处理**的较轻问题，如临时超阈值或预警。
- <span style="color:#f2da05">Warning</span> — 表示**潜在或正在形成**的问题，尚未影响正常运行，但若持续可能需关注。
- <span style="color:#9e9e9e">Indeterminate</span> — 在告警已产生但**无法明确判定严重程度**时使用，常因数据不完整或条件模糊。

合理选择严重级别有助于 IoT 系统的监控、升级和响应。

<b><font size="3">Severity 如何生效</font></b>

严重级别应用于：
- 由规则创建的**新告警**
- 当创建条件以不同标准再次触发时**对已有活动告警的更新**  
  例如，若 *Warning* 告警仍活动，但新条件达到 *Major*，严重级别将提升。

{% include images-gallery.html imageCollection="step-4-creation-conditions-severity-1" %}

<hr>

#### Condition

**Condition** 定义是否创建或更新告警的逻辑，是判断规则是否满足的主表达式。

示例用途：
- <span class="code-light">temperature > 30</span>
- <span class="code-light">device is offline</span>
- 使用多个 arguments、telemetry 字段或 attributes 的复杂表达式  
  （例如 <span class="code-light">temperature > threshold AND doorState == open</span>）

<hr>

<b><font size="3">添加创建条件</font></b>

点击 **Add condition**

通过定义一个或多个 filter 配置告警触发逻辑。

> 可手动创建 filter，或使用 [TBEL](/docs/{{docsPrefix}}user-guide/tbel/){:target="_blank"} 脚本函数实现更复杂的表达式。

点击 **Add argument filter** 并配置：

**1. 常规配置（General configuration）**  
- **Argument** — 要比较的变量（如 temperature）
- **Value type** — 评估值的数据类型（Numeric、Boolean、String 等）

**2. Configure filters**  
在 **Filters** 下点击 **Add** 并指定：
- **Operation** — 比较运算符，如 *equal、not equal、missing for、greater than、less than* 等
- **Value source** — 选择其一：
  - **Static** — 使用固定预定义值
  - **Dynamic** — 使用从另一 argument 获取的值
- **Value** — 指定要比较的值

**组合多个条件**  
添加多个 filter 时，选择逻辑运算符：
- **AND** — 所有条件为真
- **OR** — 至少一个条件为真

添加所有需要的 filter 后点击 **Add** 保存条件。

{% include images-gallery.html imageCollection="step-4-creation-condition-add-filter-1" %}

<b><font size="3">Condition types</font></b>

ThingsBoard 支持**三种**条件类型：

- **Simple**，  
  表达式为真时立即触发，  
  用于即时超阈值。  
  *示例：* <span class="code-light">temperature > 10</span>
- **Duration**，  
  条件需在指定时间段内持续为真，  
  可减少短暂数据尖峰带来的误报。  
  *示例：* <span class="code-light">temperature > 10</span> 持续 60 秒
- **Repeating**，  
  条件满足指定次数后才触发，  
  适用于重复错误比单次事件更重要。  
  *示例：* <span class="code-light">signalLost == true</span> 连续三次

{% include images-gallery.html imageCollection="step-4-creation-condition-types-1" %}

<hr>

#### Schedule

**Schedule** 定义告警创建规则的生效时间段。  
系统仅在当前时间处于允许区间内时才评估创建条件。

> 若创建条件在**定义的时间段之外**为真，告警**不会创建** — 即使逻辑表达式为真。

{% include images-gallery.html imageCollection="step-4-schedule-1" %}

<b><font size="3">Schedule 类型</font></b>

**Static mode**

ThingsBoard 支持三种 schedule 模式：
- **Active all time** — 始终生效
- **Active at a specific time range**
  *示例：* 周一至周五 09:00–18:00
- **Custom schedule** — 为每周每天定义不同时间区间

{% include images-gallery.html imageCollection="step-4-schedule-types-1" %}

**Dynamic mode**

除手动配置 schedule 外，可通过 attribute 或 telemetry 提供 JSON 对象。
适用于不同设备或 Customer 需要不同 schedule 的场景。

**如何启用 Dynamic mode**
- 在 **Schedule** 部分选择 **Dynamic mode**。
- 选择包含所需 schedule 配置 JSON 的 argument（attribute 或 telemetry）。

{% include images-gallery.html imageCollection="step-4-schedule-dynamic-mode-1" %}

<b><font size="3">schedule JSON 示例</font></b>

**1. 始终生效（Active all time）**

JSON 对象可为：

```json
{}
```
{:.copy-code}

或

```json
{
  "type": "ANY_TIME"
}
```
{:.copy-code}

<br>
**2. 特定时间 schedule（Specific time schedule）**

此格式可为选定星期几定义精确时间范围。

**示例：**  
**周二**和**周四**全天生效：

```json
{
  "type": "SPECIFIC_TIME",
  "daysOfWeek": [2, 4],
  "startsOn": 0,
  "endsOn": 0,
  "timezone": "Europe/Kiev"
}
```
{:.copy-code}

**字段说明：**
- **timezone** — 用于解释 schedule 的时区
- **daysOfWeek** — 星期几的数字格式（1–7，1 = 周一）
- **startsOn** — 生效时段开始时间，距当天开始的毫秒数
- **endsOn** — 生效时段结束时间，距当天开始的毫秒数

当 **startsOn** 和 **endsOn** 均设为 **0** 时，表示规则全天生效。

<br>
**3. Custom schedule**

为每一天分别定义时间区间。

**示例：**  
schedule 每天 24 小时生效：

```json
{
  "type": "CUSTOM",
  "timezone": "Europe/Kiev",
  "items": [
    { "dayOfWeek": 1, "enabled": true, "startsOn": 0, "endsOn": 0 },
    { "dayOfWeek": 2, "enabled": true, "startsOn": 0, "endsOn": 0 },
    { "dayOfWeek": 3, "enabled": true, "startsOn": 0, "endsOn": 0 },
    { "dayOfWeek": 4, "enabled": true, "startsOn": 0, "endsOn": 0 },
    { "dayOfWeek": 5, "enabled": true, "startsOn": 0, "endsOn": 0 },
    { "dayOfWeek": 6, "enabled": true, "startsOn": 0, "endsOn": 0 },
    { "dayOfWeek": 7, "enabled": true, "startsOn": 0, "endsOn": 0 }
  ]
}
```
{:.copy-code}

**字段说明：**

- **timezone** — 用于解释 schedule 的时区
- **items** — 包含每天配置的数组

每项包含：
- **dayOfWeek** — 数字格式的星期（Monday = 1、Tuesday = 2 等），schedule 在该日生效
- **enabled** — 规则在该日是否生效
- **startsOn** — schedule 在指定日期生效的起始时间戳（毫秒）
- **endsOn** — schedule 在指定日期生效的结束时间戳（毫秒）

当 **startsOn** 和 **endsOn** 均设为 **0** 时，表示规则全天生效。

<hr>

#### Additional info

**Additional info** 字段可为告警补充有助于事件分析或故障排查的上下文数据。
该信息与告警一并存储，并在告警详情视图中显示，便于运维、技术人员和分析师高效工作。

**可添加的有用内容示例：**
- 运维备注
- 故障排查步骤
- 文档链接
- 上下文字段，如：
  - zone ID
  - 关键阈值说明
  - 负责人

<hr>

#### Mobile dashboard

该选项定义用户查看告警时，ThingsBoard 移动应用中将打开的 **mobile dashboard**。

<b><font size="3">工作方式</font></b>

选择 mobile dashboard 后：
- 进入告警时移动应用会自动打开该 dashboard
- 用户可立即看到相关部件与指标
- 故障排查更快捷

<b><font size="3">示例场景</font></b>

- **High Temperature** 告警的诊断 dashboard
- 面向技术人员的带控制按钮的 dashboard
- 移动 asset 的地理位置 dashboard

<b><font size="3">特别适用于：</font></b>
- 现场工程师响应告警
- 需快速诊断
- 监控分布式设备（如冰箱、传感器、车辆）

<hr>

### Clear condition

**Clear condition** 定义 ThingsBoard 将告警自动切换为 **Cleared（已清除）** 状态的逻辑。

若未配置清除条件，告警**永远不会**自动清除，即使监控值已恢复正常。  
此类情况下，告警只能通过 UI 或 API 手动清除。

点击 **Add clear condition** 并配置以下参数：

{% include images-gallery.html imageCollection="step-5-clear-conditions-1" %}

<br><b><font size="4">步骤 5.1 清除条件</font></b>

清除条件规定**何时将告警视为已解决**，并可安全切换至 *Cleared* 状态。

**清除条件示例：**
 - <span class="code-light">temperature ≤ 30</span>
- 值恢复正常范围
- device 连接恢复
- 涉及多个 argument 的复杂表达式

<hr>

<b><font size="3">添加清除条件</font></b>

点击 **Add condition** 定义告警清除逻辑。

通过添加一个或多个 filter 配置清除条件。  
可手动创建 filter，或使用 TBEL 脚本函数实现更复杂场景。

**1. 常规配置**   
点击 **Add argument filter** 并指定：
- **Argument** — 要评估的变量（如 temperature）
- **Value type** — 期望的输入类型（Numeric、Boolean、String 等）

**2. 配置 filters**   
在 **Filters** 部分点击 **Add** 并设置：
- **Operation** — 比较运算符，如 *equal、not equal、missing for、greater than、less than、greater or equal、less or equal、starts with、ends with、contains、not contains、in、not in*
- **Value source：**
  - **Static** — 使用固定值
  - **Dynamic** — 使用从另一 argument 获取的值
- **Value** — 要比较的值

**组合多个条件**   
若添加多个 filter，选择逻辑运算符：
- **AND** — 所有条件必须为真
- **OR** — 至少一个条件必须为真

添加所有需要的 filter 后点击 **Add** 保存清除条件。

{% include images-gallery.html imageCollection="step-5-clearing-condition-add-filter-1" %}

**条件类型**

ThingsBoard 支持与告警创建相同的条件类型：
- **Simple** — 条件为真时立即清除
- **Duration** — 需持续满足指定时长后才清除
- **Repeating** — 条件需满足指定次数后才清除

{% include images-gallery.html imageCollection="step-5-clearing-condition-types-1" %}

完成所有必要配置后，点击 **Save** 保存清除条件。

<hr>

<b><font size="4">步骤 5.2 Schedule</font></b>

**Clear Schedule（清除 Schedule）** 定义清除条件**何时**允许触发。

**示例场景：**
- 仅在工作时间允许自动清除
- 仅在夜间允许清除
- 限定在特定时间段内才能清除

> 若清除条件在允许的 schedule 之外为真，告警将不会被清除

{% include images-gallery.html imageCollection="step-5-schedule-1" %}

<hr>

<b><font size="4">步骤 5.3 Additional info</font></b>

此区块用于附加将在告警清除时存储于 **Alarm Details** 中的额外数据。

适用于：
- 维护结构化事件日志
- 添加运维备注
- 保存额外诊断上下文
- 提供后续操作提示

支持使用 *${attributeName}* 动态占位符。

<hr>

<b><font size="4">步骤 5.4 Mobile dashboard</font></b>

定义在 ThingsBoard 移动应用中查看已清除告警时打开的 mobile dashboard。

适用于以下场景：
- 清除后需展示额外诊断信息
- 运维人员需确认系统恢复
- 用户需跳转至其他场景或 dashboard

<hr>

### 配置高级设置

在此步骤中，可定义**alarm propagation（告警传播）** — 告警如何在系统内其他实体间分布。  
传播决定了**谁可以看到告警**以及告警在**实体层级的哪一层**可见。

这对于多级 asset 结构、customer 层级、企业环境和 MSP 部署尤为重要。

<hr>

<b><font size="3">可用的传播选项</font></b>

<b><font size="3">Propagate alarm to related entities</font></b>

启用后，告警对 originator 的**所有相关实体**可见，与关系类型无关。

适用于：
- **Device** 已分配给 **Asset**
- **Asset** 已关联至 **Customer**
- 希望告警在互连实体间可见

这确保关系图中的所有实体（如 *Device &#8702; Office &#8702; Building*）均可查看和处理告警。

{% include images-gallery.html imageCollection="step-6-propagate-alarm-1" %}

<hr>

<b><font size="3">Propagate alarm to the owner (Customer / Tenant)</font></b>

使告警对 originator 的**直接所有者**可见 — 即 **Customer** 或 **Tenant**。

所有者可查看其管理的所有 devices/assets 的告警，**无需额外建立关系**。

{% include images-gallery.html imageCollection="step-6-propagate-alarm-2" %}

<hr>

{% if docsPrefix == "pe/" or docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}
<b><font size="3">Propagate alarm to entity owners hierarchy</font></b>

将告警**沿完整所有权链向上传播**，确保在每一级父级都可见：  
**Asset &#8702; Customer &#8702; Tenant**

**适用于：**
- 具有嵌套 customer 结构的 **B2B 平台**
- **MSP（托管服务提供商）** 部署
- 具有多级组织层级的**大型企业**

所有上级所有者均可看到告警，即使与 originator 无直接关系。

{% include images-gallery.html imageCollection="step-6-propagate-alarm-3" %}

<hr>
{% endif %} 

<b><font size="3">Propagate alarm to Tenant</font></b>

使告警在 **Tenant 级别**可见，与所有权或关系无关。

**适用于：**
- Tenant 管理员需查看**所有关键事件**
- 需要**整个基础设施的集中概览**

此为最全局的可见性选项。

{% include images-gallery.html imageCollection="step-6-propagate-alarm-4" %}

<hr>

### 保存规则

点击 **Add** 保存规则配置。

保存后，ThingsBoard 将根据您定义的条件、schedule 和传播设置自动创建、更新和处理告警。

{% include images-gallery.html imageCollection="step-7-save-rule-1" %}

<hr>

## 管理告警规则

创建告警规则后，其会出现在 **Alarms &#8702; Alarm rules** 页面的表格中。  
在此可快速查看每条规则的关键参数 — alarm type、目标实体、严重级别、是否配置清除条件 — 并使用一组可用操作管理规则。

每条规则行都包含操作面板，用于复制、导出、调试、编辑或删除配置。

每条告警规则都包含用于管理的操作栏：
1. **Copy alarm rule configuration** — 复制规则配置，便于基于现有规则快速创建新规则
2. **Export** — 将规则导出为 JSON 文件，用于备份或迁移至其他 ThingsBoard 实例
3. **Events** — 打开与规则关联的事件日志，包括触发、清除、状态变更和错误
4. **Debug configuration** — 启用调试模式，提供详细执行信息用于故障排查
5. **Edit** — 打开规则编辑器，可修改任意配置参数
6. **Delete** — 从系统中移除告警规则

{% include images-gallery.html imageCollection="alarm-rules-parameters-1" %}

<br><b><font size="4">查看告警规则详情</font></b>

点击告警规则可查看其详细信息。

{% include images-gallery.html imageCollection="alarm-rules-parameters-2" %}

<br><b><font size="4">编辑告警规则</font></b>

要修改告警规则，点击该规则，告警规则详情窗口将打开。  
点击 **橙色铅笔** 图标切换到 **edit mode**。

完成所需修改后，点击 **橙色对勾** 图标应用并保存更改。

{% include images-gallery.html imageCollection="alarm-rules-parameters-3" %}

<hr>

## 导出 / 导入告警规则

可将告警规则**导出**为 JSON 文件，并**导入**到同一或其他 ThingsBoard 实例中。

<br><b><font size="4">导出告警规则</font></b>

- 进入 **Alarms** 页面 &#8702; **Alarm rules** 选项卡
- 在对应告警规则行中点击 **Export** 按钮

{% include images-gallery.html imageCollection="export-alarm-rule-1" %}

<br><b><font size="4">导入告警规则</font></b>

ThingsBoard 支持以 JSON 格式导入此前导出的告警规则，便于实例间配置迁移、快速部署标准告警模板以及从备份恢复。

导入步骤：
- 进入 **Alarms** 页面 &#8702; **Alarm rules** 选项卡
- 点击右上角「**+**」按钮，在下拉菜单中选择 **Import alarm rule**
- 在导入对话框中拖放 JSON 文件或手动选择包含告警规则配置的文件
- 点击 **Import** 上传配置
- 在打开的对话框中指定告警规则将应用到的实体或 profile
- 点击 **Add** 保存规则

保存后，规则将立即生效，ThingsBoard 将根据其配置逻辑开始应用。

{% include images-gallery.html imageCollection="import-alarm-rule-1" %}

<hr>

## 告警规则配置示例

为更好地理解告警规则的工作方式，下面介绍若干实用示例。每个示例演示特定场景、条件类型或可在实际项目中使用的告警规则功能。

在以下场景中，我们将在**设备上直接**创建告警规则。

{% capture difference %}
**建议：** 若同一规则需应用于多个设备，请在 **Device Profile** 级别创建。  
这可实现告警逻辑集中管理、减少重复并简化持续维护。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

<b><font size="4">准备工作</font></b>

以下示例需要一台名为 **Thermometer**、发送 **temperature** telemetry 的设备。
1. 下载 CSV 文件：[thermometer-device-data.csv](/docs/user-guide/resources/alarm-rules/thermometer-device-data.csv){:target="_blank" download="thermometer-device-data.csv"}
2. 进入「Devices」并[导入](/docs/user-guide/bulk-provisioning/){:target="_blank"} CSV 文件。

**CSV 包含：**
- **Name：** Thermometer
- **Type：** thermostat
- **Time series：** <span class="code-light">temperature</span>

> **关于 CSV 的重要说明：**<span class="code-light">temperature</span> 键的列类型必须设为「**Time series**」。

{% include images-gallery.html imageCollection="alarm-rules-example-prepare-device-1" %}

<hr>

### 示例1. 简单告警条件：
*温度监控 {: #example-1-simple-alarm-condition-temperature-monitoring }*

**场景：**   
冷库用于存储易腐商品，内部温度需持续监控以防止货损并维持适宜存储条件。

**目标：**   
当温度超过 **10°C** 时创建 **critical** 告警。

<hr>

<b><font size="3">步骤 1. 创建告警规则</font></b>

- 从左侧菜单打开 **Alarms** 页面
- 进入 **Alarm rules** 选项卡
- 点击右上角「**+**」按钮
- 在下拉菜单中选择 **Create new alarm rule**

<b><font size="3">步骤 2. General 部分</font></b>

在 **General** 部分指定：
- **Alarm type：** *High Temperature*
- 选择 **Target entity type** — Device
- 指定规则应用的 **entity** — Thermometer

<b><font size="3">步骤 3. 添加 argument</font></b>

- 在 **Arguments** 部分点击 **Add argument** 并填写：
  - **Argument name：** temperature
  - **Entity type：** *Current entity*
  - **Argument type：** *Latest telemetry*
  - **Time series key：** <span class="code-light">temperature</span>
- 完成后点击 **Add**

这将创建可在规则逻辑条件中使用的 <span class="code-light">temperature</span> 变量。

<b><font size="3">步骤 4. 配置触发条件</font></b>

在 **Trigger condition** 部分点击 **Add trigger condition**。

**步骤 4.1 Severity**  
- **Severity：** *Critical*

**步骤 4.2 Condition**

点击「**Add condition**」。

在 filter 配置窗口中点击 **Add argument filter** 并指定：
- **Argument：** <span class="code-light">temperature</span>
- **Value type：** *Numeric*
- **Operation：** *greater than*
- **Value：** 10
- 点击 **Add**

**Type：** *Simple*  
- 点击 **Save**

配置完成后，温度超过 **10°C** 时将立即创建告警。

<b><font size="3">步骤 5. 保存规则</font></b>

点击 **Add** 保存规则。

<hr>

<b><font size="4">结果</font></b>

保存后，当 <span class="code-light">temperature</span> 值超过 **10°C** 时，ThingsBoard 将自动创建 critical 告警。

{% include images-gallery.html imageCollection="alarm-rules-example-simple-1" %}

<hr>

### 示例2. 告警清除条件

*延续示例[简单告警条件：温度监控](#example-1-simple-alarm-condition-temperature-monitoring)*

**场景**   
冰箱用于存储易腐产品。critical **High Temperature** 告警触发后，当温度恢复至安全水平时必须自动清除。

**目标**   
在现有 **High Temperature** 规则中添加清除条件，当温度为 **≤ 4°C** 时将告警设为 **Cleared**。

<hr>

<b><font size="3">步骤 1. 打开 High Temperature 规则</font></b>

- 在侧边菜单中进入 **Alarm** &#8702; **Alarm rules**
- 在列表中找到 **High Temperature** 规则
- 点击 **Edit** 图标（铅笔）打开规则编辑器

<b><font size="3">步骤 2. 配置清除条件</font></b>

滚动到 **Clear condition** 部分：
- 点击 **Add clear condition**
- 点击「**Add condition**」打开配置窗口

<b><font size="3">步骤 2.1 添加 filter</font></b>

在配置窗口中点击 **Add argument filter** 并指定：
- **Argument：** <span class="code-light">temperature</span>
- **Value type：** *Numeric*
- **Operation：** *less or equal*
- **Value：** 4

此条件定义温度恢复至安全水平的时刻。点击 **Add**

**Type：** *Simple*  
- 点击 **Save**

此后，温度降至 **4°C 或以下**时将立即清除告警。

<b><font size="3">步骤 3. 保存规则</font></b>

点击 **Apply** 保存更新后的规则。

<hr>

<b><font size="4">结果</font></b>

保存后，ThingsBoard 将：
- 温度超过 **10°C** 时创建 **Critical** — **High Temperature** 告警
- 温度为 **≤ 4°C** 时自动清除告警

此配置形成完整的告警生命周期，保持系统状态准确，无需人工干预。

{% include images-gallery.html imageCollection="alarm-rule-example-clear-condition-1" %}

<hr>

### 示例3. 带持续时长的告警条件

*延续示例[简单告警条件：温度监控](#example-1-simple-alarm-condition-temperature-monitoring)*

**目标：**   
更新现有 **High Temperature** 规则，使其仅在温度超过阈值并持续指定时长（如 **1 分钟**）时触发。  
此机制有助于避免因短暂温度尖峰引起的误报。

<hr>

<b><font size="3">步骤 1. 打开 High Temperature 规则</font></b>

- 在侧边菜单中进入 **Alarm** &#8702; **Alarm rules**
- 在列表中找到 **High Temperature** 规则
- 点击 **Edit** 图标（铅笔）打开规则编辑器

<b><font size="3">步骤 2. 配置触发条件</font></b>

滚动到 **Trigger condition** 部分，编辑现有条件：
- **Condition type：** 将 *Simple* 改为 **Duration**
- **Duration value：** 1
- **Time unit：** *Minutes*
- 点击 **Save** 应用更新后的告警条件设置

此后，告警仅在温度**连续 60 秒**超过阈值时才会触发。

<b><font size="3">步骤 3. 保存更新后的规则</font></b>

点击 **Apply** 保存更新后的规则配置。

<hr>

<b><font size="4">结果</font></b>

保存后，ThingsBoard 将：
- 仅在温度超过阈值并持续 **整整 1 分钟**时创建 **High Temperature** 告警
- 忽略短暂的随机温度尖峰
- 提供更稳定、误报更少的告警系统

{% include images-gallery.html imageCollection="alarm-rules-example-condition-duration-1" %}

<hr>

### 示例4. 带动态持续时长的告警

*延续示例[带持续时长的告警条件](#example-3-alarm-condition-with-a-duration)*

**场景**   
已配置 **High Temperature** 告警，在温度超过阈值并持续 **1 分钟**时触发。  
本示例将该逻辑扩展为**动态** duration — 即触发告警所需的时长由设备上的 **server attribute** 定义。

**目标**   
更新 High Temperature 规则，使：
- 仅在温度在设备 <span class="code-light">highTemperatureDurationThreshold</span> [server attribute](/docs/{{docsPrefix}}user-guide/attributes/#server-side-attributes){:target="_blank"} 中指定的时长内持续高于临界阈值时创建告警
- 无需编辑告警规则即可调整 duration，仅需更新设备的 attribute 值

<hr>

**准备工作**   
为 **Thermometer** 设备添加 **server attribute**：
- **Key：** <span class="code-light">highTemperatureDurationThreshold</span>
- **Value type：** *Integer*
- **Value：** 2

{% include images-gallery.html imageCollection="alarm-rules-example-condition-with-dynamic-duration-1" %}

此值将作为 duration 要求供告警规则使用。

<hr>

<b><font size="3">步骤 1. 打开 High Temperature 规则</font></b>

- 在侧边菜单中进入 **Alarm** &#8702; **Alarm rules**
- 在列表中找到 **High Temperature** 规则
- 点击 **Edit** 图标（铅笔）打开规则编辑器

<b><font size="3">步骤 2. 添加 argument</font></b>

在 **Arguments** 部分：
- 点击 **Add argument**
- 填写字段：
  - **Entity type：** *Current entity*
  - **Argument type：** *Attribute*
  - **Attribute scope：** *Server attributes*
  - **Attribute key：** <span class="code-light">highTemperatureDurationThreshold</span>
  - **Argument name：** highTemperatureDurationThreshold
- 点击 **Add**

现在拥有可在 **Duration** 条件中使用的动态变量。

<b><font size="3">步骤 3. 配置触发条件</font></b>

滚动到 **Trigger condition** 部分，编辑现有条件：
- **Condition type：** *Duration*
- **Value type：** 将 *Static* 改为 **Dynamic**
- **Value：** 指定 argument <span class="code-light">highTemperatureDurationThreshold</span>
- **Unit：** *Minutes*
- 在条件块内点击 **Save**

此后，触发告警所需的 duration 由设备 attribute 决定，而非固定数值。

<b><font size="3">步骤 4. 保存规则</font></b>

点击 **Apply** 保存更新后的配置。

<hr>

<b><font size="4">结果</font></b>

保存后，ThingsBoard 将：
- 在以下情况下创建 **High Temperature** 告警：温度
  - 超过阈值（如 >10°C），**且**
  - 在 <span class="code-light">highTemperatureDurationThreshold</span> attribute 定义的时长内（如 2 分钟）保持高于阈值

这确保告警仅响应**持续偏差**，而非短期传感器尖峰。

{% include images-gallery.html imageCollection="alarm-rules-example-condition-with-dynamic-duration-2" %}

<hr>

### 示例5. 带重复条件的告警

*延续示例[简单告警条件：温度监控](#example-1-simple-alarm-condition-temperature-monitoring)*

**目标：**   
更新 **High Temperature** 规则，使告警仅在阈值条件连续满足指定次数时创建。  
有助于过滤随机传感器尖峰，仅响应重复或持续的偏差。

<hr>

<b><font size="3">步骤 1. 打开 High Temperature 规则</font></b>

- 在侧边菜单中进入 **Alarm** &#8702; **Alarm rules**
- 在列表中找到 **High Temperature** 规则
- 点击 **Edit** 图标（铅笔）打开规则编辑器

<b><font size="3">步骤 2. 编辑触发条件</font></b>

更改以下参数以更新现有触发条件：
- **Condition type：** *Repeating*
- **Count of events：** 3  
点击 **Save** 应用更改。

此配置下，ThingsBoard 将在创建告警前检查阈值条件是否**连续三次**满足。

<b><font size="3">步骤 3. 保存规则</font></b>

点击 **Apply** 保存更新后的配置。

<hr>

<b><font size="4">结果</font></b>

保存后，ThingsBoard 行为如下：
- 仅在条件**连续 3 次**满足时创建 **High Temperature** 告警
- 单次或随机温度尖峰不会触发告警

{% include images-gallery.html imageCollection="alarm-rules-example-condition-repeating-1" %}

<hr>

### 示例6. 定义告警规则 schedule

*延续示例[简单告警条件：温度监控](#example-1-simple-alarm-condition-temperature-monitoring)*

**目标：**   
更新 **High Temperature** 规则，使告警**仅在工作时间**触发。  
适用于仅在特定时段（如员工工作时间）需要监控的场景。

<hr>

<b><font size="3">步骤 1. 打开 High Temperature 规则</font></b>

- 在侧边菜单中进入 **Alarm** &#8702; **Alarm rules**
- 在列表中找到 **High Temperature** 规则
- 点击 **Edit** 图标（铅笔）打开规则编辑器

<b><font size="3">步骤 2. 配置告警规则 schedule</font></b>

滚动到 **Trigger condition** 部分，打开 **Schedule** 设置。
- **选择 schedule 类型：** *Active at a specific time*
- 配置工作时间：
  - **Timezone：** Europe/Kiev (UTC+02:00)
  - **Days：** Monday、Tuesday、Wednesday、Thursday、Friday
  - **Time range：**
    - **From：** 10:00
    - **To：** 19:00
- 点击 **Save** 应用 schedule 配置。

此配置下，规则**仅在工作日 10:00 至 19:00** 生效。  
在此时间区间外，即使 <span class="code-light">temperature > 10°C</span> 为真，系统也**不会**创建 **High Temperature** 告警。

<b><font size="3">步骤 3. 保存规则</font></b>

点击 **Apply** 保存更新后的配置。

<hr>

<b><font size="4">结果</font></b>

保存后，ThingsBoard 将：
- 仅在工作日 **10:00 至 19:00** 激活 **High Temperature** 规则
- 忽略发生在此时间窗口外的温度阈值违规

{% include images-gallery.html imageCollection="alarm-rules-example-schedule-1" showListImageTitles="true" %}

<hr>

### 示例7. 高级阈值

*延续示例[简单告警条件：温度监控](#example-1-simple-alarm-condition-temperature-monitoring)*

**目标：**   
更新 **High Temperature** 规则，添加通过设备级 server attribute 启用或禁用告警的能力。

本示例中，告警应**仅当以下两个条件均为真**时触发：
1. <span class="code-light">temperatureAlarmFlag == true</span>
2. <span class="code-light">temperature > 10°C</span>

这使您可灵活控制特定设备的告警是否激活 — **无需编辑规则**。

<hr>

**准备工作**   
为 **Thermometer** 设备添加 **server attribute**：
- **Key：** <span class="code-light">temperatureAlarmFlag</span>
- **Type：** Boolean
- **Value：** `true`

此 attribute 决定告警规则对该设备是否生效。

{% include images-gallery.html imageCollection="alarm-rules-example-advanced-thresholds-1" %}

<hr>

<b><font size="3">步骤 1. 打开 High Temperature 告警规则</font></b>

- 在侧边菜单中进入 **Alarm** &#8702; **Alarm rules**
- 在列表中找到 **High Temperature** 规则
- 点击 **Edit** 图标（铅笔）打开规则编辑器

<b><font size="3">步骤 2. 添加 argument</font></b>

在 **Arguments** 部分：
- 点击 **Add argument**
- 填写字段：
  - **Entity type：** *Current entity*
  - **Argument type：** *Attribute*
  - **Attribute scope：** *Server attributes*
  - **Attribute key：** <span class="code-light">temperatureAlarmFlag</span>
  - **Argument name：** temperatureAlarmFlag
- 点击 **Add**

现在拥有可在告警条件中使用的布尔变量。

<b><font size="3">步骤 3. 配置触发条件</font></b>

滚动到 **Trigger condition** 部分，编辑现有条件。

添加另一条件：
- 点击 **Add argument filter** 并配置：
  - **Argument：** <span class="code-light">temperatureAlarmFlag</span>
  - **Value type：** *Boolean*
  - **Operation：** *equal*
  - **Value：** `true`
- 点击 **Add**

此 filter 决定告警是否允许针对该设备触发。

<b><font size="3">步骤 4. 保存规则</font></b>

点击 **Apply** 保存更新后的配置。

<hr>

<b><font size="4">结果</font></b>

保存后，ThingsBoard 将：
- 仅在以下情况下创建 High Temperature 告警：
  - <span class="code-light">temperatureAlarmFlag == true</span>，且
  - <span class="code-light">temperature</span> 超过 **10°C**
- 若 temperatureAlarmFlag == false，则对该设备完全忽略该规则，即使超过阈值

{% include images-gallery.html imageCollection="alarm-rules-example-advanced-thresholds-2" %}

<hr>

<b><font size="4">此方法的优势</font></b>

- 可**无需编辑规则**即启用或禁用告警
- 每台设备可有各自的告警激活状态
- 适用于设备间告警策略各异的大型项目
- 便于与 dashboard 集成 — 运维人员可通过简单开关切换告警

<hr>

## 后续步骤

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 反馈

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 点赞，帮助我们传播。  
如有任何问题，请[联系我们](/docs/contact-us/){:target="_blank"}。