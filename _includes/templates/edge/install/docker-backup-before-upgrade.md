### 升级 ThingsBoard Edge 前的准备

升级前请备份 ThingsBoard Edge 数据。

#### 停止 Edge 容器

进入 **docker-compose.yml** 所在目录并停止容器：

```
docker compose stop
```
{: .copy-code}

#### 备份数据库卷

升级前，为数据库卷创建 **备份副本**：

```bash
docker run --rm -v tb-edge-postgres-data:/source -v tb-edge-postgres-data-backup:/backup busybox sh -c "cp -a /source/. /backup"
```
{: .copy-code}

此操作将 **tb-edge-postgres-data** 的全部内容复制到 **tb-edge-postgres-data-backup**。

#### 恢复备份（如需）

{% include templates/edge/user-guide/backup/docker-restore-backup.md %}
