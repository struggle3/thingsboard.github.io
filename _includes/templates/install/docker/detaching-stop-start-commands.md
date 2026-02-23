可使用 `Ctrl-p` `Ctrl-q` 键序从会话终端分离——容器将继续在后台运行。

如有问题，可检查服务日志以排查错误。
例如，查看 {{serviceFullName}} 容器日志请执行以下命令：

```
docker compose logs -f my{{serviceName}}
```
{: .copy-code}

停止容器：

```
docker compose stop my{{serviceName}}
```
{: .copy-code}

启动容器：

```
docker compose start my{{serviceName}}
```
{: .copy-code}

{% capture dockerComposeStandalone %}
Docker Compose 的 docker-compose（带连字符）写法已废弃。建议改用 Docker Compose V2。
<br>若仍使用独立的 docker compose，以上命令对应为：
<br>**docker-compose logs -f my{{serviceName}}**
<br>**docker-compose stop my{{serviceName}}**
<br>**docker-compose start my{{serviceName}}**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}
