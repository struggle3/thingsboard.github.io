* TOC
{:toc}

### 概述

**ThingsBoard Edge** 支持不同类型的自动化事件——**Scheduler** 和 **Rule Chain** 事件。

**Scheduler 事件** 是自动执行的周期任务，如遥测和属性更新或 RPC 命令等。
该功能详情请参阅 [ThingsBoard Platform Scheduler 文档](/docs/pe/user-guide/scheduler/){: target="_blank"} 和 [Edge Scheduler 文档](/docs/pe/edge/user-guide/scheduler/){: target="_blank"}。

{% capture white-labeling-note %}
**Scheduler** 功能仅在 **Professional Edition** 中支持。
{% endcapture %}
{% include templates/info-banner.md content=white-labeling-note %}

**Rule Chain** 可根据传入数据或事件执行自动化任务。
这些任务由 [rule nodes](/docs/pe/user-guide/rule-engine-2-0/overview/#rule-node){: target="_blank"} 执行，即 **Rule Chain** 的构建块。例如，当设备发送达到阈值的温度数据时，Rule Chain 会处理并创建告警通知。
详见 [Rule Engine](/docs/pe/user-guide/rule-engine-2-0/overview/){: target="_blank"} 和 [Rule Chain Templates](/docs/pe/edge/rule-engine/rule-chain-templates/){: target="_blank"} 文档。

#### Edge 特有说明

* 在 **Edge 4.0** 之前，**Rule Chain 模板** 无法在 **ThingsBoard Edge** 上直接创建或修改，需在 **ThingsBoard Cloud** 配置后再同步到 **Edge**。
* 自 **Edge 4.0** 起，可在 **Edge** 上创建和编辑 **Rule Chain**。
* **Scheduler 事件** 必须在 **ThingsBoard Cloud** 中配置并分配到 **Edge**。
* **Rule Chain 模板** 和 **Scheduler 事件** 同步到 **Edge** 实例后，将完全在边缘执行，不依赖互联网连接。
* **Scheduler 事件** 和 **Rule Chain 模板** 均在 **Edge** 上本地执行。

### 对比矩阵 

![comparison-matrix](/images/pe/edge/user-guide/scheduler/comparison-matrix.webp){: style="display: block; margin: auto; max-width: 700px"}

### 何时使用各自？

* **Scheduler：** 
  * 需要基于时间触发；
  * 与设备数据无关的周期或计划自动化。

* **Rule Chain：**
  * 对事件或遥测进行实时响应；
  * 需要复杂逻辑或外部 API 调用；
  * 处理本地传入数据、属性更新、告警等。

### 同时使用两项功能

为在 Edge 上创建增强自动化逻辑，可同时使用 **Scheduler 事件** 和 **Rule Chain 模板**。

![both-features-logic](/images/pe/edge/user-guide/scheduler/both-feature-logic.webp){: style="display: block; margin: auto; max-width: 750px"}

#### 用例

若要在每晚 7 点关闭设备（如泵），并在 10 分钟后若仍在运行则发出告警，需配置两个 **Scheduler 事件** 并修改 **Rule Chain 模板**。
{% include images-gallery.html imageCollection="example" showListImageTitles="true" %}

### 下一步

{% include templates/edge/guides-banner-edge.md %}
