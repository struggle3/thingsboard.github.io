
* TOC
{:toc}

该页面用于查看和分析 broker 系统中存储的所有会话。
包括当前在线的已连接会话（表示当前已连接到 broker 的客户端），以及持久化客户端的已断开会话。
通过该页面，用户可全面了解所有已存储会话，便于监控并管理客户端与 broker 的活跃及历史交互记录。

查看当前 TBMQ 会话的详细信息，请按以下步骤操作：

1. 在左侧菜单打开 "Sessions" 页面。
2. 点击会话表行，打开会话详情窗口。

在 "Session Details" 中，用户可以断开或移除客户端会话：
* 要**断开**客户端，点击 "Disconnect client" 按钮。请注意，仅可断开 `Connected` 状态的客户端。
* 要**移除**客户端会话，点击 "Remove session" 按钮。请注意，仅可移除 `Disconnected` 状态的客户端。

{% include images-gallery.html imageCollection="sessions-details" %}

## Session Details

**Details** 选项卡包含以下信息： 
   * **Connected Status**（Connected/Disconnected）。
   * **Connected At** - 客户端连接的时间戳。
   * **Disconnected At** - 对于已断开的持久化客户端，显示客户端断开的时间戳。
   * **Keep Alive**（秒）- 表示 broker 与客户端在会话关闭前可无通信的持续时间。
   * **Node ID** - 客户端当前/曾经连接的 broker 节点。
   * **Clean Start**（clean/persistent session）- 为 true 时，broker 将丢弃所有可用的先前会话信息与消息，并启动新会话。
   * **Session expiry interval** - 对于已断开的持久化客户端，表示连接丢失后客户端会话信息保留的时长。
   * **Session end** - 对于已断开的持久化客户端，表示会话信息与消息何时被移除。
   * **Client ID** - 客户端标识符。
   * **Client IP** - 客户端 IP 地址。
   * [**Client type**](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-client-type)（Device/Application）。
   * 用于认证当前会话的 [**Client Credentials**](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/mqtt-client-credentials/)。
   * **MQTT version** - 指定使用的 MQTT 协议版本：MQTT 3.1 (3)、MQTT 3.1.1 (4) 或 MQTT 5.0 (5)。

## Subscriptions

在 **Subscriptions** 选项卡中，用户可查看与会话关联的订阅的详细信息，例如：
{% include templates/mqtt-broker/subscription-options.md %}

会话详情通常为只读，但用户可在会话内有效管理订阅，包括添加、删除和编辑。
管理订阅的可用操作如下：
* 要**添加**新订阅，点击 "Add Subscription" 按钮。
* 要**删除**订阅，点击该订阅旁的 "Delete" 图标。
* 要**编辑**已有的主题过滤器或 QoS，在表单中修改后点击 "Update" 按钮。

{% include images-gallery.html imageCollection="sessions-subscriptions" %}

## Metrics

**Metrics** 选项卡提供该会话内 MQTT 消息流转的详细洞察，有助于监控消息投递的性能与可靠性：
* **Received PUBLISH Messages**。 客户端接收的 PUBLISH 消息总数。
* **Received QoS 0 Messages**。 接收的 QoS 0（"AT_MOST_ONCE"）消息数量。
* **Received QoS 1 Messages**。 接收的 QoS 1（"AT_LEAST_ONCE"）消息数量。
* **Received QoS 2 Messages**。 接收的 QoS 2（"EXACTLY_ONCE"）消息数量。
* **Sent PUBLISH Messages**。 客户端发送的 PUBLISH 消息总数。
* **Sent QoS 0 Messages**。 发送的 QoS 0（"AT_MOST_ONCE"）消息数量。
* **Sent QoS 1 Messages**。 发送的 QoS 1（"AT_LEAST_ONCE"）消息数量。
* **Sent QoS 2 Messages**。 发送的 QoS 2（"EXACTLY_ONCE"）消息数量。

{% include images-gallery.html imageCollection="sessions-metrics" %}
