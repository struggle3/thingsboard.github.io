* TOC
{:toc}

## 故障排查工具与技巧

### MessagePack 处理日志

若要记录最慢与调用最频繁的规则节点日志，
请在[日志配置](#enable-certain-logs)中加入以下 **logger**：

```bash
<logger name="org.thingsboard.server.service.queue.TbMsgPackProcessingContext" level="DEBUG" />
```

配置后，可在[日志](#logs)中查看如下信息：

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

## 日志

### 查看日志

无论采用何种部署方式，ThingsBoard Edge 日志均存放在以下目录：

```bash
/var/log/tb-edge
```

不同部署工具查看日志的方式不同：

{% capture contenttogglespecdeploymenttype %}
Standalone Deployment%,%standalone%,%templates/edge/troubleshooting/logs/view-logs/standalone-view-logs.md%br%
Docker-Compose Deployment%,%docker-compose%,%templates/edge/troubleshooting/logs/view-logs/docker-compose-view-logs.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="deploymentType" toggle-spec=contenttogglespecdeploymenttype %}


### 启用特定日志 {#enable-certain-logs}

ThingsBoard 支持按需启用或禁用系统特定部分的日志。

可通过修改 `logback.xml` 实现。该文件与日志本身存放在同一目录：

```bash
/usr/share/tb-edge/conf
```

`logback.xml` 配置示例：

```bash
<!DOCTYPE configuration>
<configuration scan="true" scanPeriod="10 seconds">

    <appender name="fileLogAppender"
              class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>/var/log/tb-edge/tb-edge.log</file>
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>/var/log/tb-edge/tb-edge.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
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

The most useful for the troubleshooting parts of the config files are **loggers**.
They allow you to enable/disable logging for a specific class or group of classes.

In the example above, the default logging level is set to **INFO** (meaning that logs will contain only general information, warnings and errors). 
However, for the `org.thingsboard.js.api` package we enabled the most detailed level of logging by setting it to **TRACE**.

It’s also possible to completely disable logging for certain parts of the system. 
In the example above, we did this to the `com.microsoft.azure.servicebus.primitives.CoreMessageReceiver` class by setting the log-level to **OFF**.

To enable/disable logging for a specific part of the system, you need to add the appropriate `</logger>` configuration, and wait up to 10 seconds.

Different deployment tools provide different ways to update logs:

{% capture contenttogglespecdeploymenttype2 %}
Standalone Deployment%,%standalone%,%templates/edge/troubleshooting/logs/enable-logs/standalone-enable-logs.md%br%
Docker-Compose Deployment%,%docker-compose%,%templates/edge/troubleshooting/logs/enable-logs/docker-compose-enable-logs.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="deploymentType2" toggle-spec=contenttogglespecdeploymenttype2 %}

## 指标

可在配置文件中设置以下环境变量以启用 Prometheus 指标：
* 将 `METRICS_ENABLED` 设为 `true`
* 将 `METRICS_ENDPOINTS_EXPOSE` 设为 `prometheus` 

指标路径为：`https://<yourhostname>/actuator/prometheus`，可由 Prometheus 抓取（无需认证）。

## Prometheus 指标

**Spring Boot Actuator** 可通过 **Prometheus** 暴露部分内部状态指标。

**ThingsBoard** 推送至 **Prometheus** 的统计项如下：

### tb-edge 指标：

- **attributes_queue_${index_of_queue}**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示**属性写入**数据库的统计。  
  _注意：为提高性能，使用多个队列（线程）持久化属性。_
- **ruleEngine_${name_of_queue}**（statsNames - **totalMsgs, failedMsgs, successfulMsgs, tmpFailed, failedIterations, successfulIterations, timeoutMsgs, tmpTimeout**）：
  表示规则引擎中的消息处理统计，按队列（如 Main、HighPriority、SequentialByOriginator 等）持久化。
  部分指标说明：
    - **tmpFailed**：失败并稍后重试的消息数。
    - **tmpTimeout**：超时并稍后重试的消息数。
    - **timeoutMsgs**：超时被丢弃的消息数。
    - **failedIterations**：至少有一条消息未成功处理的消息包处理迭代数。
- **ruleEngine_${name_of_queue}_seconds**（针对每个 **tenantId**）：表示各队列处理消息的耗时统计。
- **core**（statsNames - **totalMsgs, toDevRpc, coreNfs, sessionEvents, subInfo, subToAttr, subToRpc, deviceState, getAttr, claimDevice, subMsgs**）：
  表示内部系统消息的处理统计。
  部分指标说明：
    - **toDevRpc**：Transport 服务处理过的 RPC 响应数。
    - **sessionEvents**：Transport 服务的会话事件数。
    - **subInfo**：Transport 服务的订阅信息数。
    - **subToAttr**：Transport 服务对属性更新的订阅数。
    - **subToRpc**：Transport 服务对 RPC 的订阅数。
    - **getAttr**：Transport 服务的「获取属性」请求数。
    - **claimDevice**：Transport 服务的设备认领数。
    - **deviceState**：设备状态变更处理数。
    - **subMsgs**：已处理的订阅消息数。
    - **coreNfs**：已处理的特定「系统」消息数。
- **jsInvoke**（statsNames - **requests, responses, failures**）：表示 JS 执行器总请求数、成功数与失败数。
- **attributes_cache**（results - **hit, miss**）：表示命中缓存与未命中缓存的属性请求数。


### transport 指标：
- **transport**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示 Transport 从 Core 接收的请求数。
- **ruleEngine_producer**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示从 Transport 推送到规则引擎的消息数。
- **core_producer**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示从 Transport 推送到 ThingsBoard 节点设备 actor 的消息数。
- **transport_producer**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示从 Transport 到 Core 的请求数。


### PostgreSQL 相关指标：
- **ts_latest_queue_${index_of_queue}**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示**最新遥测**写入数据库的统计。  
  注意：为提高性能，使用多个队列（线程）。
- **ts_queue_${index_of_queue}**（statsNames - **totalMsgs, failedMsgs, successfulMsgs**）：表示**遥测**写入数据库的统计。  
  注意：为提高性能，使用多个队列（线程）。

## Edge 随机断开与云端连接

若 Edge 实例无明显原因反复断开，数秒内又重连，最可能的原因是 **Edge 与云端之间的网络不稳定**。
可能由带宽不足或网络间歇性丢包导致。

一种做法是使用外部工具**诊断网络**并解决发现的问题。

若无法排查网络，可**增大部分超时**调整 Edge 与云端之间的 gRPC 连接参数。
有助于在临时网络波动时减少意外断开。

**在 ThingsBoard Server（云端）：**

* **EDGES_RPC_CLIENT_MAX_KEEP_ALIVE_TIME_SEC**：客户端 keepalive ping 之间的最小允许间隔。防止客户端发送过于频繁的 ping，避免对服务器造成负担；滥用可能成为拒绝服务攻击向量。若客户端在此间隔内发送更频繁的 ping，服务器可终止连接。**默认 1 秒**。

* **EDGES_RPC_KEEP_ALIVE_TIME_SEC**：连接无活动（无读操作）多长时间后，服务器向客户端发送 keepalive ping。用于确认连接仍存活，并防止中间网络设备因空闲而断开连接。服务器主动检查客户端是否仍响应的方式。**默认 10 秒**。

* **EDGES_RPC_KEEP_ALIVE_TIMEOUT_SEC**：服务器等待 keepalive ping 响应的最长时间。若在此时间内未收到确认，服务器将认为连接已断开并可能关闭。该超时用于检测无响应客户端。<br>**默认 5 秒**。

Read more about **Edge parameters for Cloud** [here](/docs/{{peDocsPrefix}}user-guide/install/config/#edges-parameters){:target="_blank"}

**在 ThingsBoard Edge（gRPC 客户端）：**

* **CLOUD_RPC_KEEP_ALIVE_TIME_SEC**：客户端在空闲（无读操作）多少秒后向服务器发送 keepalive ping。该设置对保持空闲期连接存活、防止服务器因超时关闭连接至关重要。用于定期探测服务器是否仍响应，并通过可能因空闲而断连的网络设备（如 NAT、负载均衡器）维持连接。**默认 10 秒**。

* **CLOUD_RPC_KEEP_ALIVE_TIMEOUT_SEC**：客户端等待 keepalive ping 响应的最长时长。若在此时间内未收到确认，客户端将认为连接已断开或不可达。该超时用于检测服务器或网络故障。若服务器在此时间内无响应，客户端将视为连接丢失，可能会尝试重连或执行其他恢复操作。**默认 5 秒**。

Read more about **Cloud configuration for Edge** [here](/docs/{{docsPrefix}}user-guide/install/config/#cloud-configuration){:target="_blank"}

{% capture infoWired %}
**警告：**{: style="color:red"}  
[gRPC](https://grpc.io/docs/guides/keepalive/){:target="_blank"} advises against enabling keepalive without calls and recommends that clients avoid configuring their keepalive much below **one minute**.

**Scale‑safe starting points:**
* **Do not reduce timeouts on unreliable networks:** If you see ping‑ack timeouts in the logs, increase the `*_KEEP_ALIVE_TIMEOUT_SEC`
* **Keep the client interval ≥ server’s minimum:** Raise this server guardrail if you want to intentionally block overly chatty clients, and then coordinate the necessary client changes.
* **Keep the interval < the shortest NAT/LB idle timeout** on the path so the flow never goes idle (e.g., if the middlebox drops after 60 s, use 25–55 s intervals)
{% endcapture %}
{% include templates/warn-banner.md content=infoWired %}

### 如何应用

{% capture how-to-apply %}
Docker%,%dockerKeepalive%,%templates/edge/troubleshooting/docker-keepalive.md%br%
Ubuntu%,%ubuntuKeepalive%,%templates/edge/troubleshooting/ubuntu-keepalive.md%br%{% endcapture %}
{% include content-toggle.liquid content-toggle-id="how-to-apply" toggle-spec=how-to-apply %}

## 监控消息统计

{% assign sinceVersion = "4.2" %}
{% include templates/edge/since-edge.md %}

为诊断和解决 Cloud 与 Edge 间消息传递问题，可监控 **uplink**（Edge → Cloud）和 **downlink**（Cloud → Edge）消息流。

* [下载](https://github.com/thingsboard/thingsboard-edge/releases/download/v4.2/uplink_downlink_edge_stats.json)预配置的 Edge 仪表板。
* 将仪表板导入**云端**：
  * 进入 **仪表板** 部分。
  * 点击 **"+"** 按钮，选择 **"导入仪表板"**，浏览本地 `.json` 文件并点击 **"导入"** 完成。

{% include images-gallery.html imageCollection="how-to-import-dashboard" %}

### 统计监控的遥测键

ThingsBoard Edge 暴露一组遥测键，用于监控 Edge 与 Cloud 间的消息统计。

#### Uplink
* **uplinkMsgsAdded**：加入队列的消息数。
* **uplinkMsgsPushed**：成功发送到 Cloud 的消息数。
* **uplinkMsgsPermanentlyFailed**：永久失败的消息数。
* **uplinkMsgsTmpFailed**：暂时失败的消息数（如因网络问题）。
* **uplinkMsgsLag**：队列中剩余的消息数（滞后量）。

#### Downlink
* **downlinkMsgsAdded**：加入队列的消息数。
* **downlinkMsgsPushed**：成功发送到 Cloud 的消息数。
* **downlinkMsgsPermanentlyFailed**：永久失败的消息数。
* **downlinkMsgsTmpFailed**：暂时失败的消息数（如因网络问题）。
* **downlinkMsgsLag**：队列中剩余的消息数（滞后量）。


## Getting help

<section id="talkToUs">
    <div id="gettingHelp">
        <a href="https://app.gitter.im/#/room/#thingsboard_chat:gitter.im">
            <span class="phrase-heading">Community chat</span>
            <p>Our Gitter channel is the best way to contact our engineers and share your ideas with them.</p>
        </a>
        <a href="https://stackoverflow.com/questions/tagged/thingsboard">
            <span class="phrase-heading">Stack Overflow</span>
            <p>The ThingsBoard team will also monitor posts tagged thingsboard. If there aren’t any existing questions that help, please ask a new one!</p>
        </a>
    </div>
</section>

If your problem isn't answered by any of the guides above, feel free to contact ThingsBoard team.

<a class="button" href="/docs/contact-us/">Contact us</a>
