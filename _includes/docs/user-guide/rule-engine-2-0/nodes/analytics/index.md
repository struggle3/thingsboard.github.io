Analytics 节点对入站数据流及跨实体数据执行统计计算与聚合。

这些节点可从流数据计算统计指标（最小值、最大值、求和、平均值、计数），跟踪 alarm 数量，或定期聚合实体的 attributes 和 telemetry。

- <span class="item-pe product-label-padding">[aggregate latest](/docs/user-guide/rule-engine-2-0/nodes/analytics/aggregate-latest)</span> — 按周期对指定父实体集的子实体 attributes 或最新时序进行聚合。
- <span class="item-pe product-label-padding">[aggregate stream](/docs/user-guide/rule-engine-2-0/nodes/analytics/aggregate-stream)</span> — 根据入站数据流计算 MIN/MAX/SUM/AVG/COUNT/UNIQUE。
- <span class="item-pe product-label-padding">[alarms count](/docs/user-guide/rule-engine-2-0/nodes/analytics/alarms-count)</span> — 收到新 alarm 的输入消息时统计 alarm 数量。
- <span class="item-pe product-label-padding">[alarms count (deprecated)](/docs/user-guide/rule-engine-2-0/nodes/analytics/alarms-count-deprecated)</span> — 按周期对所选实体集统计 alarm 数量。
