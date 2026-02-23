![image](/images/user-guide/rule-engine-2-0/nodes/transformation-nodes/deduplication-node.png)

**在可配置周期内，对来自同一来源实体（Originator）的消息进行去重，并根据指定的去重策略返回结果。**

去重策略：
- FIRST — 返回去重周期内到达的第一条消息。
- LAST — 返回去重周期内到达的最后一条消息。
- ALL — 将所有消息作为单一 JSON 数组消息返回，其中每个元素为包含 msg 和 metadata 内部属性的对象。

配置：
{% if docsPrefix == null %}
<object width="70%" data="/images/user-guide/rule-engine-2-0/nodes/transformation-nodes/deduplication-node-2-ce.png"></object>
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix contains "paas/") %}
<object width="70%" data="/images/user-guide/rule-engine-2-0/nodes/transformation-nodes/deduplication-node-2-pe.png"></object>
{% endif %}
