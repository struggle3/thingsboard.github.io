* TOC
{:toc}

## 概述

**ThingsBoard 告警**是用于监控和响应实体事件及条件的重要功能。
若要全面了解 **ThingsBoard 告警**功能，请参阅 [Working with Alarms](/docs/{{cloudDocsPrefix}}user-guide/alarms/){: target="_blank"} 文档。

尽管 **Edge** 的 **告警** 功能设计与 **Cloud** 类似，但包含若干显著差异：
* 告警在 **Edge** 上本地处理，侧重于触发告警的即时条件，不依赖连接性。
* 告警数据可从 **Edge** 推送到 **Cloud**，也可从 **Cloud** 发回至 **Edge**。此设置支持跨不同位置的实时监控和告警管理。
* Edge 告警可与本地其他系统或软件集成，用于进一步处理、通知或执行操作。

简而言之，**ThingsBoard Edge 告警**提供可独立于 **Cloud** 连接运行的实时、本地化告警管理。

## 在 Edge 实例上创建告警

**Edge 告警**的创建和配置方式与 **Cloud 告警**相同。因此，需要根据告警触发条件定义 **参数和规则**。

创建告警最简单的方式是使用 [Device profile 中的告警规则](/docs/{{cloudDocsPrefix}}user-guide/device-profiles/#alarm-rules){: target="_blank"}。大多数任务可通过 **Alarm Rules** 以最少配置完成。

如需更复杂的逻辑，建议使用另一种方式，即在 [Rule Engine](/docs/{{cloudDocsPrefix}}user-guide/rule-engine-2-0/re-getting-started/){: target="_blank"} 中使用 ["Create Alarm"](/docs/user-guide/rule-engine-2-0/nodes/action/create-alarm/){:target="_blank"} 和 ["Clear Alarm"](/docs/user-guide/rule-engine-2-0/nodes/action/clear-alarm/){: target="_blank"} 规则节点。这是较高级选项，需要一定的编程能力。请参阅 [corresponding example](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/){: target="_blank"}。

## 从 Cloud 推送告警到 Edge

**ThingsBoard 系统**支持将 **告警** 从 **Cloud** 推送到 **Edge**，以提高运营效率并减少对 **Cloud** 资源的依赖。

{% capture prerequisite %}
请提前确定要使用的 **Rule Chain**，这将显著影响配置过程。
{% endcapture %}
{% include templates/info-banner.md content=prerequisite %}

### 操作指南

将告警从 **Cloud** 推送到 **Edge**，请按以下步骤操作：

{% include images-gallery.html imageCollection="push-to-edge" showListImageTitles="true" %}

## 从 Edge 推送告警到 Cloud

**ThingsBoard** 同样支持将告警从 **Edge** 推送到 **Cloud**。
{% capture local-deployment %}
**请注意！** <br>
若使用 **较早版本** 的 Edge，您 **无法** 在 **Edge** 本身创建或编辑 **Rule Chain**。必须在 **Cloud (Server)** 中配置为模板，然后分配给 **Edge** 实例。

从 **Edge 4.0** 起，您可以在 **Edge** 上创建和编辑 **Rule Chain**。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

### 操作指南

将告警从 **Edge** 推送到 **Cloud**，请按以下步骤操作：

{% include images-gallery.html imageCollection="push-to-cloud" showListImageTitles="true" %}

## 下一步

{% include templates/edge/guides-banner-edge.md %}
