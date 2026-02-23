* TOC
{:toc}

## 功能概述

ThingsBoard (TB) 实体视图 (EV) 自 v2.2 起可用。该功能为许多 TB 用户所需求。
类似于 SQL 数据库视图限制底层表对外暴露程度，TB EV 限制设备或资产的 [遥测](/docs/{{docsPrefix}}user-guide/telemetry/) 和 [属性](/docs/{{docsPrefix}}user-guide/attributes/) 向 [客户](/docs/{{docsPrefix}}user-guide/ui/customers/) 的暴露程度。
作为租户管理员，您可为每台设备或资产创建多个 EV，并分配给不同客户。

支持的用例：

 - **同时共享** 特定设备或资产数据给多个客户。之前的 EV 功能因 TB 安全模型限制而无法实现。
 - 允许特定客户用户查看收集的数据（如传感器读数），但 **隐藏** 电池电量、系统错误等调试信息。
 - 设备即服务（**DaaS**）模型，其中设备在不同时间段收集的数据属于不同客户。

## 架构

实体视图包含以下信息：

 - **TenantId** - 表示与视图所有者的链接；
 - **CustomerId** - 表示与有权访问视图的客户的链接；
 - **EntityId** - 表示与目标设备或资产的链接；
 - **Name and type** - 用于显示和搜索的常规 ThingsBoard 实体字段；
 - **Start and end time** - 表示用于限制对目标设备遥测的访问的时间间隔。客户无法看到指定间隔之外的实体遥测；
 - **Time series keys** - 可被查看者访问的时序数据 key 列表；
 - **Attribute keys** - 可被查看者访问的属性名称列表；

![image](/images/user-guide/entity-views/new-entity-view.png)

理解 TB 如何处理遥测和属性更新以及这些更改如何影响实体视图很重要。

### 时序数据视图

所有时序数据以目标实体名义存储在数据库中。不会向任何实体视图复制时序数据。
当用户代表实体视图 ID 打开仪表板或执行 REST API 调用时，发生以下操作：

 - 请求的开始和结束时间戳被验证并调整以符合实体视图的开始和结束时间。
 因此，若仪表板尝试获取 1 年的数据，但 EV 仅配置为访问 6 个月的数据，则会失败。
 - 请求的时序数据 key 根据实体视图中配置的时序数据 key 进行验证和调整。
 因此，若仪表板尝试获取此视图不允许的遥测 key，则会失败。

### 属性视图

每次保存或更新此实体视图时，实体视图会自动从目标实体复制指定属性。
出于性能考虑，目标实体属性的更改不会每次传播到实体视图。
可通过在 Rule Chain 中配置「copy to view」规则节点并将「Post attributes」和「Attributes Updated」消息链接到该规则节点来启用自动传播。

![image](/images/user-guide/entity-views/rule-chain.png)

## 未来改进

ThingsBoard 路线图中有以下功能：

 - 为设备视图启用/禁用 RPC 请求；
 - 为特定视图配置可访问（传播）的告警列表。

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
