* TOC
{:toc}

本指南概述使用 TLS/SSL 上的 gRPC 连接保护 ThingsBoard 与 Edge 实例之间连接的步骤。

您可通过两种方式配置 SSL 终结：利用平台的内置 gRPC 流量 SSL 能力，或采用外部负载均衡器作为终结点。

说明分为两部分：配置服务器端（平台）和客户端（edge）。

## Server SSL 配置

选择使用内置机制或负载均衡器进行 gRPC 流量的 SSL 终结。使用下方内容切换选择并查看各选项的说明。

{% capture contenttogglespec %}
Build-in mechanism%,%build_in%,%templates/edge/user-guide/grpc-over-ssl-build-in.md%br%
Load Balancer%,%load_balancer%,%templates/edge/user-guide/grpc-over-ssl-load-balancer.md{% endcapture %}

{% include content-toggle.html content-toggle-id="platformOption" toggle-spec=contenttogglespec %}

## 配置 Edge 使用 SSL 连接

### Ubuntu 或 CentOS/RHEL

要在 Ubuntu 或 CentOS/RHEL 安装的 Edge 上启用 SSL 通信，请执行以下命令：

```bash
sudo sh -c 'cat <<EOL >> /etc/tb-edge/conf/tb-edge.conf
export CLOUD_RPC_SSL_ENABLED=true
EOL'
```
{: .copy-code}

若使用自签名证书，需要将服务器端公钥证书添加到 Edge 配置中以验证服务器证书：

```bash
sudo sh -c 'cat <<EOL >> /etc/tb-edge/conf/tb-edge.conf
export CLOUD_RPC_SSL_CERT=certFile.crt
EOL'
```
{: .copy-code}

要应用这些更改，请重启 Edge：

```bash
sudo systemctl restart tb-edge
```
{: .copy-code}

### Docker

在 Docker 部署中，请确保 `docker-compose.yml` 文件中的 **CLOUD_RPC_SSL_ENABLED** 变量设置为 'true'。
若使用自签名证书，也请相应设置 **CLOUD_RPC_SSL_CERT**。

进行这些更改后，使用以下命令重启 ThingsBoard Edge Docker 容器：

```bash
docker compose restart mytbedge
```
{: .copy-code}
