执行以下命令拉取镜像：

```bash
docker pull thingsboard/tb-pe-mqtt-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

创建集成日志卷（_799 为 ThingsBoard 非 root Docker 用户的用户 ID_）：

```bash
mkdir -p ~/.tb-pe-mqtt-integration-logs && sudo chown -R 799:799 ~/.tb-pe-mqtt-integration-logs
```
{: .copy-code}

执行以下命令运行集成：

```bash
docker run -it -v ~/.tb-pe-mqtt-integration-logs:/var/log/tb-mqtt-integration \
-e "RPC_HOST=mytbedge" -e "RPC_PORT=9090" \
-e "INTEGRATION_ROUTING_KEY=YOUR_ROUTING_KEY"  -e "INTEGRATION_SECRET=YOUR_SECRET" \
--name my-tb-pe-mqtt-integration --network edge_docker_default --restart always thingsboard/tb-pe-mqtt-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

参数说明：

- **mytbedge：** ThingsBoard Edge 服务的主机名。
- **9090：** 集成端口，由 tb-edge.yml 文件中的 INTEGRATIONS_RPC_PORT 环境变量配置。
- **YOUR_ROUTING_KEY：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的实际**集成路由密钥**。
- **YOUR_SECRET：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的实际**集成密钥**。
- **docker run：** 运行此容器的命令。
- **-it：** 附加终端会话以查看当前 ThingsBoard 远程集成进程输出。
- **-v ~/.tb-pe-mqtt-integration-logs:/var/log/tb-mqtt-integration：** 将主机目录 **~/.tb-pe-mqtt-integration-logs** 挂载到 ThingsBoard 远程集成日志目录。
- **--name my-tb-pe-mqtt-integration：** 容器的本地友好名称。
- **--network edge_docker_default：** **mytbedge** 服务所在的网络名称。
- **--restart always：** 系统重启或故障后自动启动 ThingsBoard 集成。
- **thingsboard/tb-pe-mqtt-integration:{{ site.release.pe_full_ver }}：** Docker 镜像。

执行此命令后，可打开位于 **~/.tb-pe-mqtt-integration-logs** 的日志。
您应能看到包含从服务器接收的最新集成配置的 INFO 日志消息。

要保持容器在后台运行并脱离当前终端会话，请按 **Ctrl+p** 后按 **Ctrl+q**。

#### 重新附加、停止和启动命令

要重新连接到终端（查看 ThingsBoard 远程集成日志）请运行：

```
docker attach tb-pe-mqtt-integration
```
{: .copy-code}

停止容器：

```
docker stop tb-pe-mqtt-integration
```
{: .copy-code}

启动容器：

```
docker start tb-pe-mqtt-integration
```
{: .copy-code}
