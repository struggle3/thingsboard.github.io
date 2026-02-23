* TOC
{:toc}

TBMQ 提供友好的工具，让用户可以通过**首页**和**监控**页面监控 broker 活动并便捷访问各项功能。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/home-page.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/home-page.png)
{% endif %}

## 图表

在**首页**顶部，您会看到六组图表，显示最近 10 分钟内 broker 活动的关键信息：
  - **入站消息。** 该图表显示 MQTT 客户端向 broker 发布的消息数量。
  - **出站消息。** 此处可查看 broker 向订阅客户端投递的消息数量。
  - **丢弃消息。** 该图表表示因缺少订阅者或因网络问题、客户端断开、资源限制等原因无法投递到订阅者的消息。
  - **会话。** 该图表表示当前 MQTT 会话数量。
  - **订阅。** 该图表显示当前订阅数量。
  - **网络流量。** 该图表展示 MQTT 客户端处理、发送或接收的数据大小。

请注意，在监控页面上，用户可以更深入地查看图表数据。
您可以放大特定区域、设置自定义日期范围以显示数据，或将图表以全屏模式打开。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/monitoring-page.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/monitoring-page.png)
{% endif %}

## 会话

会话卡片提供已连接和已断开会话的概览。
用户可前往 [Sessions](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/sessions/) 页面查看这些会话的完整信息，包括状态、持续时间和其它详情。

## 凭据

系统显示按两种类型分类的客户端凭据数量：**Device** 和 **Application**。
有关凭据类型的更多信息，请参阅[文档](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/)。

![image](/images/mqtt-broker/user-guide/ui/sessions-credentials-card.png)
 
## 配置

包含常用配置参数的信息：
  - **Basic 认证。** 通过开关按钮启用/禁用该认证方式。
  - **X.509 证书链认证。**
  - **JWT 认证。**
  - **SCRAM 认证。**
  - **TCP 端口。** 默认在 `1883` 端口启用 TCP 监听器。可设置 `LISTENER_TCP_BIND_PORT` 环境变量修改端口。
  - **TLS 端口。** 默认在 `8883` 端口禁用 SSL/TLS 监听器。可设置 `LISTENER_SSL_BIND_PORT` 环境变量修改默认端口。
  - **WS 端口。** 默认在 `8084` 端口启用 WS 监听器。可设置 `LISTENER_WS_BIND_PORT` 环境变量修改端口。
  - **WSS 端口。** 默认在 `8085` 端口禁用 WSS 监听器。可设置 `LISTENER_WSS_BIND_PORT` 环境变量修改端口。
  - **TCP 监听器。** 默认启用。设为 `false` 可禁用：设置环境变量 `LISTENER_TCP_ENABLED`。
  - **TLS 监听器。** 默认禁用。设置 `LISTENER_SSL_ENABLED` 环境变量为 `true` 可启用 SSL/TLS 监听器。
  - **WS 监听器。** 默认启用。设置 `LISTENER_WS_ENABLED` 环境变量为 `false` 可禁用。
  - **WSS 监听器。** 默认禁用。设置 `LISTENER_WSS_ENABLED` 环境变量为 `true` 可启用。
  - **TCP 监听器最大负载大小。** 该参数定义 TCP 消息中允许的最大负载大小，默认 `65536` 字节。可设置 `TCP_NETTY_MAX_PAYLOAD_SIZE` 环境变量（单位：字节）修改。
  - **TLS 监听器最大负载大小。** 与 TCP 监听器类似，该参数指定 SSL/TLS 加密消息中允许的最大负载大小，默认 `65536` 字节。可设置 `SSL_NETTY_MAX_PAYLOAD_SIZE` 环境变量（单位：字节）修改。
  - **WS 监听器最大负载大小。** 指定 WS 消息中允许的最大负载大小，默认 `65536` 字节。可设置 `WS_NETTY_MAX_PAYLOAD_SIZE` 环境变量（单位：字节）修改。
  - **WSS 监听器最大负载大小。** 定义 WSS 加密消息中允许的最大负载大小，默认 `65536` 字节。可设置 `WSS_NETTY_MAX_PAYLOAD_SIZE` 环境变量（单位：字节）修改。

![image](/images/mqtt-broker/user-guide/ui/config-card.png)

## Kafka Brokers

显示 Kafka Brokers 的基本信息：
- **Address。** Kafka broker 地址。
- **Size。** broker 上存储的数据大小。

![image](/images/mqtt-broker/user-guide/ui/kafka-brokers-card.png)

## Kafka Topics

显示 Kafka Topics 的基本信息：
- **Name。** Kafka topic 名称。
- **Partitions。** topic 分区数。
- **Replicas。** topic 副本因子。
- **Size。** topic 大小。

![image](/images/mqtt-broker/user-guide/ui/kafka-topics-card.png)

## Kafka Consumer Groups

显示 Kafka Consumer Groups (CG) 的基本信息：
- **ID。** Consumer Group ID。
- **State。** CG 状态，可为 `STABLE`、`PREPARING_REBALANCE`、`COMPLETING_REBALANCE`、`EMPTY`、`DEAD` 或 `UNKNOWN`。
- **Members。** CG 中的消费者数量。
- **Lag。** 组内所有消费者 lag 的总和。Consumer lag 是消费者最后提交的 offset 与生产者末端 offset 之间的差值。

![image](/images/mqtt-broker/user-guide/ui/kafka-consumer-groups-card.png)

## 资源使用统计

TBMQ 为各服务实例提供运行时的资源使用统计。这些指标有助于监控系统行为，并在不同环境（VM、容器、物理机）中支持调试或优化。

{% capture resource-usage-note %}
系统指标使用 OSHI Java 库采集，该库直接从主机环境获取硬件和操作系统统计信息。
{% endcapture %}
{% include templates/info-banner.md content=resource-usage-note %}

系统指标按周期采集并保存。默认每 **60 秒**更新一次系统信息，间隔由配置定义：

```yaml
# 系统信息（CPU、内存使用等）持久化频率（秒）
persist-frequency: "${STATS_SYSTEM_INFO_PERSIST_FREQUENCY_SEC:60}"
```

资源使用表包含每项服务的以下信息：
* **Last update time**。 最近一次指标更新的时间戳。
* **Service ID**。 服务实例标识符。
* **Service type**。 服务类型（如 TBMQ、Integration Executor）。
* **CPU**。 CPU 负载百分比（悬停可查看可用 CPU 核心数）。
* **RAM**。 物理内存使用百分比（悬停可查看总内存 GB 数）。
* **Disk**。 磁盘空间使用百分比（悬停可查看总磁盘容量 GB 数）。
* **Status**。 表示最近一次更新的新旧程度。
    - `Active` - 1 小时内上报。
    - `Inactive` - 1 小时至 1 周内上报。
    - `Outdated` - 超过 1 周前上报。

TBMQ 使用 Redis 中的 `tbmq:service:registry` 键跟踪所有已注册服务。
后续用于获取资源使用数据的每个 **Service ID** 作为 Redis hash 的一部分存储在该键中。
服务在首次启动时自动加入注册表，存储的元数据有助于识别哪些服务当前可用于系统指标上报。

该键不受 TTL 管理，条目会无限期存储。TBMQ 不会自动从注册表中移除已停止运行的服务。
您可在 UI 中手动删除服务（或使用 REST API），仅当服务状态为 `Outdated` 时显示 "Delete" 按钮。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/resource-usage.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/resource-usage.png)
{% endif %}
