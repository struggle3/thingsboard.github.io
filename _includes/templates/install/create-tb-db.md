然后，以 "postgres" 用户身份连接 "postgres" 数据库：

```bash
psql -U postgres -d postgres -h 127.0.0.1 -W
```
{: .copy-code}

创建名为 "thingsboard" 的 ThingsBoard 数据库：
```bash
CREATE DATABASE thingsboard;
```
{: .copy-code}

按两次 "Ctrl+D" 退出 PostgreSQL。
