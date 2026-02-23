<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>Since TB Version 3.2.2</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count.png)

收到新 alarm 的输入消息时统计 alarm 数量。输入消息可为 `ALARM`、`ALARM_ACK`、`ALARM_CLEAR`，或 alarm 的 `ENTITY_CREATED`、`ENTITY_UPDATED` 消息。
根据 alarm 统计映射和消息 originator（设备、Asset 等）执行 count 查询。

统计结果写入实体的指定目标时序属性。

为每个实体及其 alarm 统计结果生成类型为 **POST_TELEMETRY_REQUEST** 的消息。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-config-new.png)

- **Count alarms for propagation entities** — 启用时，不仅统计 alarm originator，还统计所有传播实体的 alarm。
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

<br>
