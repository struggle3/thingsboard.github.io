{% capture hybrid-info %}
若您计划在生产环境中部署 100 万以上设备或具有高数据摄取率（> 5000 条消息/秒），ThingsBoard 团队建议使用混合数据库方案。
在此情况下，ThingsBoard 将把时序数据存储在 Cassandra 中，同时继续使用 PostgreSQL 存储主要实体（设备/资产/仪表板/客户）。
{% endcapture %}
{% include templates/info-banner.md content=hybrid-info %}

##### PostgreSQL 安装

从此处[下载](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)安装文件（PostgreSQL 12.17 或更新版本）并按照安装说明操作。

在 PostgreSQL 安装过程中，系统会提示您输入超级用户 (postgres) 密码。
请勿忘记此密码，后续将使用。为简便起见，我们将用 "postgres" 代替。

##### 创建 ThingsBoard 数据库

安装完成后，启动 "pgAdmin" 软件并以超级用户 (postgres) 登录。  
打开服务器并创建数据库 "thingsboard"，所有者设置为 "postgres"。

##### Cassandra 安装

以下说明将帮助您安装 Cassandra。

- Download DataStax Community Edition v3.0.9
    - [MSI Installer (32-bit)](http://downloads.datastax.com/community/datastax-community-32bit_3.0.9.msi)
    - [MSI Installer (64-bit)](http://downloads.datastax.com/community/datastax-community-64bit_3.0.9.msi)
- Run downloaded MSI package. You are first presented with an initial welcome panel that identifies your installation package:

 ![image](/images/user-guide/install/windows/windows-cassandra-1.png)
 
- Clicking next takes you to the end user license agreement:
 
 ![image](/images/user-guide/install/windows/windows-cassandra-2.png)
 
- The next panel allows you to specify where the software is to be installed:
   
 ![image](/images/user-guide/install/windows/windows-cassandra-3.png)

- Once the installation directory has been set, the installer will ask how you want to handle the service that will be installed:

 ![image](/images/user-guide/install/windows/windows-cassandra-4.png)

- The next panel initiates the installation process:

 ![image](/images/user-guide/install/windows/windows-cassandra-5.png)
 
 ![image](/images/user-guide/install/windows/windows-cassandra-6.png)

- The final panel asks if you would like to register to be updated when new versions of the software become available:

 ![image](/images/user-guide/install/windows/windows-cassandra-7.png)
 
- You can find installed interfaces in "DataStax Community Edition" program group that the installer creates for you:

 ![image](/images/user-guide/install/windows/windows-cassandra-8.png)
 
- The primary interface into Cassandra is the CQL (Cassandra Query Language) shell utility, which can be used to execute CQL commands for the new Cassandra server.

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
      maximumPoolSize: "${SPRING_DATASOURCE_MAXIMUM_POOL_SIZE:5}"
``` 
{: .copy-code}

找到 "DATABASE_TS_TYPE" 参数。将 "sql" 替换为 "cassandra"。

```yml
    type: "${DATABASE_TS_TYPE:cassandra}" # cassandra OR sql (for hybrid mode, only this value should be cassandra)
```

您可根据需要调整 "cassandra" 配置块内的参数。

```yml
# Cassandra driver configuration parameters
cassandra:
  # Thingsboard cluster name
  cluster_name: "${CASSANDRA_CLUSTER_NAME:Thingsboard Cluster}"
  # Thingsboard keyspace name
  keyspace_name: "${CASSANDRA_KEYSPACE_NAME:thingsboard}"
  # Specify node list
  url: "${CASSANDRA_URL:127.0.0.1:9042}"
  # Enable/disable secure connection
  ssl: "${CASSANDRA_USE_SSL:false}"
  # Enable/disable JMX
  jmx: "${CASSANDRA_USE_JMX:true}"
  # Enable/disable metrics collection.
  metrics: "${CASSANDRA_DISABLE_METRICS:true}"
  # NONE SNAPPY LZ4
  compression: "${CASSANDRA_COMPRESSION:none}"
  # Specify cassandra cluster initialization timeout in milliseconds (if no hosts available during startup)
  init_timeout_ms: "${CASSANDRA_CLUSTER_INIT_TIMEOUT_MS:300000}"
  # Specify cassandra claster initialization retry interval (if no hosts available during startup)
  init_retry_interval_ms: "${CASSANDRA_CLUSTER_INIT_RETRY_INTERVAL_MS:3000}"
  max_requests_per_connection_local: "${CASSANDRA_MAX_REQUESTS_PER_CONNECTION_LOCAL:32768}"
  max_requests_per_connection_remote: "${CASSANDRA_MAX_REQUESTS_PER_CONNECTION_REMOTE:32768}"
  # Credential parameters #
  credentials: "${CASSANDRA_USE_CREDENTIALS:false}"
  # Specify your username
  username: "${CASSANDRA_USERNAME:}"
  # Specify your password
  password: "${CASSANDRA_PASSWORD:}"
```

