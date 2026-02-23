API & Rate Limits 功能通过限制单个 host/device/tenant 在单位时间（分钟、小时等）内的请求数来控制 API 使用量。

API & Rate limits **默认关闭**。系统管理员可通过 [thingsboard.yml](/docs/user-guide/install/{{docsPrefix}}config/) 配置 rate limits。

## REST API limits（REST API 限制）

REST API 调用被各类 UI 组件及可能代表客户用户或租户用户运行的自动脚本使用。
限制租户或客户的 API 调用量至关重要，以避免因自定义部件或脚本错误导致服务器过载。

*rest.limits.tenant.enabled* 参数或 *TB_SERVER_REST_LIMITS_TENANT_ENABLED* 环境变量用于启用/禁用租户级限制。

*rest.limits.tenant.configuration* 参数或 *TB_SERVER_REST_LIMITS_TENANT_CONFIGURATION* 环境变量用于配置 REST API 调用的最大数量。
例如，值 "100:1,2000:60" 表示每秒不超过 100 次请求、每分钟不超过 2000 次请求。

```yaml
server:
  ...
  rest:
    limits:
      tenant:
        enabled: "${TB_SERVER_REST_LIMITS_TENANT_ENABLED:false}"
        configuration: "${TB_SERVER_REST_LIMITS_TENANT_CONFIGURATION:100:1,2000:60}"
      customer:
        enabled: "${TB_SERVER_REST_LIMITS_CUSTOMER_ENABLED:false}"
        configuration: "${TB_SERVER_REST_LIMITS_CUSTOMER_CONFIGURATION:50:1,1000:60}"
```

## Websocket limits（Websocket 限制）

Websocket 用于将设备的新 telemetry 值实时推送到 dashboard。

*ws.send_timeout* 参数或 *TB_SERVER_WS_SEND_TIMEOUT* 环境变量控制 Websocket 消息成功送达客户端的最大时间。若客户端过慢，会话将被关闭。

*ws.limits.max_queue_per_ws_session* 参数或 *TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_QUEUE_PER_WS_SESSION* 环境变量控制等待发送给客户端的最大消息数。若客户端过慢，会话将被关闭。

*ws.limits.max_sessions_per_\** 参数或 *TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SESSIONS_PER_\** 环境变量控制每类实体（tenant、customer、public 或 regular user）的最大活动连接数。
若某类实体的会话数过多，新连接将被拒绝。

*ws.limits.max_subscriptions_per_\** 参数或 *TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SUBSCRIPTIONS_PER_\** 环境变量控制每类实体所有会话中的最大活动订阅数。
若某类实体的订阅数过多，将不再接受新订阅。

*ws.limits.max_updates_per_session* 参数或 *TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_UPDATES_PER_SESSION* 环境变量配置每个会话从服务器发送给客户端的最大消息数。
例如，值 "300:1,3000:60" 表示每秒不超过 300 次更新、每分钟不超过 3000 次更新。

示例配置如下：

```yaml
server:
  ...
  ws:
    send_timeout: "${TB_SERVER_WS_SEND_TIMEOUT:5000}"
    limits:
      # Limit the amount of sessions and subscriptions available on each server. Put values to zero to disable particular limitation
      max_sessions_per_tenant: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SESSIONS_PER_TENANT:0}"
      max_sessions_per_customer: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SESSIONS_PER_CUSTOMER:0}"
      max_sessions_per_regular_user: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SESSIONS_PER_REGULAR_USER:0}"
      max_sessions_per_public_user: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SESSIONS_PER_PUBLIC_USER:0}"
      max_queue_per_ws_session: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_QUEUE_PER_WS_SESSION:500}"
      max_subscriptions_per_tenant: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SUBSCRIPTIONS_PER_TENANT:0}"
      max_subscriptions_per_customer: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SUBSCRIPTIONS_PER_CUSTOMER:0}"
      max_subscriptions_per_regular_user: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SUBSCRIPTIONS_PER_REGULAR_USER:0}"
      max_subscriptions_per_public_user: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_SUBSCRIPTIONS_PER_PUBLIC_USER:0}"
      max_updates_per_session: "${TB_SERVER_WS_TENANT_RATE_LIMITS_MAX_UPDATES_PER_SESSION:300:1,3000:60}"
```

## Database rate limits（数据库 rate limits）

尽管已对 REST API 调用量进行限制，但部分调用可能产生多次数据库查询。rule chains 在消息处理期间同样可能产生大量查询。
单次 telemetry 上传也会产生数据库查询以将数据写入 DB。

可针对 Cassandra DB 指定限制，并可配置打印统计信息的参数。例如：

```log
2018-11-29 10:51:25,020 [SockJS-1] INFO  o.t.s.d.n.CassandraBufferedRateExecutor - 
Permits queueSize [0] totalAdded [6395] totalLaunched [6395] totalReleased [6396] totalFailed [0] totalExpired [0] 
totalRejected [0] totalRateLimited [0] totalRateLimitedTenants [0] currBuffer [0]
```  

可选：可配置打印超出阈值的租户名称。

*cassandra.query.tenant_rate_limits.configuration* 参数或 *CASSANDRA_QUERY_TENANT_RATE_LIMITS_CONFIGURATION* 环境变量用于配置每个租户的最大查询数。
例如，值 "1000:1,30000:60" 表示每秒不超过 1000 次更新、每分钟不超过 30000 次更新。


```yaml
# Cassandra driver configuration parameters
cassandra:
  ...
  # Cassandra cluster connection query parameters
  query:
  ...
    rate_limit_print_interval_ms: "${CASSANDRA_QUERY_RATE_LIMIT_PRINT_MS:10000}"
    tenant_rate_limits:
      enabled: "${CASSANDRA_QUERY_TENANT_RATE_LIMITS_ENABLED:false}"
      configuration: "${CASSANDRA_QUERY_TENANT_RATE_LIMITS_CONFIGURATION:1000:1,30000:60}"
      print_tenant_names: "${CASSANDRA_QUERY_TENANT_RATE_LIMITS_PRINT_TENANT_NAMES:false}"
```

## Transport rate limits（Transport rate limits）

限制来自单个设备或某租户下所有设备的消息数量非常重要。
此限制在 transport 层生效，在消息推送到 rule engine 之前应用。

*transport.rate_limits.tenant.configuration* 参数或 *TB_TRANSPORT_RATE_LIMITS_TENANT* 环境变量用于配置每个租户所有设备的最大消息数。
例如，值 "1000:1,20000:60" 表示每秒不超过 1000 条消息、每分钟不超过 20000 次更新。

*transport.rate_limits.device.configuration* 参数或 *TB_TRANSPORT_RATE_LIMITS_DEVICE* 环境变量用于配置单个设备的最大消息数。
例如，值 "10:1,300:60" 表示每秒不超过 10 条消息、每分钟不超过 300 次更新。


```yaml
transport:
...
  rate_limits:
    enabled: "${TB_TRANSPORT_RATE_LIMITS_ENABLED:false}"
    tenant: "${TB_TRANSPORT_RATE_LIMITS_TENANT:1000:1,20000:60}"
    device: "${TB_TRANSPORT_RATE_LIMITS_DEVICE:10:1,300:60}"
```

## Next steps（下一步）

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
