#### 前提条件

* 具备代理服务器（**HTTP** 或 **HTTPS**），含地址、端口及凭据（如需）。
* 明确需绕过代理的地址（如内网资源）。
* 已安装 **Java 17**。
* 已安装并运行 **ThingsBoard Edge**。

#### 步骤 1. 修改配置文件

在基于 Debian 的安装（如 Ubuntu）中配置代理后的 **ThingsBoard Edge**，请修改 **tb-edge.conf** 文件：

```bash
sudo tee -a /etc/tb-edge/conf/tb-edge.conf > /dev/null <<EOL
#Enable the proxy
export CLOUD_RPC_PROXY_ENABLED=true

#Set the proxy server host and port
export CLOUD_RPC_PROXY_HOST="proxy_host"
export CLOUD_RPC_PROXY_PORT="proxy_port"
EOL
```
{: .copy-code}

* 将 _proxy_host_ 和 _proxy_port_ 替换为代理的主机名和端口。
* 若有需绕过代理的主机（如内网地址），按格式设置 <non_proxy_hosts>：localhost|127.0.0.1|yourdomain.com

##### 配置认证（如需）

若代理需认证，添加以下参数：

```bash
#(Optional) Add authentication if required
export CLOUD_RPC_PROXY_USERNAME="proxy_username"
export CLOUD_RPC_PROXY_PASSWORD="proxy_password"
```
{: .copy-code}

* 将 _proxy_user_ 和 _proxy_password_ 替换为实际凭据。

##### 验证更改（可选）

运行以下命令验证更改：

```bash
cat /etc/tb-edge/conf/tb-edge.conf
```
{: .copy-code}

#### 步骤 2. 重启 ThingsBoard Edge

修改 **tb-edge.conf** 后需重启服务使更改生效：

```bash
sudo service tb-edge restart
```
{: .copy-code}

**Edge** 服务启动后，在 [http://localhost:8080](http://localhost:8080){: target="_blank"} 打开 **Edge UI**，使用 **租户凭据** 登录。

{% capture docker-deployment %}
若 Edge 安装时将 HTTP 绑定端口改为 **18080**，请通过 [http://localhost:18080](http://localhost:18080){: target="_blank"} 访问 **ThingsBoard Edge** 实例。
{% endcapture %}
{% include templates/info-banner.md content=docker-deployment %}

#### 故障排查

**ThingsBoard Edge** 日志存放在以下目录：

```bash
/var/log/tb-edge
```
检查服务端是否有错误：

```bash
cat /var/log/tb-edge/tb-edge.log | grep ERROR
```
{: .copy-code}

检查连通性：

```bash
curl -x http://proxy_host:proxy_port https://your_tb_cloud_url
```
{: .copy-code}

* 将 _proxy_host_ 和 _proxy_port_ 替换为代理的主机名和端口。

确认服务可到达代理服务器：

```bash
ping proxy_host
traceroute proxy_host
```
{: .copy-code}

* 将 _proxy_host_ 替换为代理的主机名。

### 下一步

{% include templates/edge/guides-banner-edge.md %}