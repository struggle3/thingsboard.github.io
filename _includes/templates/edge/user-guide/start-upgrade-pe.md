_**注意**：以下步骤适用于ThingsBoard {{previousVersion}} 版本。

将终端切换到包含 "docker-compose.yml" 文件的目录，运行以下命令停止并移除当前运行的TB Edge容器（若仍在运行）：
```
docker compose stop mytbedge
```
{: .copy-code}

升级前，请备份数据库卷：

```bash
docker run --rm -v tb-edge-postgres-data:/source -v tb-edge-postgres-data-backup:/backup busybox sh -c "cp -a /source/. /backup"
```
{: .copy-code}

修改 **ThingsBoard Edge** 的主docker compose文件（docker-compose.yml）并更新镜像版本：

```text
sed -i 's|thingsboard/tb-edge-pe:{{previousVersion}}|thingsboard/tb-edge-pe:{{versionName}}|' docker-compose.yml
```
{: .copy-code}

{% include templates/edge/install/info-patch-upgrade.md %}

启动docker compose：
```bash
docker compose up -d && docker compose logs -f mytbedge
```
{: .copy-code}
