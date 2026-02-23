* TOC
{:toc}

## 应用场景

假设您需要使用ThingsBoard规则引擎实现「计数器」逻辑。
由于消息处理在规则节点内部异步执行，大多数情况下，「获取当前计数值 -> 加上新计数值 -> 保存计数值」这种逻辑会因竞态条件而产生与预期不符的错误结果。
这是多线程编程中常见的问题。您可参考这篇[文章](https://opensourceforgeeks.blogspot.com/2014/01/race-condition-synchronization-atomic.html)了解该问题及现有解决方案。
自ThingsBoard v2.5起，可通过可配置队列解决该处理问题。

在本教程中，我们将配置ThingsBoard规则引擎，使用具有「按来源顺序提交」消息策略的队列。
尽管该场景为虚构示例，您将学习如何使用队列实现消息顺序处理，并在实际应用中运用该知识。

## 前置条件

我们假定您已完成以下指南并阅读了所列文章：

  * [快速入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  
此外，您需要在环境中至少预置一个设备。

## 步骤 1：创建规则链

![Rule chain image](/images/user-guide/rule-engine-2-5/tutorials/sync_rule_chain.png)

我们将添加两个生成器节点，每个生成七条消息。第一个生成器将产生计数值为 101 的消息。
第二个生成器产生计数值为 10 的消息。因此最终结果应为 777。

![First generator image](/images/user-guide/rule-engine-2-5/tutorials/generator1.png)
![Second generator image](/images/user-guide/rule-engine-2-5/tutorials/generator2.png)

两条消息都将放入 **SequentialByOriginator** 队列。该队列使用[消息提交策略](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#submit-settings)
**SEQUENTIAL_BY_ORIGINATOR**，即基于来源实体的后续消息将在前一条消息被确认（处理完成并从队列删除）后开始处理。

我们使用 **originator attributes** 节点获取当前「计数器」值。当前禁用「若任一属性缺失则告知失败」，因为设备可能尚不具备所需属性，启用会导致错误。
该属性将在第一条消息到达 **save attributes** 节点后设置到设备。
![Originator attributes node image](/images/user-guide/rule-engine-2-5/tutorials/sync_originator_attributes.png)

使用 **script** 节点执行计算。

![Script node image](/images/user-guide/rule-engine-2-5/tutorials/sync_counter_script.png)

最后一步是使用 **save attributes** 节点保存新的计数值。

![Save attributes node image](/images/user-guide/rule-engine-2-5/tutorials/sync_save_counter_attribute.png)

## 步骤 2：验证规则链逻辑

保存规则链以验证我们的逻辑是否正确。生成器将自动产生 14 条消息：

![Events image](/images/user-guide/rule-engine-2-5/tutorials/sync_events.png)

持久化到设备的最终计数值为：

![Device attributes image](/images/user-guide/rule-engine-2-5/tutorials/sync_result.png)

这说明我们的逻辑正确无误。

## 快速总结

下载并导入本教程附带的规则链 JSON [**文件**](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/resources/synchronization_rule_chain.json)。
别忘了在生成器节点中填写您的具体设备。

## 下一步

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}
