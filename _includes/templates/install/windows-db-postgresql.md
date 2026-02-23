{% capture postgresql-info %}
ThingsBoard 团队建议在负载合理（< 5000 条消息/秒）的开发和生产环境中使用 PostgreSQL。
许多云服务商提供托管 PostgreSQL 服务，对大多数 ThingsBoard 实例而言是成本效益较高的解决方案。
{% endcapture %}
{% include templates/info-banner.md content=postgresql-info %}

##### PostgreSQL 安装

从此处[下载](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)安装文件（PostgreSQL 15 或更新版本）并按照安装说明操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请勿忘记此密码，后续将使用。为简便起见，我们将用 "postgres" 代替。

##### 创建 ThingsBoard 数据库

安装完成后，启动 "pgAdmin" 软件并以超级用户 (postgres) 登录。  
打开服务器并创建数据库 "thingsboard"，所有者设置为 "postgres"。

##### ThingsBoard 配置

若您已将 PostgreSQL 超级用户密码设为 "postgres"，可跳过此步骤。 

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

找到 "SQL_POSTGRES_TS_KV_PARTITIONING" 参数以覆盖时间戳键值存储分区大小的默认值：

```yml
    sql:
      postgres:
        # Specify partitioning size for timestamp key-value storage. Example: DAYS, MONTHS, YEARS, INDEFINITE.
        ts_key_value_partitioning: "${SQL_POSTGRES_TS_KV_PARTITIONING:MONTHS}"
```