{% capture hybrid-timescale-info %}
ThingsBoard 团队建议：仅在生产环境已使用 TimescaleDB 的公司使用 Timescale 数据库。
此方案下，ThingsBoard 将时序数据存储于 TimescaleDB 超表，同时继续使用 PostgreSQL 存储主要实体（设备/资产/仪表板/客户）。  
{% endcapture %}
{% include templates/info-banner.md content=hybrid-timescale-info %}

##### PostgreSQL 安装

{% include templates/install/postgres-install-rhel.md %}

{% include templates/install/create-tb-db-rhel.md %}

##### TimescaleDB 安装

{% include templates/install/timescale-rhel-install.md %}

##### ThingsBoard 配置

编辑 ThingsBoard 配置文件 

```bash 
sudo nano /etc/thingsboard/conf/thingsboard.conf
``` 
{: .copy-code}

将以下行添加到配置文件中。请勿忘记**将** "PUT_YOUR_POSTGRESQL_PASSWORD_HERE" **替换为**您的**实际 postgres 用户密码**：

```bash
# DB Configuration 
export DATABASE_TS_TYPE=timescale
export SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/thingsboard
export SPRING_DATASOURCE_USERNAME=postgres
export SPRING_DATASOURCE_PASSWORD=PUT_YOUR_POSTGRESQL_PASSWORD_HERE
# Specify Interval size for data chunks storage. Please note that this value can be set only once.
export SQL_TIMESCALE_CHUNK_TIME_INTERVAL=604800000 # Number of miliseconds. The current value corresponds to one week.
```
{: .copy-code}
