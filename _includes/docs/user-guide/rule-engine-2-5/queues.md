* TOC
{:toc}

## 简介

ThingsBoard 使用队列保障消息处理、应对偶发峰值，并在高负载下保持系统稳定运行。
可在架构说明中[进一步了解队列](/docs/{{docsPrefix}}reference/#message-queues-are-awesome)。

ThingsBoard 支持两类消息队列：**Kafka** 和 **In-Memory**。
- **Kafka** 是广泛使用的分布式持久化消息队列，面向海量数据，适合高吞吐、高可用、可扩展的生产环境。
- **In-Memory** 队列是轻量、快速、简单的实现，面向小规模或开发环境，将消息存储在内存而非磁盘，优先考虑速度而非持久化。

平台 3.4 版本引入了配置 UI，简化配置与管理并提升用户体验。
简而言之，规则引擎在启动时订阅队列并轮询新消息。
始终存在 **Main** 主题（队列）作为新消息的默认入口。
可通过 **Checkpoint** 节点将消息放入其他主题。
该节点会自动确认目标主题中的对应消息。

## 队列配置

仅**系统管理员**用户可配置队列。配置后，新更改会立即生效。
队列有两种配置模式：**通用队列配置**和**隔离租户队列配置**。
更多关于隔离租户的信息，请参阅[租户配置](/docs/{{docsPrefix}}user-guide/tenant-profiles/#processing-in-isolated-thingsboard-rule-engine-queues)。

### 通用队列配置

开箱即用时，所有消息（如遥测、连接或生命周期事件等）会被推送到 **Main** 或选定的默认主题。
当禁用隔离处理（默认）时，ThingsBoard 将各租户的消息放入公共主题。优点：成本更低；无需额外管理 VM 或容器。缺点：单个规则引擎服务被所有租户共享。

创建新队列步骤如下：
 - 以系统管理员身份登录；
 - 进入 **Settings** 页面的 **Queues** 标签；
 - 点击「plus」按钮创建新队列。

{% if docsPrefix == null %}
![image](/images/user-guide/queues/add-queue-1-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/queues/add-queue-1-pe.png)
{% endif %}

 - 输入队列名称。选择策略类型并配置重试处理与轮询设置。点击 Add。

{% if docsPrefix == null %}
![image](/images/user-guide/queues/add-queue-2-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/queues/add-queue-2-pe.png)
{% endif %}

您已创建自定义队列。

{% if docsPrefix == null %}
![image](/images/user-guide/queues/add-queue-3-ce.png)
{% endif %}
{% if docsPrefix == "pe/" %}
![image](/images/user-guide/queues/add-queue-3-pe.png)
{% endif %}

{% capture difference %}
**注意：**
<br>
**Main** 队列设置可调整，但主题本身不能重命名或删除。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 隔离租户的队列配置

为便于查阅，该配置与隔离租户[文档](/docs/{{docsPrefix}}user-guide/tenant-profiles/#queue-configuration-for-isolated-tenants)放在一起。

## 队列设置

队列定义包含以下参数与模块：

* **Name** — 用于统计与日志；
* [提交设置](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#submit-settings) — 定义向规则引擎提交消息的逻辑与顺序；
* [重试处理设置](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#retries-processing-settings) — 定义消息确认逻辑；
* [轮询设置](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#polling-settings) — 批量与即时处理的队列设置。

### 提交设置 {#submit-settings}

规则引擎服务持续轮询特定主题的消息，一旦 Consumer 返回消息列表则创建 TbMsgPackProcessingContext 对象。队列提交策略控制 TbMsgPackProcessingContext 中的消息如何投递到规则链。
共有 5 种策略：

* **Sequential by originator** — 按实体（消息来源）逐个提交。例如 Device A 的新消息需等 Device A 的前一条消息被确认后才提交。
* **Sequential by tenant** — 在租户（消息来源的拥有者）内按序提交。例如 Tenant A 的新消息需等 Tenant A 的前一条消息被确认后才离开队列。
* **Sequential** — 消息一条接一条提交。前一条消息被确认前，新消息不会提交。处理较慢。
* **Burst** — 所有消息按到达顺序提交到规则链。
* **Batch** — 使用**分组参数 "Batch size"** 将消息分批。前一批确认前，新一批不会提交。

参见本[指南](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/queues-for-synchronization/)了解提交策略用例。

### 重试处理设置 {#retries-processing-settings}

处理策略控制失败或超时消息如何被重新处理。共有 5 种策略：

* **Retry failed and timeout** — 重试处理包中所有失败和超时的消息。
* **Skip all failures** — 忽略所有失败，失败消息将「丢失」。
  例如 DB 宕机时，消息不会被持久化，但仍标记为「acknowledged」并从队列删除。
  该策略主要用于与旧版本向后兼容及开发/演示环境。
  已提交给规则链处理的超时消息不会被取消，规则引擎仍会尝试处理。
* **Skip all failures and timeouts** — 忽略所有失败和超时，失败与超时消息将「丢失」。
  例如 DB 宕机时，消息不会被持久化，但仍标记为「acknowledged」并从队列删除。
  已提交给规则链处理的超时消息将被取消。
  规则节点不会开始处理被取消的消息；已开始处理的消息在取消时不会被中断。
* **Retry all** — 重试处理包中所有消息。假设处理包有 100 条消息。
  若其中 1 条失败，策略仍会重新处理（重提交到规则引擎）全部 100 条。
  每次重提交到规则引擎时，这些消息为原始消息的二进制副本。
  重提交前会取消前一次提交的所有消息。
  规则节点不会开始处理被取消的消息；已开始处理的消息在取消时不会被中断。
* **Retry failed** — 仅重试处理包中失败的消息。假设处理包有 100 条消息。
  若其中 1 条失败，策略仅重新处理（重提交到规则引擎）该 1 条。超时消息不会重试。
  每次重提交到规则引擎时，这些消息为原始消息的二进制副本。
  重提交前会取消前一次提交的所有消息。
  规则节点不会开始处理被取消的消息；已开始处理的消息在取消时不会被中断。
* **Retry timeout** — 仅重试处理包中超时的消息。假设处理包有 100 条消息。
  若其中 1 条超时，策略仅重新处理（重提交到规则引擎）该 1 条。失败消息不会重试。
  每次重提交到规则引擎时，这些消息为原始消息的二进制副本。
  重提交前会取消前一次提交的所有消息。
  规则节点不会开始处理被取消的消息；已开始处理的消息在取消时不会被中断。

所有重试处理策略均支持以下重要配置参数：

* **Number of retries** — 重试次数，0 表示不限；
* **Percentage of failure messages for skipping retries** — 若失败或超时占比小于 X%，则跳过重试；
* **Retry within** — 在 consumer 线程中等待重试的秒数；
* **Additional retry within** — 第二次及后续重试的等待秒数。

参见本[指南](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/queues-for-message-reprocessing/)了解处理策略用例。

### 轮询设置 {#polling-settings}

批量处理：
* **Poll interval** — 无新消息时，两次轮询之间的毫秒间隔。
* **Partitions** — 与本队列关联的分区数。用于扩展可并行处理的消息数量。

即时处理：
* **Send message poll for each consumer** — 队列由分区组成。未勾选时，所有分区共用一个 consumer；勾选时，每个分区有独立 consumer。
* **Processing within** — consumer 返回的消息包的处理间隔（毫秒）。

### 自定义属性

可为队列（主题）创建指定自定义属性。属性与队列提供者相关，
例如 Kafka 的 `retention.ms:604800000;retention.bytes:1048576000`，
或 AWS SQS 的 `MaximumMessageSize:262144;MessageRetentionPeriod:604800` 等。

注意：这些属性仅在队列首次创建时生效。

## 默认队列

预配置三个默认队列：Main、HighPriority、SequentialByOriginator。
它们按提交和处理策略区分。
规则引擎主要从 **Main** 主题处理消息，也可通过「Checkpoint」规则节点将消息放入其他主题。
Main 主题默认忽略失败消息，以保持与旧版本兼容。
您可在了解风险后自行重配置。
注意：若某条消息因规则节点脚本失败而未处理，可能阻塞后续消息。
我们设计了专用[仪表板](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics)用于监控规则引擎处理与失败情况。

**HighPriority** 主题可用于告警或其他关键处理步骤。
HighPriority 主题中的消息在失败时会持续重试，直至处理成功。
适用于 SMTP 或外部系统宕机场景，规则引擎会持续重试发送直至处理完成。

若需保证消息按正确顺序处理，**SequentialByOriginator** 主题很重要。
来自同一实体的消息将按进入队列的顺序处理。
规则引擎在前一条（同一实体 ID）消息被确认前，不会向规则链提交新消息。

## 下一步

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}