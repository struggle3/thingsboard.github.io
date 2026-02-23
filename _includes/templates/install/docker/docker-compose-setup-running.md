执行以下命令进行安装：

```bash
./docker-install-tb.sh --loadDemo
```
{: .copy-code}

其中：

- `--loadDemo` - 可选参数。是否加载额外演示数据。

执行以下命令启动服务：

```bash
./docker-start-services.sh
```
{: .copy-code}

当所有服务成功启动后，可在浏览器中打开 `http://{your-host-ip}`（例如 `http://localhost`）。
您将看到 ThingsBoard 登录页面。

使用以下默认凭证：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin

若使用了 `--loadDemo` 参数安装包含演示数据的数据库，还可使用以下凭证：

- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

若遇问题可查看服务日志排查错误。
例如，要查看 ThingsBoard 节点日志请执行以下命令：

```bash
docker compose {{dockerComposeFileLocation}}logs -f tb-core1 tb-rule-engine1
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose {{dockerComposeFileLocation}}logs -f tb-core1 tb-rule-engine1**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

或使用以下命令查看所有容器状态：

```bash
docker compose {{dockerComposeFileLocation}}ps
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose {{dockerComposeFileLocation}}ps**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

使用以下命令查看所有运行中服务的日志：

```bash
docker compose {{dockerComposeFileLocation}}logs -f
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose {{dockerComposeFileLocation}}logs -f**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

详见 [docker-compose logs](https://docs.docker.com/compose/reference/logs/) 命令参考。

执行以下命令停止服务：

```bash
./docker-stop-services.sh
```
{: .copy-code}

执行以下命令停止并完全移除已部署的 Docker 容器：

```bash
./docker-remove-services.sh
```
{: .copy-code}

执行以下命令更新指定或所有服务（拉取新镜像并重建容器）：

```bash
./docker-update-service.sh [SERVICE...]
```
{: .copy-code}

其中：

- `[SERVICE...]` - 要更新的服务列表（在 docker-compose 配置中定义）。若未指定则更新所有服务。
