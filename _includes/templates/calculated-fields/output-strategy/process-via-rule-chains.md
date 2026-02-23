结果不会直接写入数据库。ThingsBoard 会生成内部消息：
- <span class="code-light">POST_TELEMETRY_REQUEST</span>，或
- <span class="code-light">POST_ATTRIBUTES_REQUEST</span>

并将其路由到实体的 **Default Rule Chain**。

在以下场景可使用该策略：
- 额外处理逻辑
- 过滤、脚本或转换
- 条件持久化
- enrichment、路由或转发

要存储结果，Rule Chain 中需包含 [save time series](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#save-timeseries-node){:target="_blank"} 或 [save attributes](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#save-attributes-node){:target="_blank"} 节点。

> 这是在引入直接处理之前使用的经典处理模型。