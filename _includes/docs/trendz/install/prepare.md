### 升级 Trendz Analytics 前的准备

**停止 Trendz Analytics**
检查 Trendz 与数据库服务是否已停止。
```bash
sudo systemctl stop trendz
```
{: .copy-code}

```bash
sudo systemctl status trendz
```
{: .copy-code}

#### 备份数据库
升级前请备份数据库。

检查 PostgreSQL 状态。备份时无需停止 PostgreSQL。
```bash
sudo systemctl status postgresql
```
{: .copy-code}

***请确保有足够空间存放数据库备份***

检查数据库大小
```bash
sudo -u postgres psql -c "SELECT pg_size_pretty( pg_database_size('trendz') );"
```
{: .copy-code}
检查可用空间

```bash
df -h /
```
{: .copy-code}

若有足够可用空间，请执行备份。
```bash
sudo -Hiu postgres pg_dump trendz > trendz.sql.bak
```
{: .copy-code}

确认备份文件已生成。