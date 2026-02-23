{% capture hybrid-info %}
如果您计划在生产环境中管理 100 万以上设备或处理**高数据采集率（超过 5000 msg/sec）**，ThingsBoard 团队建议使用**混合数据库方案**。
在此方案下，**ThingsBoard Edge** 将时序数据存储在 Cassandra 中，同时继续使用 PostgreSQL 存储设备、资产、仪表板和客户等主要实体。
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-ubuntu.md %}

要创建名为 **tb_edge** 的新 PostgreSQL 数据库，请使用以下命令：

```bash
echo "CREATE DATABASE tb_edge;" | psql -U postgres -d postgres -h 127.0.0.1 -W
```
{: .copy-code}

按两次 **"Ctrl+D"** 退出 PostgreSQL。

##### Cassandra 安装

{% include templates/edge/install/cassandra-ubuntu-install.md %}

##### ThingsBoard Edge 配置

编辑 **ThingsBoard Edge** 配置文件：

```bash 
sudo nano /etc/tb-edge/conf/tb-edge.conf
``` 
{: .copy-code}

将以下行添加到配置文件。别忘了**将** "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" **替换为您的 postgres 用户实际密码**：

```bash
# DB Configuration 
export DATABASE_TS_TYPE=cassandra
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/tb_edge
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
``` 
{: .copy-code}

您可以选择性添加以下参数，以将 Edge 实例重新配置为连接外部 Cassandra 节点：

```bash
export CASSANDRA_CLUSTER_NAME=Edge Cluster
export CASSANDRA_KEYSPACE_NAME=thingsboard
export CASSANDRA_URL=127.0.0.1:9042
export CASSANDRA_USE_CREDENTIALS=false
export CASSANDRA_USERNAME=
export CASSANDRA_PASSWORD=
```
{: .copy-code}