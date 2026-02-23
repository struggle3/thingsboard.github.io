{% if docsPrefix == 'pe/edge/' %}
{% assign cloudLink = " or [**ThingsBoard Cloud**](https://thingsboard.cloud/signup){: target="_blank"}" %}
{% else %}
{% assign cloudLink = "" %}
{% endif %}

**Edge** 服务启动后，在 [http://localhost:8080](http://localhost:8080){: target="_blank"} 打开 **Edge UI**。

{% include templates/edge/bind-port-changed-banner.md %}

请使用 **ThingsBoard Server** 的租户凭证 {{cloudLink}}登录 **ThingsBoard Edge**。