{% capture hybrid-timescale-info %}
ThingsBoard 团队仅建议已在生产环境使用 TimescaleDB 的企业使用 Timescale 数据库。
此种情况下，ThingsBoard 将在 TimescaleDB Hypertable 中存储时序数据，同时继续使用 PostgreSQL 存储主要实体（设备/资产/仪表板/客户）。
{% endcapture %}
{% include templates/info-banner.md content=hybrid-timescale-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-ubuntu.md %}

{% include templates/install/create-tb-db.md %}

##### TimescaleDB 安装

{% include templates/install/timescale-ubuntu-install.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件 

```bash
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

将以下内容添加到配置文件中。请勿忘记将 "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" **替换为**您的**实际 postgres 用户密码**：

```bash
# 数据库配置 
export DATABASE_TS_TYPE=timescale
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
# 指定数据块存储的时间间隔。请注意，该值只能设置一次。
export SQL_TIMESCALE_CHUNK_TIME_INTERVAL=604800000 # 毫秒数。当前值对应一周。
```
{: .copy-code}
