#### 服务器
在进行任何更改前先停止当前运行的 **ThingsBoard** 容器。然后编辑 docker compose 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

在 YAML 文件的 **"environment"** 块中添加以下内容：
```yml
    environment:
      - EDGES_RPC_CLIENT_MAX_KEEP_ALIVE_TIME_SEC=1
      - EDGES_RPC_KEEP_ALIVE_TIME_SEC=30
      - EDGES_RPC_KEEP_ALIVE_TIMEOUT_SEC=25
```
{: .copy-code}

#### Edge

在进行任何更改前先停止当前运行的 **TB Edge 容器**。然后编辑 docker compose 文件：

```bash
nano docker-compose.yml
```
{: .copy-code}

在 YAML 文件的 **"environment"** 块中添加以下内容：
```yml
    environment:
      - CLOUD_RPC_KEEP_ALIVE_TIME_SEC=30
      - CLOUD_RPC_KEEP_ALIVE_TIMEOUT_SEC=25
```
{: .copy-code}

完成所有更改后，启动 **ThingsBoard** 和 **TB Edge** Docker 容器。
