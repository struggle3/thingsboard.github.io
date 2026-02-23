配置密码后，连接数据库以创建 thingsboard 数据库：

```bash
psql -U postgres -d postgres -h 127.0.0.1 -W
```
{: .copy-code}

执行创建数据库语句：

```bash
CREATE DATABASE thingsboard;
```
{: .copy-code}

然后按两次 "Ctrl+D" 退出 PostgreSQL。
