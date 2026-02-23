#### 服务器

编辑 **ThingsBoard 配置文件**：
```bash
sudo nano /etc/thingsboard/conf/thingsboard.conf
```
{: .copy-code}

在配置文件中添加以下内容：
```bash
export EDGES_RPC_CLIENT_MAX_KEEP_ALIVE_TIME_SEC=1
export EDGES_RPC_KEEP_ALIVE_TIME_SEC=30
export EDGES_RPC_KEEP_ALIVE_TIMEOUT_SEC=25
```
{: .copy-code}

#### Edge

然后编辑 **ThingsBoard Edge 配置文件**：
```bash
sudo nano /etc/tb-edge/conf/tb-edge.conf
```
{: .copy-code}

在配置文件中添加以下内容：
```bash
export CLOUD_RPC_KEEP_ALIVE_TIME_SEC=30
export CLOUD_RPC_KEEP_ALIVE_TIMEOUT_SEC=25
```
{: .copy-code}

完成所有更改后，重启 **ThingsBoard** 和 **TB Edge** 服务。
