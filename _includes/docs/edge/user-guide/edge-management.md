* TOC
{:toc}

## 概述

**ThingsBoard** 提供两种不同的部署选项：**ThingsBoard Edge** 和 **ThingsBoard Cloud**。

**ThingsBoard Edge** 专为本地分布式数据处理而设计，可在数据产生源头直接进行数据分析与管理。这种方式支持本地处理、存储以及对关键情况的即时响应，即使无需与中央服务器保持持续连接。更多信息，请参阅 [什么是 ThingsBoard Edge](/docs/{{docsPrefix}}getting-started-guides/what-is-edge/){: target="_blank"} 文章。

相比之下，**ThingsBoard Cloud** 是托管于云端的全托管、可扩展且具备容错能力的平台。连接到云端的设备通过互联网传输数据，适用于集中式数据采集、处理和管理。更多信息，请参阅 [What is ThingsBoard](/docs/{{docsPrefix}}getting-started-guides/what-is-edge/){: target="_blank"} 文章。

### Edge 与 Cloud 的主要区别

尽管 **Edge 的设计与 Cloud 相似**，主要区别在于 **数据处理的部署位置**：
* **Edge** 在边缘设备上 **本地** 存储和处理数据。
* **Cloud** 在云端 **集中** 存储和处理数据。

**连接要求** 也有所不同：
* 连接到 **Edge** 的设备可在局域网（LAN）内运行，**无需云端连接**。
* 连接到 **Cloud** 的设备需要 **互联网连接** 才能与平台通信。

**集群部署** 指在分布式架构中的部署方式，多个节点（实例）协同工作，以实现可扩展性、容错性和高可用性。
* 早期版本的 **Edge 不支持集群部署**。其设计为在本地运行、处理和分析数据后再与中央 ThingsBoard 服务器同步。
* 从 4.0 版本起 **Edge 支持集群**。多个 Edge 节点可组成集群以实现高可用性。若一个节点故障，其他节点可无缝继续处理工作负载。
* **Cloud 支持集群部署**，对处理大规模物联网应用（设备众多、数据吞吐量高）至关重要。

## 同步架构

**ThingsBoard Edge** 与 **ThingsBoard Cloud** 通过 [gRPC（远程过程调用）协议](https://grpc.io/){: target="_blank"} 通信。该通信通道支持边缘设备与云端服务器之间的高效数据同步，实现无缝消息流，同时最大限度地降低开销和延迟。

为优化此过程，消息使用 [Protocol Buffers (ProtoBuf)](https://github.com/protocolbuffers/protobuf){: target="_blank"} 进行序列化。

从 **ThingsBoard Edge** 发送到 **ThingsBoard Cloud** 的所有消息在传输前会先存储在本地 **PostgreSQL** 表 **（cloud_event 表）** 中。从 **3.9 版本**起，这些事件可存储在 **Kafka 主题** 中（当使用 Kafka 作为队列时）。这样 **ThingsBoard Edge** 可在无法连接 Cloud 时继续运行。连接建立后，本地 **cloud_event/ts_cloud_event 表（或 Kafka 主题）** 中的所有消息将发送到 **Cloud**，并标记为已成功传输。

要查看从 **Cloud** 传输到 **Edge** 的消息列表，请进入 Cloud（Server）的 **Edge management > Instances** 区域，点击 **Edge** 并选择 **"Downlinks"** 选项卡：

{% include images-gallery.html imageCollection="downlinks" %}

### 强制同步流程

在网络中断或其他通信故障期间，**ThingsBoard Edge** 可能与 **Cloud** 不同步。Edge 实例会继续独立运行，收集遥测数据、处理设备事件并应用本地规则。然而，这些数据和状态变更无法到达 Cloud，导致不一致。

为确保 **ThingsBoard Edge** 与 **Cloud** 保持一致，以提供准确高效的物联网功能，可强制执行同步流程。

要强制执行同步，请进入 Cloud（Server）的 **Edge management > Instances** 区域，点击 **Edge**，然后点击 **"Sync Edge"** 按钮：

{% include images-gallery.html imageCollection="forceSync" %}

## 实体管理

除 **Customers** 和 **Users** 外，大多数实体可在 **Edge** 实例上创建。要在 **Edge** 上使用这些实体，必须先将其 **分配** 给 **Edge**。

要 **分配** 特定实体到 **Edge**，请登录 **Cloud** 并进入 **Edge management > Instances** 区域：

{% include images-gallery.html imageCollection="instancesSection" showListImageTitles="true" %}

实体被分配到特定 **Edge** 后，将推送到 **Edge 事件队列**。
若 Edge 与 Cloud 的 **连接** 处于 **活动** 状态，分配的实体将在 Edge 上 **立即** 创建。
若 Edge 实例 **未连接** 到 **Cloud**，实体将在 **连接建立后** 创建。

### Edge 详情

有关 Edge 及最新事件的更多信息可在 **"Edge Details"** 页面查看。
进入 **Edge management > Instances** 区域并点击 Edge：
* **"Details"** 选项卡包含一般信息，如 **Edge ID**、**Edge key** 和 **Edge secret**。您还可在此选项卡上 **分配实体** 并 **强制同步**。
* **"Attributes"** 选项卡显示发布到服务器的最新属性。
* **"Latest telemetry"** 选项卡显示 Edge 的最新遥测记录。
* **"Alarms"** 选项卡显示告警列表。
* **"Events"** 选项卡显示与 Edge 相关的各类事件。
* **"Downlinks"** 选项卡显示从 Cloud 传输到 Edge 的消息列表。
* **"Relations"** 选项卡显示与 Edge 关联的其他实体记录。
* **"Audit logs"** 选项卡显示用于追踪用户操作的审计记录。

{% include images-gallery.html imageCollection="edgeDetails" %}

### Edge 状态页

Edge 实例本身提供 Edge 配置的基本信息。要查看此信息，请登录 **Edge 实例** 并进入 **Edge > Status** 区域

{% include images-gallery.html imageCollection="edgeStatus" showListImageTitles="true" %}

### Cloud 事件

**Cloud Events** 页面显示 ThingsBoard Edge 推送到 Cloud 的事件。要查看此信息，请登录 **Edge 实例** 并进入 **Edge > Cloud events** 区域。将显示以下信息：

* **Created time：** 事件创建并推送到 Cloud 的日期和时间。格式为 YYYY-MM-DD H:Min:Sec。
* **Action：** 推送到 Cloud 的操作。可能包括：Added、Deleted、Updated、Attributes Updated、Attributes Deleted、Timeseries Deleted、Timeseries Updated、RPC Call、Credentials Updated、Relation Add or Update、Relation Deleted、Relations Deleted、Alarm Ack、Alarm Clear、Attributes Request、Rule Chain Metadata Request、Relation Request、Credential Request。
* **Entity type：** 创建事件的实体类型。
* **Entity ID：** 实体的标识代码。
* **Status：** 定义事件是否已推送到 Cloud。
  * **Deployed：** 事件已推送到 ThingsBoard 服务器。
  * **Pending：** 事件已在 ThingsBoard Edge 上创建，已保存到本地数据库，将在连接恢复后尽快推送到 Cloud。
* **Data：** 点击查看推送到 Cloud 的详细信息。

{% include images-gallery.html imageCollection="cloudEvenets" %}

默认情况下，事件显示最近一天的数据。要设置不同的时间范围，请点击页面顶部的 **"Time window"** 按钮。

## 下一步

{% include templates/edge/guides-banner-edge.md %}
