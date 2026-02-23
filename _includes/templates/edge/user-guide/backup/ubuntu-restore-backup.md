停止 **ThingsBoard Edge** 服务（若仍在运行）：

```bash
sudo systemctl stop tb-edge
```
{: .copy-code}

若要从备份文件恢复 **PostgreSQL** 数据库，执行以下命令：

```bash
 sudo -u postgres psql tb_edge < tb_edge.sql.bak
 ```
{: .copy-code}

启动 **ThingsBoard Edge** 服务：

```bash
sudo systemctl start tb-edge
```
{: .copy-code}


