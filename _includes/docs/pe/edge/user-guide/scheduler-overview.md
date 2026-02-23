* TOC
{:toc}

### Scheduler 概述

{% capture white-labeling-note %}
**Scheduler** 功能仅在 **Professional Edition** 中支持。
{% endcapture %}
{% include templates/info-banner.md content=white-labeling-note %}

**ThingsBoard Scheduler** 是一项允许用户自动化周期任务的功能，例如遥测和属性更新、RPC 命令和规则链触发。

**Edge** 的 **Scheduler** 功能与 **Platform** 设计类似。
完整说明请参阅 **ThingsBoard Platform** [Scheduler 文档](/docs/pe/user-guide/scheduler/){: target="_blank"}。

**Scheduler 事件** 无法在 **ThingsBoard Edge** 上直接创建或修改，所有调度必须在 **ThingsBoard Platform** 中配置后分配到 **Edge** 实例。
这些计划任务直接在 **Edge** 实例上执行，确保即使无云连接也能实时自动化。

### 配置 Scheduler 功能 

创建 **Scheduler 事件**：

{% include images-gallery.html imageCollection="createSchedulerEvent" showListImageTitles="true" %}

### 使用 ThingsBoard Edge 进行计划灌溉管理（用例）

为说明 **Scheduler** 功能在自动化和管理效率中的作用，请参阅 [智能灌溉解决方案模板](/docs/pe/solution-templates/smart-irrigation/){: target="_blank"}。

该解决方案基于 **土壤湿度传感器读数** 和 **预定义计划** 实现自动化灌溉。
目标是在 **最小化用水** 的同时维持最佳土壤湿度水平。

由于灌溉系统通常部署在偏远农田，**ThingsBoard Edge** 实例将在本地运行，确保即使在网络中断情况下也能持续运行。

**智能灌溉解决方案模板** 可：
* 确保每天在预定义时间灌溉两次。
* 实时监控关键参数，例如：
  * 土壤湿度。
  * 日用水量。
  * 灌溉时长。
* 在 **ThingsBoard Edge** 上本地运行，避免依赖持续互联网连接。

安装解决方案模板时，请登录 **ThingsBoard Platform** 并进入 **Solution templates** 部分。
向下滚动到 **Smart Irrigation** 区块并点击 **"Install"** 按钮。

{% include images-gallery.html imageCollection="installTemplate" %}

#### 配置详情

查看配置详情。
由于 **规则链** 和 **Scheduler 事件** 无法在 **Edge** 上直接创建，所有配置需先在 **ThingsBoard Platform** 完成后再与 **Edge** 实例同步。

**智能灌溉解决方案模板** 会自动创建 **Edge** 实例并分配所有所需配置。

{% include images-gallery.html imageCollection="remoteFarmR1" showListImageTitles="true" %}

##### Scheduler

{% include images-gallery.html imageCollection="schedulerParameters" showListImageTitles="true" %}

##### 规则链

{% include images-gallery.html imageCollection="ruleChainParameters" showListImageTitles="true" %}

##### 可视化

{% include images-gallery.html imageCollection="dashboard" showListImageTitles="true" %}

#### Scheduler 的优势
**智能灌溉解决方案模板** 中配置的 **Scheduler** 功能：
* 确保偏远地区自主灌溉，不依赖云。
* 基于固定计划运行灌溉，优化用水。
* 减少人工干预，提高运维效率。
* 通过实时土壤湿度遥测更新增强监控。

### 下一步

{% include templates/edge/guides-banner-edge.md %}
