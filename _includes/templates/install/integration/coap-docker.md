执行以下命令拉取镜像：

```bash
docker pull thingsboard/tb-pe-coap-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

执行以下命令创建集成日志卷 (799 is the user id of ThingsBoard non-root docker user):

```bash
mkdir -p ~/.tb-pe-coap-integration-logs && sudo chown -R 799:799 ~/.tb-pe-coap-integration-logs
```
{: .copy-code}

执行以下命令运行集成：

```bash
docker run -it -p 5683:5683/udp -v ~/.tb-pe-coap-integration-logs:/var/log/tb-coap-integration  \
-e "RPC_HOST={{hostName}}" -e "RPC_PORT=9090" \
-e "INTEGRATION_ROUTING_KEY=YOUR_ROUTING_KEY"  -e "INTEGRATION_SECRET=YOUR_SECRET" \
--name my-tb-pe-coap-integration --restart always thingsboard/tb-pe-coap-integration:{{ site.release.pe_full_ver }}
```
{: .copy-code}

其中：
    
- `{{hostName}}` - 您的 ThingsBoard PE 实例的主机名；
- `9090` - 您的 ThingsBoard PE 实例的端口，通过 thingsboard.yml 中的 INTEGRATIONS_RPC_PORT 环境变量配置；
- `YOUR_ROUTING_KEY` - 占位符，替换为在 [于 ThingsBoard 中创建远程集成](#create-remote-integration-in-thingsboard) 时获取的**集成密钥**；
- `YOUR_SECRET` - 占位符，替换为在 [于 ThingsBoard 中创建远程集成](#create-remote-integration-in-thingsboard) 时获取的**集成密钥**；
- `docker run` - 运行此容器；
- `-it` - 附加到显示当前 ThingsBoard 进程输出的终端会话；
- `-p 5683:5683/udp` - 将本地 UDP 端口 5683 映射到集成的内部 UDP 端口 5683；
- `-v ~/.tb-pe-coap-integration-logs:/var/log/tb-coap-integration` - 将主机目录 `~/.tb-pe-coap-integration-logs` 挂载到 ThingsBoard 日志目录；
- `--name tb-pe-coap-integration` - 容器的本地友好名称；
- `--restart always` - 系统重启或故障后自动启动 ThingsBoard 集成；
- `thingsboard/tb-pe-coap-integration:{{ site.release.pe_full_ver }}` - Docker 镜像。

执行此命令后可在以下位置查看日志 `~/.tb-pe-coap-integration-logs`。
您应能看到一些带有最新从服务器接收的集成配置的 INFO 日志消息。

{% capture difference %}
可使用 **`Ctrl-p`**+**`Ctrl-q`** 从会话终端分离——容器将继续在后台运行。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

- **重新连接、停止和启动命令**

要重新连接到终端（查看 ThingsBoard 日志）请运行：

```
docker attach tb-pe-coap-integration
```
{: .copy-code}

停止容器：

```
docker stop tb-pe-coap-integration
```
{: .copy-code}

启动容器：

```
docker start tb-pe-coap-integration
```
{: .copy-code}