拉取镜像，运行命令：

```bash
docker pull thingsboard/tb-pe-http-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

为集成日志创建卷（_799 为非root ThingsBoard Docker 用户的用户ID_）：

```bash
mkdir -p ~/.tb-pe-http-integration-logs && sudo chown -R 799:799 ~/.tb-pe-http-integration-logs
```
{: .copy-code}

使用以下命令运行集成：

```bash
docker run -it -v ~/.tb-pe-http-integration-logs:/var/log/tb-http-integration \
-e "RPC_HOST=mytbedge" -e "RPC_PORT=9090" \
-e "INTEGRATION_ROUTING_KEY=YOUR_ROUTING_KEY"  -e "INTEGRATION_SECRET=YOUR_SECRET" \
--name my-tb-pe-http-integration --network edge_docker_default --restart always thingsboard/tb-pe-http-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

参数说明：
    
- **mytbedge：** ThingsBoard Edge 服务的主机名。
- **9090：** 集成端口。由 tb-edge.yml 文件中的 INTEGRATIONS_RPC_PORT 环境变量配置。
- **YOUR_ROUTING_KEY：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的实际 **integration routing key**。
- **YOUR_SECRET：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的实际 **integration secret**。
- **docker run：** 运行此容器的命令。
- **-it：** 附加终端会话以查看当前 ThingsBoard 远程集成进程输出。
- **-v ~/.tb-pe-http-integration-logs:/var/log/tb-http-integration：** 将主机的 **~/.tb-pe-http-integration-logs** 目录挂载到 ThingsBoard 远程集成日志目录。
- **--name my-tb-pe-http-integration：** 此容器的本地名称。
- **--network edge_docker_default：** **mytbedge** 服务所在的网络名称。
- **--restart always：** 系统重启或故障后自动启动 ThingsBoard Integration。
- **thingsboard/tb-pe-http-integration:{{ site.release.pe_full_ver }}：** Docker 镜像。

执行此命令后，可打开位于 **~/.tb-pe-http-integration-logs** 的日志。
您应能看到包含从Server接收的最新集成配置的 INFO 级别日志消息。

要保持容器在后台运行并脱离当前终端会话，请按 **Ctrl+p** 后按 **Ctrl+q**。

#### 重新附加、停止和启动命令

要重新附加到终端（查看 ThingsBoard 远程集成日志），运行：

```
docker attach tb-pe-http-integration
```
{: .copy-code}

停止容器：

```
docker stop tb-pe-http-integration
```
{: .copy-code}

启动容器：

```
docker start tb-pe-http-integration
```
{: .copy-code}
