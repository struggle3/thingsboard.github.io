运行时查看最新日志：
 
```bash
docker compose logs -f tbmq-1 tbmq-2
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs -f tbmq-1 tbmq-2**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

可使用 **grep** 仅显示包含指定字符串的输出。
例如，检查 backend 侧是否有错误：

```bash
docker compose logs tbmq-1 tbmq-2 | grep ERROR
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs tbmq-1 tbmq-2 \| grep ERROR**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**提示：** 可将日志重定向到文件再用任意文本编辑器分析：

```bash
docker compose logs -f tbmq-1 tbmq-2 > tbmq.log
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs -f tbmq-1 tbmq-2 > tbmq.log**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**说明：** 也可进入 TBMQ 容器内查看日志：

```bash
docker ps
docker exec -it NAME_OF_THE_CONTAINER bash
```
{: .copy-code}
