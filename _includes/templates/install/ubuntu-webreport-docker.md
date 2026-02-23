## 前提条件

安装 Docker [Ubuntu 版本](https://docs.docker.com/engine/install/ubuntu/)。

{% include templates/install/docker-install-note.md %}

创建 docker compose 文件
```bash
cat <<EOT >> tb-web-report.yml
version: '3.0'
services:
  tb-web-report:
    container_name: tb-web-report
    restart: always
    image: "thingsboard/tb-pe-web-report:{{ site.release.pe_full_ver }}"
    ports:
      - "8383:8383"
    env_file:
      - ./tb-web-report.env
EOT
```
{: .copy-code}

为 tb-web-report 容器创建 .env 文件
```bash
cat <<EOT >> tb-web-report.env
HTTP_BIND_ADDRESS=0.0.0.0
HTTP_BIND_PORT=8383
LOGGER_LEVEL=info
LOG_FOLDER=logs
LOGGER_FILENAME=tb-web-report-%DATE%.log
DOCKER_MODE=true

DEFAULT_PAGE_NAVIGATION_TIMEOUT=120000
DASHBOARD_LOAD_WAIT_TIME=3000
USE_NEW_PAGE_FOR_REPORT=true
EOT
```
{: .copy-code}

在 Docker 中启动 WebReport 服务
```bash
docker compose -f tb-web-report.yml up -d
```
{: .copy-code}

## 容器故障排查

从容器读取日志

```bash
docker logs -f tb-web-report
```
{: .copy-code} 