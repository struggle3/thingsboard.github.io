* TOC
{:toc}

## 概述

ThingsBoard 支持以灵活 schedule 配置调度多种类型事件。
ThingsBoard Scheduler 按 schedule 触发已配置的 scheduler 事件。
触发 scheduler 事件时，会从事件配置生成 [Rule Engine Message](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-message)，其结构与 Rule Engine Message 类似。
生成的消息会被转发到 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)，并从 [Root Rule Chain](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain) 开始处理。

<br>

![image](/images/user-guide/scheduler.svg)

## 视频教程

观看下方视频教程，按步骤了解如何使用此功能。

<br>
<div id="video">
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/RnHAao8yET4" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## Scheduler 管理

租户管理员和客户用户可在 ThingsBoard 中配置 **Scheduler events**。

![image](/images/user-guide/ui/scheduler.png)

**Scheduler events** 页面显示当前已配置的 scheduler 事件。
支持添加、更新或删除 scheduler 事件。页面支持 **List view** 和 **Calendar view** 两种模式。
可通过页面顶部的对应图标切换视图。

![image](/images/user-guide/ui/scheduler-view-buttons.png)

在 Calendar view 模式下，scheduler 事件按其 schedule 以标签形式显示。 

![image](/images/user-guide/ui/scheduler-calendar-view.png)

默认 Calendar view 为 **Month** 类型。
**Calendar view type** 下拉菜单可切换到其他视图类型，可选类型如下：

- *Month / Week / Day / List Year / List Month / List Week / List Day / Agenda Week / Agenda Day*

点击右上角 `+` 按钮，或在 Calendar view 中点击任意单元格可创建新的 scheduler 事件。

### Scheduler Event 对话框

Scheduler event 编辑对话框包含 **Configuration** 和 **Schedule** 两个表单。

![image](/images/user-guide/ui/scheduler-event-dialog.png)

**Configuration** 表单用于根据所选 event 类型设置 event type 和 event configuration 参数。
scheduler event 的配置说明见 [Scheduler Event Types](#scheduler-event-types) 章节。

**Schedule** 表单用于配置 event schedule。

![image](/images/user-guide/ui/scheduler-event-schedule.png)

Schedule 表单参数如下：

- **Timezone** - 处理该 scheduler event 的时区。
- **Start Date/Time** - 触发该 scheduler event 的日期/时间。
- **Repeat** - 该 scheduler event 为一次性或重复执行。 
- **Repeats** - 重复规则，可选 *Daily* 或 *Weekly*。
- **Repeat on** - 适用于 *Weekly*，指定触发该 scheduler event 的星期几。
- **Ends on** - 该 scheduler event 重复结束的日期。
 

## Scheduler Event 类型

在 Configuration 中的 **Event type** 字段可选择现有 event 类型或指定自定义类型。

### Custom Type

Custom type 按 message 结构使用默认 scheduler event 配置表单。

![image](/images/user-guide/ui/scheduler-custom-event-type.png)

- **Originator** - message originator，可为 *Single entity*（如 Device、Asset 等）或 [*Group of entities*](/docs/{{docsPrefix}}user-guide/groups/)。未指定时，scheduler event 实体本身作为 originator。
- **Message type** - 符合 Rule Engine message 类型的 message type。可为[已有 message type](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types) 或自定义。未指定时，scheduler event type 将作为 message type。 
- **Message body** - JSON 格式的 message body。
- **Metadata** - 表示 message metadata 字段的 key/value 表。

### Generate Report

支持按 schedule 生成 [Reporting](/docs/{{docsPrefix}}user-guide/reporting/#generate-report-rule-chain) 功能支持的报告。

![image](/images/user-guide/ui/scheduler-generate-report-event-type-report-config.png)

![image](/images/user-guide/ui/scheduler-generate-report-event-type-email-config.png)

- **Report configuration**：
    - **Base URL** - Report Server 需能访问的 ThingsBoard UI 的 base URL。
    - **Dashboard** - 用于生成报告的仪表板。
    - **Dashboard state parameter value** - 指定报告生成的目标仪表板状态。可点击字段最右侧按钮调用 **Select dashboard state** 对话框自动设置。
    - **Timezone** - 报告中显示目标仪表板所用的时区。
    - **Use dashboard time window** - 若勾选，报告生成时使用目标仪表板中配置的 time window。
    - **Time window** - 报告生成时使用的仪表板 time window。
    - **Report name pattern** - 生成报告的文件名模式，可包含 `%d{date-time pattern}` 形式的日期时间模式。详见 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 文档。
    - **Report type** - 报告文件类型，可为 *PDF \| PNG \| JPEG*。
    - **Use current user credentials** - 若勾选，将使用创建该报告配置的用户凭证在报告生成时打开仪表板 UI。
    - **Customer user credentials** - 其凭证将用于打开仪表板 UI 的目标客户用户。
    - **Generate Test Report** 按钮用于测试，将按当前配置执行报告生成。生成成功时会自动下载报告文件。

- **Send email** - 若勾选，将发送带报告附件的邮件。

- **Email configuration**：
    - **From** - 发件地址
    - **To** - 收件人地址列表（逗号分隔）
    - **Cc** - 抄送地址列表（逗号分隔）
    - **Bcc** - 密送地址列表（逗号分隔）
    - **Subject** - 邮件主题，可按 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 使用 `%d{date-time pattern}` 形式的日期时间模式。
    - **Body** - 邮件正文，可按 [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 使用 `%d{date-time pattern}` 形式的日期时间模式。

### Update Attributes

支持为实体或实体组按 schedule 更新属性。

![image](/images/user-guide/ui/scheduler-update-attributes-event-type.png)

- **Target** - 要更新属性的目标实体，可为 *Single entity*（如 Device、Asset 等）或 [*Group of entities*](/docs/{{docsPrefix}}user-guide/groups/)。
- **Entity attributes scope** - 要更新属性的 [scope](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types)。若 **Target** 中指定了 Device 实体类型，可选择。可为 **Server attributes** 或 **Shared attributes**。其他实体类型均使用 **Server attributes** scope。 
- **Server / Shared attributes** - 表示待更新属性值的 key/value 表。

### Send RPC Request to Device

支持按 schedule 向设备或设备组发送命令（[RPC call](/docs/{{docsPrefix}}user-guide/rpc/#server-side-rpc-api)）。

![image](/images/user-guide/ui/scheduler-send-rpc-request-event-type.png)

- **Target** - 接收命令的目标设备，可为 *Single device* 或 [*Group of devices*](/docs/{{docsPrefix}}user-guide/groups/)。
- **Method** - RPC call 方法。
- **Params** - JSON 格式的 RPC call 参数。

## Scheduler 部件

ThingsBoard 支持通过 **Scheduler events** 或 **Reports schedule** 部件管理 scheduler 事件，这些部件属于 **Scheduling** 部件包。

![image](/images/user-guide/ui/scheduler-scheduler-events-widget.png)

**Scheduler events** 部件功能与 [**Scheduler events** 页面](#scheduler-administration)相同。
还可为自定义 scheduler event 类型配置预定义表单。 
可在部件配置的 **Advanced** 选项卡中配置 **Custom event types** 列表实现。

![image](/images/user-guide/ui/scheduler-scheduler-events-widget-custom-types.png)

- **Display name** - 自定义 event 类型的显示名称。
- **Type name** - 自定义 event 的内部名称。
- **Display originator entity select** - 是否在 scheduler event 配置表单中允许选择 originator。
- **Display message type select** - 是否在 scheduler event 配置表单中允许选择 message type。
- **Display message metadata table** - 是否在 scheduler event 配置表单中显示 metadata 表。
- **Configuration HTML template** - 用于生成编辑 event configuration 对象自定义表单的 HTML 代码。

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
