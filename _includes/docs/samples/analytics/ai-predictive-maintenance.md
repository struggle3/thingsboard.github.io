{% if docsPrefix == nil or docsPrefix == "pe/" %}
{% assign HOST = "localhost:8080" %}
{% endif %}
{% if docsPrefix == "paas/" %}
{% assign HOST = "thingsboard.cloud" %}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
{% assign HOST = "eu.thingsboard.cloud" %}
{% endif %}

* TOC
{:toc}

本文档介绍将原始设备遥测数据转化为可操作维护洞察的 ThingsBoard 解决方案：

**工作流程：**
1. 设备发送 `vibration`（mm/s）、`temperature`（°C）和 `acousticDev`（相对基线的偏差百分比）。
2. [计算字段](/docs/user-guide/calculated-fields/)为每个指标维护最近 N 个值（默认：100）和/或最近 M 分钟的滚动窗口。
3. 滚动窗口被转发到 AI 规则节点（OpenAI 或其他 LLM provider）。
4. 若 AI 检测到异常，规则链会创建 ThingsBoard 告警并可选择发送通知。


### 架构

![image](/images/samples/analytics/iot-anomaly-detection-diagram.svg)

### 前置条件

- ThingsBoard 版本 **4.2+**
- 能够发送所需遥测值的设备（本指南中将模拟这些值）
- LLM provider 凭据（OpenAI、Azure OpenAI 等）

### 遥测输入与输出

**每设备预期的遥测键：**
- `vibration` — mm/s（浮点数）
- `temperature` — °C（浮点数）
- `acousticDev` — 相对基线的偏差百分比（浮点数）

**AI 输出：**
- `anomaly` — 简短标签（如 `"Bearing Wear"`）
- `summary` — 简洁的可读建议（如 `"Vibration has reached 7.4 mm/s and temperature is at 86°C accompanied by irregular acoustic patterns, indicating bearing wear. Recommend immediate bearing inspection and replacement to avoid catastrophic failure."`）

### 计算字段配置

**目的：** 高效维护最近 N 个读数（默认 100，可配置）的滚动窗口，并将其直接转发到 AI 节点。

**步骤：**

<b>1. [下载](/docs/samples/analytics/resources/equipment_sensor.json){:target="_blank" download="equipment_sensor.json"}</b> 并将 **EquipmentSensor** 设备配置文件导入到您的 ThingsBoard 实例。

{% include images-gallery.html imageCollection="import-equipment-sensor-device-profile" %}

<b>2. [下载](/docs/samples/analytics/resources/rolling-window-records.json){:target="_blank" download="rolling-window-records.json"}</b> 并将计算字段导入到 **EquipmentSensor** 设备配置文件中。

{% include images-gallery.html imageCollection="import-calculated-field-into-profile" %}

**要点：**

- 滚动窗口时间范围设置为 **1 天**。
- 存储值数量设置为 **100**。系统设置中默认最大为 1000，可配置。
- TBEL 脚本以单条消息将滚动值输出到规则引擎：

```javascript
// Sample script to output raw values of the rolling arguments;
return {
    "acousticDevRecords": acousticDevRecords,
    "temperatureRecords": temperatureRecords,
    "vibrationRecords": vibrationRecords
};
```

### 规则链配置

**目的：** 分析滚动窗口数据，对异常进行分类，并生成自然语言摘要。支持 OpenAI 或其他 LLM provider。

**步骤：**

- [下载](/docs/samples/analytics/resources/equipment_health_analysis.json){:target="_blank" download="equipment_health_analysis.json"} 包含「<b>Equipment Health Analysis</b>」规则链配置的 <b>json 文件</b>。

{% include images-gallery.html imageCollection="import-equipment-health-analysis-rule-chain" showListImageTitles="true" %}

<b>5.</b> 更新 <b>EquipmentSensor</b> 配置文件，引用「<b>Equipment Health Analysis</b>」规则链。

{% include images-gallery.html imageCollection="update-equipment-sensor-profile" %}

重要说明：

* 系统和用户提示可引用传入消息数据：
  * `$[*]` — 整个消息体
  * `${*}` — 整个消息元数据
  * `$[key]` — 消息体中的特定字段
  * `${key}` — 元数据中的特定值
* 支持的响应格式：**TEXT**、**JSON** 和 **JSON Schema**（本文使用 JSON Schema）。
* 使用 5 秒间隔的 **deduplication** 节点来减少 AI token 消耗。

### 测试

<b>步骤 1.</b> 使用 **EquipmentSensor** 配置文件创建测试设备 **Equipment Sensor 1**。

{% include images-gallery.html imageCollection="create-test-device-1" %}

<b>步骤 2.</b> 从设备详情中复制「<b>Check connectivity</b>」命令。

{% include images-gallery.html imageCollection="create-test-device-2" %}

您的命令大致如下：

```bash
curl -v -X POST http://{{ HOST }}/api/v1/6sED1ALqyJg0P6ezIODH/telemetry \
--header Content-Type:application/json \
--data "{temperature:25}"
```

<b>&#8195; *</b> 其中 `{{ HOST }}` 为 <b>ThingsBoard 实例的主机</b>，`6sED1ALqyJg0P6ezIODH` 为 <b>设备访问令牌</b>。

{% include images-gallery.html imageCollection="check-connectivity-command-from-device" %}

<br><b>步骤 3.</b> 修改并发送测试数据。

<b>步骤 3.1 无告警情况：</b>

{% if docsPrefix == nil or docsPrefix == "pe/" %}

将以下测试数据发送到 ThingsBoard。请务必替换：
- `$THINGSBOARD_HOST_NAME` 为您的 ThingsBoard 实例主机，
- `$YOUR_DEVICE_ACCESS_TOKEN` 为您的设备访问令牌。

```bash
curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$YOUR_DEVICE_ACCESS_TOKEN/telemetry \
--header Content-Type:application/json \
--data '{"vibration":4.2,"temperature":70,"acousticDev":5}'
```
{:.copy-code}

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}

将以下测试数据发送到 ThingsBoard。
请确保将 `$YOUR_DEVICE_ACCESS_TOKEN` 替换为您的设备访问令牌。

```bash
curl -v -X POST http://{{ HOST }}/api/v1/$YOUR_DEVICE_ACCESS_TOKEN/telemetry \
--header Content-Type:application/json \
--data '{"vibration":4.2,"temperature":70,"acousticDev":5}'
```
{:.copy-code}

{% endif %}

不会创建告警。

{% include images-gallery.html imageCollection="send-test-data-no-alarm-case" %}

<br>
<b>步骤 3.2 轴承磨损检测：</b>

{% if docsPrefix == nil or docsPrefix == "pe/" %}

通过将以下测试数据发送到 ThingsBoard 来模拟轴承磨损事件。请务必替换：
- `$THINGSBOARD_HOST_NAME` 为您的 ThingsBoard 实例主机，
- `$YOUR_DEVICE_ACCESS_TOKEN` 为您的设备访问令牌。

```bash
curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$YOUR_DEVICE_ACCESS_TOKEN/telemetry \
--header Content-Type:application/json \
--data '{"vibration":8.2,"temperature":88,"acousticDev":5}'
```
{:.copy-code}

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}

通过将以下测试数据发送到 ThingsBoard 来模拟轴承磨损事件。
请确保将 `$YOUR_DEVICE_ACCESS_TOKEN` 替换为您的设备访问令牌。

```bash
curl -v -X POST http://{{ HOST }}/api/v1/$YOUR_DEVICE_ACCESS_TOKEN/telemetry \
--header Content-Type:application/json \
--data '{"vibration":8.2,"temperature":88,"acousticDev":5}'
```
{:.copy-code}

{% endif %}

{% include images-gallery.html imageCollection="send-test-data-bearing-wear-detection" %}

<br>将创建告警。以下是 AI 输出示例：

```json
{
  "anomaly": "Bearing Wear",
  "summary": "Vibration has reached 7.4 mm/s and temperature is at 86 °C accompanied by irregular acoustic patterns, indicating bearing wear. Recommend immediate bearing inspection and replacement to avoid catastrophic failure."
}
```

<br>
<b>步骤 3.3 不对中</b> 检测：

{% if docsPrefix == nil or docsPrefix == "pe/" %}

通过将以下测试数据发送到 ThingsBoard 来模拟不对中事件。请务必替换：
- `$THINGSBOARD_HOST_NAME` 为您的 ThingsBoard 实例主机，
- `$YOUR_DEVICE_ACCESS_TOKEN` 为您的设备访问令牌。

```bash
curl -v -X POST http://$THINGSBOARD_HOST_NAME/api/v1/$YOUR_DEVICE_ACCESS_TOKEN/telemetry \
--header Content-Type:application/json \
--data '{"vibration":32.2,"temperature":38,"acousticDev":5}'
```
{:.copy-code}

{% endif %}
{% if docsPrefix == "paas/" or docsPrefix == "paas/eu/" %}

通过将以下测试数据发送到 ThingsBoard 来模拟不对中事件。
请确保将 `$YOUR_DEVICE_ACCESS_TOKEN` 替换为您的设备访问令牌。

```bash
curl -v -X POST http://{{ HOST }}/api/v1/$YOUR_DEVICE_ACCESS_TOKEN/telemetry \
--header Content-Type:application/json \
--data '{"vibration":32.2,"temperature":38,"acousticDev":5}'
```
{:.copy-code}

{% endif %}

{% include images-gallery.html imageCollection="send-test-data-misalignment-detection" %}

<br>将创建告警。以下是 AI 输出示例：

```json
{
  "anomaly": "Misalignment",
  "summary": "A sudden vibration spike to 32.2 mm/s without a corresponding temperature rise or acoustic deviation indicates likely misalignment in the drive train. Please perform an immediate shaft-and-coupling alignment check to prevent further mechanical damage."
}
```

### 性能与成本控制

* **批处理与防抖**：仅在收到 N 个点或每 T 秒后向 AI 发送。
* **提前过滤**：若所有指标均处于正常范围内，则跳过 AI 调用。
* **有效负载压缩**：若提示允许，可发送统计量（min/mean/max/std、趋势）而非完整数组。

### 故障排查

* **无告警**：
  1. 确认「Latest telemetry」标签页中有原始设备数据。
  2. 启用并查看计算字段调试事件。
  3. 启用并查看对应规则节点调试事件。
* **成本过高**：增加去重周期，调整提示或更换 AI 模型。

### 下一步

尝试调整 AI 提示，并向社区反馈您的建议！
