ThingsBoard 内置 MQTT 客户端包含重传机制，用于提高需要确认的消息类型的可靠性。
该机制适用于以下 MQTT 消息类型：
- **PUBLISH**（仅 QoS 1 或 2）
- **SUBSCRIBE**
- **UNSUBSCRIBE**
- **PUBREL**（仅 QoS 2）

发送上述任一类消息后，客户端会在可配置的延迟内等待确认。
若未收到确认，将重传消息。重传间隔采用**指数退避**策略，从初始延迟开始，每次翻倍。
**抖动因子**会在延迟中加入随机波动，以减少集中重试。

例如，若将重传配置为**三次尝试**、**初始延迟 5,000 ms**、**抖动因子 0.15**，则重传大约会在 **5,000 ms**、**10,000 ms** 和 **20,000 ms** 触发，每次延迟会因 ±15% 抖动而略有变化。
若最后一次尝试后仍未收到确认，系统会按指数退避加抖动计算下一次延迟，在等待完成后将消息视为**无法送达**并丢弃。

{% if include.show-yml-config == true %}
可在 `thingsboard.yml` 中全局配置重传参数，这些设置影响平台上的**所有 MQTT 客户端**：

```yaml
mqtt:
  client:
    retransmission:
      max_attempts: "${TB_MQTT_CLIENT_RETRANSMISSION_MAX_ATTEMPTS:3}"
      initial_delay_millis: "${TB_MQTT_CLIENT_RETRANSMISSION_INITIAL_DELAY_MILLIS:5000}"
      jitter_factor: "${TB_MQTT_CLIENT_RETRANSMISSION_JITTER_FACTOR:0.15}"
```
{% endif %}
