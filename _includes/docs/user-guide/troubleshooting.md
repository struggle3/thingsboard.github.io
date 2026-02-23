* TOC
{:toc}

## 常见性能问题

本节描述可能出现的各类问题场景。

{% capture contenttogglespecscenario %}
无消息处理%,%no-message-processing%,%templates/troubleshooting/scenarios/no-message-processing.md%br%
消息延迟增长%,%growing-latency%,%templates/troubleshooting/scenarios/growing-latency.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="scenario" toggle-spec=contenttogglespecscenario %}

## 故障排查工具与建议

### Rule Engine Statistics Dashboard
可查看 rule chain 处理过程中是否存在 Failures、Timeouts 或 Exceptions。更多详情见[此处](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-engine-statistics)。

### Kafka Queue Consumer group 消息 lag

**说明：** 仅在选择 Kafka 作为 queue 时适用。

通过该 log 可判断消息处理是否存在问题（Queue 用于系统内所有消息传递，可分析 rule-engine queues 及 <b>transport</b>、<b>core</b> 等）。
使用 consumer-group lag 排查 rule-engine 处理的更多说明见[此处](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#troubleshooting)。

### CPU/Memory 使用

有时问题源于某服务资源不足。可登录 server/container/pod 并执行 <code>top</code> 命令查看 CPU 和 Memory 使用情况。

建议配置 Prometheus 和 Grafana 便于监控。

若某服务偶尔占用 100% CPU，可横向扩展（在 cluster 中新增节点）或纵向扩展（增加 CPU 总量）。

### Message Pack 处理 Log

可启用对最慢且调用最频繁的 rule node 的日志记录。
需在[日志配置](#enable-certain-logs)中添加以下 <i>logger</i>：

```bash
<logger name="org.thingsboard.server.service.queue.TbMsgPackProcessingContext" level="DEBUG" />
```

配置后可在 [logs](#logs) 中看到如下消息：

```bash
2021-03-24 17:01:21,023 [tb-rule-engine-consumer-24-thread-3] DEBUG o.t.s.s.q.TbMsgPackProcessingContext - Top Rule Nodes by max execution time:
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] DEBUG o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f740670-8cc0-11eb-bcd9-d343878c0c7f] max execution time: 1102. [RuleChain: Thermostat|RuleNode: Device Profile Node(3f740670-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] DEBUG o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f6debf0-8cc0-11eb-bcd9-d343878c0c7f] max execution time: 1. [RuleChain: Thermostat|RuleNode: Message Type Switch(3f6debf0-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - Top Rule Nodes by avg execution time:
2021-03-24 17:01:21,024 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f740670-8cc0-11eb-bcd9-d343878c0c7f] avg execution time: 604.0. [RuleChain: Thermostat|RuleNode: Device Profile Node(3f740670-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,025 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f6debf0-8cc0-11eb-bcd9-d343878c0c7f] avg execution time: 1.0. [RuleChain: Thermostat|RuleNode: Message Type Switch(3f6debf0-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,025 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - Top Rule Nodes by execution count:
2021-03-24 17:01:21,025 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f740670-8cc0-11eb-bcd9-d343878c0c7f] execution count: 2. [RuleChain: Thermostat|RuleNode: Device Profile Node(3f740670-8cc0-11eb-bcd9-d343878c0c7f)]
2021-03-24 17:01:21,028 [tb-rule-engine-consumer-24-thread-3] INFO  o.t.s.s.q.TbMsgPackProcessingContext - [Main][3f6debf0-8cc0-11eb-bcd9-d343878c0c7f] execution count: 1. [RuleChain: Thermostat|RuleNode: Message Type Switch(3f6debf0-8cc0-11eb-bcd9-d343878c0c7f)]
```

### 清理 Redis/Valkey 缓存

**说明：** 仅在选择 Redis 或 Valkey 作为 cache 时适用。

缓存内数据可能损坏。无论原因如何，清空缓存都是安全的 —— ThingsBoard 会在运行时重新填充。清空缓存需登录部署的 server/container/pod，打开应用命令行工具（Redis 用 <code>redis-cli</code>，Valkey 用 <code>valkey-cli</code>），执行 <code>FLUSHALL</code>。Sentinel 模式下，需访问 master container 执行清空命令。

若难以定位问题原因，可尝试清空缓存以排除缓存导致的问题。


## Logs

### 读取 logs

无论部署方式如何，ThingsBoard logs 均存储在 ThingsBoard Server/Node 所在 server/container 的以下目录：

```bash
/var/log/thingsboard
```

不同部署方式查看 logs 的方法不同：

{% capture contenttogglespecdeploymenttype %}
Standalone 部署%,%standalone%,%templates/troubleshooting/logs/view-logs/standalone-view-logs.md%br%
Docker-Compose 部署%,%docker-compose%,%templates/troubleshooting/logs/view-logs/docker-compose-view-logs.md%br%
Kubernetes 部署%,%kubernetes%,%templates/troubleshooting/logs/view-logs/kubernetes-view-logs.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}


### 启用特定 logs

ThingsBoard 可根据故障排查需求对系统各部分启用或禁用日志。

通过修改 <b>logback.xml</b> 文件实现。该文件与 logs 同处 ThingsBoard Server/Node 所在 server/container 的以下目录：

```bash
/usr/share/thingsboard/conf
```

以下是 <b>logback.xml</b> 配置示例：

```bash
<!DOCTYPE configuration>
<configuration scan="true" scanPeriod="10 seconds">

    <appender name="fileLogAppender"
              class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/var/log/thingsboard/thingsboard.log</file>
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>/var/log/thingsboard/thingsboard.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
            <maxFileSize>100MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>3GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>%d{ISO8601} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="org.thingsboard.server" level="INFO" />
    <logger name="org.thingsboard.js.api" level="TRACE" />
    <logger name="com.microsoft.azure.servicebus.primitives.CoreMessageReceiver" level="OFF" />

    <root level="INFO">
        <appender-ref ref="fileLogAppender"/>
    </root>
</configuration>
```

配置文件中与故障排查最相关的是 <i>loggers</i>。
可为特定类或类组启用/禁用日志。
上例中默认日志级别为 <b>INFO</b>（仅包含一般信息、警告和错误），对包 <code>org.thingsboard.js.api</code> 启用了最详细级别。
也可完全关闭某部分的日志，上例中通过 <b>OFF</b> 级别对 <code>com.microsoft.azure.servicebus.primitives.CoreMessageReceiver</code> 类进行了禁用。

为系统某部分启用/禁用日志需添加相应 <code></logger></code> 配置并等待最多 10 秒。

不同部署方式更新 logs 的方法不同：

{% capture contenttogglespecdeploymenttype2 %}
Standalone 部署%,%standalone%,%templates/troubleshooting/logs/enable-logs/standalone-enable-logs.md%br%
Docker-Compose 部署%,%docker-compose%,%templates/troubleshooting/logs/enable-logs/docker-compose-enable-logs.md%br%
Kubernetes 部署%,%kubernetes%,%templates/troubleshooting/logs/enable-logs/kubernetes-enable-logs.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype2 %}


## Metrics

在配置文件中将环境变量 `METRICS_ENABLED` 设为 `true`、`METRICS_ENDPOINTS_EXPOSE` 设为 `prometheus` 可启用 Prometheus metrics。
若以 microservices 方式运行 ThingsBoard 且 MQTT 与 COAP transport 为独立服务，还须将 `WEB_APPLICATION_ENABLE` 设为 `true`、
`WEB_APPLICATION_TYPE` 设为 `servlet`、`HTTP_BIND_PORT` 设为 `8081`，以启用带 Prometheus metrics 的 web-server。

Metrics 暴露在 `https://<yourhostname>/actuator/prometheus`，可由 Prometheus 抓取（无需认证）。

## Prometheus metrics

Spring Actuator 可通过 Prometheus 暴露部分内部状态 metrics。

以下是 ThingsBoard 推送到 Prometheus 的 metrics 列表。

### <b>tb-node</b> metrics
- <i>attributes_queue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about writing <b>attributes</b> to the database. 
Note that there are several queues (threads) for persisting attributes in order to reach maximum performance.
- <i>ruleEngine_${name_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs, tmpFailed, failedIterations, successfulIterations, timeoutMsgs, tmpTimeout</i>): 
  stats about processing of the messages inside of the Rule Engine. They are persisted for each queue (e.g. Main, HighPriority, SequentialByOriginator etc).
  Some stats descriptions:
  - <i>tmpFailed</i>: number of messages that failed and got reprocessed later
  - <i>tmpTimeout</i>: number of messages that timed out and got reprocessed later
  - <i>timeoutMsgs</i>: number of messages that timed out and were discarded afterwards
  - <i>failedIterations</i>: iterations of processing messages pack where at least one message wasn't processed successfully
- <i>ruleEngine_${name_of_queue}_seconds</i> (for each present <i>tenantId</i>): stats about the time message processing took for different queues.
- <i>core</i> (statsNames - <i>totalMsgs, toDevRpc, coreNfs, sessionEvents, subInfo, subToAttr, subToRpc, deviceState, getAttr, claimDevice, subMsgs</i>): 
  stats about processing of the internal system messages.
  Some stats descriptions:
  - <i>toDevRpc</i>: number of processed RPC responses from Transport services
  - <i>sessionEvents</i>: number of session events from Transport services
  - <i>subInfo</i>: number of subscription infos from Transport services
  - <i>subToAttr</i>: number of subscribes to attribute updates from Transport services
  - <i>subToRpc</i>: number of subscribes to RPC from Transport services
  - <i>getAttr</i>: number of 'get attributes' requests from Transport services
  - <i>claimDevice</i>: number of Device claims from Transport services
  - <i>deviceState</i>: number of processed changes to Device State
  - <i>subMsgs</i>: number of processed subscriptions
  - <i>coreNfs</i>: number of processed specific 'system' messages
- <i>jsInvoke</i> (statsNames - <i>requests, responses, failures</i>): stats about total, successful and failed requests to the JS executors
- <i>attributes_cache</i> (results - <i>hit, miss</i>): stats about how much attribute requests went to the cache


### <b>transport</b> metrics
- <i>transport</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about requests received by Transport from TB nodes 
- <i>ruleEngine_producer</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about pushing messages from Transport to the Rule Engine.
- <i>core_producer</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about pushing messages from Transport to the TB node Device actor.
- <i>transport_producer</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about requests from Transport to the TB.


<b>Some metrics depends on the type of the database you are using to persist timeseries data.</b>

### PostgreSQL-specific metrics
- <i>ts_latest_queue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about writing <b>latest telemetry</b> to the database. 
Note that there are several queues (threads) in order to reach maximum performance.
- <i>ts_queue_${index_of_queue}</i> (statsNames - <i>totalMsgs, failedMsgs, successfulMsgs</i>): stats about writing <b>telemetry</b> to the database. 
Note that there are several queues (threads) in order to reach maximum performance.

### Cassandra-specific metrics
- <i>rateExecutor_currBuffer</i>: number of messages that are currently being persisted inside the Cassandra.
- <i>rateExecutor_tenant</i> (for each present <i>tenantId</i>): number of requests that got rate-limited
- <i>rateExecutor</i> (statsNames - <i>totalAdded, totalRejected, totalLaunched, totalReleased, totalFailed, totalExpired, totalRateLimited</i>)
Stats descriptions:
    - <i>totalAdded</i>: number messages that were submitted for persisting
    - <i>totalRejected</i>: number messages that were rejected while trying to submit for persisting
    - <i>totalLaunched</i>: number messages sent to the Cassandra
    - <i>totalReleased</i>: number successfully persisted messages
    - <i>totalFailed</i>: number of messages that were not persisted
    - <i>totalExpired</i>: number of expired messages that were not sent to the Cassandra
    - <i>totalRateLimited</i>: number of messages that were not processed because of the Tenant's rate-limits
    
## Grafana Dashboards

{% if docsPrefix == "pe/" %}
可从[此处](https://github.com/thingsboard/thingsboard-pe-docker-compose/tree/master/basic/monitoring/grafana/provisioning/dashboards){: target="_blank"}导入预配置的 Grafana dashboards。
{% else %}
可从[此处](https://github.com/thingsboard/thingsboard/tree/master/docker/monitoring/grafana/provisioning/dashboards){: target="_blank"}导入预配置的 Grafana dashboards。
{% endif %}

> **注意：** 根据集群配置，可能需对 dashboards 进行调整。

部署 ThingsBoard docker-compose 集群配置后也可查看 Grafana dashboards（更多信息请参考[本指南](/docs/user-guide/install/{{docsPrefix}}cluster/docker-compose-setup/){: target="_blank"}）。
确保将 `MONITORING_ENABLED` 环境变量设为 `true`。部署完成后，可访问 [http://localhost:9090](http://localhost:9090){: target="_blank"} 的 Prometheus 和 [http://localhost:3000](http://localhost:3000){: target="_blank"} 的 Grafana（默认用户名为 `admin`，密码为 `foobar`）。

以下是默认预配置 Grafana dashboards 的截图：

{% include images-gallery.html imageCollection="metrics-dashboards" %}

## OAuth2

Sometimes after configuring OAuth you can not see the button for logging in with OAuth provider. This happens when “Domain name” and “Redirect URI Template” contain faulty values, they need to be the same you use for accessing your ThingsBoard web page.

Example:

| Base URL |  Domain name     |  Redirect URI Template                    |
|-----------------|----------------- |----------------------------------         |
|http://mycompany.com:8080    |mycompany.com:8080     | http://mycompany.com:8080/login/oauth2/code  |
|https://mycompany.com          |mycompany.com          | https://mycompany.com/login/oauth2/code       |

Base URL in "HOME" section should not contain "/" or other characters.

> Go to your ThingsBoard as a System Administrator. Check the General
> Settings -> Base URL should not contain “/” at the end (e.g. “https://
> mycompany.com ” instead of “https://mycompany.com/”).

OAuth2 配置请点击[此处](/docs/{{docsPrefix}}user-guide/oauth-2-support/)。

## Getting help

<section id="talkToUs">
    <div id="gettingHelp">
        <a href="https://github.com/thingsboard/thingsboard">
            <span class="phrase-heading">Github Project</span>
            <p>查看项目并考虑贡献。</p>
        </a>
        <a href="https://stackoverflow.com/questions/tagged/thingsboard">
            <span class="phrase-heading">Stack Overflow</span>
            <p>The ThingsBoard team will also monitor posts tagged thingsboard. If there aren’t any existing questions that help, please ask a new one!</p>
        </a>
    </div>
</section>

若以上指南均未解答您的问题，欢迎联系 ThingsBoard 团队。

<a class="button" href="/docs/contact-us/">Contact us</a>
