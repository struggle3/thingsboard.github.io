{% assign current_version = include.version %}

1. 将 `docker-compose.yml` 文件中 `thingsboard/tb-pe-node` 和 `thingsboard/tb-pe-web-report` 的版本改为 **{{ current_version }}**。

2. 执行以下命令：

{% if include.skipUpgrade %}

```bash
docker pull thingsboard/tb-pe-node:{{ current_version }}
docker pull thingsboard/tb-pe-web-report:{{ current_version }}
docker compose stop thingsboard-pe
docker compose up -d
```
{: .copy-code}

{% else %}

```bash
docker pull thingsboard/tb-pe-node:{{ current_version }}
docker pull thingsboard/tb-pe-web-report:{{ current_version }}
docker compose stop thingsboard-pe
docker compose run --rm -e UPGRADE_TB=true thingsboard-pe
docker compose up -d
```
{: .copy-code}

{% endif %}
