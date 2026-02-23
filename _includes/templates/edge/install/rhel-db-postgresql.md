{% capture postgresql-info %}
ThingsBoard 团队建议在 **中等负载（低于 5000 msg/sec）** 的开发和生产环境中使用 **PostgreSQL**。
多数云服务商提供托管 **PostgreSQL** 服务，对大多数 ThingsBoard 部署来说性价比较高。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

**ThingsBoard Edge** 使用 **PostgreSQL** 作为本地存储。

{% include templates/edge/install/postgres-install-rhel.md %}

{% include templates/edge/create-tb-db-rhel.md %}
