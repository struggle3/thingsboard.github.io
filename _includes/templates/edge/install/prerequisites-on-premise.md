{% if currentThingsBoardVersion == "ThingsBoard Professional Edition" %}
{% assign peDocsPrefix = "pe/" %}
{% endif %}

您可以安装**ThingsBoard {{appPrefix}}**本地Server。请参阅 [ThingsBoard安装指南](/docs/user-guide/install/{{peDocsPrefix}}installation-options/){:target="_blank"}。

可通过 [http://localhost:8080](http://localhost:8080){:target="_blank"} 访问本地Server。在本教程中，我们将该URL称为 **SERVER_URL**。请使用以下凭据登录：
* **用户名：** tenant@thingsboard.org
* **密码：** tenant
