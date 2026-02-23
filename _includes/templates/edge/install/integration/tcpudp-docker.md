执行以下命令拉取镜像：

```bash
docker pull thingsboard/tb-pe-tcp-udp-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

为集成日志创建卷（_799 为非 root ThingsBoard Docker 用户的用户 ID_）：

```bash
mkdir -p ~/.tb-pe-tcp-udp-integration-logs && sudo chown -R 799:799 ~/.tb-pe-tcp-udp-integration-logs
```
{: .copy-code}

执行以下命令运行集成：

```liquid
{% if page.url contains "udp" or page.url contains "remote-integrations" -%}
docker run -it -p 11560:11560/udp -v ~/.tb-pe-tcp-udp-integration-logs:/var/log/tb-tcp-udp-integration  \
{%- else -%}
docker run -it -p 10560:10560 -v ~/.tb-pe-tcp-udp-integration-logs:/var/log/tb-tcp-udp-integration  \ 
{%- endif -%}-e "RPC_HOST=mytbedge" -e "RPC_PORT=9090" \
-e "INTEGRATION_ROUTING_KEY=YOUR_ROUTING_KEY"  -e "INTEGRATION_SECRET=YOUR_SECRET" \
--name my-tb-pe-tcp-udp-integration --network NETWORK_NAME \
--restart always thingsboard/tb-pe-tcp-udp-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

参数说明：

- **mytbedge：** ThingsBoard Edge 服务的主机名。
- **9090：** 集成端口，由 **tb-edge.yml** 文件中的 **INTEGRATIONS_RPC_PORT** 环境变量配置。
{% if page.url contains "udp" %}
- **-p 11560:11560/udp：** 当 exposed 端口为 UDP 时使用。
- **YOUR_ROUTING_KEY：** 替换为实际的**集成路由密钥**。
- **YOUR_SECRET：** 替换为实际的**集成密钥**。
{% elsif page.url contains "tcp" %}
- **-p 10560:10560：** 将本地端口 10560 映射到 TCP 集成的内部端口 10560。
- **YOUR_ROUTING_KEY：** 替换为实际的**集成路由密钥**。
- **YOUR_SECRET：** 替换为实际的**集成密钥**。
{% elsif page.url contains "remote-integrations" %}
- **-p 11560:11560/udp：** 当 exposed 端口为 UDP 时使用。
- **-p 10560:10560：** 将本地端口 10560 映射到 TCP 集成的内部端口 10560。
- **YOUR_ROUTING_KEY：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的实际**集成路由密钥**。
- **YOUR_SECRET：** 替换为 [步骤 3](/docs/pe/edge/user-guide/integrations/remote-integrations/#step-3-save-remote-integration-credentials){: target="_blank"} 中获取的实际**集成密钥**。
{% endif %}
- **docker run：** 运行此容器的命令。
- **-it：** 附加终端会话以查看当前 ThingsBoard 远程集成进程输出。
- **-v ~/.tb-pe-tcp-udp-integration-logs:/var/log/tb-tcp-udp-integration：** 将主机目录 **~/.tb-pe-tcp-udp-integration-logs** 挂载到 ThingsBoard 远程集成日志目录。
- **--name tb-pe-tcp-udp-integration：** 设置集成的本地名称。
- **--network NETWORK_NAME：** **mytbedge** 服务所在的网络名称。请将 **NETWORK_NAME** 替换为实际网络名。
  - 要查看网络名称，可运行以下命令： 

  ```bash
  docker network ls
  ``` 
  {: .copy-code}

- **--restart always：** 系统重启或故障后自动启动 ThingsBoard 集成。
- **thingsboard/tb-pe-tcp-udp-integration:{{ site.release.pe_full_ver }}：** Docker 镜像。

执行此命令后，可打开位于 **~/.tb-pe-tcp-udp-integration-logs** 的日志。
您应能看到包含从服务器接收的最新集成配置的 INFO 日志消息。

要保持容器在后台运行并脱离当前终端会话，请按 **Ctrl+p** 后按 **Ctrl+q**。

#### 重新附加、停止和启动命令

要重新连接到终端（查看 ThingsBoard 远程集成日志）请运行：

```bash
docker attach my-tb-pe-tcp-udp-integration
```
{: .copy-code}

停止容器：

```bash
docker stop my-tb-pe-tcp-udp-integration
```
{: .copy-code}

启动容器：

```bash
docker start my-tb-pe-tcp-udp-integration
```
{: .copy-code}

