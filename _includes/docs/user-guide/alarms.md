* TOC
{:toc}

**Alarms** 是监控与实体（设备、资产、Customer 等）相关事件的重要工具。告警机制可帮助快速响应异常、条件违规或关键状态变化，预防潜在问题并确保系统稳定运行。

例如，可在 ThingsBoard 中配置：温度超过设定阈值时自动创建告警。实际场景可能更复杂，涉及组合条件、时间间隔、聚合数据或上下文相关逻辑。

告警机制的基础是 [Alarm rules](/docs/{{docsPrefix}}user-guide/alarm-rules){:target="_blank"} 中定义的条件和逻辑，用于决定何时创建、更新或清除告警。规则配置完成后，系统会按配置生成告警，并通过界面查看、筛选和管理。规则创建与配置详见 [Alarm rules](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"} 部分。

本文介绍告警的日常使用、界面工具及使用建议。

<hr>

## 告警创建或清除通知

ThingsBoard 的 [Notification center](/docs/{{docsPrefix}}user-guide/notifications){:target="_blank"} 负责向相关用户发送告警事件及系统活动通知。
默认情况下，您会收到来自设备的告警以及 Customer 实体创建的告警（针对 Tenant Administrator）。

{% include images-gallery.html imageCollection="notification-about-alarm" %}

Notification center 支持灵活配置通知规则，定义通知对象、触发条件和送达渠道。
可选送达渠道包括：
- ThingsBoard Web 界面
- Email
- SMS
- [Slack](/docs/{{docsPrefix}}user-guide/notifications/#slack){:target="_blank"}
- [Microsoft Teams](/docs/{{docsPrefix}}user-guide/notifications/#microsoft-teams){:target="_blank"}
- [ThingsBoard 应用内通知](/docs/{{docsPrefix}}mobile/){:target="_blank"}

更多配置说明见[此处](/docs/{{docsPrefix}}user-guide/notifications){:target="_blank"}。

<hr>

## 查看与管理告警

<b><font size="4">Alarms 页面</font></b>

在左侧导航菜单中选择 **Alarms** 页面可查看和管理告警。页面以统一列表展示与实体相关的告警，包括：
- 创建时间
- 告警来源（Originator）
- 告警类型
- 严重程度
- 指派用户
- 状态（活动/已清除、已确认/未确认）

点击目标告警 **Details** 列中的省略号（…）可查看更多信息。

默认显示所有活动告警，可按筛选条件和时间范围缩小结果。

{% include images-gallery.html imageCollection="find-alarms" %}

<hr>

<b><font size="4">告警部件</font></b>

ThingsBoard 提供用于在 dashboard 上展示和管理告警的专用部件：

<b><font size="3">Alarms table 部件</font></b>

- 在可配置时间范围内，为选定实体显示告警
- 支持按类型、严重程度、确认状态和传播方式筛选
- 可直接在部件中执行告警操作（确认、清除、指派）

{% include images-gallery.html imageCollection="visualize-alarms-on-dashboard-1" %}

<b><font size="3">Alarm count 部件</font></b>

- 显示符合筛选条件的告警数量
- 支持按严重程度、状态和类型筛选
- 常用于高层监控 dashboard

{% include images-gallery.html imageCollection="visualize-alarms-on-dashboard-2" %}

关于如何向 dashboard 添加部件，请参阅 [dashboard 配置](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"} 文档。

<hr>

<b><font size="4">特定实体的告警</font></b>

可在实体的详情页面（例如设备）直接查看和管理该实体的告警。
- 打开 **Devices** 页面（或对应实体类型）
- 选择目标实体
- 在实体详情中切换到 **Alarms** 选项卡

在此可查看和管理仅属于该实体的告警。

{% include images-gallery.html imageCollection="find-alarm-for-specific-device" %}

以下介绍可对告警执行的操作。

<hr>

## 告警操作

### 确认与清除告警

每条告警有两个状态维度：
- **已确认** / **未确认**
- **活动** / **已清除**

可在以下位置执行确认或清除：
- **Alarms** 页面
- **Alarms table** 部件
- 实体详情页的 **Alarms** 选项卡

<b><font size="3">确认</font></b>

点击 **Acknowledge** 将告警标记为已查看。确认不影响告警逻辑，仅便于运维流程。

{% include images-gallery.html imageCollection="acknowledge-alarm" %}

<b><font size="3">清除</font></b>

{% include images-gallery.html imageCollection="clear-alarm" %}

点击 **Clear** 可关闭告警。清除可手动完成，或在规则中定义了清除条件时自动执行。

<hr>

### 告警评论

查看或添加评论：
- 点击 **Details** 列中的省略号（…）打开**告警详情**窗口
- 滚动至 **Activity** 区域

评论分两类：
- **用户评论**：手动添加，作者可编辑或删除
- **系统评论**：由系统生成（如严重程度变化、告警指派等），只读，以灰色显示

评论有助于记录操作和系统事件。

{% include images-gallery.html imageCollection="alarm-comments-1" %}

<hr>

## 核心概念

以下介绍告警的主要概念：

### Originator

**Originator** 是触发告警事件的实体。例如，设备上报的 telemetry 超过设定阈值时，该设备即为告警的 originator。

### Type

告警类型是描述事件性质的语义标识（例如 *High Temperature* 或 *Low Humidity*）。

告警类型决定同一实体内告警的唯一性。

{% include images-gallery.html imageCollection="alarm-type" %}

### Severity

表示事件的严重程度。ThingsBoard 支持五个级别（从高到低）：
- **Critical**
- **Major**
- **Minor**
- **Warning**
- **Indeterminate**

告警创建时分配 Severity，并可由规则逻辑更新。

{% include images-gallery.html imageCollection="alarm-severity" %}

### Status

告警有两个主要维度：
- **活动** / **已清除**
- **已确认** / **未确认**

组合后形成四种状态：
- *活动 & 未确认*
- *活动 & 已确认*
- *已清除 & 未确认*
- *已清除 & 已确认*

告警可由用户手动清除，或在满足预设清除条件时自动清除。清除条件为可配。

### 告警唯一性

ThingsBoard 通过 **originator**、**type** 和 **start time** 的组合识别告警。
因此，同一时刻仅能存在一条具有相同 originator、type 和 start time 的活动告警。

**示例：**  
假设配置规则：温度高于 20 时创建「High Temperature」告警，温度小于等于 20 时清除该告警。

事件顺序：  
12:00 — 温度 = 18 → 无告警  
12:30 — 温度 = 22 → **告警创建**（**startTime = 12:30**）  
13:00 — 温度 = 25 → 更新已有告警  
13:30 — 温度 = 18 → **告警清除**（**endTime = 13:30**）

结果是生成一条 startTime 为 12:30、endTime 为 13:30 的「High Temperature」告警。

### 告警时间说明

<b><font size="4">告警开始时间与创建时间</font></b>

告警包含两个关键时间戳：
- **Start time**：告警条件首次满足的时刻，基于上报的 telemetry 时间
- **Creation time**：ThingsBoard 接收并处理 telemetry 后创建告警的时刻

多数情况下两者一致。当设备发送延迟或回溯 telemetry（例如离线或批量上报）时可能不同。
此时，start time 为超过阈值的 telemetry 时间戳，creation time 为 ThingsBoard 处理该消息的时刻，因而可能不同。

**延迟 telemetry 示例**

空气质量监控系统阈值为 100 单位。

**12:00** — 传感器上报 95 → 未触发告警条件  
**12:05** — 传感器上报 105 → **告警条件满足**  
**12:08** — ThingsBoard 接收并处理数据，**创建告警**

此时：
- **startTime = 12:05**（实际超过阈值的时刻）
- **creationTime = 12:08**（平台处理 telemetry 的时刻）

这种区分有助于分析系统响应时间和事件顺序。

<b><font size="4">告警结束时间</font></b>

告警创建时，**endTime** 初始等于 startTime。若条件持续满足（例如后续 telemetry 再次超阈值），endTime 会相应更新，直至告警被清除。

**告警触发条件类型**

告警规则可选择告警创建时刻的判定方式。
- **Simple** — 超过阈值时立即创建告警
- **Duration** — 条件持续满足指定时长（例如温度超阈值 5 分钟）时才创建告警
- **Repeating** — 条件满足指定次数（例如第 5 次超阈值）时才创建告警

### Assignee

告警可指派给负责处理的用户。指派可在以下位置进行：

- **Alarms** 页面
- **Alarms table** 部件
- 实体的 **Alarms** 选项卡

{% include images-gallery.html imageCollection="assignee-alarm-1" %}

{% capture difference %}
注意：用户只有在拥有对应实体访问权限时，才能被指派该告警。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

被指派的用户将根据其通知设置接收通知。

{% include images-gallery.html imageCollection="assignee-alarm-2" %}

### 告警传播

告警传播使告警不仅在其 originator 上可见，还可根据层次结构和规则配置在相关实体间可见。

**工作方式**

告警创建时，ThingsBoard 会：
1. 识别 originator
2. 分析实体关系
3. 应用规则中定义的传播筛选条件
4. 在所有相关实体上展示告警

每条传播的告警并非独立副本，而是同一告警在不同实体上的展示，与 originator 完全同步。

**示例场景**

层次：**Tenant → Customer A → Office A（资产）→ Device A1**

若启用传播且 Device A1 触发告警：
- 告警在 **Device A1** 上出现
- 传播到 **Office A**
- 对 **Customer A** 可见
- 可继续传播到 **Tenant**

这样可在多级架构下实现集中可见性。

<hr>

## 查看与管理告警

**Alarms 页面**

使用左侧菜单中的「Alarms」页面可查看和管理告警。
页面以列表形式展示与实体相关的告警（设备、资产、Customer 等）以及您和 Customer 的告警，包括：创建时间、来源、告警类型、严重程度、[指派对象](#assign-alarm-to-user)和告警状态。
默认显示所有时间的活动告警。可按筛选条件和时间范围查看其他结果。
要查看告警详情，请点击该告警「Details」列中的省略号（…）。

{% include images-gallery.html imageCollection="find-alarms" %}

<br>
**告警部件**

ThingsBoard 提供用于在 dashboard 上展示告警的部件。

「**Alarms table**」部件可按时间范围和筛选条件，为选定实体方便地展示和管理告警。

{% include images-gallery.html imageCollection="visualize-alarms-on-dashboard-1" %}

「**Alarm count**」部件根据所选筛选条件显示告警数量。

{% include images-gallery.html imageCollection="visualize-alarms-on-dashboard-2" %}

筛选设置支持：

* 使用 acknowledge/unacknowledge/active/clear 的任意组合按状态筛选告警；
* 使用各严重级别组合按严重程度筛选告警；
* 按类型显示告警列表；
* 启用或禁用传播告警搜索（仅限「Alarms table」部件）。

如何向监控面板添加部件，请参阅[此文档](/docs/{{docsPrefix}}user-guide/widgets/#adding-a-widget-to-the-dashboard)。

<br>
**特定实体的告警**

要查看某实体（此处以设备为例）的告警：

- 进入该实体类型的页面，此处为「Devices」；
- 点击目标实体打开详情；
- 切换到「Alarms」选项卡。

此处可查看与该实体相关的所有告警，并可选择应用筛选条件和时间范围。

{% include images-gallery.html imageCollection="find-alarm-for-specific-device" %}

以下介绍可对告警执行的操作。

### 确认和/或清除告警

告警有四种状态： acknowledged/unacknowledged/active/clear。

确认告警：在 Alarms table 部件中点击「Acknowledge」图标，或在「Alarms」页面的告警详情窗口中点击「Acknowledge」按钮，或在实体详情窗口的「Alarms」选项卡中点击。

{% include images-gallery.html imageCollection="acknowledge-alarm" %}

清除告警：在 Alarms table 部件中点击「Clear」图标，或在告警详情窗口中点击「Clear」按钮。

{% include images-gallery.html imageCollection="clear-alarm" %}

### 告警评论

查看某告警的评论，请点击「Details」列中的省略号（…）打开告警详情。
在此可查看系统评论、其他用户评论，并可添加自己的评论。

{% include images-gallery.html imageCollection="alarm-comments-1" %}

评论分为用户评论和系统评论两类。
有权限的用户可添加、编辑和删除自己的评论。系统评论为不可编辑的灰色评论，描述诸如严重程度变更、告警指派等事件。

## 使用 REST API 管理告警

ThingsBoard 提供用于管理和查询告警的 REST API。详见 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 文档。

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 反馈

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星，帮助我们推广。
如有问题，请[联系我们](/docs/contact-us/){:target="_blank"}。
