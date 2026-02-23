* TOC
{:toc}

{% assign sinceVersion = "4.2" %}
{% include templates/since.md %}

{% assign feature = "Reporting" %}{% include templates/pe-feature-banner.md %}

在ThingsBoard中，**报表**是用于以报表形式收集、组织并自动交付数据的强大而灵活的工具。

报表系统围绕两个关键组件构建：
- **报表模板** — 定义报表的结构、内容和格式。模板可以是**PDF**或**CSV**格式，并可包含任意[支持的组件](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/#components--interaction){:target="_blank"}。
- **调度器事件** — 在指定时间自动触发报表生成，并通过可用渠道（如email、Slack或其他集成）将其发送给所选收件人。

**简而言之**：模板定义报表**内容**，而调度器决定**何时**以及**发给谁**。

本指南将介绍在ThingsBoard中使用报表的基本步骤，并创建一个报表模板，配置为向两个不同客户自动交付。

{% include templates/prerequisites-pe.md %}

> <b>重要：</b>
- 本示例中已创建三台设备和拥有这些设备的两名客户。部分设备上已触发告警。
您需要同样操作 — 否则报表中的设备和告警表将为空。
- 如果您刚开始使用ThingsBoard平台，建议先阅读[ThingsBoard专业版入门指南](/docs/getting-started-guides/helloworld-pe/){:target="_blank"}。

## 步骤 1. 创建报表模板

作为示例，让我们创建一个包含以下内容的报表模板：
- **包含所有客户设备的表格**，显示其最新遥测值和当前状态。
- **过去24小时这些设备上触发的告警表**。
- **两个独立的折线图**，分别显示设备过去24小时的温度和湿度值。

此设置既能提供设备状况的最新概览，又能快速查看今日检测到的问题 — 全部整合在一份报表中。

- 从左侧边栏打开"**报表**"页面。您将自动进入"**模板**"标签页。
- 点击右上角的"**+ 添加报表模板**"按钮。
- 选择"**创建新报表模板**"。
- 在弹窗中填写以下内容：
    - 将其<b>名称</b>设为"<b>每日设备告警报表</b>"。
    - 选择<b>PDF</b>报表<b>格式</b>。
    - 选择<b>报表</b>作为<b>模板类型</b>。
    - [可选] <b>描述</b>："<b>每日设备活动和告警报表</b>"。
    - 点击"<b>添加</b>"以创建报表模板并打开<b>报表构建器</b>界面。

在**报表构建器**中，您可以设计报表的结构、布局和内容。

{% include images-gallery.html imageCollection="reporting-getting-started-create-template" %}

## 步骤 2. 添加报表组件

<b>报表构建器</b>允许您添加和配置用于定义报表结构和视觉布局的组件。

通过将组件从组件库拖入内容区域来添加组件。

{% include images-gallery.html imageCollection="reporting-getting-started-report-builder" %}

### 步骤 2.1“标题”组件

首先，添加<b>标题</b>组件。

- 在<b>报表组件库</b>中找到并将其拖入报表的<b>标题区域</b>。
- 在<b>编辑器</b>的<b>文本</b>字段下，输入您想要的标题文本。本示例中，我们使用与报表模板相同的名称：
  ```
  每日设备告警报表
  ```
  {:.copy-code}

- 如需要，可调整<b>字体设置</b>（如大小、样式或对齐）以使标题更突出。
- 完成后，点击<b>应用</b>保存组件。

{% include images-gallery.html imageCollection="reporting-getting-started-heading" %}

### 步骤 2.2“富文本”组件

接下来，添加<b>富文本</b>组件，其中包含报表用途的简要说明。

- 在<b>组件库</b>中找到<b>富文本</b>组件，并将其拖入<b>内容区域</b>。
- 在组件的文本字段中输入以下文本（或您偏好的描述）。
  例如：
  ```
  本报表列出您项目中当前部署的所有设备及其当日的告警。
  ```
  {:.copy-code}

- 添加文本后，点击<b>应用</b>。

{% include images-gallery.html imageCollection="reporting-getting-started-rich-text" %}

### 步骤 2.3“实体表”组件

下一个要添加的组件是<b>实体表</b> — 表格型组件，用于显示所有设备及其最新遥测值和状态列表。

- 从<b>组件库</b>将<b>实体表</b>组件拖放入<b>内容区域</b>。
- 在<b>数据源</b>部分，创建新的<b>实体别名</b>，用于获取类型为<b>设备</b>的所有实体。
- 开启<b>表头</b>并更新表头文本。
- 在<b>列</b>部分：
  - 添加新表列，将键设为"<b>temperature</b>"。
  - 添加另一列表列，遥测键为"<b>humidity</b>"。
  - 再添加一列属性"<b>active</b>"，用于显示设备状态。
- 在<b>列设置</b>中，为每个键的单元格设置<b>居中对齐</b>。
- 点击<b>保存</b>组件以应用更改。

{% include images-gallery.html imageCollection="reporting-getting-started-entity-table" %}

### 步骤 2.4“告警表”组件

下一个要添加的组件是**告警表**组件，用于显示所选时间段的告警列表。

- 从组件面板将<b>告警表</b>组件拖入报表布局的主内容区域。
- 默认情况下，告警表预配置为显示<b>过去24小时</b>的告警。
- 将<b>所有设备</b>实体别名设为<b>告警来源</b>。
- 在<b>筛选器</b>部分，勾选仅显示当前活动告警。
- 向下滚动，找到标为<b>表头</b>的开关并开启。
- 输入您想要的表头，例如：
  ```
  下表列出您的设备过去一天的告警。
  ```
  {:.copy-code}

  - 如需要，调整<b>水平对齐</b>并减小<b>字体大小</b>。
- 保持表列不变（无需修改）。
- <b>保存</b>组件。

{% include images-gallery.html imageCollection="reporting-getting-started-alarm-table" %}

### 步骤 2.5“折线图”组件

我们将在报表中添加的最后组件是两个独立的<b>折线图</b>，用于可视化<b>温度</b>和<b>湿度</b>的<b>历史遥测趋势</b>。每个图表将表示您设备过去<b>24小时</b>收集的数据。

<b><font size="3">1. 添加第一个图表 — 温度</font></b>

- 将<b>折线图</b>组件拖入报表的内容区域。
- 默认情况下，时间窗口显示过去一天的数据，按1小时聚合。
- 将实体别名<b>所有设备</b>设为<b>数据源</b>。
- 保留遥测键<b>temperature</b>，但将<b>标签</b>改为
  ```
  ${entityName} temperature
  ```
  {:.copy-code}

- 配置Y轴：
  - 标签：**温度**
  - 最小值：**15**
  - 最大值：**35**
  - 单位：**°C**
- 设置阈值：
  - 第一项：**30 °C**，颜色 <span style="color:red">红色</span>
  - 第二项：**18 °C**，颜色 <span style="color:blue">蓝色</span>
- 将<b>图例位置</b>设为<b>底部</b>。
- <b>保存</b>组件。

{% include images-gallery.html imageCollection="reporting-getting-started-charts-1" %}

<br><b><font size="3">2. 添加第二个图表 — 湿度</font></b>

- 在第一个下方拖入另一个<b>折线图</b>组件。
- 将实体别名<b>所有设备</b>指定为<b>数据源</b>。
- 将遥测键设为<b>humidity</b>，单位<b>%</b>，并将<b>标签</b>改为
  ```
  ${entityName} humidity
  ```
  {:.copy-code}

- 配置Y轴：
  - 标签：**湿度**
  - 单位：**%**
- 将<b>图例位置</b>设为<b>底部</b>。
- <b>保存</b>组件。

{% include images-gallery.html imageCollection="reporting-getting-started-charts-2" %}

### 步骤 2.6 保存报表模板并预览

在报表模板中添加并配置所有必需组件后，最后一步是<b>保存您的工作</b>，并可选择<b>生成测试报表</b>以验证显示是否正确。

<br><b><font size="3">更新报表文件名</font></b>

保存模板前，更新报表文件名，便于识别导出的文件：
- 在<b>文件名模式</b>字段中输入清晰、描述性的名称，例如：
  ```text
  daily-device-alarm-report-%d{yyyy-MM-dd_HH:mm:ss}
  ```
  {:.copy-code}

{% include images-gallery.html imageCollection="reporting-getting-started-save-report-1" %}

<br><b><font size="3">保存模板</font></b>

要保存当前配置：
- 点击报表构建器界面右上角的<b>保存</b>按钮。

这将把您的布局、组件和设置保存到当前模板下，供手动或[定时报表](/docs/{{docsPrefix}}user-guide/reporting/scheduling-reports/){:target="_blank"}生成时使用。

{% include images-gallery.html imageCollection="reporting-getting-started-save-report-2" %}

### 步骤 2.7 生成测试报表（可选）

要确保模板配置正确且数据按预期显示，点击"<b>生成测试报表</b>"（位于<b>保存</b>按钮旁边）。
系统将使用您所选实体别名的可用测试数据创建示例报表。

{% include images-gallery.html imageCollection="reporting-getting-started-generate-test-report" %}

## 步骤 3：为客户安排报表

<b>每日设备告警</b>报表模板准备就绪后，您可以使用调度器功能为客户端配置自动交付。

<b>正确调度的关键点</b>

为确保报表正确生成且包含准确数据，您必须指定：
- <b>报表收件人</b> — 将收到生成报表的用户（如经理或客户）。
- <b>用户账户</b> — 代表其生成报表的账户。这定义了报表的数据范围和应用的权限。

<b>为何重要</b>

在ThingsBoard中，报表根据触发报表的用户账户的访问权限生成。

示例：
- 如果报表应仅包含<b>客户A</b>拥有的设备，在调度报表时必须将<b>用户</b>字段设为属于客户A的用户的email地址。
- 同样，要为<b>客户B</b>的收件人调度报表，在<b>用户</b>字段中使用客户B用户的email地址。

这确保报表仅显示该特定用户可访问的设备和数据。

### 步骤 3.1 为客户A用户调度报表

首先，我们为客户A的所有用户配置报表的自动 deliver。
报表将代表<b>Jane Smith</b>（该客户的管理员）生成。

- 进入"<b>报表</b>"页面的"<b>调度</b>"标签页。
- 点击右上角的"<b>+ 定时报表</b>"创建新的调度器事件。
- 在调度对话框中提供以下详情：
  - 为调度事件指定清晰的标题，例如：
  ```
  客户A的每日设备告警报表
  ```
  {:.copy-code}

  - <b>事件类型</b> — 始终设为<b>创建报表</b>。
  - <b>报表模板</b> — 选择之前创建的每日设备告警报表模板。
  - <b>用户</b> — 指定代表其生成报表的用户账户：<b>janesmith@thingsboard.io</b>（Jane Smith — 客户A管理员）。

{% include images-gallery.html imageCollection="scheduler-event-customer-a-1" %}

- 设置<b>收件人</b>：
  - 在"<b>收件人</b>"字段中，点击<b>新建</b>创建新的收件人组。
    - 输入通知收件人组的<b>名称</b>。
    - 选择<b>客户用户</b>筛选器。
    - 将<b>客户</b>设为<b>客户A</b>。
    - 点击"<b>添加</b>"。

- <b>通知模板</b>和推送方式：
  - 选择现有通知模板（定义报表的推送方式）并编辑。
  - 在<b>Web</b>之外添加<b>Email</b>作为推送方式。点击"<b>下一步</b>"。
  - 添加将附加<b>PDF报表</b>的<b>邮件通知</b>的<b>主题和正文</b>。点击"<b>保存</b>"。

{% include images-gallery.html imageCollection="scheduler-event-customer-a-2" %}

<b>设置<b>调度</b></b>

- 进入<b>调度</b>标签页。
- <b>开始时间</b> — 设置首次运行的日期和时间。
- <b>时区</b> — 选择适用的时区。
- 启用<b>重复</b>：
  - <b>间隔</b> — 选择<b>每日</b>。
  - <b>结束日期</b> — 设置结束日期或留空以持续 deliver。
- 最后，点击"<b>创建</b>"保存并应用调度器事件。

现在，每天在指定时间，所有客户A用户将自动收到包含其设备告警最新信息的报表。

{% include images-gallery.html imageCollection="scheduler-event-customer-a-3" %}

### 步骤 3.2. 为客户B用户调度报表

现在让我们创建另一个调度事件，将报表发送给客户B的用户。
此报表将代表<b>Emma Johnson</b> — 该客户的管理员生成。

- 在"<b>模板</b>"页面的右上角点击"<b>+ 定时报表</b>"创建新的调度器事件。
- 为调度指定描述性名称，例如：
  ```
  客户B的每日设备告警报表
  ```
  {:.copy-code}

- 选择与客户A相同的模板 — <b>每日设备告警报表</b>。
- 将用户账户设为<b>emmajohnson@thingsboard.io</b>（Emma Johnson – 客户B管理员）。
  > 报表将代表此用户生成，仅包含客户B可访问的数据。

- 在"<b>收件人</b>"字段中，点击"<b>新建</b>"创建新的收件人组。
  - <b>名称</b>：输入<b>组名</b>。
  - <b>筛选器</b>：选择<b>客户用户</b>。
  - <b>客户</b>：设为<b>客户B</b>。
  - 点击"<b>添加</b>"。

- 使用已配置为通过<b>Email</b>和<b>Web</b>发送消息的现有<b>通知模板</b>。
- 以与客户A相同的方式设置发送调度：
  - 开始日期/时间：指定首次运行的日期和时间。
  - <b>重复</b>：启用此选项。
    - <b>间隔</b>：选择"<b>每日</b>"。
    - <b>结束日期</b>：设置调度的结束日期。

- 最后，点击"<b>创建</b>"保存调度器事件。

{% include images-gallery.html imageCollection="scheduler-event-customer-b" %}

## 步骤 4. 调度事件结果

两种场景使用相同的模板 — 每日设备告警报表。

两个客户的每位用户各自收到的报表仅包含其可访问的实体。

系统在指定时间每天自动发送报表，无需任何人工干预。

在调度事件中指定的时间，客户A和客户B的所有用户将收到[通知](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}以及生成的设备告警报表。

通知将通过两个渠道发送：

<b>1. Web UI通知</b>

- 有关生成报表的通知将出现在ThingsBoard Web UI中。
- 租户用户可以直接在ThingsBoard界面中打开报表。

> <b>重要：</b>
- 仅租户用户可以直接在ThingsBoard Web UI中查看生成的报表。
- 客户用户无法在Web UI中访问报表 — 他们只能通过<b>Email</b>或<b>Slack</b>接收。
如果收件人是客户用户，请确保至少选择其中一种推送渠道。

{% include images-gallery.html imageCollection="sent-web-notification" %}

<br>
<b>2. 邮件通知</b>
- 将向用户发送邮件，主题和正文为您在通知模板中配置的内容。
- 邮件将附带报表作为PDF文件，可在浏览器中打开查看或下载。

{% include images-gallery.html imageCollection="sent-email" %}

## 从JSON导入模板

如需要，您也可以[以JSON文件格式下载现成的“每日设备告警报表”模板](/docs/pe/user-guide/reporting/resources/daily_device_alarm_report.json){:target="_blank" download="daily_device_alarm_report.json"}。
要将JSON文件中的模板导入您的实例，请参阅[本指南](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/#importing-report-template){:target="_blank"}中的说明。

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

## 您的反馈

欢迎在[github](https://github.com/thingsboard/thingsboard){:target="_blank"}上为ThingsBoard加星，帮助我们传播。
如对本示例有任何疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。
