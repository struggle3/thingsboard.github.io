{% capture update_server_first %}
更新ThingsBoard Edge前，请确保 <b>ThingsBoard Server 已更新至最新版本</b>。

若Server版本过旧，请[先升级](/docs/{{peDocsPrefix}}user-guide/install/upgrade-instructions/{{updateServerLink}}/){:target="_blank"}。

以下说明适用于 <b>ThingsBoard Edge {{previousVersion}}</b> 版本。
{% endcapture %}
{% include templates/warn-banner.md content=update_server_first %}