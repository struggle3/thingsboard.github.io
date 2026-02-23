<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>Since TB Version 2.1</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-latest.png)

按周期对指定父实体集的子实体 attributes 或最新时序进行聚合。

以可配置周期，对从子实体获取的 attributes 或最新时序执行聚合。

聚合结果写入父实体的指定目标时序属性。
 
为每个父实体及其聚合属性生成类型为 **POST_TELEMETRY_REQUEST** 的消息。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-latest-config.png)

- **Execution period value/time unit** — 指定聚合任务周期。
- **Entities** — 指定执行聚合的父实体集。可选： 
    - **Single entity** — 单个实体
    - **Group of entities** — 指定实体组
    - **Relations query** — 从 **Root entity** 起通过 **Relations query** 查到的实体集
- **Child entities** — 指定从父实体查找子实体的 **Relations query**。仅当父实体选择 **Single entity** 或 **Relations query** 时需配置。
若选择 **Group of entities**，子实体从实体组本身选择。
- **Aggregate latest mappings** — 映射配置表，指定子属性聚合规则。

映射配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-latest-mapping-config.png)

- **Latest telemetry** — 指定聚合的是子实体最新 telemetry 还是 attribute。
- **Source telemetry/attribute** — 子实体最新 telemetry 或 attribute 的 key 名。
- **Attribute scope** — 当使用 attribute 作为源（未勾选 **Latest telemetry**）时，指定子属性作用域。
- **Default value** — 当子实体未定义或缺少源属性时使用的默认数值。
- **Aggregation function** — 用于子值聚合的数学函数。可选：
    - **Minimum** — 取所有子实体中的最小 attribute 值
    - **Maximum** — 取所有子实体中的最大 attribute 值
    - **Sum** — 求子实体 attribute 值总和
    - **Average** — 求子实体 attribute 值的平均值
    - **Count** — 统计子实体数量。此时 **Source telemetry/attribute** 不使用，可为空
    - **Count unique** — 统计子实体 attribute 值的去重数量
- **Target telemetry** — 父实体用于存储聚合结果的目标 telemetry key 名。
- **Filter entities** — 是否在聚合 attribute 值前过滤子实体。
- **Entity filter** — 用于过滤子实体的筛选器。包含两部分：
    1. 需获取并在 JavaScript 过滤函数中使用的实体 attribute/最新时序 key 列表
    1. JavaScript 过滤函数，应返回 boolean 结果。以包含已获取 attributes/最新时序值的 **attributes** 映射为入参。
    获取的 attribute 值以带 scope 前缀的 key 加入 **attributes** 映射：
        - shared attribute -> <code>shared_</code>
        - client attribute -> <code>cs_</code>
        - server attribute -> <code>ss_</code>
        - telemetry -> 无前缀

对每个父实体，节点会生成新消息（类型 **POST_TELEMETRY_REQUEST**，originator 为父实体，json body 含目标 telemetry 及聚合值）并通过 **Success** 链转发。
若某子属性聚合失败，节点会生成失败消息（含失败原因，originator 为父实体）并通过 **Failure** 链转发。

**Since TB Version 3.3.3** 可选择队列名：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)

<br>
