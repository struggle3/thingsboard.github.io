{% assign current_version = include.version %}

1. 将`docker-compose.yml`中`thingsboard/tb-node`的版本改为**{{ current_version }}**。

2. 执行以下命令：

{% if include.skipUpgrade %}

```bash
docker pull thingsboard/tb-node:{{ current_version }}
docker compose stop thingsboard-ce 
docker compose up -d
```
{: .copy-code}

{% else %}

```bash
docker pull thingsboard/tb-node:{{ current_version }}
docker compose stop thingsboard-ce
docker compose run --rm -e UPGRADE_TB=true thingsboard-ce 
docker compose up -d
```
{: .copy-code}

{% endif %} 
