{% capture hybrid-info %}
ThingsBoard 团队建议：若计划在生产环境中部署 100 万以上设备或具有高数据采集率（> 5000 条/秒），请使用混合数据库方案。
此方案下，ThingsBoard 将时序数据存储于 Cassandra，同时继续使用 PostgreSQL 存储主要实体（设备/资产/仪表板/客户）。  
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-rhel.md %}

{% include templates/install/create-tb-db-rhel.md %}

##### Cassandra 安装

{% include templates/install/cassandra-rhel-install.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件 

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。请勿忘记**将** "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" **替换为**您的**实际 postgres 用户密码**：

```bash
# DB Configuration 
export DATABASE_TS_TYPE=cassandra
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
``` 
{: .copy-code}

可选的，可添加以下参数以将 ThingsBoard 实例重新配置为连接外部 Cassandra 节点：

```bash
export CASSANDRA_CLUSTER_NAME=Thingsboard Cluster
export CASSANDRA_KEYSPACE_NAME=thingsboard
export CASSANDRA_URL=127.0.0.1:9042
export CASSANDRA_USE_CREDENTIALS=false
export CASSANDRA_USERNAME=
export CASSANDRA_PASSWORD=
```
{: .copy-code}