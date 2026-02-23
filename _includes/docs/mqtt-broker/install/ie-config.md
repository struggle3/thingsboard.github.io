

## HTTP 服务器参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>server.address</td>
			<td>HTTP_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td>HTTP 服务器绑定地址</td>
		</tr>
		<tr>
			<td>server.port</td>
			<td>HTTP_BIND_PORT</td>
			<td>8082</td>
			<td>HTTP 服务器绑定端口</td>
		</tr>
	</tbody>
</table>


## Kafka 参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>queue.integration-downlink.poll-interval</td>
			<td>TB_IE_DOWNLINK_POLL_INTERVAL</td>
			<td>1000</td>
			<td>从 'tbmq.ie.downlink' 主题轮询消息的间隔（毫秒）</td>
		</tr>
		<tr>
			<td>queue.integration-msg.poll-interval</td>
			<td>TB_IE_MSG_POLL_INTERVAL</td>
			<td>1000</td>
			<td>从 'tbmq.msg.ie' 主题轮询消息的间隔（毫秒）</td>
		</tr>
		<tr>
			<td>queue.integration-msg.pack-processing-timeout</td>
			<td>TB_IE_MSG_PACK_PROCESSING_TIMEOUT</td>
			<td>30000</td>
			<td>处理消息包的超时时间（毫秒）</td>
		</tr>
		<tr>
			<td>queue.integration-msg.ack-strategy.type</td>
			<td>TB_IE_MSG_ACK_STRATEGY_TYPE</td>
			<td>SKIP_ALL</td>
			<td>'tbmq.msg.ie' 主题的处理策略。可选：SKIP_ALL、RETRY_ALL</td>
		</tr>
		<tr>
			<td>queue.integration-msg.ack-strategy.retries</td>
			<td>TB_IE_MSG_ACK_STRATEGY_RETRIES</td>
			<td>5</td>
			<td>重试次数，0 表示不限。用于 RETRY_ALL 处理策略</td>
		</tr>
		<tr>
			<td>queue.integration-msg.ack-strategy.pause-between-retries</td>
			<td>TB_IE_MSG_ACK_STRATEGY_PAUSE_BETWEEN_RETRIES</td>
			<td>1</td>
			<td>消费者线程中重试前的等待时间（秒）</td>
		</tr>
		<tr>
			<td>queue.kafka.bootstrap.servers</td>
			<td>TB_KAFKA_SERVERS</td>
			<td>localhost:9092</td>
			<td>用于建立连接的 Kafka bootstrap 服务器列表</td>
		</tr>
		<tr>
			<td>queue.kafka.enable-topic-deletion</td>
			<td>TB_KAFKA_ENABLE_TOPIC_DELETION</td>
			<td>true</td>
			<td>控制 TBMQ 是否允许删除为 Integration 创建的 Kafka 主题。
设为 'true' 时，TBMQ 在清理过程中可能会自动删除主题（例如 Integration 被删除时）。
设为 'false' 时，TBMQ 将跳过主题删除并仅停止使用。
有助于防止生产环境中意外丢失数据</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.partition-assignment-strategy</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_PARTITION_ASSIGNMENT_STRATEGY</td>
			<td>org.apache.kafka.clients.consumer.StickyAssignor</td>
			<td>按优先级排序的分区分配策略类名或类型列表，在使用组管理时，客户端将用其在不同消费者实例间分配分区所有权</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.session-timeout-ms</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_SESSION_TIMEOUT_MS</td>
			<td>10000</td>
			<td>使用 Kafka 组管理功能时，用于检测客户端故障的超时时间（毫秒）</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.max-poll-interval-ms</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_MAX_POLL_INTERVAL_MS</td>
			<td>300000</td>
			<td>使用消费者组管理时，两次 poll() 调用之间的最大延迟（毫秒）</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.max-poll-records</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_MAX_POLL_RECORDS</td>
			<td>2000</td>
			<td>单次 poll() 调用返回的最大记录数</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.max-partition-fetch-bytes</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_MAX_PARTITION_FETCH_BYTES</td>
			<td>16777216</td>
			<td>服务器每个分区将返回的最大数据量（字节）</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.fetch-max-bytes</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_FETCH_MAX_BYTES</td>
			<td>134217728</td>
			<td>服务器对 fetch 请求应返回的最大数据量（字节）</td>
		</tr>
		<tr>
			<td>queue.kafka.default.consumer.heartbeat-interval-ms</td>
			<td>TB_KAFKA_DEFAULT_CONSUMER_HEARTBEAT_INTERVAL_MS</td>
			<td>3000</td>
			<td>使用 Kafka 组管理功能时，向消费者协调器发送心跳的期望间隔。心跳用于确保消费者会话保持活跃，并便于新消费者加入或离开时进行再平衡。该值必须小于 TB_KAFKA_DEFAULT_CONSUMER_SESSION_TIMEOUT_MS，通常不应超过其 1/3。可进一步调低以控制正常再平衡的期望时间。单位毫秒，默认 3 秒</td>
		</tr>
		<tr>
			<td>queue.kafka.default.producer.acks</td>
			<td>TB_KAFKA_DEFAULT_PRODUCER_ACKS</td>
			<td>1</td>
			<td>生产者在认为请求完成前，要求 leader 收到的确认数量</td>
		</tr>
		<tr>
			<td>queue.kafka.default.producer.retries</td>
			<td>TB_KAFKA_DEFAULT_PRODUCER_RETRIES</td>
			<td>1</td>
			<td>设为大于 0 时，发送失败且可能是临时错误的记录将被客户端重新发送</td>
		</tr>
		<tr>
			<td>queue.kafka.default.producer.batch-size</td>
			<td>TB_KAFKA_DEFAULT_PRODUCER_BATCH_SIZE</td>
			<td>16384</td>
			<td>生产者会尝试将发送到同一分区的多条记录合并为更少的请求。单位字节</td>
		</tr>
		<tr>
			<td>queue.kafka.default.producer.linger-ms</td>
			<td>TB_KAFKA_DEFAULT_PRODUCER_LINGER_MS</td>
			<td>5</td>
			<td>生产者将请求传输之间到达的记录合并为单批请求，单位毫秒</td>
		</tr>
		<tr>
			<td>queue.kafka.default.producer.buffer-memory</td>
			<td>TB_KAFKA_DEFAULT_PRODUCER_BUFFER_MEMORY</td>
			<td>33554432</td>
			<td>生产者用于缓冲待发送到服务器记录的总内存（字节）</td>
		</tr>
		<tr>
			<td>queue.kafka.default.producer.compression-type</td>
			<td>TB_KAFKA_DEFAULT_COMPRESSION_TYPE</td>
			<td>none</td>
			<td>生产者生成数据的压缩类型。有效值：`none`、`gzip`、`snappy`、`lz4` 或 `zstd`</td>
		</tr>
		<tr>
			<td>queue.kafka.admin.config</td>
			<td>TB_KAFKA_ADMIN_CONFIG</td>
			<td>retries:1</td>
			<td>用于创建 admin Kafka 客户端的配置列表，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.admin.command-timeout</td>
			<td>TB_KAFKA_ADMIN_COMMAND_TIMEOUT_SEC</td>
			<td>30</td>
			<td>Kafka Admin 客户端命令超时（秒）。适用于 describeCluster、listTopics 等操作</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.enabled</td>
			<td>TB_KAFKA_CONSUMER_STATS_ENABLED</td>
			<td>true</td>
			<td>启用时，打印 Kafka 主题中消费者组偏移与最后消息偏移之间的 lag</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.print-interval-ms</td>
			<td>TB_KAFKA_CONSUMER_STATS_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td>Kafka 消费者组统计信息的打印间隔（毫秒）</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.kafka-response-timeout-ms</td>
			<td>TB_KAFKA_CONSUMER_STATS_RESPONSE_TIMEOUT_MS</td>
			<td>1000</td>
			<td>等待 Kafka 统计加载请求完成的超时时间（毫秒）</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.consumer-config</td>
			<td>TB_KAFKA_CONSUMER_STATS_CONSUMER_CONFIG</td>
			<td></td>
			<td>用于 Kafka 统计消费者的配置列表，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.topic-prefix</td>
			<td>TB_KAFKA_IE_DOWNLINK_TOPIC_PREFIX</td>
			<td>tbmq.ie.downlink</td>
			<td>从 TBMQ 向 Integration Executor 发送 integration 配置和验证请求的主题前缀</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.http.topic-properties</td>
			<td>TB_KAFKA_IE_DOWNLINK_HTTP_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:6;replication.factor:1</td>
			<td>`tbmq.ie.downlink.http` 主题的 Kafka 主题属性，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.http.additional-consumer-config</td>
			<td>TB_KAFKA_IE_DOWNLINK_HTTP_ADDITIONAL_CONSUMER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.downlink.http` 主题的额外 Kafka 消费者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.http.additional-producer-config</td>
			<td>TB_KAFKA_IE_DOWNLINK_HTTP_ADDITIONAL_PRODUCER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.downlink.http` 主题的额外 Kafka 生产者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.kafka.topic-properties</td>
			<td>TB_KAFKA_IE_DOWNLINK_KAFKA_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:6;replication.factor:1</td>
			<td>`tbmq.ie.downlink.kafka` 主题的 Kafka 主题属性，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.kafka.additional-consumer-config</td>
			<td>TB_KAFKA_IE_DOWNLINK_KAFKA_ADDITIONAL_CONSUMER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.downlink.kafka` 主题的额外 Kafka 消费者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.kafka.additional-producer-config</td>
			<td>TB_KAFKA_IE_DOWNLINK_KAFKA_ADDITIONAL_PRODUCER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.downlink.kafka` 主题的额外 Kafka 生产者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.mqtt.topic-properties</td>
			<td>TB_KAFKA_IE_DOWNLINK_MQTT_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:6;replication.factor:1</td>
			<td>`tbmq.ie.downlink.mqtt` 主题的 Kafka 主题属性，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.mqtt.additional-consumer-config</td>
			<td>TB_KAFKA_IE_DOWNLINK_MQTT_ADDITIONAL_CONSUMER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.downlink.mqtt` 主题的额外 Kafka 消费者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-downlink.mqtt.additional-producer-config</td>
			<td>TB_KAFKA_IE_DOWNLINK_MQTT_ADDITIONAL_PRODUCER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.downlink.mqtt` 主题的额外 Kafka 生产者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink.topic</td>
			<td>TB_KAFKA_IE_UPLINK_TOPIC</td>
			<td>tbmq.ie.uplink</td>
			<td>从 Integration Executor 向 TBMQ 发送消息/事件的主题</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink.topic-properties</td>
			<td>TB_KAFKA_IE_UPLINK_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:6;replication.factor:1</td>
			<td>`tbmq.ie.uplink` 主题的 Kafka 主题属性，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink.additional-consumer-config</td>
			<td>TB_KAFKA_IE_UPLINK_ADDITIONAL_CONSUMER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.uplink` 主题的额外 Kafka 消费者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink.additional-producer-config</td>
			<td>TB_KAFKA_IE_UPLINK_ADDITIONAL_PRODUCER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.uplink` 主题的额外 Kafka 生产者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink-notifications.topic-prefix</td>
			<td>TB_KAFKA_IE_UPLINK_NOTIF_TOPIC_PREFIX</td>
			<td>tbmq.ie.uplink.notifications</td>
			<td>从 Integration Executor 向特定 TBMQ 节点发送通知或回复的主题前缀</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink-notifications.topic-properties</td>
			<td>TB_KAFKA_IE_UPLINK_NOTIF_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;partitions:1;replication.factor:1</td>
			<td>`tbmq.ie.uplink.notifications` 主题的 Kafka 主题属性，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink-notifications.additional-consumer-config</td>
			<td>TB_KAFKA_IE_UPLINK_NOTIF_ADDITIONAL_CONSUMER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.uplink.notifications` 主题的额外 Kafka 消费者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-uplink-notifications.additional-producer-config</td>
			<td>TB_KAFKA_IE_UPLINK_NOTIF_ADDITIONAL_PRODUCER_CONFIG</td>
			<td></td>
			<td>`tbmq.ie.uplink.notifications` 主题的额外 Kafka 生产者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-msg.topic-properties</td>
			<td>TB_KAFKA_IE_MSG_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;replication.factor:1</td>
			<td>`tbmq.msg.ie` 主题的 Kafka 主题属性，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-msg.additional-consumer-config</td>
			<td>TB_KAFKA_IE_MSG_ADDITIONAL_CONSUMER_CONFIG</td>
			<td>max.poll.records:50</td>
			<td>`tbmq.msg.ie` 主题的额外 Kafka 消费者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.integration-msg.additional-producer-config</td>
			<td>TB_KAFKA_IE_MSG_ADDITIONAL_PRODUCER_CONFIG</td>
			<td></td>
			<td>`tbmq.msg.ie` 主题的额外 Kafka 生产者配置，以分号分隔</td>
		</tr>
		<tr>
			<td>queue.kafka.kafka-prefix</td>
			<td>TB_KAFKA_PREFIX</td>
			<td></td>
			<td>所有 Kafka 主题、生产者、消费者组和消费者的通用前缀。默认为空字符串表示不添加前缀</td>
		</tr>
	</tbody>
</table>


## 服务参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>service.type</td>
			<td>TB_SERVICE_TYPE</td>
			<td>tbmq-integration-executor</td>
			<td>微服务类型。允许值：tbmq-integration-executor</td>
		</tr>
		<tr>
			<td>service.id</td>
			<td>TB_SERVICE_ID</td>
			<td></td>
			<td>此服务的唯一 ID（为空则自动生成）</td>
		</tr>
		<tr>
			<td>service.integrations.supported</td>
			<td>TB_SERVICE_INTEGRATIONS_SUPPORTED</td>
			<td>ALL</td>
			<td>在微服务 Integration Executor 上启用的 integration。允许值：HTTP、KAFKA、MQTT。默认 ALL</td>
		</tr>
		<tr>
			<td>service.integrations.excluded</td>
			<td>TB_SERVICE_INTEGRATIONS_EXCLUDED</td>
			<td>NONE</td>
			<td>在服务/微服务 Integration Executor 上排除处理的 integration 列表。允许值：HTTP、KAFKA、MQTT。默认 NONE</td>
		</tr>
	</tbody>
</table>


## Integration 通用参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>integrations.statistics.enabled</td>
			<td>INTEGRATIONS_STATISTICS_ENABLED</td>
			<td>true</td>
			<td>启用/禁用 integration 统计</td>
		</tr>
		<tr>
			<td>integrations.statistics.persist-frequency</td>
			<td>INTEGRATIONS_STATISTICS_PERSIST_FREQUENCY</td>
			<td>3600000</td>
			<td>Integration 统计持久化频率（毫秒）</td>
		</tr>
		<tr>
			<td>integrations.init.connection-timeout-sec</td>
			<td>INTEGRATIONS_INIT_CONNECTION_TIMEOUT_SEC</td>
			<td>15</td>
			<td>integration 允许的最大连接超时（秒）。任何更大的用户定义超时将被缩小到此限制</td>
		</tr>
		<tr>
			<td>integrations.init.connection-check-api-request-timeout-sec</td>
			<td>INTEGRATIONS_INIT_CONNECTION_CHECK_API_REQUEST_TIMEOUT_SEC</td>
			<td>20</td>
			<td>API 请求的连接检查超时（秒）</td>
		</tr>
		<tr>
			<td>integrations.reinit.enabled</td>
			<td>INTEGRATIONS_REINIT_ENABLED</td>
			<td>true</td>
			<td>启用/禁用 integration 热重初始化。针对状态为 'FAILED' 的 integration 执行</td>
		</tr>
		<tr>
			<td>integrations.reinit.frequency</td>
			<td>INTEGRATIONS_REINIT_FREQUENCY_MS</td>
			<td>300000</td>
			<td>重初始化 integration 的检查间隔（毫秒）。默认 5 分钟</td>
		</tr>
		<tr>
			<td>integrations.destroy.graceful-timeout-ms</td>
			<td>INTEGRATIONS_DESTROY_TIMEOUT_MS</td>
			<td>1000</td>
			<td>优雅关闭过程中每次迭代等待 integration 正确终止的持续时间（毫秒）。默认 1 秒</td>
		</tr>
		<tr>
			<td>integrations.destroy.count</td>
			<td>INTEGRATIONS_DESTROY_COUNT</td>
			<td>10</td>
			<td>在强制停止进程前尝试优雅关闭的迭代次数</td>
		</tr>
		<tr>
			<td>integrations.destroy.forced-shutdown-timeout-ms</td>
			<td>INTEGRATIONS_DESTROY_FORCED_SHUTDOWN_TIMEOUT_MS</td>
			<td>15000</td>
			<td>若优雅关闭未开始或超过允许时间，强制停止应用前的最大等待时间（毫秒）</td>
		</tr>
		<tr>
			<td>integrations.allow-local-network-hosts</td>
			<td>INTEGRATIONS_ALLOW_LOCAL_NETWORK_HOSTS</td>
			<td>true</td>
			<td>启用/禁用 integration 本地网络主机</td>
		</tr>
		<tr>
			<td>integrations.uplink.callback-threads-count</td>
			<td>INTEGRATIONS_UPLINK_THREADS</td>
			<td>4</td>
			<td>处理上行事件到 TBMQ 节点回调的线程池线程数</td>
		</tr>
		<tr>
			<td>integrations.manage.lifecycle-threads-count</td>
			<td>INTEGRATIONS_MANAGE_LIFECYCLE_THREADS</td>
			<td>4</td>
			<td>处理 integration 生命周期事件（CREATE/UPDATE/DELETE）的线程池线程数</td>
		</tr>
		<tr>
			<td>integrations.manage.command-threads-count</td>
			<td>INTEGRATIONS_MANAGE_COMMAND_THREADS</td>
			<td>4</td>
			<td>处理 integration 验证请求的线程池线程数</td>
		</tr>
		<tr>
			<td>integrations.external.threads-count</td>
			<td>INTEGRATIONS_EXTERNAL_THREADS</td>
			<td>10</td>
			<td>用于处理外部操作的线程池线程数，例如向 Kafka 主题生产消息</td>
		</tr>
		<tr>
			<td>integrations.netty.threads-count</td>
			<td>INTEGRATIONS_NETTY_SHARED_GROUP_THREADS</td>
			<td>0</td>
			<td>Netty 共享 worker 组线程数。默认 0 表示线程数为 availableProcessors * 2。用于通过 MQTT bridge（integration）向外部 MQTT broker 发送消息</td>
		</tr>
	</tbody>
</table>


## 管理参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>management.health.diskspace.enabled</td>
			<td>HEALTH_DISKSPACE_ENABLED</td>
			<td>false</td>
			<td>启用/禁用磁盘空间健康检查</td>
		</tr>
		<tr>
			<td>management.endpoint.health.show-details</td>
			<td>HEALTH_SHOW_DETAILS</td>
			<td>never</td>
			<td>控制健康端点是否显示完整组件详情（如 Redis、DB、TBMQ）。选项：'never'：始终隐藏详情（启用安全时的默认）；'when-authorized'：仅对已认证用户显示详情；'always'：响应中始终包含完整健康详情</td>
		</tr>
		<tr>
			<td>management.endpoints.web.exposure.include</td>
			<td>METRICS_ENDPOINTS_EXPOSE</td>
			<td>health,info,prometheus</td>
			<td>指定通过 HTTP 暴露哪些 Actuator 端点。使用 'health,info' 仅暴露基本健康和信息端点。如需暴露 Prometheus 指标，在列表中加入 'prometheus'（如 'health,info,prometheus'）</td>
		</tr>
	</tbody>
</table>


## 统计参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>stats.ie.enabled</td>
			<td>STATS_IE_ENABLED</td>
			<td>true</td>
			<td>启用/禁用向日志打印统计</td>
		</tr>
		<tr>
			<td>stats.ie.print-interval-ms</td>
			<td>STATS_IE_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td>打印统计的周期（毫秒）。默认值对应 1 分钟</td>
		</tr>
		<tr>
			<td>stats.timer.percentiles</td>
			<td>STATS_TIMER_PERCENTILES</td>
			<td>0.5</td>
			<td>Actuator 为定时器指标返回的百分位数。逗号分隔的双精度值列表</td>
		</tr>
		<tr>
			<td>stats.system-info.persist-frequency</td>
			<td>STATS_SYSTEM_INFO_PERSIST_FREQUENCY_SEC</td>
			<td>60</td>
			<td>系统信息（CPU、内存使用等）持久化频率（秒）</td>
		</tr>
	</tbody>
</table>


## 事件配置参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>event.error.rate-limits.enabled</td>
			<td>EVENT_ERROR_RATE_LIMITS_ENABLED</td>
			<td>true</td>
			<td>为 true 时启用限速</td>
		</tr>
		<tr>
			<td>event.error.rate-limits.integration</td>
			<td>EVENT_ERROR_RATE_LIMITS_INTEGRATION</td>
			<td>5000:3600,100:60</td>
			<td>所有 integration 每小时不超过 5000 条消息或每分钟不超过 100 条消息</td>
		</tr>
		<tr>
			<td>event.error.rate-limits.ttl-minutes</td>
			<td>EVENT_ERROR_RATE_LIMITS_TTL</td>
			<td>60</td>
			<td>达到错误事件限速后，防止限速事件重复持久化的时间（分钟）</td>
		</tr>
	</tbody>
</table>
