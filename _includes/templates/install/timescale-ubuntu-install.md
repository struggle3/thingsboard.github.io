请参阅 [TimescaleDB 官方安装页面](https://docs.timescale.com/self-hosted/latest/install/installation-linux/)在 Ubuntu 发行版上的说明，并根据您安装的 PostgreSQL 版本按照说明操作。

在软件包安装之后，您需要在 ThingsBoard 数据库中创建 TimescaleDB 扩展：
```bash
psql -U postgres -h localhost -d thingsboard
CREATE EXTENSION IF NOT EXISTS timescaledb;
\q
```
