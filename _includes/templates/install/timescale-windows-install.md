请参阅 Windows 上的 [TimescaleDB 官方安装页面](https://docs.timescale.com/self-hosted/latest/install/installation-windows/)，并根据您安装的 PostgreSQL 版本按说明操作。

在软件包安装之后，您需要在 ThingsBoard 数据库中创建 TimescaleDB 扩展：
1. 运行 PSQL 控制台：开始菜单 → PostgreSQL → SQL Shell (psql)；
2. 登录到「thingsboard」数据库；
3. 运行以下命令：
```bash 
CREATE EXTENSION IF NOT EXISTS timescaledb;
```
{: .copy-code}