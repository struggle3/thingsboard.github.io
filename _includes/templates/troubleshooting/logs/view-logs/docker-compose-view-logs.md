实时查看最新日志：

```bash
docker compose logs -f tb-core1 tb-core2 tb-rule-engine1 tb-rule-engine2
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs -f tb-core1 tb-core2 tb-rule-engine1 tb-rule-engine2**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

若怀疑问题仅与 rule-engine 相关，可只查看 rule-engine 日志：

```bash
docker compose logs -f tb-rule-engine1 tb-rule-engine2
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs -f tb-rule-engine1 tb-rule-engine2**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

可使用 <b>grep</b> 命令仅显示包含指定字符串的输出。
例如，可用以下命令检查后端是否存在错误：

```bash
docker compose logs tb-core1 tb-core2 tb-rule-engine1 tb-rule-engine2 | grep ERROR
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs tb-core1 tb-core2 tb-rule-engine1 tb-rule-engine2 \| grep ERROR**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**提示：** 可将日志重定向到文件后用任意文本编辑器分析：

```bash
docker compose logs -f tb-rule-engine1 tb-rule-engine2 > rule-engine.log
```
{: .copy-code}

{% capture dockerComposeStandalone %}
若仍使用带连字符的 docker-compose，请执行：

**docker-compose logs -f tb-rule-engine1 tb-rule-engine2 > rule-engine.log**
{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}

**注意：** 可随时进入 ThingsBoard 容器内查看日志：

```bash
docker ps
docker exec -it NAME_OF_THE_CONTAINER bash
```
