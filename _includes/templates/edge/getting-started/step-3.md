要在现场处理数据并与本地及云端服务通信，需使用**Edge规则链模板**。
本质上，**Edge根规则链**是指**ThingsBoard Edge**中处理传入数据、并可根据特定条件触发特定动作的**规则链**。

要了解遥测数据如何从**Edge**传输到**Cloud**，让我们查看默认的**Edge根规则链**：

{% include images-gallery.html imageCollection="step3" showListImageTitles="true" %}

{% capture local-deployment %}
要编辑**Edge规则链模板**或创建新模板，请登录**ThingsBoard Server**实例（**SERVER_URL**），进入**Edge management > Rule chain templates**（边缘管理 > 规则链模板）部分，并按照 [这些说明](/docs/{{docsPrefix}}rule-engine/rule-chain-templates/){: target="_blank"} 操作。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}
