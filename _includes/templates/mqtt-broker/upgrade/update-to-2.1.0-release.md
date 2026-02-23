TBMQ v2.1.0 引入多项改进，包括新的 Integration Executor 微服务及第三方服务版本升级。

#### 添加 Integration Executor 微服务

本版本通过新的 [Integration Executor](/docs/{{docsPrefix}}mqtt-broker/integrations/) 微服务支持外部集成。

<br>
<details markdown="1">
<summary>
在现有的 docker-compose.yml 中添加服务定义和 volume
</summary>

```yaml
  tbmq-integration-executor:
    restart: always
    image: "thingsboard/tbmq-integration-executor:2.1.0"
    depends_on:
      - kafka
      - tbmq
    logging:
      driver: "json-file"
      options:
        max-size: "200m"
        max-file: "5"
    environment:
      TB_SERVICE_ID: tbmq-ie
      TB_KAFKA_SERVERS: kafka:9092
      #JAVA_OPTS: "-Xmx2048M -Xms2048M -Xss384k -XX:+AlwaysPreTouch"
    volumes:
      - tbmq-ie-logs:/var/log/tbmq-integration-executor

volumes:
  tbmq-ie-logs:
    external: true
```
{: .copy-code}
</details>
<br>

完整更新的 `docker-compose.yml` 请参阅 [官方示例](https://github.com/thingsboard/tbmq/blob/release-2.1.0/msa/tbmq/configs/docker-compose.yml)。

运行以下命令创建 Integration Executor 日志的 Docker volume：

```bash
docker volume create tbmq-ie-logs
```
{: .copy-code}

更新配置后，使用以下命令启动服务：

```bash
docker compose up -d tbmq-integration-executor --no-deps
```
{: .copy-code}

#### 更新第三方服务

{% include templates/mqtt-broker/upgrade/upgrade-third-parties-for-2.1.0-release.md %}
