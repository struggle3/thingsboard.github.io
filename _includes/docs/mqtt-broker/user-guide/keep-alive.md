
* TOC
{:toc}

**Keep Alive** 特性用于确保客户端在即使一段时间内无消息交换时，仍保持与 broker 的连接和活跃会话。
可将其视为心跳，向 broker 表明客户端仍然在线且正常工作。

Keep Alive 间隔以秒为单位，范围从 0（Keep Alive 机制关闭）到最大 65535 秒（18 小时 12 分 15 秒）。

若在 **Keep Alive 时间的一倍半** 内未收到客户端发出的任何 MQTT 控制报文，broker 将**关闭连接**。

## MQTT 中的半开 TCP 连接

包括 MQTT 在内的网络系统中，一个常见问题是半开 TCP 连接的出现。
当客户端与 broker 之间的网络连接中断（如网络故障）时，一方（通常是 broker）不知道连接已断开，
就会出现半开状态：客户端可能已断开，但 broker 仍认为连接活跃。

Keep Alive 机制有助于缓解半开 TCP 连接问题。
通过强制客户端与 broker 之间进行周期性通信，即使无数据消息发送，
也可不断检查连接状态。
若 broker 在预期间隔内未收到 keep-alive 信号（如 PINGREQ），
可正确判断客户端已不可达，避免连接无限期处于半开状态。

## Keep Alive 工作原理

Keep Alive 间隔在客户端通过 `CONNECT` 报文连接 broker 时设置。

If the Keep Alive interval **is set to 60 seconds**, the client must  send any MQTT control packet (e.g., a `PINGREQ`, `PUBLISH`, `SUBSCRIBE`, etc.) within **90 seconds** (60 * 1.5) to inform the broker that it’s still connected. 

If the client fails to do so, the broker assumes the client is disconnected, and it will **terminate the connection** and trigger a **[Last Will message](/docs/{{docsPrefix}}mqtt-broker/user-guide/last-will)** (if set) to inform about unexpected disconnection.

Normally, when the client sends a `PINGREQ` to maintain the connection, the broker responds with a `PINGRESP`, confirming that the connection is still alive and the client is functioning properly. 
This exchange ensures the connection remains healthy even when no data is being transmitted.

In TBMQ, the `MQTT_KEEP_ALIVE_MONITORING_DELAY_MS` environment variable defines the interval at which the broker checks for inactive client connections. 
By default, this check occurs every second. If a dead connection is detected, the broker terminates the connection, providing "KEEP_ALIVE_TIMEOUT" as the reason.

## 何时关闭 Keep Alive

Setting the **Keep Alive interval to 0** means that the feature is not working and there is no Keep Alive timeout for the connection. 
Basically, the client is telling the broker that it will not send `PINGREQ` packets and doesn’t expect the broker to monitor the connection for inactivity.

For example, an IoT device that is always sending data at a regular rate might not need a Keep Alive check since the frequent data transmission 自然保持连接活跃. 

Key implications of disabling Keep Alive:

* **No periodic ping**. The client won’t send any periodic `PINGREQ` packets, and the broker won’t expect them. The connection is considered always active unless explicitly disconnected. 
* **未检测断连的风险**。由于 broker 不监控客户端活动，若客户端意外断开（如网络故障或其他原因），broker 在尝试向客户端发送消息前无法发现。

{% capture difference %}
我们一般建议保持 Keep Alive 机制开启。仅在确实必要且完全理解其影响时才考虑关闭。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 何时使用 Keep Alive

The Keep Alive feature functions much like a check-in system where one party regularly confirms their presence to prevent others from assuming something has gone wrong.
If the client fails to send these keep-alive signals within the expected interval, the broker considers it disconnected and may trigger to terminate connection or to publish a Last Will message.

In IoT, the Keep Alive interval is critical for maintaining reliable and consistent connections, especially in situations where network stability is a concern or devices may not always be actively transmitting data. 
For example:

* **Smart home**. Devices like thermostats or smart lights might not be constantly sending data. However, by using the Keep Alive feature, they can periodically send a signal to the broker to confirm they’re still connected, even during idle times.
* **Smart farming**. Sensors that monitor weather conditions may not constantly transmit data but will still periodically send keep-alive pings to confirm they are still functioning. If a sensor fails to do so, the broker may alert the farmer, allowing for timely intervention before any important data is lost.

## MQTT 中的客户端接管

客户端接管指两个使用相同 **clientId** 的客户端尝试同时连接 broker 的场景。
根据 MQTT 协议，broker 每个 **clientId** 仅支持一个活动连接。
若新客户端使用与现有会话相同的 **clientId** 连接，broker 将终止旧客户端连接并允许新客户端接管会话。
该机制保证任意时刻仅有一个客户端实例活跃，有助于避免会话冲突或重复消息。

该接管过程还用于维护会话连续性及处理设备在网络故障后重连的情况。
若原客户端已断开而 broker 未知（如因半开 TCP 连接），
新连接将强制关闭过时会话并建立新会话。
