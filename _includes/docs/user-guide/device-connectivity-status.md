* TOC
{:toc}

## 设备连接事件

ThingsBoard 的 Device State 服务负责监控设备连接状态，并触发推送到 [**Rule Engine**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 的设备连接事件。平台用户可定义如何响应这些事件。

支持的事件包括：

 - **Connect 事件** - 当设备连接至 ThingsBoard 时触发。适用于 MQTT 等基于会话的传输。
 对于 HTTP 传输也会触发，但在该场景下会在每次 HTTP 请求时触发；
 - **Disconnect 事件** - 当设备从 ThingsBoard 断开时触发。适用于 MQTT 等基于会话的传输。
 对于 HTTP 传输也会触发，但在该场景下会在每次 HTTP 请求时触发；
 - **Activity 事件** - 当非活跃设备通过推送遥测、属性更新或 RPC 命令变为活跃时触发。
 - **Inactivity 事件** - 当设备在一定时间内无活动时触发。
 请注意，即使设备未产生 disconnect 事件，也可能触发此事件。通常表示一段时间内未触发 activity 事件。

Device State 服务负责维护以下[服务端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types)属性：

 - **active** - 表示设备当前状态，true 或 false；
 - **lastConnectTime** - 表示设备上次连接 ThingsBoard 的时间，为自 1970 年 1 月 1 日 00:00:00 GMT 起的毫秒数；
 - **lastDisconnectTime** - 表示设备上次从 ThingsBoard 断开的时间，为自 1970 年 1 月 1 日 00:00:00 GMT 起的毫秒数；
 - **lastActivityTime** - 表示设备上次推送遥测、属性更新或执行 RPC 命令的时间，为自 1970 年 1 月 1 日 00:00:00 GMT 起的毫秒数；
 - **inactivityAlarmTime** - 表示上次触发 inactivity 事件的时间，为自 1970 年 1 月 1 日 00:00:00 GMT 起的毫秒数。

## 控制平台如何管理活动

每次设备活动都会导致 Device State 服务执行一系列操作，如数据库调用和内部簿记。
这可提供有价值的设备当前状态信息，同时也会影响性能。
部分场景不需要精确监控设备状态，用户愿意以牺牲一定的实时活动信息换取整体系统性能提升。

为满足该需求，平台提供活动上报策略功能，用于控制向 Device State 服务上报活动的频率和数量。
共有四种策略：**ALL**、**FIRST**、**LAST** 和 **FIRST_AND_LAST**。
下文将逐一说明，首先了解核心概念以更好使用该功能。

### 什么是活动？

活动表示表明设备正在执行操作或与平台通信的事件。
活动示例包括：
- 连接或断开平台
- 通过 integration 或传输层推送时序或属性数据
- 推送 RPC 命令
- 订阅属性更新

### 上报活动

上报活动指通知 Device State 服务活动已发生。
Device State 服务随后根据活动类型更新属性并触发连接事件。

例如，若活动为设备连接平台，一旦上报活动，Device State 服务将更新 **lastConnectTime**、**lastActivityTime** 属性并触发 **Connect 事件**。

### 活动上报周期

活动上报周期是指系统记录活动的时间段。
时间被划分为连续周期；即一个周期结束后，下一个立即开始。
周期时长可[配置](#configuration)。

第一个上报周期在 ThingsBoard 启动时开始。
例如，若系统在第 15 秒启动，初始上报周期也同时开始。
若周期时长设为 15 秒，该周期将在第 30 秒结束，下一个周期随即开始。
该模式在 ThingsBoard 运行期间循环重复。

![image](/images/user-guide/activity-reporting-periods.png)

### 首次与末次活动事件

- **First 事件**：上报周期内收到的首次活动。
- **Last 事件**：上报周期内收到的末次活动。

![image](/images/user-guide/first-and-last-activity-events.png)

> **注意**：若仅有一次活动，则同时视为 first 和 last。

![image](/images/user-guide/one-event-both-first-and-last.png)

### 活动上报策略

- **ALL**：所有活动立即上报给 Device State 服务。

![image](/images/user-guide/activity-strategy-all.png)

- **FIRST**：仅首次活动立即上报给 Device State 服务。

![image](/images/user-guide/activity-strategy-first.png)

> **注意**：若某上报周期内无活动，末次活动仍会上报。

![image](/images/user-guide/first-strategy-reporting-last-event.png)

- **LAST**：仅末次活动上报给 Device State 服务。活动在上报周期结束时上报。

![image](/images/user-guide/activity-strategy-last.png)

- **FIRST_AND_LAST**：首次和末次活动均上报给 Device State 服务。
  首次活动立即上报，末次活动在上报周期结束时上报。

![image](/images/user-guide/activity-strategy-first-and-last.png)

## 配置

所有配置均在 **thingsboard.yml** 中的全局参数完成。

- **state.defaultInactivityTimeoutInSec** - 若无活动上报，Device State 服务将设备视为不活跃的超时时间（秒）。
默认 600 秒（10 分钟）。可通过为设备设置 **inactivityTimeout** 服务端属性（单位毫秒）覆盖。

{% capture difference %}
**请注意：**
<br>
此参数仅控制核心服务如何判断设备连接状态（值保存在设备的 **"active"** 属性中）；**不会**影响设备会话超时。
设备会话不活动超时由 **transport.sessions.inactivity_timeout** 属性单独配置。

为避免不一致，建议使二者保持同步：传输会话不活动超时应**大于或等于**设备不活动超时。

{% endcapture %}
{% include templates/info-banner.md content=difference %}

- **state.defaultStateCheckIntervalInSec** - Device State 服务定期检查设备活动状态的间隔（秒）。默认 60 秒（1 分钟）。
- **state.telemetryTtl** - 活动遥测数据的生存时间（毫秒）。默认 0 毫秒（表示禁用 TTL）。
{% if docsPrefix == 'pe/' %}
- **integrations.activity.reporting_strategy** - integration 的活动上报策略。允许值：ALL、FIRST、LAST、FIRST_AND_LAST。默认 LAST。
- **integrations.activity.reporting_period** - integration 的上报周期时长（毫秒）。默认 3000 毫秒（3 秒）。
{% endif %}
- **transport.activity.reporting_strategy** - 传输层的活动上报策略。允许值：ALL、FIRST、LAST、FIRST_AND_LAST。默认 LAST。
- **transport.sessions.report_timeout** - 传输层上报周期时长（毫秒）。默认 3000 毫秒（3 秒）。
- **transport.sessions.inactivity_timeout** - 自设备发送最后一条消息后，设备传输会话保持打开的时长（毫秒）。默认 60000 毫秒（10 分钟）。

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
