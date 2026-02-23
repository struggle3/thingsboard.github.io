* TOC
{:toc}

{% assign sinceVersion = "4.2" %}
{% include templates/since.md %}

{% assign feature = "Scheduling" %}{% include templates/pe-feature-banner.md %}

**调度器**是用于自动化报表生成的机制。它允许您基于预定义的[报表模板](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/){:target="_blank"}在指定时间设置报表的自动创建和分发。

通过调度器，您可以：
- <b>定期接收报表而无需手动执行</b> — 无需亲自触发。
- <b>设置自定义间隔</b> — 每日、每周、每月或任意自定义调度。
- <b>定义收件人和格式</b> — 选择谁收到报表以及以什么格式（PDF、CSV）。
- <b>使用一个模板为具有不同数据筛选器的多个收件人生成报表</b> — 针对不同受众定制同一报表。

## 创建新的调度器事件

- 从左侧边栏打开"**报表**"页面，进入"**调度**"标签页。
- 点击右上角的"**+ 定时报表**"按钮。
- 在调度对话框中配置以下内容：
    - 指定**调度名称**。
    - **常规配置**：
        - **事件类型** – 始终设为"生成报表"。
        - **报表模板** – 选择要使用的[预定义报表](#report-templates)模板。
        - **用户** – 选择将用于报表生成的凭据所属用户。
        - **时区** – 选择报表生成的时区。
        - **收件人**：
            - **收件人** — 指定将收到报表的用户。
            - **模板** — 选择定义报表推送方式的模板。
    - **调度设置**：
        - **开始时间** – 设置首次触发时间。
        - **时区** – 选择调度运行的时区。
        - **重复** – 切换启用重复：选择每日、每周或每月等间隔。

您可在"[报表](#reports)"标签页下找到所有生成的报表。

{% include images-gallery.html imageCollection="create-schedule-report" %}

## 报表

"**报表**"标签页存储所有生成的报表。在此您可以：
- 下载报表。
- 按报表模板或用于生成报表的凭据所属用户筛选报表。
- 删除不再需要的报表。

> 可通过[租户配置](/docs/{{docsPrefix}}user-guide/tenant-profiles/){:target="_blank"}限制每个租户生成的报表数量。

{% include images-gallery.html imageCollection="reports" %}
