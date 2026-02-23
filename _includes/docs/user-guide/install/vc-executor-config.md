* TOC
{:toc}

##  Spring common parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>spring.main.web-environment</td>
			<td>WEB_APPLICATION_ENABLE</td>
			<td>false</td>
			<td> If you enabled process metrics you should also enable 'web-environment'.</td>
		</tr>
		<tr>
			<td>spring.main.web-application-type</td>
			<td>WEB_APPLICATION_TYPE</td>
			<td>none</td>
			<td> If you enabled process metrics you should set 'web-application-type' to 'servlet' value.</td>
		</tr>
		<tr>
			<td>spring.main.allow-circular-references</td>
			<td></td>
			<td>"true" </td>
			<td> Spring Boot configuration property that controls whether circular dependencies between beans are allowed.</td>
		</tr>
	</tbody>
</table>


##  Server common parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>server.address</td>
			<td>HTTP_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> 服务器绑定地址 (has no effect if web-environment is disabled).</td>
		</tr>
		<tr>
			<td>server.port</td>
			<td>HTTP_BIND_PORT</td>
			<td>8086</td>
			<td> 服务器绑定端口 (has no effect if web-environment is disabled).</td>
		</tr>
	</tbody>
</table>


##  Zookeeper connection parameters. Used for service discovery.

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>zk.enabled</td>
			<td>ZOOKEEPER_ENABLED</td>
			<td>true</td>
			<td> Enable/disable zookeeper discovery service.</td>
		</tr>
		<tr>
			<td>zk.url</td>
			<td>ZOOKEEPER_URL</td>
			<td>localhost:2181</td>
			<td> Zookeeper连接字符串</td>
		</tr>
		<tr>
			<td>zk.retry_interval_ms</td>
			<td>ZOOKEEPER_RETRY_INTERVAL_MS</td>
			<td>3000</td>
			<td> Zookeeper重试间隔（毫秒）</td>
		</tr>
		<tr>
			<td>zk.connection_timeout_ms</td>
			<td>ZOOKEEPER_CONNECTION_TIMEOUT_MS</td>
			<td>3000</td>
			<td> Zookeeper连接超时（毫秒）</td>
		</tr>
		<tr>
			<td>zk.session_timeout_ms</td>
			<td>ZOOKEEPER_SESSION_TIMEOUT_MS</td>
			<td>3000</td>
			<td> Zookeeper会话超时（毫秒）</td>
		</tr>
		<tr>
			<td>zk.zk_dir</td>
			<td>ZOOKEEPER_NODES_DIR</td>
			<td>/thingsboard</td>
			<td> Zookeeper'文件系统'中的目录名</td>
		</tr>
		<tr>
			<td>zk.recalculate_delay</td>
			<td>ZOOKEEPER_RECALCULATE_DELAY_MS</td>
			<td>0</td>
			<td> The recalculate_delay property is recommended in a microservices architecture setup for rule-engine services.
 This property provides a pause to ensure that when a rule-engine service is restarted, other nodes don't immediately attempt to recalculate their partitions.
 The delay is recommended because the initialization of rule chain actors is time-consuming. Avoiding unnecessary recalculations during a restart can enhance system performance and stability.</td>
		</tr>
	</tbody>
</table>


##  Queue configuration parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>queue.type</td>
			<td>TB_QUEUE_TYPE</td>
			<td>kafka</td>
			<td> kafka(Apache Kafka)</td>
		</tr>
		<tr>
			<td>queue.prefix</td>
			<td>TB_QUEUE_PREFIX</td>
			<td></td>
			<td> 全局队列前缀。若指定，则在默认topic名前添加：'prefix.default_topic_name'。应用于所有topic（及kafka consumer group）。</td>
		</tr>
		<tr>
			<td>queue.in_memory.stats.print-interval-ms</td>
			<td>TB_QUEUE_IN_MEMORY_STATS_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td> For debug lvl</td>
		</tr>
		<tr>
			<td>queue.kafka.bootstrap.servers</td>
			<td>TB_KAFKA_SERVERS</td>
			<td>localhost:9092</td>
			<td> Kafka Bootstrap服务器</td>
		</tr>
		<tr>
			<td>queue.kafka.ssl.enabled</td>
			<td>TB_KAFKA_SSL_ENABLED</td>
			<td>false</td>
			<td> 启用/禁用Kafka SSL通信</td>
		</tr>
		<tr>
			<td>queue.kafka.ssl.truststore.location</td>
			<td>TB_KAFKA_SSL_TRUSTSTORE_LOCATION</td>
			<td></td>
			<td> truststore文件路径</td>
		</tr>
		<tr>
			<td>queue.kafka.ssl.truststore.password</td>
			<td>TB_KAFKA_SSL_TRUSTSTORE_PASSWORD</td>
			<td></td>
			<td> 若指定了truststore则为其密码</td>
		</tr>
		<tr>
			<td>queue.kafka.ssl.keystore.location</td>
			<td>TB_KAFKA_SSL_KEYSTORE_LOCATION</td>
			<td></td>
			<td> keystore文件路径。客户端可选，用于客户端双向认证</td>
		</tr>
		<tr>
			<td>queue.kafka.ssl.keystore.password</td>
			<td>TB_KAFKA_SSL_KEYSTORE_PASSWORD</td>
			<td></td>
			<td> The store password for the key store file. This is optional for the client and only needed if ‘ssl.keystore.location’ is configured. Key store password is not supported for PEM format</td>
		</tr>
		<tr>
			<td>queue.kafka.ssl.key.password</td>
			<td>TB_KAFKA_SSL_KEY_PASSWORD</td>
			<td></td>
			<td> The password of the private key in the key store file or the PEM key specified in ‘keystore.key’</td>
		</tr>
		<tr>
			<td>queue.kafka.acks</td>
			<td>TB_KAFKA_ACKS</td>
			<td>all</td>
			<td> 生产者认为请求完成前要求leader收到的确认数。控制发送记录的持久性。允许值：0、1、all</td>
		</tr>
		<tr>
			<td>queue.kafka.retries</td>
			<td>TB_KAFKA_RETRIES</td>
			<td>1</td>
			<td> 重试次数。重发因瞬时错误发送失败的记录</td>
		</tr>
		<tr>
			<td>queue.kafka.compression.type</td>
			<td>TB_KAFKA_COMPRESSION_TYPE</td>
			<td>none</td>
			<td> none或gzip</td>
		</tr>
		<tr>
			<td>queue.kafka.batch.size</td>
			<td>TB_KAFKA_BATCH_SIZE</td>
			<td>16384</td>
			<td> 默认批量大小。为待发送批量的上限</td>
		</tr>
		<tr>
			<td>queue.kafka.linger.ms</td>
			<td>TB_KAFKA_LINGER_MS</td>
			<td>1</td>
			<td> 创建少许人工延迟，即不立即发送记录</td>
		</tr>
		<tr>
			<td>queue.kafka.max.request.size</td>
			<td>TB_KAFKA_MAX_REQUEST_SIZE</td>
			<td>1048576</td>
			<td> 单次请求最大字节数。限制生产者单次请求发送的批次数以避免发送过大请求</td>
		</tr>
		<tr>
			<td>queue.kafka.max.in.flight.requests.per.connection</td>
			<td>TB_KAFKA_MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION</td>
			<td>5</td>
			<td> 客户端在单连接上阻塞前可发送的未确认请求最大数</td>
		</tr>
		<tr>
			<td>queue.kafka.buffer.memory</td>
			<td>TB_BUFFER_MEMORY</td>
			<td>33554432</td>
			<td> 生产者用于缓冲待发送记录的内存总字节数</td>
		</tr>
		<tr>
			<td>queue.kafka.replication_factor</td>
			<td>TB_QUEUE_KAFKA_REPLICATION_FACTOR</td>
			<td>1</td>
			<td> Kafka多broker上的数据副本数</td>
		</tr>
		<tr>
			<td>queue.kafka.max_poll_interval_ms</td>
			<td>TB_QUEUE_KAFKA_MAX_POLL_INTERVAL_MS</td>
			<td>300000</td>
			<td> 使用consumer group管理时两次poll()调用间的最大延迟。限制消费者在获取更多记录前可空闲的最长时间</td>
		</tr>
		<tr>
			<td>queue.kafka.max_poll_records</td>
			<td>TB_QUEUE_KAFKA_MAX_POLL_RECORDS</td>
			<td>8192</td>
			<td> 单次poll()调用返回的最大记录数</td>
		</tr>
		<tr>
			<td>queue.kafka.max_partition_fetch_bytes</td>
			<td>TB_QUEUE_KAFKA_MAX_PARTITION_FETCH_BYTES</td>
			<td>16777216</td>
			<td> 服务器每分区返回的最大数据量。消费者按批获取记录</td>
		</tr>
		<tr>
			<td>queue.kafka.fetch_max_bytes</td>
			<td>TB_QUEUE_KAFKA_FETCH_MAX_BYTES</td>
			<td>134217728</td>
			<td> 服务器返回的最大数据量。消费者按批获取记录</td>
		</tr>
		<tr>
			<td>queue.kafka.request.timeout.ms</td>
			<td>TB_QUEUE_KAFKA_REQUEST_TIMEOUT_MS</td>
			<td>30000</td>
			<td> (30秒) </td>
		</tr>
		<tr>
			<td>queue.kafka.session.timeout.ms</td>
			<td>TB_QUEUE_KAFKA_SESSION_TIMEOUT_MS</td>
			<td>10000</td>
			<td> (10秒) </td>
		</tr>
		<tr>
			<td>queue.kafka.auto_offset_reset</td>
			<td>TB_QUEUE_KAFKA_AUTO_OFFSET_RESET</td>
			<td>earliest</td>
			<td> earliest、latest或none</td>
		</tr>
		<tr>
			<td>queue.kafka.use_confluent_cloud</td>
			<td>TB_QUEUE_KAFKA_USE_CONFLUENT_CLOUD</td>
			<td>false</td>
			<td> 启用/禁用Confluent Cloud</td>
		</tr>
		<tr>
			<td>queue.kafka.confluent.ssl.algorithm</td>
			<td>TB_QUEUE_KAFKA_CONFLUENT_SSL_ALGORITHM</td>
			<td>https</td>
			<td> 客户端验证服务器主机名的端点标识算法。默认https</td>
		</tr>
		<tr>
			<td>queue.kafka.confluent.sasl.mechanism</td>
			<td>TB_QUEUE_KAFKA_CONFLUENT_SASL_MECHANISM</td>
			<td>PLAIN</td>
			<td> 认证Schema Registry请求的机制。SASL/PLAIN应仅与TLS/SSL传输层配合使用以确保明文密码不未加密传输</td>
		</tr>
		<tr>
			<td>queue.kafka.confluent.sasl.config</td>
			<td>TB_QUEUE_KAFKA_CONFLUENT_SASL_JAAS_CONFIG</td>
			<td>org.apache.kafka.common.security.plain.PlainLoginModule required username=\"CLUSTER_API_KEY\" password=\"CLUSTER_API_SECRET\";</td>
			<td> 使用JAAS配置指定broker上的多个SASL机制</td>
		</tr>
		<tr>
			<td>queue.kafka.confluent.security.protocol</td>
			<td>TB_QUEUE_KAFKA_CONFLUENT_SECURITY_PROTOCOL</td>
			<td>SASL_SSL</td>
			<td> 与broker通信的协议。有效值：PLAINTEXT、SSL、SASL_PLAINTEXT、SASL_SSL</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-properties-per-topic.tb_ota_package.key</td>
			<td></td>
			<td>max.poll.records</td>
			<td> Key-value properties for Kafka consumer per specific topic, e.g. tb_ota_package is a topic name for ota, tb_rule_engine.sq is a topic name for default SequentialByOriginator queue. Check TB_QUEUE_CORE_OTA_TOPIC and TB_QUEUE_RE_SQ_TOPIC params</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-properties-per-topic.tb_ota_package.key.value</td>
			<td>TB_QUEUE_KAFKA_OTA_MAX_POLL_RECORDS</td>
			<td>10</td>
			<td> Example of specific consumer properties value per topic</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-properties-per-topic.tb_version_control.key</td>
			<td></td>
			<td>max.poll.interval.ms</td>
			<td> Example of specific consumer properties value per topic for VC</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-properties-per-topic.tb_version_control.key.value</td>
			<td>TB_QUEUE_KAFKA_VC_MAX_POLL_INTERVAL_MS</td>
			<td>600000</td>
			<td> Example of specific consumer properties value per topic for VC</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-properties-per-topic-inline</td>
			<td>TB_QUEUE_KAFKA_CONSUMER_PROPERTIES_PER_TOPIC_INLINE</td>
			<td></td>
			<td>      tb_rule_engine.sq:
        - key: max.poll.records
          value: "${TB_QUEUE_KAFKA_SQ_MAX_POLL_RECORDS:1024}"
 If you override any default Kafka topic name using environment variables, you must also specify the related consumer properties
 for the new topic in `consumer-properties-per-topic-inline`. Otherwise, the topic will not inherit its expected configuration (e.g., max.poll.records, timeouts, etc).
 Format: "topic1:key1=value1,key2=value2;topic2:key=value"
 Example: "tb_core_modified.notifications:max.poll.records=10;tb_edge_modified:max.poll.records=10,enable.auto.commit=true"</td>
		</tr>
		<tr>
			<td>queue.kafka.other-inline</td>
			<td>TB_QUEUE_KAFKA_OTHER_PROPERTIES</td>
			<td></td>
			<td> In this section you can specify custom parameters (semicolon separated) for Kafka consumer/producer/admin </td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.core</td>
			<td>TB_QUEUE_KAFKA_CORE_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:1;min.insync.replicas:1</td>
			<td> Core topic的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.notifications</td>
			<td>TB_QUEUE_KAFKA_NOTIFICATIONS_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:1;min.insync.replicas:1</td>
			<td> 通知topic的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.version-control</td>
			<td>TB_QUEUE_KAFKA_VC_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:1;min.insync.replicas:1</td>
			<td> Core topic的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.housekeeper</td>
			<td>TB_QUEUE_KAFKA_HOUSEKEEPER_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:10;min.insync.replicas:1</td>
			<td> Housekeeper任务topic的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.enabled</td>
			<td>TB_QUEUE_KAFKA_CONSUMER_STATS_ENABLED</td>
			<td>true</td>
			<td> Prints lag between consumer group offset and last messages offset in Kafka topics</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.print-interval-ms</td>
			<td>TB_QUEUE_KAFKA_CONSUMER_STATS_MIN_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td> Statistics printing interval for Kafka's consumer-groups stats</td>
		</tr>
		<tr>
			<td>queue.kafka.consumer-stats.kafka-response-timeout-ms</td>
			<td>TB_QUEUE_KAFKA_CONSUMER_STATS_RESPONSE_TIMEOUT_MS</td>
			<td>1000</td>
			<td> Time to wait for the stats-loading requests to Kafka to finis</td>
		</tr>
		<tr>
			<td>queue.kafka.topics_cache_ttl_ms</td>
			<td>TB_QUEUE_KAFKA_TOPICS_CACHE_TTL_MS</td>
			<td>300000</td>
			<td> topic缓存TTL（毫秒）。默认5分钟</td>
		</tr>
		<tr>
			<td>queue.partitions.hash_function_name</td>
			<td>TB_QUEUE_PARTITIONS_HASH_FUNCTION_NAME</td>
			<td>murmur3_128</td>
			<td> murmur3_32、murmur3_128或sha256</td>
		</tr>
		<tr>
			<td>queue.core.topic</td>
			<td>TB_QUEUE_CORE_TOPIC</td>
			<td>tb_core</td>
			<td> 默认topic名</td>
		</tr>
		<tr>
			<td>queue.core.notifications_topic</td>
			<td>TB_QUEUE_CORE_NOTIFICATIONS_TOPIC</td>
			<td>tb_core.notifications</td>
			<td> 需要最低延迟和处理时间的高优先级通知</td>
		</tr>
		<tr>
			<td>queue.core.poll-interval</td>
			<td>TB_QUEUE_CORE_POLL_INTERVAL_MS</td>
			<td>25</td>
			<td> Core微服务轮询消息的间隔（毫秒）</td>
		</tr>
		<tr>
			<td>queue.core.partitions</td>
			<td>TB_QUEUE_CORE_PARTITIONS</td>
			<td>10</td>
			<td> Core微服务使用的分区数</td>
		</tr>
		<tr>
			<td>queue.core.pack-processing-timeout</td>
			<td>TB_QUEUE_CORE_PACK_PROCESSING_TIMEOUT_MS</td>
			<td>2000</td>
			<td> Core微服务处理消息包的超时</td>
		</tr>
		<tr>
			<td>queue.core.ota.topic</td>
			<td>TB_QUEUE_CORE_OTA_TOPIC</td>
			<td>tb_ota_package</td>
			<td> 默认topic名 for OTA updates</td>
		</tr>
		<tr>
			<td>queue.core.ota.pack-interval-ms</td>
			<td>TB_QUEUE_CORE_OTA_PACK_INTERVAL_MS</td>
			<td>60000</td>
			<td> The interval of processing the OTA updates for devices. Used to avoid any harm to the network due to many parallel OTA updates</td>
		</tr>
		<tr>
			<td>queue.core.ota.pack-size</td>
			<td>TB_QUEUE_CORE_OTA_PACK_SIZE</td>
			<td>100</td>
			<td> The size of OTA updates notifications fetched from the queue. The queue stores pairs of firmware and device ids</td>
		</tr>
		<tr>
			<td>queue.core.usage-stats-topic</td>
			<td>TB_QUEUE_US_TOPIC</td>
			<td>tb_usage_stats</td>
			<td> Stats topic name</td>
		</tr>
		<tr>
			<td>queue.core.stats.enabled</td>
			<td>TB_QUEUE_CORE_STATS_ENABLED</td>
			<td>true</td>
			<td> 启用/禁用Core微服务统计</td>
		</tr>
		<tr>
			<td>queue.core.stats.print-interval-ms</td>
			<td>TB_QUEUE_CORE_STATS_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td> Core微服务统计打印间隔</td>
		</tr>
		<tr>
			<td>queue.core.housekeeper.topic</td>
			<td>TB_HOUSEKEEPER_TOPIC</td>
			<td>tb_housekeeper</td>
			<td> Housekeeper任务topic名</td>
		</tr>
		<tr>
			<td>queue.vc.topic</td>
			<td>TB_QUEUE_VC_TOPIC</td>
			<td>tb_version_control</td>
			<td> 默认topic名</td>
		</tr>
		<tr>
			<td>queue.vc.partitions</td>
			<td>TB_QUEUE_VC_PARTITIONS</td>
			<td>10</td>
			<td> Number of partitions to associate with this queue. Used for scaling the number of messages that can be processed in parallel</td>
		</tr>
		<tr>
			<td>queue.vc.poll-interval</td>
			<td>TB_QUEUE_VC_INTERVAL_MS</td>
			<td>25</td>
			<td> Interval in milliseconds between polling of the messages if no new messages arrive</td>
		</tr>
		<tr>
			<td>queue.vc.pack-processing-timeout</td>
			<td>TB_QUEUE_VC_PACK_PROCESSING_TIMEOUT_MS</td>
			<td>180000</td>
			<td> Timeout before retrying all failed and timed-out messages from the processing pack</td>
		</tr>
		<tr>
			<td>queue.vc.msg-chunk-size</td>
			<td>TB_QUEUE_VC_MSG_CHUNK_SIZE</td>
			<td>250000</td>
			<td> Limit for single queue message size</td>
		</tr>
	</tbody>
</table>


##  Version control parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>vc.thread_pool_size</td>
			<td>TB_VC_POOL_SIZE</td>
			<td>6</td>
			<td> Pool size for handling export tasks</td>
		</tr>
		<tr>
			<td>vc.git.io_pool_size</td>
			<td>TB_VC_GIT_POOL_SIZE</td>
			<td>3</td>
			<td> Pool size for handling the git IO operations</td>
		</tr>
		<tr>
			<td>vc.git.repositories-folder</td>
			<td>TB_VC_GIT_REPOSITORIES_FOLDER</td>
			<td>${java.io.tmpdir}/repositories</td>
			<td> Default storing repository path</td>
		</tr>
	</tbody>
</table>


##  Usage statistics parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>usage.stats.report.enabled</td>
			<td>USAGE_STATS_REPORT_ENABLED</td>
			<td>true</td>
			<td> 启用/禁用API使用统计收集。默认在系统和租户级别收集</td>
		</tr>
		<tr>
			<td>usage.stats.report.enabled_per_customer</td>
			<td>USAGE_STATS_REPORT_PER_CUSTOMER_ENABLED</td>
			<td>false</td>
			<td> 启用/禁用客户级API使用统计收集</td>
		</tr>
		<tr>
			<td>usage.stats.report.interval</td>
			<td>USAGE_STATS_REPORT_INTERVAL</td>
			<td>60</td>
			<td> 统计上报间隔。默认每10秒发送汇总统计</td>
		</tr>
		<tr>
			<td>usage.stats.report.pack_size</td>
			<td>USAGE_STATS_REPORT_PACK_SIZE</td>
			<td>1024</td>
			<td> 每个包中的统计消息数</td>
		</tr>
	</tbody>
</table>


##  Metrics parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>metrics.enabled</td>
			<td>METRICS_ENABLED</td>
			<td>false</td>
			<td> 启用/禁用actuator指标。</td>
		</tr>
		<tr>
			<td>metrics.timer.percentiles</td>
			<td>METRICS_TIMER_PERCENTILES</td>
			<td>0.5</td>
			<td> Metrics percentiles returned by actuator for timer metrics. List of double values (divided by ,).</td>
		</tr>
	</tbody>
</table>


##  General management parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>management.endpoints.web.exposure.include</td>
			<td>METRICS_ENDPOINTS_EXPOSE</td>
			<td>info</td>
			<td> 暴露指标端点（使用'prometheus'启用prometheus指标）。</td>
		</tr>
	</tbody>
</table>


##  Service common properties

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>service.type</td>
			<td>TB_SERVICE_TYPE</td>
			<td>tb-vc-executor</td>
			<td> 服务类型</td>
		</tr>
		<tr>
			<td>service.id</td>
			<td>TB_SERVICE_ID</td>
			<td></td>
			<td> 本服务的唯一ID（空则自动生成）</td>
		</tr>
	</tbody>
</table>


##  Notification system parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>notification_system.rules.deduplication_durations</td>
			<td>TB_NOTIFICATION_RULES_DEDUPLICATION_DURATIONS</td>
			<td>RATE_LIMITS:14400000;</td>
			<td> 触发器类型的去重时长（毫秒，分号分隔）。格式：'NotificationRuleTriggerType1:123;NotificationRuleTriggerType2:456'</td>
		</tr>
	</tbody>
</table>
