丰富节点用于在出站消息中包含关于消息来源、与来源相关的实体及其他上下文数据，供规则链中的后续处理步骤使用。

这些节点可从消息来源、相关实体、当前租户或客户等多个来源获取属性、最新时序值、历史时序数据和实体详情，以丰富消息。

这种丰富使后续规则节点能够根据配置设置和上下文数据做出有上下文的决策并应用处理逻辑。

- [计算差值](/docs/user-guide/rule-engine-2-0/nodes/enrichment/calculate-delta) — 计算入站消息中当前值与来自同一来源的上一值之间的差值，可选择包含消息间经过的时间。
- [客户属性](/docs/user-guide/rule-engine-2-0/nodes/enrichment/customer-attributes) — 通过添加消息来源客户的[服务端属性](/docs/user-guide/attributes/)或[最新时序值](/docs/user-guide/telemetry/)丰富消息。
- [客户详情](/docs/user-guide/rule-engine-2-0/nodes/enrichment/customer-details) — 通过添加消息来源客户的详情（如名称、邮箱、国家、地址等）丰富消息。
- [获取设备凭据](/docs/user-guide/rule-engine-2-0/nodes/enrichment/fetch-device-credentials) — 通过添加来源设备的凭据（类型和值）丰富消息。
- [来源属性](/docs/user-guide/rule-engine-2-0/nodes/enrichment/originator-attributes) — 通过添加消息来源的属性（客户端、共享、服务端）和/或最新时序值丰富消息。
- [来源字段](/docs/user-guide/rule-engine-2-0/nodes/enrichment/originator-fields) — 通过添加消息来源的详情（如名称、标签、配置名称等）丰富消息。
- [来源遥测](/docs/user-guide/rule-engine-2-0/nodes/enrichment/originator-telemetry) — 通过添加消息来源在指定时间间隔内的[历史时序数据](/docs/user-guide/telemetry/)丰富消息，支持可配置的获取策略和可选聚合函数。
- [关联设备属性](/docs/user-guide/rule-engine-2-0/nodes/enrichment/related-device-attributes) — 通过添加通过可配置关系查询（方向、类型、设备配置）找到的[关联](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations)设备的属性和/或最新时序值丰富消息。
- [关联实体数据](/docs/user-guide/rule-engine-2-0/nodes/enrichment/related-entity-data) — 通过添加通过可配置关系查询（方向、类型和实体过滤）找到的关联实体的属性、最新时序值或实体字段丰富消息。
- [租户属性](/docs/user-guide/rule-engine-2-0/nodes/enrichment/tenant-attributes) — 通过添加消息来源租户的服务端属性或最新时序值丰富消息。
- [租户详情](/docs/user-guide/rule-engine-2-0/nodes/enrichment/tenant-details) — 通过添加消息来源租户的详情（如名称、邮箱、国家、地址等）丰富消息。
