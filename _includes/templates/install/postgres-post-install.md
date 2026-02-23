安装 **PostgreSQL** 后，建议为 **PostgreSQL 主用户** 设置密码。

以下命令将切换当前用户为 PostgreSQL 用户并在 PostgreSQL 中直接设置密码。
```bash
sudo -u postgres psql -c "\password"
```
{: .copy-code}

然后**输入并确认**密码。