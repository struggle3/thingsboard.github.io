* TOC
{:toc}

本指南介绍如何在 ThingsBoard 中验证 incoming telemetry 数据，并在存储前丢弃无效值。

以 Thermometer 温度传感器的温度读数为例，确保仅将支持范围内的值存入数据库。

本指南为入门级，重点演示平台核心能力，而非从零构建配置。    
因此，在设置过程中将提供并导入预设的 rule chain 配置。

将上述配置导入 ThingsBoard 实例后，可查看其结构、逻辑和行为，并据此适配自己的使用场景。

<hr>

## 使用场景

假设设备配备 Thermometer 温度传感器，定期向 ThingsBoard 发送遥测。

Thermometer 传感器支持 -40 °C 至 +80 °C 的温度测量。

目标是：
- 仅在温度值处于有效范围内时，接受并存储温度读数
- 丢弃超出范围的遥测值
- 其他不含温度字段的遥测数据均原样放行

虽然示例简化，但展示了可应用于实际 IoT 部署的常见遥测验证模式。

<hr>

## 前置条件

在继续前，请阅读 [Rule Engine](/docs/user-guide/rule-engine-2-0/overview/){:target="_blank"} 文档，了解本示例中使用的消息路由与处理概念。

<hr>

## 验证逻辑

Incoming 消息可能**包含或未包含** <span class="code-light">temperature</span> 字段。   
遥测验证遵循以下规则：
- 若消息**不包含** <span class="code-light">temperature</span>，则视为**有效**
- 若存在 <span class="code-light">temperature</span> 键，其值必须在 **-40 至 80** 范围内

仅满足上述条件的消息会存入数据库。

<br>

遥测验证通过 [rule chain](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain){:target="_blank"} 实现，在保存前过滤 incoming 消息。Rule chain 行为如下：
- 将**使用该 rule chain 的设备发出的所有消息**路由到带温度验证脚本的 [filter node](/docs/user-guide/rule-engine-2-0/nodes/filter/script){:target="_blank"}
- 将**已验证的遥测**转发至 [save timeseries node](/docs/user-guide/rule-engine-2-0/nodes/action/save-timeseries){:target="_blank"}，由该节点将数据存入数据库

该 rule chain 确保仅存储有效的温度读数，无效值在持久化前被过滤。

## 步骤 1. 导入验证 rule chain

1. 下载 rule chain 配置文件：   
   [validate_incoming_telemetry_rule_chain.json](/docs/user-guide/resources/guides/validate_incoming_telemetry_rule_chain.json){:target="_blank" download="validate_incoming_telemetry_rule_chain.json"}。
2. 进入 **Rule chains** 页面。
3. 点击右上角 **「&#43; Add rule chain」** 按钮，选择 **「Import rule chain」**。
4. [上传 rule chain 配置文件](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#import-rule-chain){:target="_blank"} 并点击 **Import**。
5. 点击 **Apply changes** 完成导入。

<br><b><font size="3">本示例使用的脚本</font></b>

```javascript
return typeof msg.temperature === 'undefined' || (msg.temperature >= -40 && msg.temperature <= 80);
```
{:.copy-code}

**脚本逻辑说明**
- <span class="code-light">typeof msg.temperature === 'undefined'</span> **&#8702;** 允许不包含温度数据的消息原样通过。
- <span class="code-light">(msg.temperature >= -40 && msg.temperature <= 80)</span> **&#8702;** 校验温度值在支持范围内。

<hr>

## 步骤 2. 添加演示设备

创建一台上报温度遥测的演示设备，并确保其使用刚导入的验证 rule chain。

1. 进入 **Entities** **&#8702;** **Devices**。
2. 点击右上角 **「&#43; Add device」** 按钮，选择 **「Add new device」** 并创建：
    - **Device name:** Thermometer
    - **Device profile:** thermostat
3. 在 **thermostat** 设备配置文件设置中，将导入的 **Validate Incoming Telemetry** rule chain 设为此配置文件的默认 rule chain。
4. 保存更改。

此后，使用该配置文件的所有设备在上报遥测前都会经过验证。

<hr>

## 测试配置

要验证验证逻辑是否按预期工作，请打开设备的 **Latest telemetry** 标签页实时查看 incoming 数据，然后发布测试遥测消息。   
可使用 [Check connectivity](/docs/{{docsPrefix}}user-guide/ui/devices/#check-connectivity){:target="_blank"} 功能，或执行以下命令&#42;：

1. 温度**在**有效范围内（例如 <span class="code-light">25</span>）。   
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

2. 温度**低于**范围（例如 <span class="code-light">-50<span>）。   
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:-50}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:-50}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:-50}"
   ```
   {: .copy-code}
   {% endif %}

3. 温度**高于**范围（例如 <span class="code-light">100</span>）。   
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:100}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:100}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{temperature:100}"
   ```
   {: .copy-code}
   {% endif %}

4. **不含** <span class="code-light">temperature</span> 字段的消息。   
   {% if docsPrefix == null or docsPrefix == "pe/" %}
   ```bash
   curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{humidity:46}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/" %}
   ```bash
   curl -v -X POST https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{humidity:46}"
   ```
   {: .copy-code}
   {% endif %}
   {% if docsPrefix == "paas/eu/" %}
   ```bash
   curl -v -X POST https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry --header Content-Type:application/json --data "{humidity:46}"
   ```
   {: .copy-code}
   {% endif %}

**&#42;** 请务必替换：
{% if docsPrefix == null or docsPrefix == "pe/" %}- **$THINGSBOARD_HOST_NAME** 为 ThingsBoard 实例的主机名或 IP 地址。{% endif %}
- **$ACCESS_TOKEN** 为设备 access token

仅通过验证的遥测消息会被持久化。无效的温度值会被丢弃。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}
