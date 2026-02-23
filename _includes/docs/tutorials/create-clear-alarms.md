* TOC
{:toc}

## 使用场景

假设您的制冷设备配备温度传感器，定期向 ThingsBoard 上报遥测数据。

正常工作温度范围为 2 °C 至 5 °C。若上报温度超出此范围，应视为异常状态。

目标是：
- 当温度低于 **2 °C** 或高于 **5 °C** 时**创建告警**
- 当温度回到可接受范围内时**自动清除告警**

虽然示例做了简化，但展示了适用于**冷藏存储**、**食品物流**和**工业制冷系统**等实际 IoT 部署场景的**通用遥测监控模式**。

为突出平台能力而非手动配置，本指南使用可[导入](/docs/{{docsPrefix}}user-guide/alarm-rules/#export--import-alarm-rule){:target="_blank"}到 ThingsBoard 的**预设告警规则配置**。
您可快速理解告警规则的工作方式，查看其逻辑，并在自己的 IoT 场景中复用或调整。

<hr>

## 前置条件

在继续前，请先阅读 [告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"} 文档，了解本指南中使用的告警创建、触发条件和告警生命周期管理概念。

此外，需要有一台设备用于测试告警触发，可使用现有设备或按以下步骤[新建设备](/docs/{{docsPrefix}}user-guide/ui/devices/#adding-new-device){:target="_blank"}：
1. 进入 **实体 &#8702; 设备**。
2. 点击右上角 **「&#43; 添加设备」** 按钮，选择 **「添加新设备」**。
3. 使用如下参数创建设备：   
   &#8194;&#8226;&#8194;**设备名称**：Thermometer   
   &#8194;&#8226;&#8194;**设备配置文件**：thermostat
4. 点击 **添加** 完成创建。

设备即可上报遥测并用于告警规则测试。

> **建议**：在设备配置文件级别应用告警规则，避免为多台同类型设备重复配置，并保证告警行为一致。

<hr>

## 告警规则配置

需要创建两条独立的告警规则，分别负责不同温度阈值和告警类型。

<b><font size="3">高温告警规则</font></b>   
- **告警类型**：高温
- **创建告警条件**：温度 > 5 °C
- **清除告警条件**：温度 ≤ 5 °C

<b><font size="3">低温告警规则</font></b>   
- **告警类型**：低温
- **创建告警条件**：温度 < 2 °C
- **清除告警条件**：温度 ≥ 2 °C

每次收到目标实体的遥测时都会评估告警规则：
- 读取上报的温度值
- 与创建和清除条件进行比较
- 若满足条件，则创建、更新或清除告警

## 步骤 1. 导入高温告警规则

1. 下载 [高温告警规则](/docs/user-guide/resources/guides/high_temperature_alarm_rule.json){:target="_blank" download="high_temperature_alarm_rule.json"} 配置文件。
2. 进入 **告警 &#8702; 告警规则**。
3. 点击右上角 **「&#43; 添加告警规则」**，选择 **「导入告警规则」**。
4. 指定您的**设备**或**设备配置文件**作为目标实体。
5. 点击 **添加** 完成导入。

## 步骤 2. 导入低温告警规则

1. 下载 [低温告警规则](/docs/user-guide/resources/guides/low_temperature_alarm_rule.json){:target="_blank" download="low_temperature_alarm_rule.json"} 配置文件。
2. 在 **告警 &#8702; 告警规则** 中点击 **「&#43; 添加告警规则」**，选择 **「导入告警规则」**。 
3. 指定您的**设备**或**设备配置文件**作为目标实体。
4. 点击 **添加**。

## 验证告警触发

要验证告警规则是否正常，请上报若干温度值。   
最简单的方式是使用 [检查连接](/docs/{{docsPrefix}}user-guide/ui/devices/#check-connectivity){:target="_blank"}。也可使用以下命令：

⚠️ 请将 {% unless docsPrefix contains "paas/" %}   
&#8194;&#8226;&#8194;**$THINGSBOARD_HOST_NAME** 替换为您的 ThingsBoard 主机名或 IP 地址。   
&#8194;&#8226;&#8194;{% endunless %}**$ACCESS_TOKEN** 替换为设备访问令牌。

1. 触发高温告警。   
   上报超过上限的温度值（例如 7 °C）。
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:7}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:7}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:7}"
   ```
   {: .copy-code}
   {% endif %}

2. 清除高温告警。   
   上报正常范围内的温度值（例如 4 °C）。
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:4}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:4}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:4}"
   ```
   {: .copy-code}
   {% endif %}


3. 触发低温告警。   
   上报低于下限的温度值（例如 1 °C）。
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:1}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:1}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:1}"
   ```
   {: .copy-code}
   {% endif %}


4. 清除低温告警。   
   再次上报可接受范围内的温度值（例如 4 °C）。
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:4}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:4}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:4}"
   ```
   {: .copy-code}
   {% endif %}

每步完成后，在 **告警** 页面、设备详情内的对应标签页或 dashboard 上查看告警状态，确认行为正确。

<hr>

## 另请参阅

- [验证并过滤入站遥测](/docs/{{docsPrefix}}tutorials/validate-incoming-telemetry){:target="_blank"}
- [告警事件时发送邮件通知](/docs/{{docsPrefix}}tutorials/send-email/){:target="_blank"}

<hr>

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}
