* TOC
{:toc}

保留消息是 MQTT 的一种特性，允许 broker 存储特定主题的「最后已知有效」消息，
并在客户端订阅匹配主题时向其投递该消息。

关于保留消息需注意以下几点：
* broker 上**每个主题**仅可存储**一条消息**。
* 同主题上**下一条发布的消息**将**替换前一条**。
* 同主题上发布的**空负载消息**将**清除**该主题的全部保留消息。
* 该主题的订阅者将收到**仅最后一条**消息（如有）。

## 保留消息的用法

客户端订阅主题时，通常只会收到订阅之后发布的消息。
但有了保留消息后，broker 会保存该主题上的最后一条消息，使任何新订阅者都能立即收到最新保留消息，
即使它是在订阅建立之前发布的。

何时使用保留消息：

* **初始状态信息**：若订阅者连接时需要知道主题的最后已知值，保留消息很合适。
例如在温度监控系统中，新订阅者会立即收到最近一次上报的温度，无需等待下次更新。
* **关键配置或状态更新**：对于承载重要配置数据或设备状态更新的主题，
保留消息可确保新连接的设备或客户端也能立即获得当前状态。 
例如，可用保留消息通知客户端系统’s 运行状态，如「Device Online」或「Service in Maintenance」。
* **Last Will and Testament(LWT)通知**：保留消息可与 LWT 消息配合使用。
例如，可用保留消息公告设备当前可用性，若设备意外断开，LWT 可相应更新该状态。
* **持久化命令或指令**：若发布的控制命令或指令需保留至某客户端收到为止（如开设备），
使用保留消息可确保该命令一直保留到有订阅者准备好处理它。

何时避免使用保留消息：

* **频繁实时更新**：若主题提供频繁的实时数据（如每秒更新的传感器读数），
使用保留消息可能意义不大且产生不必要开销，因为最新数据会自然发给订阅者。
* **敏感或临时数据**：若消息包含不应为新订阅者持久保存的临时或敏感信息（如一次性通知或告警），应避免使用保留消息。

有效利用保留消息，可让新订阅者无需等待即可获得最新关键信息，
提升 MQTT 配置的整体响应性和用户体验。

## 发布保留消息

在 MQTT 中，保留消息指将 **retained flag** 设为 _true_ 的普通发布消息。
以下示例使用 `mosquitto_pub` 发布一条保留消息。 

```shell
mosquitto_pub -d -h "YOUR_MQTT_BROKER_HOST" -p 1883 -D PUBLISH user-property hello world -q 1 -t demo/topic -V mqttv5 -m "Hello world" -r
```
{: .copy-code}

**注意**：请将 `YOUR_MQTT_BROKER_HOST` 替换为您的 broker 主机名。
确保已禁用认证，否则请相应调整本指南中的命令。

使用以下命令以默认凭证连接本地部署的 TBMQ：

```bash
mosquitto_pub -d -h "localhost" -p 1883 -D PUBLISH user-property hello world -q 1 -t demo/topic -V mqttv5 -m "Hello world" -r -u tbmq_websockets_username
```
{: .copy-code}

## 负载与用户属性

要在 Web UI 的保留消息页查看某主题最后一条消息的负载和用户属性，请按以下步骤操作：

1. 打开「保留消息」页面。
2. 可选：使用筛选按主题、负载或 QoS 查找保留消息。
3. 查看保留消息负载，点击图标 `{}`。
4. 查看保留消息的用户属性，点击图标 `[]`。若按钮禁用，表示该保留消息无用户属性。

{% include images-gallery.html imageCollection="details-retained-messages" %}

## 删除保留消息

删除保留消息很简单。要移除既有保留消息，可向要删除的保留消息对应主题发送一条带 `zero-byte payload` 的新保留消息。
之后，该主题的任何新订阅者都不会再收到之前的保留消息。

要删除主题 `demo/topic` 的保留消息，可使用以下命令，通过 `-n` 参数指定零字节负载：

```shell
mosquitto_pub -d -h "YOUR_MQTT_BROKER_HOST" -p 1883 -q 1 -t demo/topic -n -r
```
{: .copy-code}

使用默认凭证的本地部署：
```shell
mosquitto_pub -d -h "localhost" -p 1883 -q 1 -t demo/topic -n -r -u tbmq_websockets_username
```
{: .copy-code}

在 TBMQ 的 Web UI 中删除保留消息有两种方式，取决于要删除的消息数量：
1. **删除单条保留消息**：点击「Delete retained message」图标并确认。
2. **删除多条保留消息**：
  * 勾选要删除的消息。
  * 点击右上角「Delete retained messages」按钮，出现提示时确认。

{% include images-gallery.html imageCollection="delete-retained-messages" %}

## 清理空保留消息节点

broker 中的保留消息使用 [Trie](https://en.wikipedia.org/wiki/Trie) 数据结构存储在内存中，
该结构以高效检索著称。
Trie（又称前缀树）是一种基于树的数据结构，可根据键或字符序列快速检索信息。

Trie 以层级方式组织主题名，每个节点代表主题名中的一个主题层级。
通过 Trie 数据结构，broker 可根据订阅客户端提供的主题过滤器快速定位和获取保留消息。
确保客户端在无明显延迟下收到感兴趣的保留消息，有助于提升 broker 的性能和响应速度。

删除保留消息时，broker 从内存中移除消息负载并将对应节点标记为空。
若大量保留消息被删除，broker 内存中可能留下许多空节点。
这些空节点会降低效率并浪费内存资源。

清理空保留消息节点可释放内存资源并提升 broker 性能，
因为空节点减少后 broker 能更快处理 MQTT 消息。

要清理空保留消息节点，请点击右上角「Clear empty retained messages nodes」按钮并确认。

{% include images-gallery.html imageCollection="clear-empty-retained-messages" %}

此外，broker 可通过调度器定期清理空保留消息节点。由以下环境变量控制：
`MQTT_RETAIN_MSG_TRIE_CLEAR_NODES_CRON` and `MQTT_RETAIN_MSG_TRIE_CLEAR_NODES_ZONE`.
