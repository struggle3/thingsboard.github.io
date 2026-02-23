在运行时查看最新日志：

```bash
docker compose logs -f tb-edge
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose 命令，请执行：

**docker-compose logs -f tb-edge**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

可使用 <b>grep</b> 命令仅显示包含指定字符串的输出。
例如，可用以下命令检查后端是否存在错误：

```bash
docker compose logs tb-edge | grep ERROR
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose 命令，请执行：

**docker-compose logs tb-edge \| grep ERROR**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**提示：** 可将日志重定向到文件，然后用任意文本编辑器分析：

```bash
docker compose logs -f tb-edge > tb-edge.log
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose 命令，请执行：

**docker-compose logs -f tb-edge > tb-edge.log**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**注意：** 可随时登录 ThingsBoard Edge 容器并在其中查看日志：

```bash
docker ps
docker exec -it NAME_OF_THE_CONTAINER bash
```
{: .copy-code}
