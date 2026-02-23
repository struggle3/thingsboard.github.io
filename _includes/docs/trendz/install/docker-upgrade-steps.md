{% assign current_version = include.version %}

1. 创建数据库备份导出：
    ```bash
    docker compose exec postgres sh -c "pg_dump -U postgres trendz > /var/lib/postgresql/data/trendz_dump"
    ```
    {: .copy-code}

2. 将 `docker-compose.yml` 中 `thingsboard/trendz` 与 `thingsboard/trendz-python-executor` 的版本号改为 **{{ current_version }}**。

3. 执行以下命令：
{% if include.skipUpgrade %}
    ```bash
    docker pull thingsboard/trendz:{{ current_version }}
    docker compose stop trendz
    docker compose up -d
    ```
    {: .copy-code}
{% else %}
    ```bash
    docker pull thingsboard/trendz:{{ current_version }}
    docker compose stop trendz
    docker compose run --rm -e UPGRADE_TRENDZ=true trendz
    docker compose up -d
    ```
    {: .copy-code}
{% endif %} 