* TOC
{:toc}

##  Spring通用参数

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
			<td> 若启用进程指标，则也应启用'web-environment'。</td>
		</tr>
		<tr>
			<td>spring.main.web-application-type</td>
			<td>WEB_APPLICATION_TYPE</td>
			<td>none</td>
			<td> 若启用进程指标，则应将'web-application-type'设为'servlet'。</td>
		</tr>
		<tr>
			<td>spring.main.allow-circular-references</td>
			<td></td>
			<td>"true" </td>
			<td> Spring Boot配置属性，用于控制是否允许bean之间的循环依赖。</td>
		</tr>
	</tbody>
</table>


##  服务器通用参数

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
			<td> 服务器绑定地址（禁用web-environment时无效）。</td>
		</tr>
		<tr>
			<td>server.port</td>
			<td>HTTP_BIND_PORT</td>
			<td>8083</td>
			<td> 服务器绑定端口（禁用web-environment时无效）。</td>
		</tr>
	</tbody>
</table>


##  Zookeeper连接参数（用于服务发现）

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
			<td> 启用/禁用Zookeeper服务发现。</td>
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
			<td> 在rule-engine微服务架构中建议配置recalculate_delay。该属性提供延迟，确保rule-engine服务重启时，其他节点不会立即尝试重新计算分区。建议配置延迟是因为规则链actor初始化耗时，避免重启期间不必要的重算可提升系统性能和稳定性。</td>
		</tr>
	</tbody>
</table>


##  缓存参数

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
			<td> caffeine或redis</td>
		</tr>
		<tr>
			<td>cache.entityLimits.timeToLiveInMinutes</td>
			<td>CACHE_SPECS_ENTITY_LIMITS_TTL</td>
			<td>5</td>
			<td> 实体限制缓存TTL</td>
		</tr>
		<tr>
			<td>cache.entityLimits.maxSize</td>
			<td>CACHE_SPECS_ENTITY_LIMITS_MAX_SIZE</td>
			<td>100000</td>
			<td> 0表示禁用缓存</td>
		</tr>
	</tbody>
</table>


##  Redis/Valkey配置参数

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
			<td> Redis部署类型：Standalone（单节点）或Cluster</td>
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
			<td> 使用默认Redis配置文件</td>
		</tr>
		<tr>
			<td>redis.standalone.clientName</td>
			<td>REDIS_CLIENT_NAME</td>
			<td>standalone</td>
			<td> 仅当使用非默认ClientConfig时生效</td>
		</tr>
		<tr>
			<td>redis.standalone.connectTimeout</td>
			<td>REDIS_CLIENT_CONNECT_TIMEOUT</td>
			<td>30000</td>
			<td> 仅当使用非默认ClientConfig时生效</td>
		</tr>
		<tr>
			<td>redis.standalone.readTimeout</td>
			<td>REDIS_CLIENT_READ_TIMEOUT</td>
			<td>60000</td>
			<td> 仅当使用非默认ClientConfig时生效</td>
		</tr>
		<tr>
			<td>redis.standalone.usePoolConfig</td>
			<td>REDIS_CLIENT_USE_POOL_CONFIG</td>
			<td>false</td>
			<td> 仅当使用非默认ClientConfig时生效</td>
		</tr>
		<tr>
			<td>redis.cluster.nodes</td>
			<td>REDIS_NODES</td>
			<td></td>
			<td> 用于引导的"host:port"对列表（逗号分隔）。</td>
		</tr>
		<tr>
			<td>redis.cluster.max-redirects</td>
			<td>REDIS_MAX_REDIRECTS</td>
			<td>12</td>
			<td> 在集群中执行命令时允许的最大重定向数。</td>
		</tr>
		<tr>
			<td>redis.cluster.useDefaultPoolConfig</td>
			<td>REDIS_USE_DEFAULT_POOL_CONFIG</td>
			<td>true</td>
			<td> 设为false时将使用pool config节中的值构建连接池配置</td>
		</tr>
		<tr>
			<td>redis.sentinel.master</td>
			<td>REDIS_MASTER</td>
			<td></td>
			<td> 主节点名称</td>
		</tr>
		<tr>
			<td>redis.sentinel.sentinels</td>
			<td>REDIS_SENTINELS</td>
			<td></td>
			<td> Sentinel的"host:port"对列表（逗号分隔）</td>
		</tr>
		<tr>
			<td>redis.sentinel.password</td>
			<td>REDIS_SENTINEL_PASSWORD</td>
			<td></td>
			<td> 与Sentinel通信的密码</td>
		</tr>
		<tr>
			<td>redis.sentinel.useDefaultPoolConfig</td>
			<td>REDIS_USE_DEFAULT_POOL_CONFIG</td>
			<td>true</td>
			<td> 设为false时将使用pool config节中的值构建连接池配置</td>
		</tr>
		<tr>
			<td>redis.db</td>
			<td>REDIS_DB</td>
			<td>0</td>
			<td> 数据库索引</td>
		</tr>
		<tr>
			<td>redis.password</td>
			<td>REDIS_PASSWORD</td>
			<td></td>
			<td> 数据库密码</td>
		</tr>
		<tr>
			<td>redis.username</td>
			<td>REDIS_USERNAME</td>
			<td></td>
			<td> Redis ACL认证用户名(Redis 6.0+)。留空则使用传统仅密码认证</td>
		</tr>
		<tr>
			<td>redis.ssl.enabled</td>
			<td>TB_REDIS_SSL_ENABLED</td>
			<td>false</td>
			<td> 启用/禁用安全连接</td>
		</tr>
		<tr>
			<td>redis.ssl.credentials.cert_file</td>
			<td>TB_REDIS_SSL_PEM_CERT</td>
			<td></td>
			<td> Redis服务器(CA)证书路径</td>
		</tr>
		<tr>
			<td>redis.ssl.credentials.user_cert_file</td>
			<td>TB_REDIS_SSL_PEM_KEY</td>
			<td></td>
			<td> 用户证书文件路径。客户端可选，可用于客户端双向认证</td>
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
			<td> 连接池可分配的最大连接数</td>
		</tr>
		<tr>
			<td>redis.pool_config.maxIdle</td>
			<td>REDIS_POOL_CONFIG_MAX_IDLE</td>
			<td>128</td>
			<td> 池中可保持的最大空闲连接数（不关闭）</td>
		</tr>
		<tr>
			<td>redis.pool_config.minIdle</td>
			<td>REDIS_POOL_CONFIG_MIN_IDLE</td>
			<td>16</td>
			<td> 池中可保持的最小空闲连接数（不关闭）</td>
		</tr>
		<tr>
			<td>redis.pool_config.testOnBorrow</td>
			<td>REDIS_POOL_CONFIG_TEST_ON_BORROW</td>
			<td>false</td>
			<td> 借用连接时启用/禁用发送PING命令</td>
		</tr>
		<tr>
			<td>redis.pool_config.testOnReturn</td>
			<td>REDIS_POOL_CONFIG_TEST_ON_RETURN</td>
			<td>false</td>
			<td> 指定在将连接归还连接池前是否进行测试。</td>
		</tr>
		<tr>
			<td>redis.pool_config.testWhileIdle</td>
			<td>REDIS_POOL_CONFIG_TEST_WHILE_IDLE</td>
			<td>true</td>
			<td> 用于Redis连接池场景</td>
		</tr>
		<tr>
			<td>redis.pool_config.minEvictableMs</td>
			<td>REDIS_POOL_CONFIG_MIN_EVICTABLE_MS</td>
			<td>60000</td>
			<td> 空闲连接在被驱除出连接池前需空闲的最短时间（毫秒）</td>
		</tr>
		<tr>
			<td>redis.pool_config.evictionRunsMs</td>
			<td>REDIS_POOL_CONFIG_EVICTION_RUNS_MS</td>
			<td>30000</td>
			<td> 两次连续驱除运行之间的时间间隔（毫秒）</td>
		</tr>
		<tr>
			<td>redis.pool_config.maxWaitMills</td>
			<td>REDIS_POOL_CONFIG_MAX_WAIT_MS</td>
			<td>60000</td>
			<td> 当所有连接耗尽时，客户端愿意等待池中连接的最大时间（毫秒）</td>
		</tr>
		<tr>
			<td>redis.pool_config.numberTestsPerEvictionRun</td>
			<td>REDIS_POOL_CONFIG_NUMBER_TESTS_PER_EVICTION_RUN</td>
			<td>3</td>
			<td> 每次驱除运行期间待测试驱除的连接数</td>
		</tr>
		<tr>
			<td>redis.pool_config.blockWhenExhausted</td>
			<td>REDIS_POOL_CONFIG_BLOCK_WHEN_EXHAUSTED</td>
			<td>true</td>
			<td> 当线程从池请求连接但无可用连接且因maxTotal配置无法创建更多时，决定其行为</td>
		</tr>
	</tbody>
</table>


##  MQTT服务器参数

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>transport.mqtt.bind_address</td>
			<td>MQTT_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> MQTT绑定地址</td>
		</tr>
		<tr>
			<td>transport.mqtt.bind_port</td>
			<td>MQTT_BIND_PORT</td>
			<td>1883</td>
			<td> MQTT绑定端口</td>
		</tr>
		<tr>
			<td>transport.mqtt.proxy_enabled</td>
			<td>MQTT_PROXY_PROTOCOL_ENABLED</td>
			<td>false</td>
			<td> 启用代理协议支持。默认禁用。启用后支持v1和v2。可用于在日志中获取客户端真实IP及速率限制。</td>
		</tr>
		<tr>
			<td>transport.mqtt.timeout</td>
			<td>MQTT_TIMEOUT</td>
			<td>10000</td>
			<td> MQTT处理超时（毫秒）</td>
		</tr>
		<tr>
			<td>transport.mqtt.disconnect_timeout</td>
			<td>MQTT_DISCONNECT_TIMEOUT</td>
			<td>1000</td>
			<td> MQTT断开超时（毫秒）。服务器发送断开消息后等待客户端断开的时间。</td>
		</tr>
		<tr>
			<td>transport.mqtt.msg_queue_size_per_device_limit</td>
			<td>MQTT_MSG_QUEUE_SIZE_PER_DEVICE_LIMIT</td>
			<td>100</td>
			<td> 设备连接前队列中等待的消息数。该限制在TenantProfileLimits机制之前低层级生效</td>
		</tr>
		<tr>
			<td>transport.mqtt.gateway_metrics_report_interval_sec</td>
			<td>MQTT_GATEWAY_METRICS_REPORT_INTERVAL_SEC</td>
			<td>60</td>
			<td> 网关指标的定期上报间隔</td>
		</tr>
		<tr>
			<td>transport.mqtt.netty.leak_detector_level</td>
			<td>NETTY_LEAK_DETECTOR_LVL</td>
			<td>DISABLED</td>
			<td> Netty泄漏检测级别</td>
		</tr>
		<tr>
			<td>transport.mqtt.netty.boss_group_thread_count</td>
			<td>NETTY_BOSS_GROUP_THREADS</td>
			<td>1</td>
			<td> Netty BOSS线程数</td>
		</tr>
		<tr>
			<td>transport.mqtt.netty.worker_group_thread_count</td>
			<td>NETTY_WORKER_GROUP_THREADS</td>
			<td>12</td>
			<td> Netty worker线程数</td>
		</tr>
		<tr>
			<td>transport.mqtt.netty.max_payload_size</td>
			<td>NETTY_MAX_PAYLOAD_SIZE</td>
			<td>65536</td>
			<td> 最大载荷大小（字节）</td>
		</tr>
		<tr>
			<td>transport.mqtt.netty.so_keep_alive</td>
			<td>NETTY_SO_KEEPALIVE</td>
			<td>false</td>
			<td> 启用TCP keepalive。连接空闲一段时间后TCP开始发送keepalive探测</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.enabled</td>
			<td>MQTT_SSL_ENABLED</td>
			<td>false</td>
			<td> 启用/禁用SSL支持</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.bind_address</td>
			<td>MQTT_SSL_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> MQTT SSL绑定地址</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.bind_port</td>
			<td>MQTT_SSL_BIND_PORT</td>
			<td>8883</td>
			<td> MQTT SSL绑定端口</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.protocol</td>
			<td>MQTT_SSL_PROTOCOL</td>
			<td>TLSv1.2</td>
			<td> SSL协议：参见 https://docs.oracle.com/en/java/javase/11/docs/specs/security/standard-names.html#sslcontext-algorithms</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.type</td>
			<td>MQTT_SSL_CREDENTIALS_TYPE</td>
			<td>PEM</td>
			<td> 服务器凭证类型(PEM-pem证书文件;KEYSTORE-java keystore)</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.pem.cert_file</td>
			<td>MQTT_SSL_PEM_CERT</td>
			<td>mqttserver.pem</td>
			<td> 服务器证书文件路径（含服务器证书或证书链，可包含服务器私钥）</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.pem.key_file</td>
			<td>MQTT_SSL_PEM_KEY</td>
			<td>mqttserver_key.pem</td>
			<td> 服务器证书私钥文件路径。默认可选。若证书文件中无私钥则为必填；</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.pem.key_password</td>
			<td>MQTT_SSL_PEM_KEY_PASSWORD</td>
			<td>server_key_password</td>
			<td> 服务器证书私钥密码（可选）</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.keystore.type</td>
			<td>MQTT_SSL_KEY_STORE_TYPE</td>
			<td>JKS</td>
			<td> Keystore类型(JKS或PKCS12)</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.keystore.store_file</td>
			<td>MQTT_SSL_KEY_STORE</td>
			<td>mqttserver.jks</td>
			<td> 存放SSL证书的keystore路径</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.keystore.store_password</td>
			<td>MQTT_SSL_KEY_STORE_PASSWORD</td>
			<td>server_ks_password</td>
			<td> 访问keystore的密码</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.keystore.key_alias</td>
			<td>MQTT_SSL_KEY_ALIAS</td>
			<td></td>
			<td> 私钥的可选别名；未设置时平台将加载keystore中的第一个私钥；</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.credentials.keystore.key_password</td>
			<td>MQTT_SSL_KEY_PASSWORD</td>
			<td>server_key_password</td>
			<td> 访问密钥的密码</td>
		</tr>
		<tr>
			<td>transport.mqtt.ssl.skip_validity_check_for_client_cert</td>
			<td>MQTT_SSL_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT</td>
			<td>false</td>
			<td> 跳过客户端证书的有效性检查。</td>
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
			<td> 启用/禁用传输统计收集</td>
		</tr>
		<tr>
			<td>transport.stats.print-interval-ms</td>
			<td>TB_TRANSPORT_STATS_PRINT_INTERVAL_MS</td>
			<td>60000</td>
			<td> 传输统计日志间隔</td>
		</tr>
		<tr>
			<td>transport.client_side_rpc.timeout</td>
			<td>CLIENT_SIDE_RPC_TIMEOUT</td>
			<td>60000</td>
			<td> 客户端侧RPC命令处理超时间隔（毫秒）</td>
		</tr>
		<tr>
			<td>transport.rate_limits.ip_limits_enabled</td>
			<td>TB_TRANSPORT_IP_RATE_LIMITS_ENABLED</td>
			<td>false</td>
			<td> 启用或禁用通用速率限制。设备和租户特定速率限制在租户配置文件中控制。</td>
		</tr>
		<tr>
			<td>transport.rate_limits.max_wrong_credentials_per_ip</td>
			<td>TB_TRANSPORT_MAX_WRONG_CREDENTIALS_PER_IP</td>
			<td>10</td>
			<td> 使用无效凭据的最大连接尝试次数</td>
		</tr>
		<tr>
			<td>transport.rate_limits.ip_block_timeout</td>
			<td>TB_TRANSPORT_IP_BLOCK_TIMEOUT</td>
			<td>60000</td>
			<td> IP封禁过期超时</td>
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
			<td> 默认topic名</td>
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
