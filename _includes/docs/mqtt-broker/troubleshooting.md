* TOC
{:toc}

## 排查工具与技巧

### Kafka 队列：Consumer Group 消息滞后

可使用下文所示日志识别消息处理或 TBMQ 基础设施其他部分的问题。
由于 Kafka 用于 MQTT 消息处理及系统其他主要部分（如 `client sessions`、`client subscriptions`、`retained messages` 等），
可据此分析 broker 的整体状态。

TBMQ 支持监控向 Kafka 生产消息的速率是否快于消费与处理的速率。
若存在该情况，消息处理延迟将逐渐增大。
要启用此功能，请确保开启 Kafka consumer-stats（参见[配置属性](/docs/{{docsPrefix}}mqtt-broker/install/config/)中的 **queue.kafka.consumer-stats** 节）。

开启 Kafka consumer-stats 后，将生成 consumer group 的 offset lag 相关日志（参见[故障排查](#logs)）。

以下为日志示例：

```bash
2022-11-27 02:33:23,625 [kafka-consumer-stats-1-thread-1] INFO  o.t.m.b.q.k.s.TbKafkaConsumerStatsService - [msg-all-consumer-group] Topic partitions with lag: [[topic=[tbmq.msg.all], partition=[2], lag=[5]]].
```

由此可知有 5 条消息已推入 `tbmq.msg.all` 主题但尚未处理。

一般而言，日志结构如下：

```bash
TIME [STATS_PRINTING_THREAD_NAME] INFO  o.t.m.b.q.k.s.TbKafkaConsumerStatsService - [CONSUMER_GROUP_NAME] Topic partitions with lag: [[topic=[KAFKA_TOPIC], partition=[KAFKA_TOPIC_PARTITION], lag=[LAG]],[topic=[ANOTHER_TOPIC], partition=[], lag=[]],...].
```

其中：
- `CONSUMER_GROUP_NAME` - 正在处理消息的消费者组名称。
- `KAFKA_TOPIC` - Kafka 主题名称。
- `KAFKA_TOPIC_PARTITION` - 主题分区号。
- `LAG` - 未处理消息数量。

**注意：**仅当该消费者组存在滞后时才打印 consumer lag 相关日志。

### CPU/内存使用

有时问题源于某服务的资源不足。可登录 `server/container/pod` 并执行 `top` 命令查看 CPU 和内存使用情况。

为便于监控，建议配置 Prometheus 和 Grafana。

若发现某服务 CPU 使用率时常达到 100%，可通过在集群中创建新节点进行水平扩展，或通过增加 CPU 总量进行垂直扩展。

## 日志

### 查看日志

无论部署类型如何，TBMQ 日志均存储在以下目录：

```bash
/var/log/thingsboard-mqtt-broker
```

不同部署工具提供不同的日志查看方式：

{% capture contenttogglespecdeploymenttype %}
Docker-Compose Deployment%,%docker-compose%,%templates/mqtt-broker/troubleshooting/logs/view-logs/docker-compose-view-logs.md%br%
Kubernetes Deployment%,%kubernetes%,%templates/mqtt-broker/troubleshooting/logs/view-logs/kubernetes-view-logs.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}

### 启用特定日志

为便于故障排查，TBMQ 允许用户为系统特定部分启用或禁用日志。可通过修改以下目录中的 **logback.xml** 文件实现：

```bash
/usr/share/thingsboard-mqtt-broker/conf
```

注意，**k8s** 和 **Docker** 部署使用不同的配置文件。

以下为 **logback.xml** 配置示例：

```bash
<!DOCTYPE configuration>
<configuration scan="true" scanPeriod="10 seconds">

    <appender name="fileLogAppender"
              class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/var/log/thingsboard-mqtt-broker/${TB_SERVICE_ID}/thingsboard-mqtt-broker.log</file>
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>/var/log/thingsboard-mqtt-broker/${TB_SERVICE_ID}/thingsboard-mqtt-broker.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
            <maxFileSize>100MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>3GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%d{ISO8601} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="org.thingsboard.mqtt.broker.actors.client.service.connect" level="TRACE"/>
    <logger name="org.thingsboard.mqtt.broker.actors.client.service.disconnect.DisconnectServiceImpl" level="INFO"/>
    <logger name="org.thingsboard.mqtt.broker.actors.DefaultTbActorSystem" level="OFF"/>

    <root level="INFO">
        <appender-ref ref="fileLogAppender"/>
    </root>
</configuration>
```

配置文件中的 _loggers_ 对故障排查最为有用，可为特定类或类组启用或禁用日志。上述示例中，默认日志级别为 **INFO**，即日志包含一般信息、警告和错误。对于 `org.thingsboard.mqtt.broker.actors.client.service.connect` 包则启用最详细级别。也可通过 **OFF** 级别完全禁用某部分的日志，如 `org.thingsboard.mqtt.broker.actors.DefaultTbActorSystem`。

要为系统某部分启用或禁用日志，需添加相应的 `</logger>` 配置并等待最多 10 秒。

不同部署工具的日志更新方式不同：

{% capture contenttogglespecdeploymenttype2 %}
Docker-Compose Deployment%,%docker-compose%,%templates/mqtt-broker/troubleshooting/logs/enable-logs/docker-compose-enable-logs.md%br%
Kubernetes Deployment%,%kubernetes%,%templates/mqtt-broker/troubleshooting/logs/enable-logs/kubernetes-enable-logs.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype2 %}

## 指标

在 TBMQ 中启用 Prometheus 指标需： 
- 将 `STATS_ENABLED` 环境变量设为 `true`。
- 在配置文件中将 `METRICS_ENDPOINTS_EXPOSE` 环境变量设为 `prometheus`。

此后可通过 `https://<yourhostname>/actuator/prometheus` 访问指标，并由 Prometheus 抓取（无需认证）。

## Prometheus 指标

TBMQ 中的 Spring Actuator 可通过 Prometheus 暴露部分内部状态指标。

以下是 TBMQ 推送到 Prometheus 的指标列表：

### TBMQ 专用指标：

- <i>incomingPublishMsg_published</i> (statsNames - <i>totalMsgs, successfulMsgs, failedMsgs</i>): stats about incoming Publish messages to be persisted in the general queue.
- <i>incomingPublishMsg_consumed</i> (statsNames - <i>totalMsgs, successfulMsgs, timeoutMsgs, failedMsgs, tmpTimeout,
  tmpFailed, successfulIterations, failedIterations</i>): stats about incoming Publish messages processing from general queue.
- <i>deviceProcessor</i> (statsNames - <i>successfulMsgs, failedMsgs, tmpFailed, successfulIterations, failedIterations</i>):
  stats about DEVICE client messages processing.
  Some stats descriptions:
  - <i>failedMsgs</i>: number of failed messages to be persisted in database and were discarded afterwards
  - <i>tmpFailed</i>: number of failed messages to be persisted in database and got reprocessed later
- <i>appProcessor</i> (statsNames - <i>successfulPublishMsgs, successfulPubRelMsgs, tmpTimeoutPublish, tmpTimeoutPubRel, timeoutPublishMsgs,
  timeoutPubRelMsgs, successfulIterations, failedIterations</i>): stats about APPLICATION client messages processing.
  Some stats descriptions:
  - <i>tmpTimeoutPubRel</i>: number of PubRel messages that timed out and got reprocessed later
  - <i>tmpTimeoutPublish</i>: number of Publish messages that timed out and got reprocessed later
  - <i>timeoutPubRelMsgs</i>: number of PubRel messages that timed out and were discarded afterwards
  - <i>timeoutPublishMsgs</i>: number of Publish messages that timed out and were discarded afterwards
  - <i>failedIterations</i>: iterations of processing messages pack where at least one message wasn't processed successfully
- <i>appProcessor_latency</i> (statsNames - <i>puback, pubrec, pubcomp</i>): stats about APPLICATION processor latency of different message types.
- <i>actors_processing</i> (statsNames - <i>MQTT_CONNECT_MSG, MQTT_PUBLISH_MSG, MQTT_PUBACK_MSG, etc.</i>): 
  stats about actors processing average time of different message types.
- <i>clientSubscriptionsConsumer</i> (statsNames - <i>totalSubscriptions, acceptedSubscriptions, ignoredSubscriptions</i>):
  stats about the client subscriptions read from Kafka by the broker node.
  Some stats descriptions:
  - <i>totalSubscriptions</i>: total number of new subscriptions added to the broker cluster
  - <i>acceptedSubscriptions</i>: number of new subscriptions persisted by the broker node
  - <i>ignoredSubscriptions</i>: number of ignored subscriptions since they were already initially processed by the broker node
- <i>retainedMsgConsumer</i> (statsNames - <i>totalRetainedMsgs, newRetainedMsgs, clearedRetainedMsgs</i>): stats about retain messages processing.
- <i>subscriptionLookup</i>: stats about average time of client subscriptions lookup in trie data structure.
- <i>retainedMsgLookup</i>: stats about average time of retain messages lookup in trie data structure.
- <i>clientSessionsLookup</i>: stats about average time of client sessions lookup from found client subscriptions for publish message.
- <i>notPersistentMessagesProcessing</i>: stats about average time for processing message delivery for not persistent clients.
- <i>persistentMessagesProcessing</i>: stats about average time for processing message delivery for persistent clients.
- <i>delivery</i>: stats about average time for message delivery to clients.
- <i>subscriptionTopicTrieSize</i>: stats about client subscriptions count in trie data structure.
- <i>subscriptionTrieNodes</i>: stats about client subscriptions nodes count in trie data structure.
- <i>retainMsgTrieSize</i>: stats about retain message count in trie data structure.
- <i>retainMsgTrieNodes</i>: stats about retain message nodes count in trie data structure.
- <i>lastWillClients</i>: stats about last will clients count.
- <i>connectedSessions</i>: stats about connected sessions count.
- <i>connectedSslSessions</i>: stats about connected via TLS sessions count.
- <i>allClientSessions</i>: stats about all client sessions count.
- <i>clientSubscriptions</i>: stats about client subscriptions count in the in-memory map.
- <i>retainedMessages</i>: stats about retain messages count in the in-memory map.
- <i>activeAppProcessors</i>: stats about active APPLICATION processors count.
- <i>activeSharedAppProcessors</i>: stats about active APPLICATION processors count for shared subscriptions.
- <i>runningActors</i>: stats about running actors count.

### PostgreSQL 专用指标：
- <i>sqlQueue_InsertUnauthorizedClientQueue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about updating **unauthorized clients** to the database.
- <i>sqlQueue_DeleteUnauthorizedClientQueue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about removing **unauthorized clients** to the database.
- <i>sqlQueue_LatestTimeseriesQueue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about **latest historical stats persistence** to the database.
- <i>sqlQueue_TimeseriesQueue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about **historical stats persistence** to the database.

注意，为达到最佳性能，**TBMQ 对上述每个队列使用多个队列（线程）**。

## 获取帮助

<section id="talkToUs">
    <div class="doc-features row mt-4">
        <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
            <a class="feature-card" href="https://join.slack.com/t/tbmq/shared_invite/zt-31kk3315e-5jtPw8YAKskq1KkUqTrTyQ">
                <img class="feature-logo" style="filter: unset" src="/images/mqtt-broker/slack-logo.svg" alt="Slack logo">
                <div class="feature-title">Slack 社区</div>
                <div class="feature-text">
                    向其他用户和贡献者提问，获取快速解答。
                </div>
            </a>
        </div>
        <div class="col-12 col-sm-6 col-lg col-xxl-6 col-4xl mb-4">
            <a class="feature-card" href="https://github.com/thingsboard/tbmq/issues?q=is%3Aissue">
                <img class="feature-logo" style="filter: unset" src="/images/mqtt-broker/github-logo.svg" alt="Github logo">
                <div class="feature-title">Github Issues</div>
                <div class="feature-text">
                    发现 bug 或有疑问？在我们的 GitHub 仓库中提交 issue。
                </div>
            </a>
        </div>
    </div>
</section>

若上述指南均无法解决您的问题，请联系 ThingsBoard 团队获取进一步帮助。

<a class="button" href="/docs/contact-us/?subject=TBMQ">联系我们</a>
