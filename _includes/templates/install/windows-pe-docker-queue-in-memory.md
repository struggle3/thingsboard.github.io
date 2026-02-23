**ThingsBoard 包含内存队列服务，默认使用且无需额外配置。**

创建 ThingsBoard 队列服务的 docker compose 文件：

```text
notepad docker-compose.yml
```
{: .copy-code}

将以下内容添加到 yml 文件中。 请勿忘记将 "PUT_YOUR_LICENSE_SECRET_HERE" 替换为**第一步中获取的许可证密钥**：

```yml
services:
  postgres:
    restart: always
    image: "postgres:16"
    ports:
      - "5432"
    environment:
      POSTGRES_DB: thingsboard
      POSTGRES_PASSWORD: postgres
    volumes:
      - postgres-data:/var/lib/postgresql/data
  thingsboard-pe:
    restart: always
    image: "thingsboard/tb-pe-node:{{ site.release.pe_full_ver }}"
    ports:
      - "8080:8080"
      - "1883:1883"
      - "8883:8883"
      - "9090:9090"
      - "7070:7070"
      - "5683-5688:5683-5688/udp"
    logging:
      driver: "json-file"
      options:
        max-size: "100m"
        max-file: "10"
    environment:
      TB_SERVICE_ID: tb-pe-node
      TB_LICENSE_SECRET: PUT_YOUR_LICENSE_SECRET_HERE
      TB_LICENSE_INSTANCE_DATA_FILE: /data/license.data
      REPORTS_SERVER_ENDPOINT_URL: http://tb-web-report:8383
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/thingsboard
      DEFAULT_TRENDZ_URL: http://trendz:8888
      DEFAULT_TB_URL: http://thingsboard-pe:8080
    volumes:
      - license-data:/data
    depends_on:
      - postgres
  tb-web-report:
    restart: always
    image: "thingsboard/tb-pe-web-report:{{ site.release.pe_full_ver }}"
    ports:
      - "8383"
    depends_on:
      - thingsboard-pe
    environment:
      HTTP_BIND_ADDRESS: 0.0.0.0
      HTTP_BIND_PORT: 8383
      LOGGER_LEVEL: info
      LOG_FOLDER: logs
      LOGGER_FILENAME: tb-web-report-%DATE%.log
      DOCKER_MODE: true
      DEFAULT_PAGE_NAVIGATION_TIMEOUT: 120000
      DASHBOARD_IDLE_WAIT_TIME: 3000
      USE_NEW_PAGE_FOR_REPORT: true
volumes:
  postgres-data:
    name: tb-postgres-data
    driver: local
  license-data:
    name: tb-pe-license-data
    driver: local
```
{: .copy-code.expandable-15}
