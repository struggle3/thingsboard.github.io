## 升级 ThingsBoard Edge 前的准备

为确保升级期间数据完整性，请备份 ThingsBoard Edge 数据。

### 停止 Edge 服务

停止 ThingsBoard Edge 服务，防止升级过程中写入数据：

```bash
sudo systemctl stop tb-edge
```
{: .copy-code}

### 备份数据库

升级前创建数据库备份，避免潜在数据丢失。

{% capture check-space %}
请确保系统有足够的可用空间存储备份。
{% endcapture %}
{% include templates/info-banner.md content=check-space %}

检查当前数据库大小：

```bash
sudo -u postgres psql -c "SELECT pg_size_pretty( pg_database_size('tb_edge') );"
```
{: .copy-code}

检查可用磁盘空间：

```bash
df -h /
```
{: .copy-code}

创建备份：

```bash
sudo -Hiu postgres pg_dump tb_edge > tb_edge.sql.bak
```
{: .copy-code}

验证备份是否创建成功：

```bash
ls -lh tb_edge.sql.bak
```
{: .copy-code}

### 恢复备份（如需）

{% include templates/edge/user-guide/backup/ubuntu-restore-backup.md %}
