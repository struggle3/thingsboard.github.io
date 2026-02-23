
* TOC
{:toc}

本功能说明 TBMQ 如何向 MQTT 订阅者投递消息。当客户端订阅某个主题并有新的匹配消息发布时，
TBMQ 使用其底层网络层 **Netty** 将消息投递给订阅者。

Netty 提供两种通过网络信道发送消息的主要方式：
- `writeAndFlush()`：发送消息并立即刷新信道，立即将数据推到网络。
- `write()`（不带 `flush()`）：将消息写入信道缓冲区，但不立即发送。数据保持在缓冲区中，直到单独调用 `flush()`。

TBMQ 利用此能力提供两种 **投递策略**：
- **每条消息立即写入并刷新**；
- **缓冲消息并定期或按数量刷新**。

这些策略可为 [两类客户端](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/) 配置：
- **设备客户端**（非持久和持久客户端）；
- **应用客户端**（持久客户端）。


## 每条消息立即写入并刷新

- **行为**：TBMQ 对发送给订阅者的每条消息调用 `writeAndFlush()`。
- **优点**：
    - 保证低延迟，消息一旦就绪即投递。
    - 简单可靠，适合低吞吐量场景。
- **缺点**：
    - 高负载下 CPU 和 I/O 开销高。
    - 过多刷新可能导致性能瓶颈。

## 缓冲投递（仅写入不刷新）

- **行为**：TBMQ 使用 `write()` 将消息加入 Netty 信道缓冲区。`flush()` 在以下情况触发：
    - 缓冲消息数达到配置的 `buffered-msg-count`。
    - 若会话在 `idle-session-flush-timeout-ms` 指定的时间内空闲（即在此期间未向订阅者发送新消息），则自动刷新缓冲区。此行为仅适用于设备客户端。
- **优点**：
    - 显著减少刷新次数，提高吞吐量。
    - 在高负载或突发流量下更高效。
- **缺点**：
    - 可能引入投递延迟，尤其在消息发布不频繁的低吞吐量场景。

## 配置

可通过应用属性分别为 **设备客户端** 和 **应用客户端** 配置策略。

### 设备客户端

```yaml
# If enabled, each message is published to non-persistent subscribers with flush. When disabled, the messages are buffered in the channel and are flushed once in a while
write-and-flush: "${MQTT_MSG_WRITE_AND_FLUSH:true}"
# Number of messages buffered in the channel before the flush is made. Used when `MQTT_MSG_WRITE_AND_FLUSH` = false
buffered-msg-count: "${MQTT_BUFFERED_MSG_COUNT:5}"

# If enabled, each message is published to persistent DEVICE client subscribers with flush. When disabled, the messages are buffered in the channel and are flushed once in a while
persistent-session.device.write-and-flush: "${MQTT_PERSISTENT_MSG_WRITE_AND_FLUSH:true}"
# Number of messages buffered in the channel before the flush is made. Used when `MQTT_PERSISTENT_MSG_WRITE_AND_FLUSH` = false
persistent-session.device.buffered-msg-count: "${MQTT_PERSISTENT_BUFFERED_MSG_COUNT:5}"
```

### 缓冲投递额外设置（设备客户端）

启用消息缓冲后，TBMQ 维护活跃客户端会话缓存以跟踪缓冲消息并决定何时刷新。
以下参数定义缓存大小、过期策略以及根据活动或阈值刷新消息缓冲区的调度器行为。

```yaml
# When either `MQTT_MSG_WRITE_AND_FLUSH` or `MQTT_PERSISTENT_MSG_WRITE_AND_FLUSH` is set to false,
# the broker buffers outgoing messages in the outbound channel to improve throughput.
# The respective buffer sizes are controlled by `MQTT_BUFFERED_MSG_COUNT` (for non-persistent clients)
# and `MQTT_PERSISTENT_BUFFERED_MSG_COUNT` (for persistent clients).
# This property defines the maximum number of session entries that can be stored in the flush state cache.
# When the cache exceeds this size, the least recently used sessions are evicted
# and their pending message buffers are flushed automatically
session-cache-max-size: "${MQTT_BUFFERED_CACHE_MAX_SIZE:10000}"
# Time in milliseconds after which an inactive session entry in the flush cache expires.
# A session is considered inactive if it receives no new messages during this period.
# Upon expiration, the session is evicted from the cache and its buffer is flushed.
# Default is 5 minutes
session-cache-expiration-ms: "${MQTT_BUFFERED_CACHE_EXPIRY_MS:300000}"
# Interval in milliseconds at which the scheduler checks all sessions in the cache
# for potential flushing. A smaller value results in more frequent flush checks
scheduler-execution-interval-ms: "${MQTT_BUFFERED_SCHEDULER_INTERVAL_MS:100}"
# Maximum duration in milliseconds that a session can remain idle (i.e., without being flushed)
# before its message buffer is automatically flushed to the client.
# In essence, a flush occurs either when the buffer limit is reached or when this timeout elapses
idle-session-flush-timeout-ms: "${MQTT_BUFFERED_IDLE_FLUSH_MS:200}"
```

### 应用客户端

```yaml
# If enabled, each message is published to persistent APPLICATION client subscribers with flush. When disabled, the messages are buffered in the channel and are flushed once in a while
write-and-flush: "${MQTT_APP_MSG_WRITE_AND_FLUSH:false}"
# Number of messages buffered in the channel before the flush is made. Used when `MQTT_APP_MSG_WRITE_AND_FLUSH` = false
buffered-msg-count: "${MQTT_APP_BUFFERED_MSG_COUNT:10}"
```

## 工作原理

当 **设备客户端** 会话活跃且启用缓冲时：

1. **会话缓冲区创建**
   TBMQ 在缓存中存储会话状态，使用 `SessionFlushState` 对象保存：
    - 缓冲消息计数。
    - 上次刷新时间戳。
    - 客户端的 Netty 信道上下文。

2. **仅写入不刷新**
   投递消息时：
    - 使用 `channel.write()` 写入，不立即刷新。
    - 缓冲区计数递增。

3. **刷新触发**
   以下任一情况会触发刷新：
    - **缓冲数量** 达到配置阈值（如 5）。
    - **会话空闲** 超过配置的超时时间。
    - **会话被驱逐** 出缓存（过期或达到最大容量），待处理消息被刷新以避免数据丢失。

4. **调度后台刷新**
   后台线程定期扫描缓存并刷新空闲会话缓冲区。

5. **关闭处理**
   服务关闭时，所有缓冲会话会被刷新以确保消息投递一致性。

对于 **应用客户端**，缓冲投递在批量消息处理期间应用。

- 使用 `write()` 将消息写入 Netty 信道，不立即刷新。
- 在写入 **配置数量的消息**（`buffered-msg-count`，默认 10）后触发刷新。
- 整个批次处理完成后，**显式刷新所有剩余未刷新消息**。
- 此方式避免基于空闲时间的刷新，适用于高吞吐量批量投递场景。

此策略之所以可行，是因为每个应用客户端在专用线程（消费者）中处理，从专用 Kafka topic 拉取消息，允许 TBMQ 独立控制每个客户端的刷新。
该设计在不依赖共享缓存或后台调度器的前提下实现精确批处理和刷新，兼顾可扩展性和消息投递一致性。

## 建议

选择合适的消息投递策略取决于工作负载特征、性能目标和客户端行为。以下为实用建议。

**在以下情况使用 `write-and-flush = true`（无缓冲）：**

- 优先考虑 **低延迟** 而非吞吐量。
- 系统 **消息率较低或中等**。
- 客户端需要 **即时投递**（如实时仪表板、告警）。
- 简洁和可预测性比原始性能更重要。

**在以下情况使用 `write-and-flush = false`（缓冲投递）：**

- 存在 **高吞吐量** 且 **发布频繁** 的工作负载。
- 需要降低 **系统调用开销和 I/O 压力**。
- 客户端可接受轻微投递延迟以换取更高效率。
- 需要 **扩展到数千客户端** 而不使 CPU 或网络饱和。

### 调优建议

- 从 **5–10** 的 `buffered-msg-count` 开始，再根据 profiling 调整。
- 对于设备客户端，调整 `idle-session-flush-timeout-ms` 以平衡延迟与及时投递。
- 监控日志中的缓存驱逐和刷新时间，定位性能瓶颈。
- 若在低吞吐量下消息经常延迟，可考虑启用立即刷新。

### 建议汇总

| 场景                           | 推荐设置                      |
|------------------------------------|------------------------------------------|
| 低延迟、实时投递    | `write-and-flush = true`                 |
| 高消息量                | `write-and-flush = false`，并调优   |
| 基于批量的应用处理 | 自定义 count 的应用缓冲  |
| 低频消息             | 避免缓冲以防延迟        |

> 在单节点 TBMQ 每秒 300 万条消息（3M msg/sec）的性能测试中，我们启用缓冲投递以最大化吞吐量和整体系统性能。
> 该配置显著降低 CPU 开销并改善延迟，在高负载下实现更高效的消息处理。
> 详见 [性能测试结果](/docs/{{docsPrefix}}mqtt-broker/reference/3m-throughput-single-node-performance-test/) 和
> [配置详情](https://github.com/thingsboard/tbmq/blob/3M-single-node-perf-test/k8s/aws/tb-broker-configmap.yml)。

## 总结

缓冲消息投递机制提供智能且灵活的方式，用于管理 TBMQ 中向 MQTT 订阅者发送消息的方式。通过利用 Netty 延迟刷新的能力，TBMQ 可显著减少 I/O 开销并在高要求环境中提高吞吐量。

**选择最适合部署需求的投递策略：**
- 在低延迟、低吞吐量场景使用 **write-and-flush**。
- 在性能优化至关重要的高吞吐量工作负载下启用 **缓冲**。

该功能确保 MQTT 消息投递管道保持高效、可靠，并能适应不同的客户端行为和系统负载。
