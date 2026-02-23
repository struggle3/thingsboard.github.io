默认情况下，chart 会安装 Bitnami PostgreSQL 作为子 chart：

```yaml
# 此部分将引入 bitnami/postgresql (https://artifacthub.io/packages/helm/bitnami/postgresql)。
# 若要添加额外配置参数，可将其放在 `postgresql` 键下，将传递给 bitnami/postgresql chart
postgresql:
  # @param enabled 若 enabled 为 true，将忽略 externalPostgresql 配置
  enabled: true
```  

该 chart 将配置单节点实例，支持可配置的存储、备份和监控选项。
若已有 PostgreSQL 实例，可将 TBMQ 配置为外部连接。
为此，请将 `postgresql.enabled` 设为 `false` 以禁用内置 PostgreSQL，并在 `externalPostgresql` 部分指定连接详情。

```yaml
# 若在外部部署 PostgreSQL，请在此部分配置
externalPostgresql:
  # @param host - 外部 PostgreSQL 服务器 host
  host: ""
  # @param port - 外部 PostgreSQL 服务器端口
  ##
  port: 5432
  # @param username - PostgreSQL 用户
  ##
  username: "postgres"
  # @param password - PostgreSQL 用户密码
  ##
  password: "postgres"
  # @param database - TBMQ 使用的 PostgreSQL 数据库名
  ##
  database: "thingsboard_mqtt_broker"
```
