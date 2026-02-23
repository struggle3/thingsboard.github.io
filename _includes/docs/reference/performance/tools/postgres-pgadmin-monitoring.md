### 使用PgAdmin监控PostgreSQL

我们将使用pgadmin监控PostgreSQL数据库。[下载并安装pgadmin](https://www.pgadmin.org/download/)的说明在此。  
打开pgadmin  
![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-starting.png)

按下列方式创建新连接。示例中使用SSH隧道功能连接AWS EC2实例，主机名为localhost。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-database-server-connect-general.png)

默认PostgreSQL用户为thingsboard，默认密码为postgres。请在此处填入您的凭据以替换默认值。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-database-server-connect-connection.png)

使用SSH隧道时，填写ThingsBoard实例IP和身份文件（与从终端连接时相同）以连接AWS EC2实例。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-database-server-connect-ssh-tunnel.png)

完成后可查看带实时PostgreSQL指标的仪表板。

![](/images/reference/performance-aws-instances/method/pgadmin/pgadmin-thingsboard-dashboard.png)

注意：若PostgreSQL在隔离于主机网络的容器中运行，连接将使用docker内部IP，需在[pg_hba.conf](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html)文件中配置安全设置。