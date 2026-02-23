* TOC
{:toc}

{% assign sinceVersion = "4.2" %}
{% include templates/since.md %}

{% assign feature = "Reporting" %}{% include templates/pe-feature-banner.md %}

在ThingsBoard中，您可以将已生成的报表附加到通过可用渠道发送给用户的系统[通知](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}（仅限Web、Email或[Slack](/docs/{{docsPrefix}}user-guide/notifications/#slack){:target="_blank"}）。
这样可以将事件通知与完整报表配对，收件人可以即时打开、查看或下载。

> **重要**：如果收件人是客户用户，报表只能附加到通过Email或Slack发送的通知。
直接在Web UI中查看报表仅适用于租户用户。

**适用场景：**
- 当发生关键告警时自动发送报表。
- 定期发送摘要，无需手动运行调度器。
- 将系统事件（如数据更新）与最新的分析内容相结合。

<br><b><font size="4">示例：向“新告警通知”模板添加报表</font></b>

让我们通过现有的"<b>新告警通知</b>"[模板](/docs/{{docsPrefix}}user-guide/notifications/#templates){:target="_blank"}，了解如何将报表附加到通知。
该模板用于在创建新告警时向租户管理员发送告警。

<b>我们将进行以下修改：</b>
- <b>添加另一种推送方式 — Email</b>（在现有的Web通知之外）。
- <b>附加包含详细告警信息的PDF报表</b>到邮件中。

<b><font size="3">首先，创建用于生成PDF报表的模板。</font></b>

我们将在模板中添加一个组件 — 告警表 — 用于显示创建的告警及其详情。

- 从左侧菜单进入"<b>报表</b>"页面 — 默认会进入"<b>模板</b>"标签页。
- 点击右上角的"<b>+ 添加报表模板</b>"按钮，选择"<b>创建新报表模板</b>"。
- 在弹窗中填写以下内容：
  - 将其<b>名称</b>设为"<b>新告警</b>"。
  - 选择<b>PDF</b>报表<b>格式</b>。
  - 选择<b>报表</b>作为<b>模板类型</b>。<br>
  - 点击"<b>添加</b>"以创建报表模板并打开<b>报表构建器</b>界面。

**在报表构建器中配置报表：**

- 找到并将"<b>告警表</b>"组件拖入报表的内容区域。
- 在"<b>告警来源</b>"部分，点击"<b>新建</b>"实体别名按钮。
  - 使用"<b>源实体</b>"筛选器 — 这样，表格将从触发通知的实体接收数据。
- 应用筛选器以仅显示<b>活动</b>告警。
- 保存组件。
- 点击右上角的"<b>保存</b>"以保存您的模板配置。

{% include images-gallery.html imageCollection="reporting-getting-started-save-report-1" %}

<br><b><font size="3">现在，修改“新告警通知”模板。</font></b>

- 进入"<b>通知中心</b>"页面的"<b>模板</b>"标签页。
- 找到"<b>新告警通知</b>"模板，<b>点击</b>以打开编辑。
- 添加另一种通知推送方式 — <b>Email</b>。
- 启用"<b>附加报表</b>"选项。
  - 选择之前创建的<b>新告警</b>模板。
  - 指定代表其生成报表的用户账户：<b>john.doe@thingsboard.io</b>（John Doe — 租户管理员）。
  - 点击"<b>下一步</b>"。
- 输入将随PDF报表一起通过邮件发送的<b>主题和消息</b>。
- 点击"<b>保存</b>"按钮保存对模板的修改。

{% include images-gallery.html imageCollection="reporting-getting-started-save-report-2" %}

<br><b><font size="3">修改“新告警通知”模板后，建议测试一切是否按预期工作。</font></b>

首先，确保已为设备配置告警创建规则。
您可以在文档相关章节找到配置此类规则的说明（[查看链接](https://thingsboard.io/docs/getting-started-guides/helloworld-pe/#step-4-configure-alarm-rules){:target="_blank"}）。

{% include images-gallery.html imageCollection="alarm-rule" %}

通过为设备发布超过告警创建规则中定义的阈值的遥测数据来触发告警。
最简单的方法是使用ThingsBoard中的[检查连接性](https://thingsboard.io/docs/getting-started-guides/helloworld-pe/#step-2-connect-device){:target="_blank"}功能。

{% include images-gallery.html imageCollection="check-connectivity-feature" %}

<b>检查通知：</b>

您应立即在ThingsBoard Web UI中看到通知。

{% include images-gallery.html imageCollection="reporting-getting-started-save-report-3" %}

同时将向所有租户管理员发送邮件，并附上包含告警详情的PDF报表。用户可以在浏览器中打开并查看报表或下载。

{% include images-gallery.html imageCollection="reporting-getting-started-save-report-4" %}
