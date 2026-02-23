{% capture edge-previousVersion %}
以下步骤适用于Edge {{previousVersion}} 版本。
{% endcapture %}
{% include templates/info-banner.md content=edge-previousVersion %}

将终端切换到包含 "docker-compose.yml" 文件的目录，运行以下命令停止并移除当前运行的TB Edge容器（若仍在运行）：
```
docker compose stop mytbedge
```
{: .copy-code}

修改 **ThingsBoard Edge** 的主docker compose文件（docker-compose.yml）并更新镜像版本：

```text
sed -i 's|thingsboard/tb-edge:{{previousVersion}}|thingsboard/tb-edge:{{versionName}}|' docker-compose.yml
```
{: .copy-code}

{% include templates/edge/install/info-patch-upgrade.md %}

要启动此docker compose，运行以下命令：
```
docker compose up -d && docker compose logs -f mytbedge
```
{: .copy-code}
