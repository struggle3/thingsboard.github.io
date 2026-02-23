#### 高级配置

下方 yml 配置列出了可用参数、对应环境变量及默认值。
例如，集成调试消息中使用的默认客户端 ID 为 *"remote"*，
可通过设置 *"RPC_CLIENT_ID"* 环境变量修改。

```bash
server:
  # 服务绑定地址
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
  # 服务绑定端口
  port: "${HTTP_BIND_PORT:8082}"

integration:
  routingKey: "${INTEGRATION_ROUTING_KEY:PUT_YOUR_ROUTING_KEY_HERE}"
  secret: "${INTEGRATION_SECRET:PUT_YOUR_SECRET_HERE}"
  # 允许连接 localhost 资源，如本地 MQTT broker 等
  allow_local_network_hosts: "${INTEGRATION_ALLOW_LOCAL_NETWORK_HOSTS:true}"
  statistics:
    # 启用/禁用集成统计
    enabled: "${INTEGRATION_STATISTICS_ENABLED:true}"
    # 统计发送间隔，默认每小时一次
    persist_frequency: "${INTEGRATION_STATISTICS_PERSIST_FREQUENCY:3600000}"

storage:
  # 数据文件存储目录
  data_folder_path: "${INTEGRATION_STORAGE_DATA_FOLDER_PATH:./}"
  # 最多保留的数据文件数量
  max_file_count: "${INTEGRATION_STORAGE_MAX_FILE_COUNT:100}"
  # 每个数据文件最大记录数
  max_records_per_file: "${INTEGRATION_STORAGE_MAX_RECORDS_PER_FILE:30}"
  # 数据文件持久化之间的最大记录数
  max_records_between_fsync: "${INTEGRATION_STORAGE_MAX_RECORDS_BETWEEN_FSYNC:100}"
  # 上传块大小
  max_read_records_count: "${INTEGRATION_STORAGE_MAX_READ_RECORDS_COUNT:50}"
  # 无新记录时的休眠间隔
  no_read_records_sleep: "${INTEGRATION_STORAGE_NO_READ_RECORDS_SLEEP:1000}"

executors:
  # 处理消息和任务的线程池大小
  thread_pool_size: "${EXECUTORS_SIZE:1}"
  # 重连 ThingsBoard 的超时（毫秒）
  reconnect_timeout: "${EXECUTORS_RECONNECT_TIMEOUT:3000}"

rpc:
  # ThingsBoard 服务主机
  host: "${RPC_HOST:thingsboard.cloud}"
  # ThingsBoard 服务端口
  port: "${RPC_PORT:9090}"
  # 无回复超时（秒），用于通道终止
  timeout: "${RPC_TIMEOUT:5}"
  # RPC 客户端 ID
  client_id: "${RPC_CLIENT_ID:remote}"
  ssl:
    # 启用/禁用 SSL
    enabled: "${RPC_SSL_ENABLED:false}"
    # SSL 证书
    cert: "${RPC_SSL_CERT:roots.pem}"

js:
  evaluator: "${JS_EVALUATOR:local}"
  # 内置 JVM JavaScript 环境属性
  local:
    # 使用沙箱（安全）JVM JavaScript 环境
    use_js_sandbox: "${USE_LOCAL_JS_SANDBOX:true}"
    # JavaScript 沙箱资源监控线程池大小
    monitor_thread_pool_size: "${LOCAL_JS_SANDBOX_MONITOR_THREAD_POOL_SIZE:4}"
    # 脚本执行允许的最大 CPU 时间（毫秒）
    max_cpu_time: "${LOCAL_JS_SANDBOX_MAX_CPU_TIME:5000}"
    # JavaScript 被列入黑名单前的最大执行错误数
    max_errors: "${LOCAL_JS_SANDBOX_MAX_ERRORS:3}"

service:
  type: "${TB_SERVICE_TYPE:tb-integration}"
``` 
{: .copy-code.expandable-10}