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
			<td>8083</td>
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
			<td>false</td>
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


##  Cache parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>cache.type</td>
			<td>CACHE_TYPE</td>
			<td>redis</td>
			<td> caffeine or redis</td>
		</tr>
		<tr>
			<td>cache.entityLimits.timeToLiveInMinutes</td>
			<td>CACHE_SPECS_ENTITY_LIMITS_TTL</td>
			<td>5</td>
			<td> Entity limits cache TTL</td>
		</tr>
		<tr>
			<td>cache.entityLimits.maxSize</td>
			<td>CACHE_SPECS_ENTITY_LIMITS_MAX_SIZE</td>
			<td>100000</td>
			<td> 0 means the cache is disabled</td>
		</tr>
	</tbody>
</table>


##  Redis/Valkey configuration parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>redis.connection.type</td>
			<td>REDIS_CONNECTION_TYPE</td>
			<td>standalone</td>
			<td> standalone or cluster or sentinel</td>
		</tr>
		<tr>
			<td>redis.standalone.host</td>
			<td>REDIS_HOST</td>
			<td>localhost</td>
			<td> Redis连接主机</td>
		</tr>
		<tr>
			<td>redis.standalone.port</td>
			<td>REDIS_PORT</td>
			<td>6379</td>
			<td> Redis连接端口</td>
		</tr>
		<tr>
			<td>redis.standalone.useDefaultClientConfig</td>
			<td>REDIS_USE_DEFAULT_CLIENT_CONFIG</td>
			<td>true</td>
			<td> Use default Redis configuration file</td>
		</tr>
		<tr>
			<td>redis.standalone.clientName</td>
			<td>REDIS_CLIENT_NAME</td>
			<td>standalone</td>
			<td> this value may be used only if you used not default ClientConfig</td>
		</tr>
		<tr>
			<td>redis.standalone.connectTimeout</td>
			<td>REDIS_CLIENT_CONNECT_TIMEOUT</td>
			<td>30000</td>
			<td> this value may be used only if you used not default ClientConfig</td>
		</tr>
		<tr>
			<td>redis.standalone.readTimeout</td>
			<td>REDIS_CLIENT_READ_TIMEOUT</td>
			<td>60000</td>
			<td> this value may be used only if you used not default ClientConfig</td>
		</tr>
		<tr>
			<td>redis.standalone.usePoolConfig</td>
			<td>REDIS_CLIENT_USE_POOL_CONFIG</td>
			<td>false</td>
			<td> this value may be used only if you used not default ClientConfig</td>
		</tr>
		<tr>
			<td>redis.cluster.nodes</td>
			<td>REDIS_NODES</td>
			<td></td>
			<td> 用于引导的"host:port"对列表（逗号分隔）.</td>
		</tr>
		<tr>
			<td>redis.cluster.max-redirects</td>
			<td>REDIS_MAX_REDIRECTS</td>
			<td>12</td>
			<td> 集群中执行命令时允许的最大重定向数.</td>
		</tr>
		<tr>
			<td>redis.cluster.useDefaultPoolConfig</td>
			<td>REDIS_USE_DEFAULT_POOL_CONFIG</td>
			<td>true</td>
			<td> if set false will be used pool config build from values of the pool config section</td>
		</tr>
		<tr>
			<td>redis.sentinel.master</td>
			<td>REDIS_MASTER</td>
			<td></td>
			<td> name of master node</td>
		</tr>
		<tr>
			<td>redis.sentinel.sentinels</td>
			<td>REDIS_SENTINELS</td>
			<td></td>
			<td> comma-separated list of "host:port" pairs of sentinels</td>
		</tr>
		<tr>
			<td>redis.sentinel.password</td>
			<td>REDIS_SENTINEL_PASSWORD</td>
			<td></td>
			<td> password to authenticate with sentinel</td>
		</tr>
		<tr>
			<td>redis.sentinel.useDefaultPoolConfig</td>
			<td>REDIS_USE_DEFAULT_POOL_CONFIG</td>
			<td>true</td>
			<td> if set false will be used pool config build from values of the pool config section</td>
		</tr>
		<tr>
			<td>redis.db</td>
			<td>REDIS_DB</td>
			<td>0</td>
			<td> db index</td>
		</tr>
		<tr>
			<td>redis.password</td>
			<td>REDIS_PASSWORD</td>
			<td></td>
			<td> db password</td>
		</tr>
		<tr>
			<td>redis.username</td>
			<td>REDIS_USERNAME</td>
			<td></td>
			<td> Redis username for ACL authentication (Redis 6.0+). Leave empty for legacy password-only auth</td>
		</tr>
		<tr>
			<td>redis.ssl.enabled</td>
			<td>TB_REDIS_SSL_ENABLED</td>
			<td>false</td>
			<td> Enable/disable secure connection</td>
		</tr>
		<tr>
			<td>redis.ssl.credentials.cert_file</td>
			<td>TB_REDIS_SSL_PEM_CERT</td>
			<td></td>
			<td> Path redis server (CA) certificate</td>
		</tr>
		<tr>
			<td>redis.ssl.credentials.user_cert_file</td>
			<td>TB_REDIS_SSL_PEM_KEY</td>
			<td></td>
			<td> Path to user certificate file. This is optional for the client and can be used for two-way authentication for the client</td>
		</tr>
		<tr>
			<td>redis.ssl.credentials.user_key_file</td>
			<td>TB_REDIS_SSL_PEM_KEY_PASSWORD</td>
			<td></td>
			<td> Path to user private key file. This is optional for the client and only needed if ‘user_cert_file’ is configured.</td>
		</tr>
		<tr>
			<td>redis.pool_config.maxTotal</td>
			<td>REDIS_POOL_CONFIG_MAX_TOTAL</td>
			<td>128</td>
			<td> Maximum number of connections that can be allocated by the connection pool</td>
		</tr>
		<tr>
			<td>redis.pool_config.maxIdle</td>
			<td>REDIS_POOL_CONFIG_MAX_IDLE</td>
			<td>128</td>
			<td> Maximum number of idle connections that can be maintained in the pool without being closed</td>
		</tr>
		<tr>
			<td>redis.pool_config.minIdle</td>
			<td>REDIS_POOL_CONFIG_MIN_IDLE</td>
			<td>16</td>
			<td> Minumum number of idle connections that can be maintained in the pool without being closed</td>
		</tr>
		<tr>
			<td>redis.pool_config.testOnBorrow</td>
			<td>REDIS_POOL_CONFIG_TEST_ON_BORROW</td>
			<td>false</td>
			<td> Enable/Disable PING command send when a connection is borrowed</td>
		</tr>
		<tr>
			<td>redis.pool_config.testOnReturn</td>
			<td>REDIS_POOL_CONFIG_TEST_ON_RETURN</td>
			<td>false</td>
			<td> The property is used to specify whether to test the connection before returning it to the connection pool.</td>
		</tr>
		<tr>
			<td>redis.pool_config.testWhileIdle</td>
			<td>REDIS_POOL_CONFIG_TEST_WHILE_IDLE</td>
			<td>true</td>
			<td> The property is used in the context of connection pooling in Redis</td>
		</tr>
		<tr>
			<td>redis.pool_config.minEvictableMs</td>
			<td>REDIS_POOL_CONFIG_MIN_EVICTABLE_MS</td>
			<td>60000</td>
			<td> Minimum amount of time that an idle connection should be idle before it can be evicted from the connection pool. Value set in milliseconds</td>
		</tr>
		<tr>
			<td>redis.pool_config.evictionRunsMs</td>
			<td>REDIS_POOL_CONFIG_EVICTION_RUNS_MS</td>
			<td>30000</td>
			<td> Specifies the time interval in milliseconds between two consecutive eviction runs</td>
		</tr>
		<tr>
			<td>redis.pool_config.maxWaitMills</td>
			<td>REDIS_POOL_CONFIG_MAX_WAIT_MS</td>
			<td>60000</td>
			<td> Maximum time in milliseconds where a client is willing to wait for a connection from the pool when all connections are exhausted</td>
		</tr>
		<tr>
			<td>redis.pool_config.numberTestsPerEvictionRun</td>
			<td>REDIS_POOL_CONFIG_NUMBER_TESTS_PER_EVICTION_RUN</td>
			<td>3</td>
			<td> Specifies the number of connections to test for eviction during each eviction run</td>
		</tr>
		<tr>
			<td>redis.pool_config.blockWhenExhausted</td>
			<td>REDIS_POOL_CONFIG_BLOCK_WHEN_EXHAUSTED</td>
			<td>true</td>
			<td> Determines the behavior when a thread requests a connection from the pool but there are no available connections and the pool cannot create more due to the maxTotal configuration</td>
		</tr>
	</tbody>
</table>


##  Snmp server parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>transport.snmp.enabled</td>
			<td>SNMP_ENABLED</td>
			<td>true</td>
			<td> Enable/disable SNMP transport protocol</td>
		</tr>
		<tr>
			<td>transport.snmp.bind_port</td>
			<td>SNMP_BIND_PORT</td>
			<td>1620</td>
			<td> Snmp bind port</td>
		</tr>
		<tr>
			<td>transport.snmp.response_processing.parallelism_level</td>
			<td>SNMP_RESPONSE_PROCESSING_PARALLELISM_LEVEL</td>
			<td>4</td>
			<td> parallelism level for executor (workStealingPool) that is responsible for handling responses from SNMP devices</td>
		</tr>
		<tr>
			<td>transport.snmp.underlying_protocol</td>
			<td>SNMP_UNDERLYING_PROTOCOL</td>
			<td>udp</td>
			<td> to configure SNMP to work over UDP or TCP</td>
		</tr>
		<tr>
			<td>transport.snmp.max_request_oids</td>
			<td>SNMP_MAX_REQUEST_OIDS</td>
			<td>100</td>
			<td> Maximum size of a PDU (amount of OID mappings in a single SNMP request). The request will be split into multiple PDUs if mappings amount exceeds this number</td>
		</tr>
		<tr>
			<td>transport.snmp.request_chunk_delay_ms</td>
			<td>SNMP_REQUEST_CHUNK_DELAY_MS</td>
			<td>100</td>
			<td> Delay after sending each request chunk (in case the request was split into multiple PDUs due to max_request_oids)</td>
		</tr>
		<tr>
			<td>transport.snmp.response.ignore_type_cast_errors</td>
			<td>SNMP_RESPONSE_IGNORE_TYPE_CAST_ERRORS</td>
			<td>false</td>
			<td> To ignore SNMP response values that do not match the data type of the configured OID mapping (by default false - will throw an error if any value of the response not match configured data types)</td>
		</tr>
		<tr>
			<td>transport.snmp.scheduler_thread_pool_size</td>
			<td>SNMP_SCHEDULER_THREAD_POOL_SIZE</td>
			<td>4</td>
			<td> Thread pool size for scheduler that executes device querying tasks</td>
		</tr>
		<tr>
			<td>transport.snmp.batch_retries</td>
			<td>SNMP_BOOTSTRAP_RETRIES</td>
			<td>8</td>
			<td> Maximum number of retry attempts for a single SNMP devices batch during bootstrap.</td>
		</tr>
		<tr>
			<td>transport.sessions.inactivity_timeout</td>
			<td>TB_TRANSPORT_SESSIONS_INACTIVITY_TIMEOUT</td>
			<td>600000</td>
			<td> 会话空闲超时为全局配置，定义设备最后一条消息到达后传输会话保持开放的时长（毫秒）。设备发送任何消息（含keepalive）时会更新会话最后活动时间。若无活动则会关闭会话并删除所有订阅。建议与设备空闲超时(state.defaultInactivityTimeoutInSec或DEFAULT_INACTIVITY_TIMEOUT)同步，该参数负责核心服务中设备连接状态检测。会话空闲超时应大于等于设备空闲超时。注意会话空闲超时为毫秒，设备空闲超时为秒。</td>
		</tr>
		<tr>
			<td>transport.sessions.report_timeout</td>
			<td>TB_TRANSPORT_SESSIONS_REPORT_TIMEOUT</td>
			<td>3000</td>
			<td> 定期检查过期会话及上报会话最后活动时间变更的间隔</td>
		</tr>
		<tr>
			<td>transport.json.type_cast_enabled</td>
			<td>JSON_TYPE_CAST_ENABLED</td>
			<td>true</td>
			<td> 处理遥测/属性JSON时尽可能将String转为Numeric</td>
		</tr>
		<tr>
			<td>transport.json.max_string_value_length</td>
			<td>JSON_MAX_STRING_VALUE_LENGTH</td>
			<td>0</td>
			<td> 处理遥测/属性JSON时允许的最大字符串长度(0表示禁用长度检查)</td>
		</tr>
		<tr>
			<td>transport.log.enabled</td>
			<td>TB_TRANSPORT_LOG_ENABLED</td>
			<td>true</td>
			<td> 启用/禁用将传输消息记录到遥测。例如LwM2M注册更新日志</td>
		</tr>
		<tr>
			<td>transport.log.max_length</td>
			<td>TB_TRANSPORT_LOG_MAX_LENGTH</td>
			<td>1024</td>
			<td> 日志消息最大长度。超出时将截断至指定值</td>
		</tr>
		<tr>
			<td>transport.stats.enabled</td>
			<td>TB_TRANSPORT_STATS_ENABLED</td>
			<td>true</td>
			<td> Enable/Disable collection of transport statistics</td>
		</tr>
		<tr>
			<td>transport.stats.print-interval-ms</td>
			<td>TB_TRANSPORT_STATS_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td> 传输统计日志间隔</td>
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
			<td>queue.kafka.consumer-properties-per-topic-inline</td>
			<td>TB_QUEUE_KAFKA_CONSUMER_PROPERTIES_PER_TOPIC_INLINE</td>
			<td></td>
			<td> If you override any default Kafka topic name using environment variables, you must also specify the related consumer properties
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
			<td>queue.kafka.topic-properties.rule-engine</td>
			<td>TB_QUEUE_KAFKA_RE_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:1;min.insync.replicas:1</td>
			<td> 规则引擎的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.core</td>
			<td>TB_QUEUE_KAFKA_CORE_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:1;min.insync.replicas:1</td>
			<td> Core topic的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.transport-api</td>
			<td>TB_QUEUE_KAFKA_TA_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:10;min.insync.replicas:1</td>
			<td> Transport Api topic的Kafka属性</td>
		</tr>
		<tr>
			<td>queue.kafka.topic-properties.notifications</td>
			<td>TB_QUEUE_KAFKA_NOTIFICATIONS_TOPIC_PROPERTIES</td>
			<td>retention.ms:604800000;segment.bytes:52428800;retention.bytes:1048576000;partitions:1;min.insync.replicas:1</td>
			<td> 通知topic的Kafka属性</td>
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
			<td>queue.transport_api.requests_topic</td>
			<td>TB_QUEUE_TRANSPORT_API_REQUEST_TOPIC</td>
			<td>tb_transport.api.requests</td>
			<td> 消费传输微服务api请求的topic</td>
		</tr>
		<tr>
			<td>queue.transport_api.responses_topic</td>
			<td>TB_QUEUE_TRANSPORT_API_RESPONSE_TOPIC</td>
			<td>tb_transport.api.responses</td>
			<td> 向传输微服务发送api响应的topic</td>
		</tr>
		<tr>
			<td>queue.transport_api.max_pending_requests</td>
			<td>TB_QUEUE_TRANSPORT_MAX_PENDING_REQUESTS</td>
			<td>10000</td>
			<td> 服务器待处理的传输微服务api请求最大数</td>
		</tr>
		<tr>
			<td>queue.transport_api.max_requests_timeout</td>
			<td>TB_QUEUE_TRANSPORT_MAX_REQUEST_TIMEOUT</td>
			<td>10000</td>
			<td> 服务器处理传输微服务api请求的最大超时（毫秒）</td>
		</tr>
		<tr>
			<td>queue.transport_api.max_callback_threads</td>
			<td>TB_QUEUE_TRANSPORT_MAX_CALLBACK_THREADS</td>
			<td>100</td>
			<td> 用于调用回调的线程数</td>
		</tr>
		<tr>
			<td>queue.transport_api.request_poll_interval</td>
			<td>TB_QUEUE_TRANSPORT_REQUEST_POLL_INTERVAL_MS</td>
			<td>25</td>
			<td> 轮询传输微服务api请求的间隔（毫秒）</td>
		</tr>
		<tr>
			<td>queue.transport_api.response_poll_interval</td>
			<td>TB_QUEUE_TRANSPORT_RESPONSE_POLL_INTERVAL_MS</td>
			<td>25</td>
			<td> 轮询传输微服务api响应的间隔（毫秒）</td>
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
			<td>60000</td>
			<td> Core微服务处理消息包的超时</td>
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
			<td>false</td>
			<td> 启用/禁用Core微服务统计</td>
		</tr>
		<tr>
			<td>queue.core.stats.print-interval-ms</td>
			<td>TB_QUEUE_CORE_STATS_PRINT_INTERVAL_MS</td>
			<td>10000</td>
			<td> Core微服务统计打印间隔</td>
		</tr>
		<tr>
			<td>queue.core.housekeeper.topic</td>
			<td>TB_HOUSEKEEPER_TOPIC</td>
			<td>tb_housekeeper</td>
			<td> Housekeeper任务topic名</td>
		</tr>
		<tr>
			<td>queue.js.request_topic</td>
			<td>REMOTE_JS_EVAL_REQUEST_TOPIC</td>
			<td>js_eval.requests</td>
			<td> JS Eval请求topic</td>
		</tr>
		<tr>
			<td>queue.js.response_topic_prefix</td>
			<td>REMOTE_JS_EVAL_RESPONSE_TOPIC</td>
			<td>js_eval.responses</td>
			<td> 与节点id组合的JS Eval响应topic前缀</td>
		</tr>
		<tr>
			<td>queue.js.max_pending_requests</td>
			<td>REMOTE_JS_MAX_PENDING_REQUESTS</td>
			<td>10000</td>
			<td> JS Eval最大待处理请求数</td>
		</tr>
		<tr>
			<td>queue.js.max_requests_timeout</td>
			<td>REMOTE_JS_MAX_REQUEST_TIMEOUT</td>
			<td>10000</td>
			<td> JS Eval最大请求超时</td>
		</tr>
		<tr>
			<td>queue.js.response_poll_interval</td>
			<td>REMOTE_JS_RESPONSE_POLL_INTERVAL_MS</td>
			<td>25</td>
			<td> JS响应轮询间隔</td>
		</tr>
		<tr>
			<td>queue.rule-engine.topic</td>
			<td>TB_QUEUE_RULE_ENGINE_TOPIC</td>
			<td>tb_rule_engine</td>
			<td> 已弃用。将在近期版本中移除</td>
		</tr>
		<tr>
			<td>queue.rule-engine.notifications_topic</td>
			<td>TB_QUEUE_RULE_ENGINE_NOTIFICATIONS_TOPIC</td>
			<td>tb_rule_engine.notifications</td>
			<td> 需要最低延迟和处理时间的高优先级通知</td>
		</tr>
		<tr>
			<td>queue.rule-engine.poll-interval</td>
			<td>TB_QUEUE_RULE_ENGINE_POLL_INTERVAL_MS</td>
			<td>25</td>
			<td> 规则引擎轮询消息的间隔（毫秒）</td>
		</tr>
		<tr>
			<td>queue.rule-engine.pack-processing-timeout</td>
			<td>TB_QUEUE_RULE_ENGINE_PACK_PROCESSING_TIMEOUT_MS</td>
			<td>60000</td>
			<td> 规则引擎处理消息包的超时</td>
		</tr>
		<tr>
			<td>queue.rule-engine.stats.enabled</td>
			<td>TB_QUEUE_RULE_ENGINE_STATS_ENABLED</td>
			<td>true</td>
			<td> 启用/禁用规则引擎统计</td>
		</tr>
		<tr>
			<td>queue.rule-engine.stats.print-interval-ms</td>
			<td>TB_QUEUE_RULE_ENGINE_STATS_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td> 规则引擎统计打印间隔</td>
		</tr>
		<tr>
			<td>queue.transport.notifications_topic</td>
			<td>TB_QUEUE_TRANSPORT_NOTIFICATIONS_TOPIC</td>
			<td>tb_transport.notifications</td>
			<td> 需要最低延迟和处理时间的高优先级通知</td>
		</tr>
		<tr>
			<td>queue.transport.poll_interval</td>
			<td>TB_QUEUE_TRANSPORT_NOTIFICATIONS_POLL_INTERVAL_MS</td>
			<td>25</td>
			<td> 轮询消息的间隔（毫秒）</td>
		</tr>
	</tbody>
</table>


##  Service common parameters

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
			<td>tb-transport</td>
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
