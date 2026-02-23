在执行初始安装之前，可配置 ThingsBoard 使用的数据库类型。
要设置数据库类型，请在 `.env` 文件中更改 `DATABASE` 变量的值： 

```bash
nano .env
```
{: .copy-code}

设置为以下之一：

- `postgres` - 使用 PostgreSQL 数据库；
- `hybrid` - 实体数据库使用 PostgreSQL，时序数据库使用 Cassandra；

**注意**：根据数据库类型将部署相应的 docker 服务（详见 `docker-compose.postgres.yml`、`docker-compose.hybrid.yml`）。