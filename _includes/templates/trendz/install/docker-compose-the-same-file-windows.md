打开包含 ThingsBoard 服务的 Docker Compose 文件：

```text
docker-compose.yml
```
{: .copy-code}

确认文件中包含以下内容：

* 以下服务：
    * trendz
    * trendz-python-executor
    * trendz-postgres
* 以下卷：
    * trendz-conf
    * trendz-data
    * trendz-python-executor-conf
    * trendz-python-executor-data
    * trendz-postgres-data

若有缺失，请按 [ThingsBoard Docker 安装说明](/docs/user-guide/install/pe/docker-windows#step-2-choose-thingsboard-queue-service) 更新 Docker Compose 文件。

Docker Compose 文件应与说明中示例一致。
