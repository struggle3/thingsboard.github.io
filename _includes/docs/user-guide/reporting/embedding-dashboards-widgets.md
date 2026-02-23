* TOC
{:toc}

{% assign sinceVersion = "4.2" %}
{% include templates/since.md %}

{% assign feature = "Reporting" %}{% include templates/pe-feature-banner.md %}

**仪表盘组件**允许您获取所选仪表盘的快照，并将其以图像形式插入报表中。

因此，报表将显示**报表生成时的仪表盘静态视图**。

适用于以下场景：
- 将仪表盘包含在[定时报表](/docs/{{docsPrefix}}user-guide/reporting/scheduling-reports/){:target="_blank"}中
- 将仪表盘数据归档供历史参考
- 在不暴露实时数据访问的情况下共享仪表盘快照

<hr>

## 添加组件

1. 导航至**报表**页面的**模板**标签页。<br>
2. 打开现有报表（或子报表）模板或[创建新模板](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/#how-to-create-a-report-template){:target="_blank"}。<br>
3. 在**组件库**中，找到**仪表盘**组件，并将其拖入报表的**内容区域**。

<hr>

## 配置

#### 数据源

所嵌入仪表盘上的部件可能：
- 在部件设置中已定义自己的数据源，
- 完全没有数据源（例如静态信息卡片），
- 或配置为显示报表模板仪表盘组件中定义的实体（或实体组）的数据。

如果仪表盘上的部件配置为显示组件中设置的实体（或实体组）的数据：
- 定义组件的数据源（设备或[实体别名](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}）。
- 如需要，配置[筛选器](/docs/{{docsPrefix}}user-guide/widgets/#filters){:target="_blank"}。

{% capture difference %}
如果别名包含多个实体，报表将为<b>每个实体生成一份仪表盘副本</b>。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

#### 目标仪表盘

- 选择要嵌入报表的**仪表盘**。
- 可选地指定特定的**仪表盘状态**。
- 您还可以为快照配置自定义**时间窗口**和**时区**。

#### 布局设置

通过设置以下项调整组件外观：
- 宽度
- 对齐
- 内边距和外边距
- 背景和边框样式

#### 保存与测试

1. 配置仪表盘组件后，点击**保存**。
2. 要验证模板配置是否正确且数据按预期显示，点击<b>生成测试报表</b>（位于<b>保存</b>按钮旁边）。
   系统将使用所选设备或实体别名的可用测试数据生成示例报表。

<hr>

## 示例：嵌入环境监测仪表盘

本示例中，我们将把预配置的<b>环境监测</b>仪表盘嵌入报表。
该仪表盘上的所有部件均使用"[仪表盘状态中的实体](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state){:target="_blank"}"作为数据源。
这意味着它们将显示您在报表模板中指定为数据源的实体的值。

{% include images-gallery.html imageCollection="dashboard-component-example-1" %}

<br><b><font size="4">步骤 1. 准备</font></b>

1. **准备一台设备**，向ThingsBoard发送**温度和湿度遥测**。
   如没有真实设备，可使用[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/){:target="_blank"}实时模拟发送遥测数据。[参见本指南](/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-3/#simulation-of-the-devices-telemetry-data){:target="_blank"}

2. **准备要嵌入的[仪表盘](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}**：
   - [以JSON格式下载**环境监测**仪表盘](/docs/pe/user-guide/reporting/resources/environmental_monitor.json){:target="_blank" download="environmental_monitor.json"}
   - [导入](/docs/{{docsPrefix}}user-guide/dashboards/#import-dashboard){:target="_blank"}到您的ThingsBoard实例。
   - 或使用您现有的仪表盘。

<b><font size="4">步骤 2. 添加组件</font></b>

- 进入"<b>报表</b>"页面的"<b>模板</b>"标签页。
- 打开现有<b>报表模板</b>或[创建新模板](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/#how-to-create-a-report-template){:target="_blank"}。
- 将<b>仪表盘</b>组件拖入报表的<b>内容区域</b>。

{% include images-gallery.html imageCollection="dashboard-component-example-2" %}

<br><b><font size="3">步骤 3. 配置数据源</font></b>

- 在"<b>数据源</b>"部分，选择其数据应在仪表盘中显示的设备。
- 在"<b>目标仪表盘</b>"部分，选择<b>环境监测</b>仪表盘。
- <b>保存</b>组件。

{% include images-gallery.html imageCollection="dashboard-component-example-3" %}

<br><b><font size="3">步骤 4. 保存报表模板</font></b>

- 更新<b>文件名模式</b>，便于识别导出的报表。
  例如：

```text
environmental-monitor-report-%d{yyyy-MM-dd_HH:mm:ss}
```
{:.copy-code}

- **保存**模板。

{% include images-gallery.html imageCollection="dashboard-component-example-4" %}

<br><b><font size="4">步骤 5. 测试</font></b>

- 点击<b>生成测试报表</b>以验证配置。

{% include images-gallery.html imageCollection="dashboard-component-example-5" %}

<br><b><font size="4">✅ 结果</font></b>

报表现在将包含环境监测仪表盘的快照，并带有所选设备的数据。

{% include images-gallery.html imageCollection="dashboard-component-example-6" %}

<hr>

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 您的反馈

欢迎在[github](https://github.com/thingsboard/thingsboard){:target="_blank"}上为ThingsBoard加星，帮助我们传播。
如对本示例有任何疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。
