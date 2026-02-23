请参阅 [TimescaleDB 官方安装页面](https://docs.timescale.com/self-hosted/latest/install/installation-linux/)在 RHEL/CentOS 发行版上的说明，并根据您安装的 PostgreSQL 版本按照说明操作。

在软件包安装之后，您需要在 ThingsBoard 数据库中创建 TimescaleDB 扩展：
```bash
sudo su - postgres
psql -d thingsboard
CREATE EXTENSION IF NOT EXISTS timescaledb;
\q
#然后按 "Ctrl+D" 返回主用户控制台。
```
