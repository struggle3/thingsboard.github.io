#### 修改 PostgreSQL 的认证方式（可选）

由于 **ThingsBoard Edge** 使用 **PostgreSQL** 数据库进行本地存储，配置 **MD5 认证** 可确保仅经认证的用户或应用能访问数据库，从而保护数据。
配置密码后，编辑 **pg_hba.conf** 文件，将本地 **IPv4 连接** 的认证方式从默认的 **ident** 改为 **MD5 哈希**。

要将 **ident** 替换为 **md5**，执行以下命令：
```
sudo sed -i 's/^host\s\+all\s\+all\s\+127\.0\.0\.1\/32\s\+ident/host    all             all             127.0.0.1\/32            md5/' /var/lib/pgsql/16/data/pg_hba.conf
```
{: .copy-code}

然后执行将重启 **PostgreSQL** 服务以应用配置更改、以 postgres 用户连接数据库并创建 **ThingsBoard Edge 数据库 (tb_edge)** 的命令。
连接 **PostgreSQL** 数据库时，请输入 PostgreSQL **密码**。

```bash
sudo systemctl restart postgresql-16.service && psql -U postgres -d postgres -h 127.0.0.1 -W -c "CREATE DATABASE tb_edge;"
```
{: .copy-code}
