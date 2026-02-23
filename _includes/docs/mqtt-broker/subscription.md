TBMQ 专业版基于**灵活按需计费**模式提供专用[私有云](/pricing/?section=tbmq-options&product=tbmq-private-cloud)实例。
我们的交互式计算器可让您定义所需容量，按需付费。
核心容量确定后，私有 broker 实例将按以下**默认与可配置限制**运行。
除另有说明外，数值均为月度限制。

<table>
  <thead>
      <tr>
          <td><b>参数名</b></td>
          <td><b>值</b></td>
          <td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>Sessions</td>
          <td>From 5K to Unlimited</td>
          <td>Broker 管理的最大客户端会话数，包括活跃连接及暂时断开但由 broker 保留用于快速重连的持久化会话。会话过期或被显式移除后不再计入会话限制，该槽位可供新会话使用</td>
      </tr>
      <tr>
          <td>Throughput (msg/sec)</td>
          <td>From 1K to Unlimited</td>
          <td>每秒处理的消息总吞吐量，包括入站和出站的 `MQTT_PUBLISH` 包。不包含 QoS 1 和 2 流程中的确认包（如 `PUBACK`、`PUBREC` 等），也不包含 `CONNECT`、`SUBSCRIBE`、`UNSUBSCRIBE` 等 MQTT 控制包</td>
      </tr>
      <tr>
          <td>Monthly traffic</td>
          <td>From 200 GB to Unlimited</td>
          <td>月度流量指通过 TBMQ broker 传输的数据总量，包括入站和出站 MQTT 消息。流量按客户端发送和接收的所有 MQTT 包 payload 之和计算。超出月度额度后，额外使用按 $0.1/GB 计费</td>
      </tr>
      <tr>
          <td>Application topic size</td>
          <td>1 GB</td>
          <td>用于为断开连接的 Application 客户端存储持久化消息的 Kafka topic 最大大小。每个客户端有独立 topic，消息保留至投递或达到大小限制</td>
      </tr>
      <tr>
          <td>Application topic TTL</td>
          <td>1 day</td>
          <td>为 Application 客户端存储在 Kafka topics 中的消息的存活时间。若客户端在此时间内保持断开，未投递消息将被自动丢弃</td>
      </tr>
      <tr>
          <td>Integration topic size</td>
          <td>1 GB</td>
          <td>用于为断开连接的 Integration 存储持久化消息的 Kafka topic 最大大小。每个 Integration 有独立 topic，消息保留至投递或达到大小限制</td>
      </tr>
      <tr>
          <td>Integration topic TTL</td>
          <td>1 day</td>
          <td>为每个 Integration 存储在专用 Kafka topics 中的消息的存活时间。若 Integration 在此时间内保持断开，未投递消息将被自动丢弃</td>
      </tr>
      <tr>
          <td>Messages storage for default ('Device') persistent sessions</td>
          <td>100 per session</td>
          <td>每个具有持久化会话的 Device 客户端离线时可存储的最大消息数。达到限制后，旧消息将被丢弃以腾出空间</td>
      </tr>
      <tr>
          <td>Device persisted messages TTL</td>
          <td>1 day</td>
          <td>Device 持久化客户端离线时为其存储的消息的存活时间参数</td>
      </tr>
      <tr>
          <td>Stats TTL</td>
          <td>1 month</td>
          <td>统计持久化的存活时间参数。包括 UI 可见的指标：sessions、subscriptions、入站消息、出站消息等</td>
      </tr>
      <tr>
          <td>Session TTL</td>
          <td>1 day</td>
          <td>已断开持久化会话的存活时间参数。若客户端在此时间内保持断开，其会话数据将被 broker 自动移除</td>
      </tr>
      <tr>
          <td>Client incoming messages rate limit</td>
          <td>Up to 50 per second, not exceeding 3000 per minute</td>
          <td>每个发布者客户端任意 Quality of Service (QoS) 级别的入站消息总数</td>
      </tr>
      <tr>
          <td>Client outgoing messages rate limit</td>
          <td>Up to 50 per second, not exceeding 3000 per minute</td>
          <td>每个非持久化订阅者客户端 Quality of Service (QoS) 为 0（"AT_MOST_ONCE"）时的出站消息总数</td>
      </tr>
      <tr>
          <td>In-flight messages per publisher</td>
          <td>100</td>
          <td>来自发布者的入站 QoS 1 和 QoS 2 消息在等待确认时的最大数量。消息由 broker 成功持久化后发送确认。超过此限制时，客户端将被断开以防止过载</td>
      </tr>
      <tr>
          <td>Client pre-connect messages</td>
          <td>100</td>
          <td>broker 在连接握手阶段为每个客户端排队的最大消息数。若客户端完成连接前超过此限制，客户端将被断开</td>
      </tr>
      <tr>
          <td>Message size</td>
          <td>1 MB</td>
          <td>broker 接受的 MQTT_PUBLISH 包中 payload 的最大大小。超出大小的消息将被拒绝</td>
      </tr>
      <tr>
          <td>Uptime SLA</td>
          <td>99.9% or 99.99%</td>
          <td>表示 broker 预期完全运行且可访问的时间百分比</td>
      </tr>
  </tbody>
</table>

其中 "**K**" 表示一千，"**M**" 表示一百万，"**B**" 表示十亿。
