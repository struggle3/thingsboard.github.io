{% if currentThingsBoardVersion == "ThingsBoard Professional Edition" %}
{% assign appPrefix = "Professional Edition" %}
{% else %}
{% assign appPrefix = "Community Edition" %}
{% endif %}

{% include templates/edge/install/prerequisites.md %}

### Edge安装与配置

#### 使用ThingsBoard Server预配置说明进行引导式安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

{% capture local-deployment %}
如因任何原因无法访问和/或使用**Edge预设配置**，请参阅 [手动安装说明](/docs/user-guide/install/{{docsPrefix}}installation-options/){: target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=local-deployment %}

### 访问用户界面：URL与凭据

{% if currentThingsBoardVersion == "ThingsBoard Professional Edition" %}
{% assign peDocsPrefix = "pe/" %}
{% capture contenttogglespec %}
ThingsBoard Cloud<br><small>将Edge连接到<br>https://thingsboard.cloud</small>%,%cloud%,%templates/edge/pe-cloud.md%br%
On-premise Server<br><small>将Edge连接到本地服务器</small>%,%on-premise%,%templates/edge/on-premise-cloud.md{% endcapture %}
{% include content-toggle.liquid content-toggle-id="cloudType" toggle-spec=contenttogglespec %}
{% endif %}
{% if currentThingsBoardVersion == "ThingsBoard Community Edition" %}
**Edge**安装完成后，您可通过 [http://localhost:18080](http://localhost:18080){:target="_blank"} 访问界面。
在本教程后续内容中，该URL将称为 **EDGE_URL**。

请使用与 **SERVER_URL** 相同的凭据登录：
* **用户名：** tenant@thingsboard.org
* **密码：** tenant
{% endif %}

{% include templates/edge/oauth2-not-supported.md %}

{% include templates/edge/bind-port-changed-banner.md %}
