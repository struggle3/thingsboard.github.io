* TOC
{:toc}

TBMQ WebSocket Client 是一款可在浏览器中访问的工具，旨在简化各类场景下的 MQTT 客户端调试与测试。
借助 [MQTT over WebSocket](/docs/{{docsPrefix}}mqtt-broker/user-guide/mqtt-over-ws/) 特性，以简洁易用为设计原则。
支持 MQTT 客户端管理、主题订阅、消息接收与发布的无缝操作。

TBMQ WebSocket Client 使用 [MQTT.js](https://github.com/mqttjs/MQTT.js) 库实现客户端与 broker 的通信。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/ws-overview.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/ws-overview.png)
{% endif %}

## Connections

TBMQ WebSocket Client 支持同时管理多个 MQTT 客户端连接。
提供可便捷发起、监控和终止多个 MQTT 客户端的界面。

### 添加连接

添加新连接，请按以下步骤操作：

1. 进入 _WebSocket Client_ 页面，点击以 _expand more_ 图标表示的 _Select Connection_。
2. 点击 _Add new connection_ 按钮。填写必要字段以创建并连接 MQTT 客户端，然后点击 _Connect_。

{% include images-gallery.html imageCollection="ws-connection-add" %}

### 编辑连接

TBMQ 支持在连接建立后修改 WebSocket Client 连接参数。
需注意的是，对连接参数的修改会立即生效。

若修改时客户端已连接，TBMQ 会先优雅断开当前会话，然后使用更新后的设置发起新会话。
这确保您的修改即时应用，在保持客户端正在进行的活动完整性的同时，实现无缝适配能力。

修改 WebSocket Client 连接，请按以下步骤操作：
1. 进入 _WebSocket Client_ 页面，点击箭头图标展开连接列表。
2. 点击待修改连接的编辑图标。
3. 进行修改后点击 Connect 保存。

{% include images-gallery.html imageCollection="ws-connection-edit" %}

### 删除连接

删除 WebSocket Client 连接，请按以下步骤操作：
1. 进入 _WebSocket Client_ 页面，点击箭头图标展开连接列表。
2. 点击待删除连接的垃圾桶图标。
3. 出现确认提示后，点击 _Yes_ 完成删除。

{% include images-gallery.html imageCollection="ws-connection-delete" %}

### 连接设置

WebSocket 连接允许用户建立并配置多种参数，包括客户端凭据、会话设置和 Last Will 设置。

#### 连接详情
* **Name**。 WebSocket Client 连接名称，必须唯一。
* **URL**。 通常包含协议（如 'ws'、'wss'）、MQTT broker 的主机名和端口。/mqtt 是 MQTT over WebSockets 的标准路径。示例：'ws://localhost:8084/mqtt'。
* **Authentication**。 TBMQ 支持以不同方式处理 clientID（必填）、username、password 等凭据的 WebSocket 连接：
  * **Auto-generated credentials**。 随机 Client ID、随机 Username、空 Password 的凭据。请注意将创建对应的 Credentials。
  * **Custom authentication**。 自定义 Client ID、Username、Password 的凭据。
  * **Use existing credentials**。 用户选择已有的 [Basic](/docs/{{docsPrefix}}mqtt-broker/security/#basic-authentication) 类型凭据，并按需输入 Password。

当选定的凭据需要密码建立连接时，会显示 Password 输入框。

{% include images-gallery.html imageCollection="ws-connection-details" %}

#### 高级设置

* **Clean start**。 启用（true）时，broker 将丢弃所有先前会话并启动新会话，即移除所有订阅并丢失所有未投递消息。
* **Keep alive**。 MQTT 客户端愿意在发送给服务器的控制包（PUBLISH、PINGREQ 等）之间等待的空闲时间，用于在无活动期间保持连接。
* **Connect timeout**。 客户端应等待 MQTT CONNACK 包以确认连接的最大等待时间。若在此时间内未收到确认，则视为连接失败。
* **Reconnect period**。 MQTT 客户端与 broker 断开后，两次重连尝试之间的间隔。
* **MQTT version**。 指定使用的 MQTT 协议版本：MQTT 3.1 (3)、MQTT 3.1.1 (4) 或 MQTT 5.0 (5)。

若选择 MQTT Version 5，将提供以下额外参数：
* **Session Expiry Interval**。 设置客户端断开后 broker 应保留会话的时间（秒）。
* **Max Packet Size**。 客户端愿意从 broker 接收的最大 payload 大小（字节）。
* **Topic Alias Maximum**。 客户端愿意接受的 broker 发送的 Topic Alias 最高值。
* **Receive Maximum**。 可并发处理的 QoS 1 和 QoS 2 消息的最大数量。
* **Request Response Information**。 设为 true 时，MQTT broker 将在响应中返回发布操作的额外信息。

{% include images-gallery.html imageCollection="ws-connection-advanced" %}

#### Last will

Last Will（可选）是 MQTT 的一项特性，允许用户在客户端非正常断开时，由 MQTT broker 代为发送指定消息。
以下是 Last Will 属性的说明：
* **Topic**。 Last Will 消息将发布到的 MQTT topic。
* **QoS**。 Last Will 消息的 Quality of Service 级别。
* **Payload**。 Last Will 消息内容。
* **Retain**。 控制 broker 在投递后是否保留 Last Will 消息。为 true 时，broker 将存储 will 消息并投递给该 topic 的未来订阅者。

若选择 MQTT Version 5，请配置以下额外特性：
* **Payload Format Indicator**。 为 true 时，表示 payload 为 UTF-8 编码字符数据。为 false 或未设置时，视为未指定的二进制数据。
* **Content Type**。 描述 will 消息所承载内容的格式。
* **Will Delay Interval**。 客户端非正常断开后，broker 在发布 will 消息前需等待的时间。
* **Message Expiry Interval**。 自发布之日起 will 消息可被投递的有效期。
* **Response Topic**。 broker 在广播 will 消息后可发布响应消息的 topic。
* **Correlation Data**。 用于将 broker 广播 will 消息后的响应消息进行关联的二进制数据。
* **User Properties**。 允许客户端以 key-value 对形式为 Will 消息添加自定义元数据。

{% include images-gallery.html imageCollection="ws-connection-will" %}

### 连接状态

TBMQ 提供保存 WebSocket Client 状态临时日志的功能，便于您监控和排查客户端连接行为。
访问这些日志：将光标悬停在当前状态标签上，即可显示详细的状态更新历史，了解连接相关事件的时间顺序。

WebSocket Client 的状态可能为以下之一：
1. **Connected**。 表示已成功与 broker 建立连接。
2. **Disconnected**。 表示 WebSocket 客户端已与 broker 关闭连接。
3. **Reconnecting**。 客户端正在尝试与 broker 重新建立连接时显示。点击右上角 Cancel 按钮可取消重连。
4. **Connection failed**。 表示客户端无法与 broker 建立连接。该状态可能附带失败原因，如认证问题、会话被接管等。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/ws-logs.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/ws-logs.png)
{% endif %}

## Subscriptions

MQTT subscriptions 是 MQTT 发布-订阅消息协议的重要组成部分，允许客户端订阅一个或多个主题。
用户可通过创建、修改或删除来管理 subscriptions。

### 添加订阅

添加 Subscription 步骤：
1. 进入 _WebSocket Client_ 页面，点击以 _plus_ 图标表示的 _Add Subscription_ 按钮。
2. 进行修改后点击 _Add_ 保存。

{% include images-gallery.html imageCollection="ws-subscription-add" %}

### 编辑订阅

修改订阅时，点击对应行的编辑图标打开 _Edit subscription_ 对话框。
完成修改后，记得点击 _Save_ 按钮确认。

请注意，若客户端已连接时修改现有订阅，TBMQ 会先取消旧 topic 的订阅，再订阅更新后的 topic。
成功重新订阅后，客户端将开始接收发布到新 topic 的消息。

{% include images-gallery.html imageCollection="ws-subscription-edit" %}

### 删除订阅

删除订阅步骤：
1. 在 Subscriptions 列表中定位到要删除的订阅，点击对应行的删除图标。
2. 出现确认提示后，点击 _Yes_ 完成删除。
   
{% include images-gallery.html imageCollection="ws-subscription-delete" %}

### 订阅设置

订阅设置涵盖客户端如何订阅 MQTT 主题的相关配置。
通常包括 topic filter、QoS (Quality of Service) 级别等参数，以及 MQTT 客户端或 broker 特有的额外选项。

* **Topic filter**。 要订阅的 MQTT topic filter。**每条连接内必须唯一。**
* **QoS**。 订阅的 Quality of Service。
* **Retain as Published**。 为 true 时，通过该订阅转发的消息保留发布时的 RETAIN 标志；为 false 时，消息的 RETAIN 标志设为 0。
* **Retain Handling**。 该选项决定客户端订阅 topic 时 broker 如何处理 retained 消息。
  * 0 - 订阅时发送 retained 消息；
  * 1 - 若订阅尚不存在，则在订阅时发送 retained 消息；
  * 2 - 订阅时不发送 retained 消息。
* **No local**。 为 true 时，broker 不会将该客户端发布的消息转发回建立该订阅的连接。
* **Color**。 用于在消息表中更好区分消息的颜色，可修改。
* **Subscription Identifier**。 分配给订阅的唯一标识符（大于 0 的数值），用于跟踪、管理和引用特定订阅，确保每条订阅可被唯一区分。

{% include images-gallery.html imageCollection="ws-subscription-overview" %}

## Messages

Messages 表用作消息日志，显示最近的消息供查看和参考。
表中每行对应一条发布或接收的消息，并展示关键消息属性的快照：
1. **Type**。 标识消息是 Received 还是 Published。
2. **Topic**。 消息关联的 topic。
3. **QoS**。 消息关联的 Quality of Service 级别。
4. **Retain**。 显示发送方是否将消息标记为 _Retain_。
5. **Payload**。 消息内嵌内容的预览。
   若消息包含 payload，可点击 Info 图标按钮查看详情。该操作将打开对话框，除可阅读 payload 外，还可复制到剪贴板。
6. **Properties** 图标按钮可访问消息中的更多设置，如 User properties、Content type、Topic Alias 等。

{% include images-gallery.html imageCollection="ws-table-msg" %}

### 消息筛选
消息表可按以下方式筛选：
* **Type 'All/Received/Published'** - 点击 Messages 表表头的 type 标签。
* **Topic/QoS/Retain** - 点击 _Clear messages_ 按钮旁的 _filter_ 图标。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/ws-table-filter.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/ws-table-filter.png)
{% endif %}

### 发布消息

WebSocket Client 页面提供易于使用的发布消息界面。
使用 TBMQ 成功发布消息需满足：
* **客户端已连接**。
* **已指定 Topic**。 使用 Topic Alias 特性时可不必指定。
* **消息格式有效**，若选择 JSON 格式。

以下是发布消息的基本选项及简要说明：
* **Topic**。 消息将发布到的 MQTT topic。
* **QoS**。 保证消息投递的 Quality of Service 级别：
  * 0 - At most once（消息可能投递也可能不投递）；
  * 1 - At least once（消息会投递，但可能重复）；
  * 2 - Exactly once（消息 Exactly once 投递）。
* **Retain**。 为 true 时，broker 存储该 topic 的最后一条消息及其 QoS，该 topic 的未来订阅者将收到该 topic 的最后一条 retained 消息。
* **Color**。 用于在消息表中标记发布的消息以便区分。
* **Format**。 指定消息显示格式。
    * JSON。 对消息内容进行 JSON 格式校验。
    * String。 不进行校验。

填写必要信息和设置后，找到并**点击 Send 图标**发布消息。
消息将发送到 broker 并转发给订阅该 topic 的所有客户端。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/ws-publish-msg.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/ws-publish-msg.png)
{% endif %}

使用 **MQTT Version 5** 的 MQTT 客户端还可使用额外参数进一步自定义消息发布。
这些特性组合提供了灵活的 MQTT 消息处理环境。

设置发布消息属性：点击左下角 _Properties_ 按钮打开对话框。
以下为各设置简要说明：
* **Payload Format Indicator**。 为 true 时，表示 payload 为 UTF-8 编码字符数据。默认 false 表示未指定的二进制数据。
* **Content Type**。 描述应用消息数据的格式。
* **Message Expiry Interval**。 应用消息的有效期（秒）。
* **Topic Alias**。 可用作 topic 简写的整数值。若 WebSocket 连接的 Topic Alias Max 为 0，则禁止使用 topic alias。
* **Correlation Data**。 用作关联标识符的二进制数据。
* **Response Topic**。 用作响应消息 Topic Name 的字符串。
* **User Properties**。 允许以 key-value 对形式添加用户定义的元数据。

{% if docsPrefix == "pe/" %}
![image](/images/pe/mqtt-broker/user-guide/ui/ws-publish-advanced-params.png)
{% else %}
![image](/images/mqtt-broker/user-guide/ui/ws-publish-advanced-params.png)
{% endif %}
