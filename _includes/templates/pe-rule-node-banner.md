{% capture peRuleNodeContent %}
仅[**专业版**](/products/thingsboard-pe/)支持**{{ rulenode }}**规则节点。<br>
请使用[**ThingsBoard Cloud**](https://{{hostName}}/signup)或[**自行安装**](/docs/user-guide/install/pe/installation-options/)平台实例。
{% endcapture %}
{% include templates/info-banner.md title="专业版规则节点" content=peRuleNodeContent %}
