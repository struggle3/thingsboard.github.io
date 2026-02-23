{% capture postgresql-info %}
ThingsBoard 团队推荐在合理负载（< 5000 条消息/秒）的开发和生产环境中使用 PostgreSQL。
许多云厂商支持托管的 PostgreSQL 服务，对于大多数 ThingsBoard 实例而言是经济实惠的选择。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

### PostgreSQL 安装

{% include templates/install/postgres-install-rpi.md %}

{% include templates/install/create-tb-db.md %}

### ThingsBoard 配置

编辑 ThingsBoard 配置文件 

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下内容添加到配置文件中。请勿忘记将 "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" **替换为**您的**实际 postgres 用户密码**：

```bash
# 数据库配置 
export DATABASE_TS_TYPE=sql
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
# 指定时间戳键值存储的分区大小。允许的值：DAYS、MONTHS、YEARS、INDEFINITE。
export SQL_POSTGRES_TS_KV_PARTITIONING=MONTHS
```
{: .copy-code}