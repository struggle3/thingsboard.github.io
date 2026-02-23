```yml
services:
  trendz:
    profiles: ['trendz']
    restart: always
    image: "thingsboard/trendz:{{ site.release.trendz_ver }}"
    ports:
      - "8888:8888"
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://trendz-postgres:5432/trendz
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: postgres
      SCRIPT_ENGINE_DOCKER_PROVIDER_URL: trendz-python-executor:8181
      SCRIPT_ENGINE_TIMEOUT: 30000
    volumes:
      - trendz-conf:/trendz-config-files
      - trendz-data:/data
    depends_on:
      - trendz-postgres
  trendz-python-executor:
    profiles: ['trendz']
    restart: always
    image: "thingsboard/trendz-python-executor:{{ site.release.trendz_ver }}"
    ports:
      - "8181:8181"
    environment:
      EXECUTOR_MANAGER: 1
      EXECUTOR_SCRIPT_ENGINE: 6
      THROTTLING_QUEUE_CAPACITY: 10
      THROTTLING_THREAD_POOL_SIZE: 6
      NETWORK_BUFFER_SIZE: 5242880
    volumes:
      - trendz-python-executor-conf:/python-executor-config-files
      - trendz-python-executor-data:/data
  trendz-postgres:
    profiles: ['trendz']
    restart: always
    image: "postgres:16"
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: trendz
      POSTGRES_PASSWORD: postgres
    volumes:
      - trendz-postgres-data:/var/lib/postgresql/data
volumes:
  trendz-conf:
    name: trendz-conf
    driver: local
  trendz-data:
    name: trendz-data
    driver: local
  trendz-python-executor-conf:
    name: trendz-python-executor-conf
    driver: local
  trendz-python-executor-data:
    name: trendz-python-executor-data
    driver: local
  trendz-postgres-data:
    name: trendz-postgres-data
    driver: local
```
{: .copy-code}

说明：

- `8888:8888`：将本地端口 8888 映射到内部 HTTP 端口 8888
- `trendz-conf:/trendz-config-files`：将 `trendz-conf` 卷挂载到 Trendz 配置目录
- `trendz-data:/data`：将 `trendz-data` 卷挂载到 Trendz 数据目录
- `trendz-postgres-data:/var/lib/postgresql/data`：将 `trendz-postgres-data` 卷挂载到 Postgres 数据目录
- `trendz`：Trendz Docker 服务名称
- `--restart always`：系统重启或故障后自动启动 Trendz
- `thingsboard/trendz:{{ site.release.trendz_ver }}`：Trendz Docker 镜像
- `thingsboard/trendz-python-executor:{{ site.release.trendz_ver }}`：Trendz Python 脚本执行器 Docker 镜像
- `SCRIPT_ENGINE_TIMEOUT`：Python 脚本执行超时时间
