* TOC
{:toc}

本指南介绍如何在 ThingsBoard 中计算遥测值之间的差值（delta），并将该计算结果用于自动触发和清除告警。

本指南为入门级，重点演示平台核心能力，而非从零构建配置。   
因此，在设置过程中将提供并导入预设的 calculated fields 和 alarm rules 配置。

将上述配置导入 ThingsBoard 实例后，可查看其结构、逻辑和行为，并据此适配自己的使用场景。

<hr>

## 使用场景

假设设备配备温度传感器，定期向 ThingsBoard 发送遥测数据。

需要：
- 在固定时间窗口（例如 15 分钟）内监控温度变化。
- 当温度变化超过设定阈值（5 °C）时触发告警。
- 当值恢复正常时自动清除告警。

该流程代表常见的实时监控与异常检测场景，并可扩展以支持更高级用例。

<hr>

## 前置条件

在继续前，建议先阅读以下 ThingsBoard 文档：
- [Calculated fields](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}：了解如何基于 incoming 数据计算新的遥测值。
- [告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules){:target="_blank"}：了解如何定义告警触发条件，以快速响应异常状态。

以上概念对理解下述配置至关重要。

<hr>

## 步骤 1. 添加演示设备

先添加一台上报温度遥测的演示设备。

该设备作为 calculated field 和 alarm rules 使用的遥测数据来源。

<b><font size="3">操作</font></b>

1. 进入 **Entities** **&#8702;** **Devices**。
2. 点击右上角 **「&#43; Add device」** 按钮，选择 **「Add new device」** 并创建：   
&#8194;&#8226;&#8194;**Device name**: Thermometer   
&#8194;&#8226;&#8194;**Device profile**: thermostat

设备将在 ThingsBoard 中注册，并可以上报遥测数据。

<hr>

## 步骤 2. 导入用于遥测 delta 的 calculated field

所提供的配置在最近 15 分钟内计算温度 delta，并将结果存储为新的遥测键：<span class="code-light">deltaTemperature</span>。

<b><font size="3">操作</font></b>

1. 下载 calculated field 配置文件：   
   [telemetry_delta_calculation_cf.json](/docs/user-guide/resources/guides/telemetry_delta_calculation_cf.json){:target="_blank" download="telemetry_delta_calculation_cf.json"}。
2. 进入 **Calculated fields** 页面。
3. 点击右上角 **「&#43; Add calculated field」** 按钮，选择 **「Import calculated field」**。
4. [上传 calculated field 配置文件](/docs/{{docsPrefix}}user-guide/calculated-fields/#export--import-calculated-field){:target="_blank"}。
5. 选择 <span class="code-light">thermostat</span> [device profile](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"} 作为目标实体，以便 calculated field 自动应用到所有相关设备。
6. 点击 **Add** 完成导入。

<b><font size="3">计算逻辑</font></b>
   
Calculated field 脚本：
- 收集最近 5 分钟内的温度值
- 使用时间窗口内的首个和末个值
- 计算两者差值
- 将绝对值存储为遥测

**本示例使用的脚本**

function calculate(ctx, altitude, temperature) {
```js
var delta = 0;

if (temperature.values.size() >= 2) {
  delta = temperature.last - temperature.first;
}

return {
  "deltaTemperature": Math.abs(toInt(delta))
}
```
{: .copy-code}
}

**要点**
- 若可用值少于两个，delta 设为 <span class="code-light">0</span>
- 脚本可应对稀疏遥测
- 结果作为 **time series telemetry** 存储并自动更新

<hr>

## 步骤 3. 配置基于遥测 delta 的告警规则

配置对 <span class="code-light">deltaTemperature</span> 键值变化做出响应的 [alarm rule](/docs/{{docsPrefix}}user-guide/alarm-rules){:target="_blank"}。

**告警逻辑**：   
&#8194;&#8226;&#8194;当 <span class="code-light">deltaTemperature ≥ 5</span> 时触发告警   
&#8194;&#8226;&#8194;当 <span class="code-light">deltaTemperature < 5</span> 时清除告警

**操作**
1. 下载 alarm rule 配置文件：   
   [temperature_deviation_alarm_rule.json](/docs/user-guide/resources/guides/temperature_deviation_alarm_rule.json){:target="_blank" download="temperature_deviation_alarm_rule.json"}。
2. 进入 **Alarms** **&#8702;** **Alarm rules**。
3. [上传 alarm rule 配置文件](/docs/{{docsPrefix}}user-guide/alarm-rules/#export--import-alarm-rule){:target="_blank"}。
4. 为 <span class="code-light">thermostat</span> [device profile](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"} 配置 alarm rule，以确保其一致应用于使用该 profile 的所有设备。
5. 点击 **Add**。

导入后，告警生命周期由 ThingsBoard 自动管理。

<hr>

## 步骤 4. 验证配置

为确认一切正常，请在 15 分钟内发布两个温度值。

**验证步骤**

1. 发布初始温度值（例如 25）。   
   最简单的方式是使用 [check connectivity](/docs/{{docsPrefix}}user-guide/ui/devices/#check-connectivity){:target="_blank"} 功能。也可执行以下命令：   
   > **请勿忘记替换**：   
   &#8194;&#8226;&#8194;<code>{{HOST_NAME}}</code> 为您的 ThingsBoard{% if docsPrefix == "edge/" or docsPrefix == "pe/edge/" %} Edge{% endif %} 主机名或 IP 地址。   
   &#8194;&#8226;&#8194;<code>$ACCESS_TOKEN</code> 为设备的 access token。

   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:25}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:25}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:25}"
   ```
   {: .copy-code}
   {% endif %} 

2. 打开设备的 **Latest telemetry** 标签页，实时监控 incoming 数据。   
   此时应能看到以下遥测键：
   - <span class="code-light">temperature = 25</span>
   - <span class="code-light">deltaTemperature = 0</span>

3. 在 15 分钟内发布第二个温度值（例如 32）。   
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:32}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:32}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:32}"
   ```
   {: .copy-code}
   {% endif %}

4. 第二次更新后：   
   &#8194;&#8226;&#8194;<span class="code-light">deltaTemperature = 7</span>。因超过阈值而触发告警
5. 打开 **Alarms** 标签页验证告警状态。

一旦 <span class="code-light">deltaTemperature</span> 键值小于 <span class="code-light">5</span>，告警将自动清除。

<hr>

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}
