**保持平台安全与更新**

当有新 ThingsBoard 版本发布时，我们提供简化的更新流程，确保系统获得最新功能和安全补丁，且不危及您的数据。

{% capture sequentiall_upgrade_note %}
**为保持数据库完整性和系统稳定性，请按顺序进行升级（例如 v4.0.2 → v4.1.0 → v4.2.0）。**

{% endcapture %}
{% include templates/info-banner.md content=sequentiall_upgrade_note %}

{% assign upgrade_url = "/docs/user-guide/install/upgrade-instructions/" %}

{% if docsPrefix == "pe/" %}
  {% assign upgrade_url = "/docs/pe/user-guide/install/upgrade-instructions/" %}
{% endif %}

请参阅官方 <a href="{{ upgrade_url }}">升级说明</a>，获取针对您当前部署环境的详细步骤。

