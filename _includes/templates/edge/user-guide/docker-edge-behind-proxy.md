#### 前提条件

* 具备代理服务器（**HTTP** 或 **HTTPS**），含地址、端口及凭据（如需）。
* 已安装并运行 **ThingsBoard Edge**，且可访问 **ThingsBoard Cloud**。
* 本机已安装 [Docker](https://docs.docker.com/engine/install/){: target="_blank"} 和 [Docker Compose](https://docs.docker.com/compose/install/){: target="_blank"}。

{% capture docker-deployment %}
进行代理配置前，请将终端切到包含 **docker-compose.yml** 文件的目录。
{% endcapture %}
{% include templates/info-banner.md content=docker-deployment %}

#### 步骤 1. 停止 Docker 容器

停止当前运行的 **TB Edge** 容器（若仍在运行）：

```bash
docker compose stop
```
{: .copy-code}

#### 步骤 2. 修改 .yml 文件

在 **docker-compose.yml** 中填入代理设置。 

打开文件可使用： 
```bash
sudo nano docker-compose.yml
```
{: .copy-code}

将以下行写入文件的 "environment" 块：
```yml
      HTTP_PROXY: http://proxy_user:proxy_password@<proxy_host:proxy_port
      HTTPS_PROXY: http://proxy_user:proxy_password@<proxy_host:proxy_port
      NO_PROXY: localhost,127.0.0.1,postgres,PUT_YOUR_CLOUD_IP
```
{: .copy-code}
* 在 **HTTP_PROXY** 和 **HTTPS_PROXY** 行分别指定 **HTTP** 与 **HTTPS** 代理服务器 
  * _例如：HTTP_PROXY=http://user:password@proxy.example.com:8080_
* 在 **NO_PROXY** 行列出需绕过代理的地址 
  * _例如：NO_PROXY=localhost,127.0.0.1,postgres,thingsboard.cloud_

预期结果：
{% include images-gallery.html imageCollection="configs" %}
#### 步骤 3. 重启容器

启动此 docker compose，执行以下命令：

```bash
docker compose up -d && docker compose logs -f mytbedge
```
{: .copy-code}

**Edge** 服务启动后，在 [http://localhost:8080](http://localhost:8080){: target="_blank"} 打开 **Edge UI**，使用 **租户凭据** 登录。

{% capture docker-deployment %}
若 Edge 安装时将 HTTP 绑定端口改为 **18080**，请通过 [http://localhost:18080](http://localhost:18080){: target="_blank"} 访问 **ThingsBoard Edge** 实例。
{% endcapture %}
{% include templates/info-banner.md content=docker-deployment %}

#### 故障排查

确认 **docker-compose.yml** 中的代理环境变量已正确设置：

```bash
echo $HTTP_PROXY
echo $HTTPS_PROXY
echo $NO_PROXY
```
{: .copy-code}

若变量未设置，检查容器内是否已正确应用：

```bash
docker exec -it container_name printenv | grep -i proxy
```
{: .copy-code}
若缺失，确保在 **docker-compose.yml** 中正确定义。

容器运行后，验证其是否可通过代理访问互联网：

```bash
docker exec -it container_name curl -I https://google.com
```
{: .copy-code}

若请求失败，可能表示代理配置错误或网络问题。

检查 Docker 容器日志以查找其他代理相关错误：

```bash
docker logs container_name
```
{: .copy-code}

检查连通性：

```bash
curl -x http://proxy_host:proxy_port https://your_tb_cloud_url
```
{: .copy-code}

### 下一步

{% include templates/edge/guides-banner-edge.md %}