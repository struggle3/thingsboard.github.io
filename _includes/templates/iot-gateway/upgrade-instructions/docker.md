### 步骤 1：停止并移除现有容器

首先，停止当前运行的 Gateway 容器：

```bash
docker compose down
```
{: .copy-code}

该操作将正常关闭网关并移除容器，不会删除任何卷或配置数据。

### 步骤 2：拉取最新 Gateway 镜像

拉取 ThingsBoard IoT Gateway Docker 镜像的最新版本：

```bash
docker pull thingsboard/tb-gateway
```
{: .copy-code}

### 步骤 3：启动更新后的 Gateway

使用更新后的镜像重新创建并启动容器：

```bash
docker compose up -d
```
{: .copy-code}

`-d` 参数表示在后台模式运行容器。

### 步骤 4：验证升级

为确保升级成功，可通过以下命令查看 Gateway 日志：

```bash
docker compose logs -f
```
{: .copy-code}

将实时显示日志，便于确认 Gateway 是否已正确运行新版本。

### 说明

- 只要 `docker-compose.yml` 和卷映射配置正确，此方法适用于任意版本的 Gateway。
- 为实现后续自动升级，可考虑在 Compose 文件中进行版本固定或标签标记，并关注官方镜像变更日志。
