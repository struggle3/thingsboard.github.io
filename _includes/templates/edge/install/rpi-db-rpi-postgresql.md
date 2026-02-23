{% capture postgresql-info %}
ThingsBoard 团队建议在 **中等负载（低于 5000 msg/sec）** 的开发和生产环境中使用 **PostgreSQL**。
多数云服务商提供托管 **PostgreSQL** 服务，对大多数 ThingsBoard 部署来说性价比较高。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

**ThingsBoard Edge** 使用 **PostgreSQL** 作为本地存储。

{% include templates/install/postgres-install-rpi.md %}

最后，执行以下命令创建名为 **tb_edge** 的 PostgreSQL 数据库：

```bash
echo "CREATE DATABASE tb_edge;" | psql -U postgres -d postgres -h 127.0.0.1 -W
```
{: .copy-code}

### ThingsBoard 配置

编辑 **ThingsBoard Edge** 配置文件： 

```bash 
sudo bash -c 'echo "export DATABASE_TS_TYPE=sql
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
export SQL_POSTGRES_TS_KV_PARTITIONING=MONTHS" >> /etc/tb-edge/conf/tb-edge.conf'
``` 
{: .copy-code}

* **PUT_YOUR_POSTGRESQL_PASSWORD_HERE：** 替换为 **实际的 PostgreSQL 密码**。
* **SQL_POSTGRES_TS_KV_PARTITIONING：** 指定时间序列 key-value 存储的分区大小。可选值：DAYS、MONTHS、YEARS、INDEFINITE。
