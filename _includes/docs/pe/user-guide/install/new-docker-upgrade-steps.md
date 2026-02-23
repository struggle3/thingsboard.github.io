{% assign current_version = include.version %}
{% assign previous_version = include.previous_version %}
{%- assign family = include.family -%}

{% capture update_note %}
{% assign base_version_parts = base_version | split: "." %}
{% assign patch_part = base_version_parts[2] %}
{% if patch_status == "true" %}
若从 {{ previous_version }} 升级，您**必须**执行下方脚本。但若从 {{ family | append: "." | append: patch_part | append: ".x" }} 版本升级，**请不要**执行升级脚本，直接启动服务即可。
{% else %}
若从 {{ previous_version }} 版本升级，必须执行下方脚本
{% endif %}
{% endcapture %}

1. 将 `docker-compose.yml` 文件中 `thingsboard/tb-pe-node` 和 `thingsboard/tb-pe-web-report` 的版本改为 **{{ current_version }}**。

2. 执行以下命令：

```bash
docker pull thingsboard/tb-pe-node:{{ current_version }}
docker pull thingsboard/tb-pe-web-report:{{ current_version }}
docker compose stop thingsboard-pe
```
{: .copy-code}

{% include templates/warn-banner.md content=update_note %}

```bash
docker compose run --rm -e UPGRADE_TB=true thingsboard-pe
```
{: .copy-code}

```bash
docker compose up -d
```
{: .copy-code}