<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>Since TB Version 2.1</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-stream.png)

根据入站数据流计算 MIN/MAX/SUM/AVG/COUNT/UNIQUE。
按消息 originator id（如设备、Asset、Customer）、**aggregation function**（如 "Average"、"Sum"、"Min"、"Max"）、**aggregation interval value**（如 1 分钟、6 小时）将入站数据流分组为 **Intervals**。

Intervals 按 **interval persistence policy** 和 **interval check value** 定期持久化。Intervals 按 **Interval TTL value** 缓存在内存中。
Intervals 状态按 **state persistence policy** 和 **state persistence value** 作为时序实体持久化。
若某实体无数据，可为这些实体生成默认值。勾选 **Create intervals automatically** 并配置 **Interval entities** 可查找这些实体。

为各 interval 的聚合结果生成 `POST_TELEMETRY_REQUEST` 消息。

以下配置将计算每小时平均温度，在小时 interval 结束后一分钟内持久化。
若某 interval 有延迟 telemetry 到达，规则节点会从内部缓存或 telemetry 中查找。

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-stream-config.png)
    
聚合结果每分钟写入数据库一次。也可在每条新消息时持久化 interval，以避免服务器故障时的数据丢失。
若某建筑下的设备未上报温度读数，可勾选 "Create Intervals automatically" 并指定 "Buildings" 实体组，从而在每个 interval 为这些建筑生成默认值（零）。    

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-stream-config-2.png)

**Since TB Version 3.3.3** 可选择队列名：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)
