### 升级 ThingsBoard 前的准备工作

**停止 ThingsBoard**
检查 ThingsBoard 及数据库服务是否在运行。
先停止 ThingsBoard，检查状态确认已停止，再处理数据库。
```bash
sudo systemctl stop thingsboard
```
{: .copy-code}

```bash
sudo systemctl status thingsboard
```
{: .copy-code}

#### 备份数据库
升级前请对数据库进行备份。
##### PostgreSQL
检查 PostgreSQL 状态。备份时无需停止 PostgreSQL。
```bash
sudo systemctl status postgresql
```
{: .copy-code}

***请确保有足够的空间存放数据库备份***
检查数据库大小
```bash
sudo -u postgres psql -c "SELECT pg_size_pretty( pg_database_size('thingsboard') );"
```
{: .copy-code}
检查可用空间

```bash
df -h /
```
{: .copy-code}

如有足够可用空间，可执行备份。
```bash
sudo -Hiu postgres pg_dump thingsboard > thingsboard.sql.bak
```
{: .copy-code}

确认备份文件已创建。

##### Cassandra
检查 Cassandra 状态。备份 Cassandra 需先停止服务。

```bash
sudo systemctl status cassandra
```
{: .copy-code}

将所有 memtable 从节点刷新到磁盘上的 SSTable。

```bash
nodetool drain
```
{: .copy-code}

停止 Cassandra。

```bash
sudo systemctl stop cassandra
```
{: .copy-code}
需再次检查状态以确认已完全停止。

```bash
sudo systemctl status cassandra
```
{: .copy-code}

***请确保有足够的空间存放数据库备份***
检查数据库大小。
```bash
du -h /var/lib/cassandra/ | tail -1
```
{: .copy-code}

检查可用空间。
```bash
df -h /
```
{: .copy-code}

执行 Cassandra 数据库备份。
```bash
mkdir backup
sudo tar -cvf backup/cassandra.tar /var/lib/cassandra
```
{: .copy-code}

***确认归档是否正在创建***

#### 启动数据库
**Cassandra**
```bash
sudo systemctl start cassandra
```
{: .copy-code}

**PostgreSQL**
无需操作，PostgreSQL 已在运行。