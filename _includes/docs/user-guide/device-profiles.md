* TOC
{:toc}

{% assign sinceVersion = "3.2" %}
{% include templates/since.md %}

ThingsBoard 中的设备 profile 允许管理员一次为多台设备定义并集中管理通用设置。
可大幅简化大量相似设备的管理，在众多设备共享相同配置和行为的 IoT 方案中尤为有用。

典型设备 profile 设置包括：
- 设置默认 [rule chain](#default-rule-chain)。
- 配置消息 [queue](#queue) 以高效处理消息。
- 定义向设备自动分发的 **firmware** 和 **software** 版本。
- 配置设备通信的 [transport protocols](#transport-configuration)。
- 定义和管理 [alarm rules](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}。
- 设置 [provision strategy](/docs/{{docsPrefix}}user-guide/device-provisioning/){:target="_blank"}。

## Create device profile

创建新设备 profile：
- 进入“Profiles”部分的“**Device profiles**”页面。
- 点击右上角“**+**”图标，从下拉菜单选择“**Create new device profile**”。
- 仅 **Name** 字段必填，其它设置均为可选。
- 点击“**Add**”创建设备 profile。

{% include images-gallery.html imageCollection="create-device-profile" %}

## Main device profile configuration

### Default rule chain

默认 [Rule Chain](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain){:target="_blank"} 处理来自任意设备的所有消息和事件。设备类型增多后，默认 rule chain 会变得复杂难管。
用户常创建自有根 rule chain，将消息按设备类型路由到专用 rule chain。

可为各设备 profile 分配独立 rule chain 以简化此流程。
便于集中、灵活地管理 telemetry 处理、设备状态（在线/离线）及设备生命周期事件（创建、更新、删除）。

{% include images-gallery.html imageCollection="device-profile-rule-chain" %}

### Queue

默认情况下，**main** [queue](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/){:target="_blank"} 用于存储来自任意设备的所有消息和事件。
传输层将消息提交到该 queue，Rule Engine 轮询 queue 获取新消息。
但在多种使用场景下，可能需要为不同设备使用不同 queue。
例如，将火灾告警/烟雾探测器传感器与其它设备的数据处理隔离。
这样，即使系统因数百万水表产生峰值负载，火灾告警上报时也能即时处理。
queue 分离还可定制不同 [submit](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#submit-settings){:target="_blank"} 和 [processing](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#retries-processing-settings){:target="_blank"} 策略。

> **请注意：** 若使用自定义 queue，需先由 **系统管理员** 配置。

{% include images-gallery.html imageCollection="device-profile-queue" %}

## Transport configuration

ThingsBoard 平台当前版本支持以下传输类型：
- [Default](#default-transport-type){:target="_blank"} - 适用于与 ThingsBoard 基础设备交互的标准 HTTP 传输。配置简单，但对大量设备或频繁更新效率较低。
- [MQTT](#mqtt-transport-type){:target="_blank"} - 专为 IoT 设备优化的轻量、双向协议，telemetry 传输高效，高吞吐、省资源。
- [CoAP](#coap-transport-type){:target="_blank"} - 适用于低带宽网络中资源受限设备的轻量 IoT 协议。
- [LWM2M](/docs/{{docsPrefix}}reference/lwm2m-api/#step-2-define-lwm2m-device-profile){:target="_blank"} - 面向资源受限设备高效管理的标准 IoT 协议，支持集中配置管理、固件更新和设备监控。
- [SNMP](/docs/{{docsPrefix}}reference/snmp-api/#device-profile-configuring){:target="_blank"} - 广泛用于管理路由器、交换机、服务器等网络设备的协议，支持采集和分析设备状态信息。

{% include images-gallery.html imageCollection="device-profile-transport" %}

### Default transport type

**Default** 传输类型用于保证与平台早期版本的兼容性。
使用该类型的设备可通过 ThingsBoard 标准 API 连接：[MQTT](/docs/{{docsPrefix}}reference/mqtt-api/){:target="_blank"}、[HTTP](/docs/{{docsPrefix}}reference/http-api/){:target="_blank"} 和 [CoAP](/docs/{{docsPrefix}}reference/coap-api/){:target="_blank"}。
无需特殊配置。

{% include images-gallery.html imageCollection="default-transport-type" %}

### MQTT transport type

**MQTT** 传输类型支持使用 MQTT 协议与设备建立灵活通信。
可通过 ThingsBoard 的 [telemetry upload API](/docs/{{docsPrefix}}reference/mqtt-api/#telemetry-upload-api){:target="_blank"} 和 [attribute update API](/docs/{{docsPrefix}}reference/mqtt-api/#publish-attribute-update-to-the-server){:target="_blank"} 定义自定义 **MQTT topic filters** 发送 telemetry 和更新属性。

MQTT 传输类型包含以下设置：

<br><b><font size="4">MQTT 设备 topic 过滤器</font></b>

自定义 MQTT topic 过滤器支持 **单层 (`+`)** 和 **多层 (`#`) 通配符**，可连接几乎任意以 **JSON** 或 **Protobuf** 格式发送 payload 的 **MQTT 设备**。

{% include images-gallery.html imageCollection="mqtt-device-topic-filters" %}

<br>
下面示例使用自定义 MQTT topic 过滤器，通过“MQTT Basic”设备凭证发布时序数据：

- 在设备 profile 中指定自定义 MQTT topic 过滤器。例如：
  - Telemetry topic 过滤器：`/telemetry`
  - Attributes topic 过滤器：`/attributes`
- 为设备配置 MQTT basic 凭证：
  - Client ID: `c1`
  - Username: `t1`
  - Password: `secret`

使用以下命令发布时序数据：

{% if docsPrefix == null or docsPrefix == "pe/" %}
> 请将`$THINGSBOARD_HOST_NAME`替换为实际host地址。

```bash
mosquitto_pub -h$THINGSBOARD_HOST_NAME-t /telemetry -i "c1" -u "t1" -P "secret" -m "{humidity:10.3}"
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
<br>
```bash
mosquitto_pub -h {{mqttHostName}} -t /telemetry -i "c1" -u "t1" -P "secret" -m "{humidity:10.3}"
```
{: .copy-code}
{% endif %}

传输数据将显示在设备的“**Latest telemetry**”选项卡中。

{% include images-gallery.html imageCollection="mqtt-transport-setting-example" %}

<br>
若使用标准 MQTT 设备 topic 过滤器配置，可使用以下命令发布时序数据和属性。

{% if (docsPrefix == null) or (docsPrefix == "pe/") %}> 请将`$THINGSBOARD_HOST_NAME`替换为实际host地址。{% endif %}

发布 **timeseries data** 的命令：
{% if (docsPrefix == null) or (docsPrefix == "pe/") %}

```bash
mosquitto_pub -h$THINGSBOARD_HOST_NAME-t v1/devices/me/telemetry -i "c1" -u "t1" -P "secret" -m "{humidity:10.3}"
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
mosquitto_pub -h {{mqttHostName}} -t v1/devices/me/telemetry -i "c1" -u "t1" -P "secret" -m "{humidity:10.3}"
```
{: .copy-code}
{% endif %}

更新 **attributes** 的命令：
{% if (docsPrefix == null) or (docsPrefix == "pe/") %}
```bash
mosquitto_pub -h$THINGSBOARD_HOST_NAME-t v1/devices/me/attributes -i "c1" -u "t1" -P "secret" -m "{"firmwareVersion": "1.3"}"
```
{: .copy-code}
{% endif %}
{% if docsPrefix contains "paas/" %}
```bash
mosquitto_pub -h {{mqttHostName}} -t v1/devices/me/attributes -i "c1" -u "t1" -P "secret" -m "{"firmwareVersion": "1.3"}"
```
{: .copy-code}
{% endif %}

<br><b><font size="4">MQTT 设备 payload</font></b>

- **JSON**。默认 ThingsBoard 期望设备以 JSON 格式发送数据。也可使用 [Protocol Buffers](https://developers.google.com/protocol-buffers) (Protobuf) 传输。
- **Protocol Buffers (Protobuf)** 是一种语言和平台无关的结构化数据序列化方式，便于最小化传输数据大小。
ThingsBoard 平台当前版本支持为 [telemetry upload](/docs/{{docsPrefix}}reference/mqtt-api/#telemetry-upload-api) 和 [attribute upload](/docs/{{docsPrefix}}reference/mqtt-api/#publish-attribute-update-to-the-server) 自定义 proto schema，并可定义下行消息（RPC 调用）的 schema。
> ThingsBoard 动态解析 protobuf 结构，因此尚不支持 OneOf、extensions 和 maps 等部分 protobuf 特性。

{% include images-gallery.html imageCollection="mqtt-device-payload" %}

- **Compatibility with other payload formats** 选项。
启用兼容模式后，ThingsBoard 默认使用 Protobuf payload 格式。若 Protobuf payload 解析失败，将自动尝试使用 JSON payload 格式。该功能在固件更新期间保证向后兼容很有用。例如，首版固件可能使用 JSON，新版本改用 Protobuf。在多设备固件更新期间，需同时支持两种格式。
> 启用兼容模式可能带来轻微性能下降。建议所有设备成功更新后关闭兼容模式。

{% include images-gallery.html imageCollection="compatibility-with-other-payload-formats" %}

### CoAP transport type

**CoAP (Constrained Application Protocol)** 是专为低带宽网络中资源受限设备设计的轻量 IoT 协议。

<b><font size="3">CoAP 设备类型：</font></b>

- **Default**。默认 CoAP 设备类型使用 JSON payload，支持与 [default transport type](#default-transport-type) 类似的基础 [CoAP APIs](/docs/{{docsPrefix}}reference/coap-api/){:target="_blank"}。
也可将 **CoAP device payload** 设置为 **Protobuf**，使设备使用 [Protocol Buffers](https://developers.google.com/protocol-buffers){:target="_blank"} (Protobuf) 传输数据。

    - **Protocol Buffers (Protobuf)** 是语言和平台无关的结构化数据序列化方法，主要用于减少传输数据大小。
  ThingsBoard 平台当前版本支持为 [telemetry upload](/docs/{{docsPrefix}}reference/coap-api/#telemetry-upload-api){:target="_blank"} 和 [attribute upload](/docs/{{docsPrefix}}reference/coap-api/#publish-attribute-update-to-the-server){:target="_blank"} 自定义 proto schema，并可定义下行消息（RPC 调用）的 schema。
  ThingsBoard 动态解析 protobuf 结构，因此尚不支持 OneOf、extensions 和 maps 等部分 protobuf 特性。

{% include images-gallery.html imageCollection="coap-default" %}

- **Efento NB-IoT** 设备为采用 NB-IoT 技术高效传输 telemetry 数据（如温度、湿度、压力、开关、泄漏等）的无线传感器。
可使用内置 CoAP 传输将其接入 ThingsBoard，接收设备消息、以 Protobuf 解码并存储 telemetry 到平台。
数据可立即用于查看、图表、dashboard、告警设置和自动化。
> 需 Efento 设备固件版本 06.02 及以上。

{% include images-gallery.html imageCollection="coap-efento-nb-iot" %}

<br><b><font size="3">Power Saving Mode</font></b>

平台支持以下节能机制以优化设备运行：
- Power Saving Mode (PSM)
- Discontinuous Reception (DRX)
- Extended Discontinuous Reception (eDRX)

{% include images-gallery.html imageCollection="power-saving-mode" %}

### LWM2M transport type

**LwM2M** 是面向资源受限设备高效管理的标准 IoT 协议，支持集中配置、远程固件更新和实时设备监控。

配置 **LwM2M 设备 profile** 时，需指定以下参数：
- **Define the objects** 要观测或交互的对象
- **Set the observe strategy** 确定平台如何监控对象变化
- **Configure how ThingsBoard processes LwM2M object data**，包括 telemetry、属性和关键参数

LwM2M 传输配置详见[此链接](/docs/{{docsPrefix}}reference/lwm2m-api/){:target="_blank"}。

{% include images-gallery.html imageCollection="lwm2m-transport-type" %}

### SNMP transport type

**SNMP** 是广泛用于管理路由器、交换机、服务器等网络设备的协议，支持采集和分析设备状态与性能数据。

配置 **SNMP 设备 profile** 时，需指定以下参数：
- **Request timeout** — 系统在重试或标记请求失败前等待的时长（毫秒）
- **Retry count** — 系统放弃前重试请求的次数
- **Communication configuration** — 定义设备如何通过 SNMP 与 ThingsBoard 通信

SNMP 传输配置详见[此链接](/docs/{{docsPrefix}}reference/snmp-api/){:target="_blank"}。

{% include images-gallery.html imageCollection="snmp-transport-type" %}

## Device profile details

点击设备 profile 可打开详情窗口，访问和管理该 profile 的各方面配置。

{% include images-gallery.html imageCollection="device-profile-details-page" %}

<b><font size="3">Details</font></b>   
该选项卡包含设备 profile 的核心配置 — 定义此类设备行为的通用设置。可配置 profile 名称、默认 dashboard、默认 rule chain、firmware/OS 信息及其它高级参数。这些设置应用于分配到此 profile 的所有设备。

<b><font size="3">Transport Configuration</font></b>   
定义设备如何与平台通信。该选项卡包含依据所选传输类型的 MQTT、HTTP、CoAP、LwM2M 或 SNMP 专用设置。

可配置：
- 认证策略
- payload 格式（JSON、Protobuf、自定义）
- topic/endpoint 设置
- 请求/响应参数
- 设备端与服务器端传输行为

传输配置确保该 profile 下所有设备的连接规则一致。

<b><font size="3">Calculated fields</font></b>   
显示基于设备属性或 telemetry 的公式自动计算值的字段。这些字段可在不修改设备固件的情况下生成衍生指标。profile 级别定义的 calculated fields 应用于使用该 profile 的所有设备。详见 [此处](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}。

<b><font size="3">Alarm rules</font></b>   
包含与设备 profile 关联的告警规则。这些规则定义该 profile 下所有设备何时以及如何生成告警，包括：
- 触发条件
- 严重级别
- 告警传播和清除逻辑
- 可选动作（通知、集成、workflow）

集中告警规则便于管理并确保设备组间监控一致。

告警规则配置详见[此处](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}。

<b><font size="3">Device provisioning</font></b>   
定义分配到此 profile 的设备如何创建和认证。该部分可包括：
- provisioning 策略（HTTP、MQTT、CoAP）
- 密钥和 token 生成规则
- provisioning 模板
- 自动注册行为

这些设置简化新设备的自动接入流程。

详见 [文档页](/docs/{{docsPrefix}}user-guide/device-provisioning/){:target="_blank"}。

<b><font size="3">Audit Log</font></b>   
显示对此设备 profile 执行的所有用户操作记录 — 配置变更、规则、provisioning 设置等。用于故障排查、合规和长期变更追踪。

<b><font size="3">Version control</font></b>   
支持通过基于 Git 的 [version control](/docs/{{docsPrefix}}user-guide/version-control/){:target="_blank"} 服务导出、提交和恢复设备 profile 配置。支持备份、协作和回滚到先前 profile 版本。

<hr>

## Next steps

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## Your feedback

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星，帮助我们传播。
如有问题，请[联系我们](/docs/contact-us/){:target="_blank"}。