{% capture hybrid-info %}
ThingsBoard 团队建议仅对已在生产环境中使用 TimescaleDB 的公司使用 Timescale 数据库。
在此情况下，ThingsBoard 将把时序数据存储在 TimescaleDB  hypertable 中，同时继续使用 PostgreSQL 存储主要实体（设备/资产/仪表板/客户）。
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

从此处[下载](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)安装文件（PostgreSQL 15 或更新版本）并按照安装说明操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请勿忘记此密码，后续将使用。为简便起见，我们将用 "postgres" 代替。

##### 创建 ThingsBoard 数据库

安装完成后，启动 "pgAdmin" 软件并以超级用户 (postgres) 登录。  
打开服务器并创建数据库 "thingsboard"，所有者设置为 "postgres"。

##### TimescaleDB 安装

{% include templates/install/timescale-windows-install.md %}

##### ThingsBoard 配置

以管理员身份打开记事本或其他编辑器（右键点击应用图标并选择“以管理员身份运行”）。  
打开以下文件进行编辑（在文件选择对话框中选择“所有文件”而非“文本文档”，编码为 UTF-8）：

```text 
C:\Program Files (x86)\thingsboard\conf\thingsboard.yml
``` 
{: .copy-code}


并找到 "# SQL DAO Configuration" 配置块。请勿忘记将 "postgres" 替换为您的实际 postgres 用户密码：

```yml
# SQL DAO Configuration
spring:
  data:
    jpa:
      repositories:
        enabled: "true"
  jpa:
    open-in-view: "false"
    hibernate:
      ddl-auto: "none"
  datasource:
    driverClassName: "${SPRING_DRIVER_CLASS_NAME:org.postgresql.Driver}"
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/thingsboard}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:YOUR_POSTGRES_PASSWORD_HERE}"
    hikari:
      maximumPoolSize: "${SPRING_DATASOURCE_MAXIMUM_POOL_SIZE:16}"
``` 
{: .copy-code}

找到 "DATABASE_TS_TYPE" 参数。将 "sql" 替换为 "timescale"。

```yml
      ts:
        type: "${DATABASE_TS_TYPE:sql}" # cassandra, sql, or timescale (for hybrid mode, DATABASE_TS_TYPE value should be cassandra, or timescale)
    
    # note: timescale works only with postgreSQL database for DATABASE_ENTITIES_TYPE.
```

您可根据需要调整 Timescale DB 相关参数："sql" 配置块内的 "timescale" 配置块。

```yml
# SQL configuration parameters
sql:
    timescale:
      # Specify Interval size for new data chunks storage.
      chunk_time_interval: "${SQL_TIMESCALE_CHUNK_TIME_INTERVAL:604800000}"
```
