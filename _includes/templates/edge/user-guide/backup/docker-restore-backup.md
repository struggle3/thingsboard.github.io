停止 **ThingsBoard Edge** 容器（若仍在运行）：

```bash
docker compose stop
```
{: .copy-code}

若要从备份卷恢复数据到主卷，执行以下命令：

```bash
docker run --rm -v tb-edge-postgres-data-backup:/source -v tb-edge-postgres-data:/target busybox sh -c "cp -a /source/. /target"
 ```
{: .copy-code}

启动 **ThingsBoard Edge** 容器：

```bash
docker compose up -d 
```
{: .copy-code}
