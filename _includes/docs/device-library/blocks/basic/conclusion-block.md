{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
现在您可以在 **{{deviceName}}** 上便捷安装 **ThingsBoard Edge**，连接设备并开始发送数据。

进一步了解可查阅 [**ThingsBoard Edge** 文档](/docs/{{page.docsPrefix}}){: target="_blank"}，
学习创建[仪表板](/docs/{{page.docsPrefix}}user-guide/db-overview/){: target="_blank"}可视化遥测、
配置[告警规则](/docs/{{page.docsPrefix}}user-guide/alarms/){: target="_blank"}实时监控设备行为等核心功能。

{% else %}
现在您可以轻松将 {{deviceName}} 连接到 **ThingsBoard** 并开始发送数据。

进一步了解可查阅 [**ThingsBoard** 文档](/docs/{{page.docsPrefix}}){: target="_blank"}，
学习创建[仪表板](/docs/{{page.docsPrefix}}user-guide/dashboards/){: target="_blank"}可视化遥测、
配置[告警规则](/docs/{{page.docsPrefix}}user-guide/alarms/){: target="_blank"}实时监控设备行为等核心功能。
{% endif %}