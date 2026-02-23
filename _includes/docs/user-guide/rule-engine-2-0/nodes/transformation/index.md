转换节点是 ThingsBoard 规则引擎的数据处理与操作组件，用于修改入站消息的内容、结构或格式。

这些节点可通过字段映射、数学计算、字符串操作、自定义脚本和 JSON 结构修改等操作转换消息。它们可提取或合并数据字段、应用业务逻辑转换，并基于现有消息创建新消息。

这种转换能力使规则链能够为特定下游需求调整消息，并实现复杂处理工作流，为存储、分析或与外部系统集成准备数据。

- [更换来源](/docs/user-guide/rule-engine-2-0/nodes/transformation/change-originator) — 将消息来源更换为其他实体，如客户、租户、关联实体、告警来源或按名称模式查找的实体。
- [复制键值对](/docs/user-guide/rule-engine-2-0/nodes/transformation/copy-key-value-pairs) — 在消息数据与元数据之间按任一方向复制指定键值对。
- [去重](/docs/user-guide/rule-engine-2-0/nodes/transformation/deduplication) — 在可配置时间间隔内对来自同一来源的消息去重，通过策略返回第一条、最后一条或所有消息作为组合结果。
- [删除键值对](/docs/user-guide/rule-engine-2-0/nodes/transformation/delete-key-value-pairs) — 从消息数据或元数据中删除指定键值对。
- <span class="item-pe product-label-padding">[复制到组](/docs/user-guide/rule-engine-2-0/nodes/transformation/duplicate-to-group)</span> — 将入站消息复制到指定实体组内的每个实体。
- <span class="item-pe product-label-padding">[按名称复制到组](/docs/user-guide/rule-engine-2-0/nodes/transformation/duplicate-to-group-by-name)</span> — 将入站消息复制到按名称动态查找的实体组内的每个实体。
- <span class="item-pe product-label-padding">[复制到关联](/docs/user-guide/rule-engine-2-0/nodes/transformation/duplicate-to-related)</span> — 将入站消息复制到与消息来源相关的所有实体（通过可配置关系查询查找）。
- [JSON Path](/docs/user-guide/rule-engine-2-0/nodes/transformation/json-path) — 使用 JSONPath 表达式提取消息数据的一部分，并用提取结果替换整个消息数据。
- [重命名键](/docs/user-guide/rule-engine-2-0/nodes/transformation/rename-keys) — 根据指定将现有键改为新键名的映射，重命名消息数据或元数据中的键。
- [脚本](/docs/user-guide/rule-engine-2-0/nodes/transformation/script) — 执行用户定义的 TBEL 或 JavaScript 函数，通过修改消息的数据、元数据和类型转换消息，产生一条或多条转换后的出站消息。
- [拆分数组消息](/docs/user-guide/rule-engine-2-0/nodes/transformation/split-array-msg) — 将包含 JSON 数组数据的入站消息拆分为多条独立消息，为每个数组元素创建一条新消息。
- [转换为邮件](/docs/user-guide/rule-engine-2-0/nodes/transformation/to-email) — 通过配置发件人、收件人、主题和正文内容，使用基于模板的字段替换转换消息，为邮件发送做准备。
