* TOC
{:toc}

{% assign sinceVersion = "4.2.1" %}
{% include templates/since.md %}

{% assign feature = "Reporting" %}{% include templates/pe-feature-banner.md %}

图表是强大的可视化工具，使分析更易理解、直观且可操作。通过图表，您无需手动分析原始数据即可快速发现规律和洞察。

常见用例：
- **可视化时序数据** — 跟踪指标随时间的变化并突出新兴趋势。
- **比较类别或实体** — 快速比较多台设备的数据或跨组的关键性能指标。
- **发现异常和不规则模式** — 轻松识别突然偏离或异常事件。
- **聚合数据** — 以清晰有序的方式显示时间区间的平均值、最小值或最大值。
- **展示占比和分布** — 使用饼图或环形图说明各类别对整体的贡献。
- **管理汇报** — 向利益相关者可视化传达关键洞察，而无需深入原始数据。

使用图表使分析更具视觉性，帮助您更快做出明智决策。

## ThingsBoard报表中的图表类型

ThingsBoard支持多种图表组件，每种都针对特定用途设计。
以下是可用图表列表及说明和实际示例。

<div style="display: flex; flex-direction: column;">
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 时序图表。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/time-series-table.png" alt="Time series chart" class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p>用于可视化随时间变化的值的通用图表。适合监控趋势和检测异常。可结合折线和柱状视图。<br><b>示例：</b>显示一天中各时间段的传感器温度以及每个区间的消息数量。</p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 折线图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/line-chart.png" alt="Line chart" class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    用于比较多个指标随时间的经典折线图。适合展示进展或相关性。<br>
    <b>示例：</b>比较不同区域的平均室内温度。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 柱状图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/bar-chart.png" alt="Bar chart" class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    用于比较类别或组的垂直柱状图。适合排名和显示聚合值。<br>
    <b>示例：</b>当月设备的月度能耗。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 点图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/point-chart.png" alt="Point chart" class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    以点的形式显示各个值。适用于散点图或事件随时间分布。<br>
    <b>示例：</b>显示运动传感器触发事件。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 状态图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/state-chart.png" alt="State chart" class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    展示系统或设备状态随时间的变化（例如ONLINE/OFFLINE）。<br>
    <b>示例：</b>一周内泵的活动状态（开/关）。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 带标签的柱状图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/bar-chart-with-labels.png" alt="Bar chart with labels." class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    在柱内或柱上方显示数值标签的柱状图。突出精确值。<br>
    <b>示例：</b>每户每日用水量，升数直接显示在柱上。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 范围图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/range-chart.png" alt="Range chart." class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    以阴影区域形式显示随时间的最小值和最大值。<br>
    <b>示例：</b>每小时最低/最高温度。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 条形图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/bars.png" alt="Bars." class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    以进度条形式紧凑显示指标。适用于完成度。<br>
    <b>示例：</b>电池电量或内存使用率。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 饼图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/pie.png" alt="Pie." class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    用于显示整体各部分构成的圆形图表。<br>
    <b>示例：</b>各部门用电占比。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 环形图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/doughnut.png" alt="Doughnut." class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    与饼图类似，但中间空心处可显示关键指标（如平均值、总和、KPI）。<br>
    <b>示例：</b>已用容量百分比加上中心的绝对值。
    </p>
  </div><br>
  <div>
    <p style="font-size: 16px;">
      <b>&#8226; 横向环形图。</b>
    </p>
    <img src="/images/user-guide/reporting/embedding-charts/horizontal-doughnut.png" alt="Horizontal doughnut." class="image-float" style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px">
    <p class="text-content">
    环形图的横向变体，以并排圆环形式显示。适用于紧凑的指标比较。<br>
    <b>示例：</b>项目中已完成与待办任务的百分比。
    </p>
  </div>
</div>

<hr>

## 向报表添加图表

1. 导航至**报表**页面的**模板**标签页。
2. 打开现有报表（或子报表）模板或[创建新模板](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/#how-to-create-a-report-template){:target="_blank"}。
3. 在**组件库**中，进入**图表**，选择**图表类型**，并将其拖入报表的**内容区域**。

<hr>

## 配置图表

定义图表应显示的数据、该数据的时间区间、X轴和Y轴配置、阈值、图例、外观设置及其他选项。

#### 时间窗口

- 定义在图表上显示遥测数据的时间区间。更多关于配置时间窗口的信息请见[此处](/docs/{{docsPrefix}}user-guide/dashboards/#time-window){:target="_blank"}。

#### 数据配置

- **数据源：**
  - 定义图表的数据源：
    - **设备** — 来自特定设备的遥测。
    - **实体别名** — 对一个或多个实体的抽象引用。当图表需要与多个实体配合使用时常用。
  - 如需要，配置[筛选器](/docs/{{docsPrefix}}user-guide/widgets/#filters){:target="_blank"}。

- **系列：**
  指定要可视化的遥测键（例如*temperature*）。

对于每个数据键（取决于所选图表），您可以配置单位、标签、颜色、折线或柱状样式等。

#### 布局设置

通过设置高度、宽度、对齐、内边距、外边距、背景和边框样式来调整组件外观。

#### 其他设置

根据图表类型，您可以配置提高清晰度和可用性的附加选项：

- **Y轴** – 配置轴标签、单位、位置和值范围，以控制垂直数据的显示方式。
- **阈值** – 基于常量值、键或实体添加参考线，以突出安全、警告或临界限制。
- **X轴** – 定义水平轴属性，包括标签、位置、刻度线和垂直线。
- **图例** – 管理图表图例的放置、格式和内容，以明确各系列的含义。
- 有关配置其他选项及更多详情，请参阅[部件](/docs/{{docsPrefix}}user-guide/widgets/){:target="_blank"}文档。

#### 保存与测试

1. 配置图表后，点击**保存**。
2. 要验证模板配置是否正确且数据按预期显示，点击<b>生成测试报表</b>（位于<b>保存</b>按钮旁边）。
系统将使用所选设备或实体别名的可用测试数据生成示例报表。

<hr>

## 示例：嵌入折线图

**目标：** 显示并比较三台设备过去24小时的温度读数。

<br><b><font size="4">步骤 1. 准备</font></b>

- **准备三台设备**，向ThingsBoard发送温度值作为遥测。我的设备数据每小时发送一次。
  > 如需要，可使用[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/){:target="_blank"}实时模拟遥测。
  [参见本指南](/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-3/#simulation-of-the-devices-telemetry-data){:target="_blank"}

<b><font size="4">步骤 2. 添加图表</font></b>

- 进入<b>报表</b>页面的<b>模板</b>标签页。
- 选择现有报表模板或[创建新模板](/docs/{{docsPrefix}}user-guide/reporting/reporting-key-concepts/#how-to-create-a-report-template){:target="_blank"}。
- 将<b>折线图</b>组件拖入报表的内容区域。

{% include images-gallery.html imageCollection="chart-component-example-1" %}

<br><b><font size="4">步骤 3. 配置图表</font></b>

- **时间窗口：** 过去24小时，按1小时聚合。
- **标题：**
  ```text
  温度历史
  ```
  {:.copy-code}

- **数据源：** 创建包含三台设备的新实体别名。
  - **别名名称：** 我的设备
  - **筛选类型：** 实体列表
  - **类型：** 设备
  - **实体列表：** 指定三台用于比较温度值的设备。
- **系列：** 添加遥测键<b>temperature</b>，标签为
  ```text
  ${entityName} temperature
  ```
  {:.copy-code}

- **Y轴：**
  - **标签：** 温度
  - **最小值：** 15
  - **最大值：** 35
  - **单位：** °C
- **图例：**
  - **位置**在**底部**，
  - 显示**最小值**、**最大值**和**平均值**。
- **保存**组件。

{% include images-gallery.html imageCollection="chart-component-example-2" %}

<br><b><font size="4">步骤 4. 保存报表模板</font></b>

- 更新文件命名模式，便于识别导出的报表：
  ```
  temperature-monitoring-report-%d{yyyy-MM-dd_HH:mm:ss}
  ```
  {:.copy-code}

- 保存模板。

{% include images-gallery.html imageCollection="chart-component-example-3" %}

<br><b><font size="4">步骤 5. 测试</font></b>

- 点击<b>生成测试报表</b>以验证配置。

{% include images-gallery.html imageCollection="chart-component-example-4" %}

<br><b><font size="4">✅ 结果</font></b>

生成的报表将包含显示所有三台设备温度趋势的折线图，方便您随时间比较。

{% include images-gallery.html imageCollection="chart-component-example-5" %}

<hr>

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 您的反馈

欢迎在[github](https://github.com/thingsboard/thingsboard){:target="_blank"}上为ThingsBoard加星，帮助我们传播。
如对本示例有任何疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。
