{% capture postgresql-info %}
ThingsBoard 团队推荐在开发和合理负载（< 5000 msg/sec）的生产环境中使用 PostgreSQL。
许多云服务商支持托管 PostgreSQL 服务器，对于大多数 ThingsBoard 实例来说这是性价比高的解决方案。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-ubuntu.md %}

{% include templates/install/create-tb-db.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件 

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下内容添加到配置文件中。请勿忘记**替换** "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" 为您的**真实 postgres 用户密码**：

```bash
# DB Configuration 
export DATABASE_TS_TYPE=sql
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
# Specify partitioning size for timestamp key-value storage. Allowed values: DAYS, MONTHS, YEARS, INDEFINITE.
export SQL_POSTGRES_TS_KV_PARTITIONING=MONTHS
```
{: .copy-code}
