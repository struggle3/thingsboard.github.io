<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>Since TB Version 2.1</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count.png)

按周期对所选实体集统计 alarm 数量。

以可配置周期，对所选实体（含子实体，若已指定）执行 alarm 统计。

统计结果写入实体的指定目标时序属性。

为每个实体及其 alarm 统计结果生成类型为 **POST_TELEMETRY_REQUEST** 的消息。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-config.png)

- **Execution period value/time unit** — 指定 alarm 统计任务周期。
- **Entities** — 指定执行 alarm 统计的实体集。可选：
    - **Single entity** — 单个实体
    - **Group of entities** — 指定实体组
    - **Relations query** — 从 **Root entity** 起通过 **Relations query** 查到的实体集
- **Count alarms for child entities** — 是否为每个所查实体的子实体执行 alarm 统计。
- **Child entities** — 指定从父实体查找子实体的 **Relations query**。仅当勾选 **Count alarms for child entities** 且 entities 选择 **Single entity** 或 **Relations query** 时需配置。
若选择 **Group of entities**，子实体从实体组本身选择。
- **Alarms count mappings** — 映射配置表，指定 alarm 统计规则。

映射配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-mapping-config.png)

- **Target telemetry** — 实体用于存储 alarm 统计结果的目标 telemetry key 名。
- **Status filter** — 用于过滤 alarm 的允许状态列表。未指定时选择任意状态的 alarm。
- **Severity filter** — 用于过滤 alarm 的允许严重程度列表。未指定时选择任意严重程度的 alarm。
- **Type filter** — 用于过滤 alarm 的允许类型列表。未指定时选择任意类型的 alarm。
- **Specify interval** — 勾选后仅选择指定 interval 内创建的 alarm，否则选择全部时间内的 alarm。

对每个所选实体，节点生成新消息（类型 **POST_TELEMETRY_REQUEST**，json body 含目标 telemetry 及 alarm 统计值）并通过 **Success** 链转发。
若某实体 alarm 统计失败，节点生成失败消息（含失败原因，originator 为实体）并通过 **Failure** 链转发。

**Since TB Version 3.3.3** 可选择队列名：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)
