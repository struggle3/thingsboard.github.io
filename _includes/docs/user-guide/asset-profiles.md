
* TOC
{:toc}

## 概述

自 ThingsBoard 3.4.2 起，租户管理员可使用资产 Profile 为多个资产配置通用设置。
每个资产在任一时间点有且仅有一个 Profile。
熟悉 ThingsBoard 的用户可注意到，资产类型已被弃用，由资产 Profile 取代。
更新脚本将根据唯一资产类型自动创建资产 Profile，并将其分配给相应资产。

资产 Profile 允许选择 [Rule Chain](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain) 和 [Queue](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)，供 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview) 处理资产数据。
下面介绍资产 Profile 中的可用设置。

## 创建资产 Profile

要创建资产 Profile，请进入 Profiles 选项卡下的 Asset Profiles，点击加号按钮添加新的资产 Profile。

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-add-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-add-1-pe.png)
{% endif %}

## 资产 Profile 设置

### Rule Chain

默认情况下，[Root Rule Chain](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain) 处理任意资产的所有传入消息和事件。
但是，资产类型越多，Root Rule Chain 可能越复杂。
许多平台用户创建 Root Rule Chain 的唯一目的是根据资产类型将消息发送到特定 Rule Chain。

为避免这一繁琐工作，自 ThingsBoard 3.4.2 起，可为资产指定自定义 Rule Chain。
新 Rule Chain 将接收资产属性更新以及资产生命周期（创建/更新/删除）事件。
此设置在资产 Profile 详情中可用。

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-1-pe.png)
{% endif %}

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-2-pe.png)
{% endif %}

### Queue

默认情况下，[Main](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/) 队列将用于存储来自任意资产的所有传入事件。
API 层将消息提交到此队列，Rule Engine 将轮询队列获取新消息。
但在多种用例中，您可能希望为不同资产使用不同队列。
例如，您可能希望将紧急资产数据与其他资产或设备的数据处理隔离。
这样，即使系统面临数百万水表产生的高峰负载，重要资产配置的变更也能及时处理。
队列分离还允许为不同队列自定义 [submit](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-submit-strategy) 和 [processing](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-processing-strategy) 策略。

此设置在创建资产 Profile 时及资产 Profile 详情中可用。

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-queue-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-queue-1-pe.png)
{% endif %}


{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-queue-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-queue-2-pe.png)
{% endif %}

## 资产 Profile 详情

点击资产 Profile 将打开详细视图，可在其中访问和管理该 Profile 的各个方面。

{% include images-gallery.html imageCollection="asset-profile-details-page" %}

<b><font size="3">Details（详情）</font></b>
此选项卡包含资产 Profile 的核心配置——定义使用此 Profile 的所有资产的行为和默认参数的通用设置。在此可配置 Profile 名称、默认仪表板、默认 Rule Chain、可视化设置及应用于所有关联资产的元数据。

<b><font size="3">Calculated fields（计算字段）</font></b>
显示使用基于资产属性或遥测的公式自动计算值的字段。在 Profile 级别定义的计算字段由使用此 Profile 的所有资产继承，使派生指标无需修改数据源即可一致生成。

<b><font size="3">Alarm rules（告警规则）</font></b>
包含为资产 Profile 配置的告警规则。这些规则定义：

- 触发条件
- 严重性级别
- 告警创建和清除逻辑
- 传播及可选的自动化操作

分配到此 Profile 的所有资产遵循相同告警逻辑，简化监控和管理。

<b><font size="3">Audit log（审计日志）</font></b>
显示与此资产 Profile 相关的所有用户操作列表——配置更改、规则更新及其他修改。有助于可追溯性、合规性及在 Profile 级别审查变更历史。

<b><font size="3">Version control（版本控制）</font></b>
提供资产 Profile 的基于 Git 的版本管理功能。可导出、提交和恢复 Profile 配置，支持结构化变更管理、备份和协作。

## 相关指南

可通过以下链接查看相关指南：

{% if docsPrefix == null %}
 - [Rule Chains](/docs/{{peDocsPrefix}}user-guide/ui/rule-chains/)
 - [Queues](/docs/{{peDocsPrefix}}user-guide/rule-engine-2-5/queues/)
 - [Assets](/docs/{{peDocsPrefix}}user-guide/ui/assets/)
 - [Entities and Relations](/docs/{{peDocsPrefix}}user-guide/entities-and-relations/)
  {% endif %}
  {% if docsPrefix == "pe/" %}
 - [Rule Chains](/docs/pe/user-guide/ui/rule-chains/)
 - [Queues](/docs/pe/user-guide/rule-engine-2-5/queues/)
 - [Assets](/docs/pe/user-guide/ui/assets/)
 - [Entities and Relations](/docs/pe/user-guide/entities-and-relations/)
  {% endif %}
  {% if docsPrefix contains "paas/" %}
 - [Rule Chains](/docs/paas/user-guide/ui/rule-chains/)
 - [Assets](/docs/paas/user-guide/ui/assets/)
 - [Entities and Relations](/docs/paas/user-guide/entities-and-relations/)
  {% endif %}

<hr>

## 您的反馈

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星，帮助我们传播。
如有任何问题，请[联系我们](/docs/contact-us/){:target="_blank"}。
