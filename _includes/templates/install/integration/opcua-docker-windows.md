Windows 用户应使用 Docker 托管卷存储远程集成日志。
在执行 docker run 命令前创建 Docker 卷（如 `tb-opc-ua-integration-logs`）：
打开「Docker Quickstart Terminal」，执行以下命令创建卷：

``` 
docker volume create tb-pe-opc-ua-integration-logs
```
{: .copy-code}

执行以下命令运行此 Docker：

```bash
docker run -it -v tb-pe-opc-ua-integration-logs:/var/log/tb-opc-ua-integration `
-e "RPC_HOST=thingsboard.cloud" -e "RPC_PORT=9090" `
-e "INTEGRATION_ROUTING_KEY=YOUR_ROUTING_KEY"  -e "INTEGRATION_SECRET=YOUR_SECRET" `
--name my-tb-pe-opc-ua-integration --restart always thingsboard/tb-pe-opc-ua-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

其中：
    
- `thingsboard.cloud` - 您的 ThingsBoard PE 实例的主机名；
- `9090` - 您的 ThingsBoard PE 实例的端口，通过 thingsboard.yml 中的 INTEGRATIONS_RPC_PORT 环境变量配置；
- `YOUR_ROUTING_KEY` - 占位符，替换为在 [于 ThingsBoard 中创建远程集成](#create-remote-integration-in-thingsboard) 时获取的**集成密钥**；
- `YOUR_SECRET` - 占位符，替换为在 [于 ThingsBoard 中创建远程集成](#create-remote-integration-in-thingsboard) 时获取的**集成密钥**；
- `docker run` - 运行此容器；
- `-it` - 附加到显示当前 ThingsBoard 进程输出的终端会话；
- `-v tb-pe-opc-ua-integration-logs:/var/log/tb-opc-ua-integration` - 将卷 `tb-pe-opc-ua-integration-logs` 挂载到 ThingsBoard 日志目录；
- `--name tb-pe-opc-ua-integration` - 容器的本地友好名称；
- `--restart always` - 系统重启或故障后自动启动 ThingsBoard 集成；
- `thingsboard/tb-pe-opc-ua-integration:{{ site.release.pe_full_ver }}` - Docker 镜像。

执行此命令后可在卷对应位置查看日志。
您应能看到一些带有最新从服务器接收的集成配置的 INFO 日志消息。

{% capture difference %}
可使用 **`Ctrl-p`**+**`Ctrl-q`** 从会话终端分离——容器将继续在后台运行。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

- **重新连接、停止和启动命令**

要重新连接到终端（查看 ThingsBoard 日志）请运行：

```
docker attach tb-pe-opc-ua-integration
```
{: .copy-code}

停止容器：

```
docker stop tb-pe-opc-ua-integration
```
{: .copy-code}

启动容器：

```
docker start tb-pe-opc-ua-integration
```
{: .copy-code}

