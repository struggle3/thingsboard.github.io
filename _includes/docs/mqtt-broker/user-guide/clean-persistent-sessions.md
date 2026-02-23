
* TOC
{:toc}

**MQTT 会话**是核心概念，使 MQTT 客户端与 MQTT Broker 之间即使在不稳定网络中也能可靠通信。在 IoT 环境中尤其重要，因为设备可能因省电模式、连接问题或网络变化而断开并重连。

MQTT 会话存储 **客户端** 与 **Broker** 之间的交互相关状态。客户端重连时可复用该状态，使通信得以继续而无需从头重新初始化。

可将 MQTT 会话类比为酒店预订。
- **持久**会话就像「预订房间」：即使外出用餐（断开），行李（订阅和未送达消息）仍留在房间等你回来。
- **非持久**会话就像「临时入住」：离开大堂后，酒店不会保留你的任何信息。

## 持久会话

持久会话在客户端断开后保留会话状态，客户端重连时可恢复订阅和排队消息。

- 消息仅在会话活跃期间保留。若会话在重连前过期，任何排队消息将被丢弃。
- 此模式提高可靠性，但引入额外的确认和存储，增加系统复杂度。
- 持久会话需要 **固定 Client ID**，以便 Broker 正确恢复会话状态。
- **离线消息投递仅适用于持久会话**，且发布者和订阅者均需使用 **QoS 1** 或 **QoS 2**。对于不可接受消息丢失的应用，始终将持久会话与 **QoS 1** 或 **QoS 2** 结合使用（[QoS 文档](/docs/{{docsPrefix}}mqtt-broker/user-guide/qos/)）。

以下 **信息可作为持久会话的一部分存储**，并在会话过期或显式清除时移除：

- 会话及其关联的 **Client ID** 的存在
- 活跃 **订阅**，包括 Topic Filter 和 Subscription Identifier
- 等待投递给客户端的 **排队消息**（QoS 1 和 QoS 2）
- 已发送但未完全确认的 **传输中消息**（QoS 1 和 QoS 2）
- 从客户端接收但尚未完全确认的 QoS 2 消息
- 配置的 **Will Message** 和 **Will Delay Interval**
- **Session Expiry Interval** 及计算出的会话过期时间
- 重连后正确恢复消息流所需的内部投递状态

## 非持久会话

非持久（clean）会话始终以全新状态开始。客户端断开时，Broker 不保留任何会话状态。

- 订阅不被保留，每次连接时必须重新创建。
- 客户端离线期间发布的消息不会被存储或事后投递。
- 此模式开销最小，不需要消息确认或会话存储。
- Clean 会话通常与 **QoS 0** 一起使用（也可用于更高 QoS），在低延迟和简单性比保证投递更重要时适用。

## Broker 如何表示现有会话

客户端连接时，Broker 通过 **CONNACK** 包中的 **Session Present** 标志告知是否存在先前的会话。

- **Session Present = true**。表示 Broker 已找到给定 **Client ID** 的现有会话并已恢复。订阅及所有存储的会话状态可供客户端使用。
- **Session Present = false**。表示未找到现有会话，已创建新会话。客户端需在需要时重新订阅。

该标志对使用 **持久会话** 的客户端尤其重要，使其能够判断是恢复先前会话还是从全新状态开始。

## MQTT v3.x 与 MQTT v5.0 的会话配置

相比 **MQTT v3.x**，**MQTT v5.0** 改进了会话管理。MQTT v3.x 仅提供基本会话持久性控制，MQTT v5.0 引入更灵活、显式的机制，更适合现代 IoT 系统，尤其是不稳定网络和大规模客户端场景。

关键变化是 MQTT v5.0 用两个独立属性 **Clean Start** 和 **Session Expiry Interval** 取代单一的 **Clean Session** 标志，使客户端能精确控制会话 *何时* 以全新状态开始，以及 Broker 在断开后 *应保留* 会话数据 *多长时间*。

<table>
  <thead>
    <tr>
      <td style="width: 20%"><b>会话类型</b></td>
      <td style="width: 20%"><b>MQTT v3.x<br>配置</b></td>
      <td style="width: 25%"><b>MQTT v5.0<br>配置</b></td>
      <td style="width: 35%"><b>说明</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>非持久会话</b></td>
      <td>Clean Session = 1</td>
      <td>
        Clean Start = 1<br>
        Session Expiry Interval = 0
      </td>
      <td>
        始终创建新会话。不存储订阅或消息。
        客户端离线期间发布的消息会丢失。
        适用于无需持久化的简单实时数据。
      </td>
    </tr>
    <tr>
      <td><b>持久会话</b></td>
      <td>Clean Session = 0</td>
      <td>
        Session Expiry Interval &gt; 0<br>
        <b>或</b><br>
        Clean Start = 0<br>
        Session Expiry Interval = 0
      </td>
      <td>
        在断开后的一段时间内保留会话状态。
        MQTT v5.0 中 Session Expiry Interval 最大为 <b>4,294,967,295 秒</b>（约 136 年）。
        重连时恢复订阅和排队消息。
        适用于间歇性连接且需控制资源使用的场景。
      </td>
    </tr>
  </tbody>
</table>

> 若未指定 Session Expiry Interval，则默认为 0。单位为秒。
> Clean Start 为布尔标志，等价于 Clean Session，0 表示 false，1 表示 true。

关于在 TBMQ UI 中查看和管理 MQTT 会话的详情，请参阅 [文档](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/sessions/)。

## TBMQ 中的会话状态管理

TBMQ 设计用于在流量模式高度多样的环境中大规模运行，涵盖从轻量级 IoT 设备到高吞吐量后端应用。
TBMQ 中的会话状态并非孤立管理。其生命周期、持久性及资源影响受客户端连接方式、产生的数据量、消费的数据量以及消息投递可靠性要求的影响。

### 客户端类型与会话行为

TBMQ 通过将客户端分为 **DEVICE** 和 **APPLICATION** 两类来提升可扩展性和可靠性。
每种 [客户端类型](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type/) 具有不同的流量模式和预期用途，使 TBMQ 能为不同客户端类型采用定制的会话持久化和消息投递策略以高效使用资源。

<table>
  <thead>
    <tr>
      <td style="width: 15%"><b>客户端类型</b></td>
      <td style="width: 20%"><b>会话类型</b></td>
      <td style="width: 35%"><b>典型用例</b></td>
      <td style="width: 30%"><b>持久性详情</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>DEVICE</td>
      <td>非持久</td>
      <td>
        简单环境监测。<br>
        示例：每分钟使用 QoS 0 发布一次的温度传感器。
      </td>
      <td>
        无会话存储。断开时消息丢弃。设备重连后须重新订阅。若设备过慢，TBMQ 会跳过消息，防止 broker 过载。
      </td>
    </tr>
    <tr>
      <td>DEVICE</td>
      <td>持久</td>
      <td>
        命令投递和配置更新。<br>
        示例：在不稳定移动网络上的固件更新命令。
      </td>
      <td>
        离线时消息排队。TBMQ 将每个 DEVICE 会话存储的消息数限制为 <b>65,535</b>，并使用可配置 TTL 移除过期消息。
      </td>
    </tr>
    <tr>
      <td>APPLICATION</td>
      <td>非持久</td>
      <td>
        通常不建议用于数据处理应用。
      </td>
      <td>
        断开期间可能丢失消息。TBMQ 向管理员显示数据丢失风险警告。
      </td>
    </tr>
    <tr>
      <td>APPLICATION</td>
      <td>持久</td>
      <td>
        企业后端和分析系统。<br>
        示例：消费数千台设备的遥测数据。
      </td>
      <td>
        专为极高吞吐量设计。支持共享订阅，可在多个应用实例间高效负载均衡。
      </td>
    </tr>
  </tbody>
</table>

### 会话配置参数

配置参数（参见 [Configuration properties](/docs/{{docsPrefix}}mqtt-broker/install/config/)）控制 TBMQ 如何处理 **持久会话** 和 **会话过期**。它们定义影响消息保留、缓冲行为和非活跃客户端会话生命周期的限制与清理规则。

- `client-session-expiry` 参数控制非活跃会话允许存在的时间以及过期会话的定期清理，防止未使用的会话状态在系统中累积。
- `persistent-session` 参数调节持久 **DEVICE** 和 **APPLICATION** 客户端的消息存储和投递，影响内存使用、吞吐量和投递延迟。

```yaml
client-session-expiry:
  # Cron job to schedule clearing of expired and not active client sessions. Defaults to 'every hour', e.g. at 20:00:00 UTC
  cron: "${MQTT_CLIENT_SESSION_EXPIRY_CRON:0 0 * ? * *}"
  # Timezone for the client sessions clearing cron-job
  zone: "${MQTT_CLIENT_SESSION_EXPIRY_ZONE:UTC}"
  # Max expiry interval allowed of inactive sessions in seconds. The current value corresponds to one week
  max-expiry-interval: "${MQTT_CLIENT_SESSION_EXPIRY_MAX_EXPIRY_INTERVAL:604800}"
  # Administration TTL in seconds for clearing sessions that do not expire by session expiry interval
  # (e.g. MQTTv3 cleanSession=false or MQTTv5 cleanStart=false && sessionExpiryInterval == 0).
  # The current value corresponds to one week. 0 or negative value means this TTL is disabled
  ttl: "${MQTT_CLIENT_SESSION_EXPIRY_TTL:604800}"
persistent-session:
  device:
    persisted-messages:
      # Maximum number of PUBLISH messages stored for each persisted DEVICE client
      limit: "${MQTT_PERSISTENT_SESSION_DEVICE_PERSISTED_MESSAGES_LIMIT:10000}"
      # TTL of persisted DEVICE messages in seconds. The current value corresponds to one week
      ttl: "${MQTT_PERSISTENT_SESSION_DEVICE_PERSISTED_MESSAGES_TTL:604800}"
      # If enabled, each message is published to persistent DEVICE client subscribers with flush. When disabled, the messages are buffered in the channel and are flushed once in a while
      write-and-flush: "${MQTT_PERSISTENT_MSG_WRITE_AND_FLUSH:true}"
      # Number of messages buffered in the channel before the flush is made. Used when `MQTT_PERSISTENT_MSG_WRITE_AND_FLUSH` = false
      buffered-msg-count: "${MQTT_PERSISTENT_BUFFERED_MSG_COUNT:5}"
  app:
    persisted-messages:
      # Kafka topic properties separated by semicolon for `tbmq.msg.app` topics
      topic-properties: "${TB_KAFKA_APP_PERSISTED_MSG_TOPIC_PROPERTIES:retention.ms:604800000;segment.bytes:26214400;retention.bytes:1048576000;replication.factor:1}"
      # If enabled, each message is published to persistent APPLICATION client subscribers with flush. When disabled, the messages are buffered in the channel and are flushed once in a while
      write-and-flush: "${MQTT_APP_MSG_WRITE_AND_FLUSH:false}"
      # Number of messages buffered in the channel before the flush is made. Used when `MQTT_APP_MSG_WRITE_AND_FLUSH` = false
      buffered-msg-count: "${MQTT_APP_BUFFERED_MSG_COUNT:10}"
```

## Message Expiry Interval 与会话状态

**Message Expiry Interval**（MQTT v5.0）定义已发布消息在 Broker 将其丢弃前保持有效的时间。
它适用于每条消息，与客户端连接状态无关。

Message Expiry Interval 在 **Broker 收到消息后** 立即开始倒计时。
消息仅在未超过其过期时间间隔时才符合投递条件。
一旦间隔过期，消息将被丢弃且不再投递，即使会话仍然存在。

对于 **持久会话**，Message Expiry Interval 在离线消息排队中起关键作用：
- **QoS 1 或 QoS 2** 的消息可在客户端离线时排队。
- 若排队消息在 **客户端重连前** 已过期，将从会话队列中移除。
- 这可防止投递过时数据，并限制持久会话中的长期消息累积。

对于 **非持久会话**，Message Expiry Interval 的实际作用有限：
- 仅在客户端连接时投递消息。
- 客户端离线时，无论过期设置如何，消息都不会排队。

**Message Expiry Interval** 和 **Session Expiry Interval** 用途不同：
- **Message Expiry Interval** 控制单条消息的有效期。
- **Session Expiry Interval** 控制断开后会话状态的保留时间。

消息仅当会话仍存在 **且** Message Expiry Interval 尚未过期时才会被投递。

## 演示持久会话

本示例展示 **持久会话** 在实际中的工作方式，使用 TBMQ [**WebSocket Client**](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/websocket-client/)。
您将看到，客户端离线期间发布的消息 **不会丢失**，并在客户端重连时投递。

以下截图演示简单的 IoT 风格场景：
1. 一客户端使用持久会话订阅某主题。
2. 该客户端随后断开。
3. 另一客户端向同一主题发布消息。
4. 当第一客户端重连时，会收到其离线期间发布的消息。

此行为仅因会话为 **持久** 且消息使用 **QoS 1** 或 **QoS 2** 投递而成为可能。

{% include images-gallery.html imageCollection="persistent-session-demo" %}
