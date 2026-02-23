ThingsBoard Edge 使用 PostgreSQL 作为本地存储。

#### PostgreSQL 安装

在此 [下载](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows) 安装文件（PostgreSQL 12.17 或更新版本）并按说明完成安装。

安装 PostgreSQL 时会提示设置超级用户（postgres）密码。
请牢记该密码，后续步骤会使用。为简化示例，此处假设密码为 "postgres"。

#### 创建 ThingsBoard Edge 数据库

安装完成后，启动 "pgAdmin"，以超级用户（postgres）登录。
打开服务器并创建数据库 **tb_edge**，所有者设为 "postgres"。
