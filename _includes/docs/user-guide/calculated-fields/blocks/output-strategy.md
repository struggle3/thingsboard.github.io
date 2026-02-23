##### 输出策略

输出策略定义计算字段结果的处理方式。支持两种策略：
- **Process immediately**（默认）— 立即处理并存储结果，不经过 Rule Chain。
- **Process via Rule Chains** — 将结果传入实体的 Default Rule Chain，进行额外处理逻辑。

{% capture outputStrategy %}
Process right away<small></small>%,%attribute%,%templates/calculated-fields/output-strategy/process-right-away.md%br%
Process via Rule Chains<small></small>%,%timeSeriesRolling%,%templates/calculated-fields/output-strategy/process-via-rule-chains.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="calculatedfieldsargumenttype" toggle-spec=outputStrategy %}