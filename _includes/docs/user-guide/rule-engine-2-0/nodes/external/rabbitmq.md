向 [RabbitMQ](https://www.rabbitmq.com/){:target="_blank"} exchange 发布消息，入站消息 data 作为消息体发送。

## 配置

### Exchange and routing configuration（Exchange 与路由配置）

定义目标 RabbitMQ exchange 及路由行为。

- **Exchange name pattern** — 发布消息的 RabbitMQ exchange 名称。留空则发布到默认 exchange。
  支持基于消息 data 和 metadata 的模板以动态选择 exchange。
- **Routing key pattern** — 在 exchange 内路由消息的 routing key。对 direct 和 topic 类型 exchange，决定哪些 queue 接收消息。
  支持基于消息 data 和 metadata 的模板以动态路由。若不需要 routing key（如 fanout exchange）可留空。

#### Message properties（消息属性）

附加到发布消息的预定义 AMQP 消息属性。消息属性控制投递模式、内容类型和持久化。

可用选项：

- **BASIC** — 非持久化，无特定内容类型
- **TEXT_PLAIN** — 非持久化，text/plain 内容类型
- **MINIMAL_BASIC** — 最小非持久化属性
- **MINIMAL_PERSISTENT_BASIC** — 最小持久化属性（消息在 broker 重启后保留）
- **PERSISTENT_BASIC** — 持久化，无特定内容类型
- **PERSISTENT_TEXT_PLAIN** — 持久化，text/plain 内容类型

{% capture persistence_note %}
**警告**：使用 **BASIC**、**TEXT_PLAIN**、**MINIMAL_BASIC** 或未设置消息属性发布的消息为非持久化。
RabbitMQ broker 重启或故障时这些消息将丢失。若需消息持久化，请使用 **MINIMAL_PERSISTENT_BASIC**、**PERSISTENT_BASIC** 或 **PERSISTENT_TEXT_PLAIN**。
{% endcapture %}
{% include templates/warn-banner.md content=persistence_note %}

Leave empty for no predefined properties.

### Connection configuration

Configure the connection to your RabbitMQ broker.

- **Host** – The hostname or IP address of the RabbitMQ server.
- **Port** – The port number for the AMQP connection. Default: `5672` (standard AMQP port).
- **Virtual host** – The RabbitMQ virtual host to connect to. Default: `/` (the default virtual host).
- **Username** – The username for authentication to the RabbitMQ broker. Default: `guest`.
- **Password** – The password for authentication to the RabbitMQ broker. Default: `guest`.

{% capture credentials_note %}
**Note**: If you use Professional Edition, we highly recommend using [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} to securely store your password.
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### Advanced settings（高级设置）

配置连接行为及自定义客户端属性。

- **Automatic recovery** — 网络故障后自动恢复连接和拓扑（exchanges、queues、bindings）。默认：`false`。启用后，RabbitMQ 客户端在连接丢失时会自动尝试重连并恢复拓扑。
- **Connection timeout (ms)** — 建立与 RabbitMQ broker 连接的超时时间（毫秒）。默认：`60000`（60 秒）。
- **Handshake timeout (ms)** — TCP 连接建立后完成 AMQP 握手的超时时间（毫秒）。默认：`10000`（10 秒）。

- **Client properties** — 连接时发送给 RabbitMQ broker 的自定义键值对。键和值均以字符串形式发送。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbRabbitMqNodeConfiguration",
  "type": "object",
  "properties": {
    "exchangeNamePattern": {
      "type": "string",
      "description": "Name of the RabbitMQ exchange (supports templatization). Empty string publishes to default exchange."
    },
    "routingKeyPattern": {
      "type": "string",
      "description": "Routing key for message routing (supports templatization)."
    },
    "messageProperties": {
      "type": [
        "string",
        "null"
      ],
      "enum": [
        null,
        "BASIC",
        "TEXT_PLAIN",
        "MINIMAL_BASIC",
        "MINIMAL_PERSISTENT_BASIC",
        "PERSISTENT_BASIC",
        "PERSISTENT_TEXT_PLAIN"
      ],
      "description": "Predefined AMQP message properties."
    },
    "host": {
      "type": "string",
      "minLength": 1,
      "description": "Hostname or IP address of the RabbitMQ server."
    },
    "port": {
      "type": "integer",
      "minimum": 1,
      "maximum": 65535,
      "description": "Port number for the AMQP connection."
    },
    "virtualHost": {
      "type": "string",
      "description": "RabbitMQ virtual host."
    },
    "username": {
      "type": "string",
      "minLength": 1,
      "description": "Username for RabbitMQ authentication."
    },
    "password": {
      "type": "string",
      "description": "Password for RabbitMQ authentication."
    },
    "automaticRecoveryEnabled": {
      "type": "boolean",
      "description": "Enable automatic connection recovery after failures."
    },
    "connectionTimeout": {
      "type": "integer",
      "minimum": 0,
      "description": "Connection timeout in milliseconds."
    },
    "handshakeTimeout": {
      "type": "integer",
      "minimum": 0,
      "description": "AMQP handshake timeout in milliseconds."
    },
    "clientProperties": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "Custom client properties sent to RabbitMQ during connection."
    }
  },
  "required": [
    "host"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

无论成功或失败，节点均保留原始消息 data 和 metadata。失败时会在消息 metadata 中添加错误详情。

### Success case（成功时）

消息成功发布到 RabbitMQ 时，出站消息原样透传。原始消息 data 和 metadata 保持接收时的状态。

### Failure case（失败时）

发布失败时，在出站消息 metadata 中添加以下字段：

- `error` — 以 `class <ExceptionClass>: <error message>` 格式包含异常类名和错误信息

**示例：**

原始消息 metadata：

```json
{
  "deviceType": "sensor"
}
```

失败后（如连接超时），metadata 变为：

```json
{
  "deviceType": "sensor",
  "error": "class java.net.SocketTimeoutException: connect timed out"
}
```

消息 data 保持不变。

## 消息确认行为

节点的消息确认行为由环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 控制：

- **设为 `true`** — 入站消息在接收后立即被确认并标记为已成功处理。创建包含更新 metadata 的新消息并加入队列供下一节点处理。
- **设为 `false`**（默认）— 入站消息在整个 RabbitMQ 发布操作期间保持处理中状态。消息就地转换，若发生错误则更新 metadata，发布完成后将修改后的消息传递至下一节点。

## 消息处理算法

1. 节点构建 RabbitMQ 发布请求：
    - If the **exchange name pattern** is configured, templates are resolved using values from the incoming message data and metadata. If empty, the default exchange is used.
    - If the **routing key pattern** is configured, templates are resolved using values from the incoming message data and metadata.
    - If **message properties** are specified, the corresponding AMQP BasicProperties are retrieved.
2. The message data is converted to bytes using UTF-8 encoding.
3. The publish operation is executed asynchronously:
    - The message is published to the specified exchange with the resolved routing key.
    - If message properties are configured, they are included in the publish.
4. When RabbitMQ accepts the message successfully:
    - The original message passes through unchanged.
    - The resulting message is forwarded via the `Success` connection.
5. If an error occurs during publishing:
    - Error details are added to the outgoing message metadata under the `error` key.
    - The message is forwarded via the `Failure` connection.

## 输出连接

- **Success**
    - 消息已成功发布到 RabbitMQ。
    - 原始消息原样透传。
- **Failure**
    - **Publishing error**：RabbitMQ broker 拒绝消息或 exchange/路由配置无效。
    - **Unexpected error**：消息处理过程中发生意外错误。

## 示例

### 示例 1 — 基本 telemetry 发布

将 telemetry 数据发布到专用 telemetry exchange，按设备类型路由。

**入站消息**

Data：

```json
{
  "temperature": 25.5,
  "humidity": 60.2
}
```

Metadata:

```json
{
  "deviceType": "TH-Sensor",
  "deviceName": "Sensor-001"
}
```

**Node configuration**

```json
{
  "exchangeNamePattern": "telemetry",
  "routingKeyPattern": "${deviceType}",
  "messageProperties": "PERSISTENT_TEXT_PLAIN",
  "host": "rabbitmq.example.com",
  "port": 5672,
  "virtualHost": "/",
  "username": "iot-user",
  "password": "secure-password",
  "automaticRecoveryEnabled": true,
  "connectionTimeout": 60000,
  "handshakeTimeout": 10000,
  "clientProperties": {
    "application": "thingsboard",
    "environment": "production"
  }
}
```

**出站消息**

Data 和 metadata：未更改。

经 `Success` 连接路由。

**结果**

telemetry 数据已成功发布到 "telemetry" exchange，routing key 为 "TH-Sensor"。消息为持久化，broker 重启后仍保留。RabbitMQ 会将消息路由到与该 exchange 绑定且 routing key 匹配的 queue。

### 示例 2 — 动态 exchange 与 routing key

根据 alarm 数据向按严重程度划分的 exchange 发布 alarm 消息，使用分层 routing key。

**入站消息**

Data：

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "bfb13620-7737-400b-9c89-d569a0835de6"
  },
  "type": "HighTemperature",
  "severity": "CRITICAL",
  "originator": {
    "entityType": "DEVICE",
    "id": "b3e86d40-78f5-11f0-8e01-57f51829cedc"
  },
  "status": "ACTIVE_UNACK",
  "details": {
    "temperature": 95.5
  }
}
```

Metadata:

```json
{
  "tenantId": "888e6780-78f5-11f0-8e01-57f51829cedc",
  "deviceType": "temperature-sensor"
}
```

**Node configuration**

```json
{
  "exchangeNamePattern": "alarms-$[severity]",
  "routingKeyPattern": "alarm.$[type].${deviceType}",
  "messageProperties": "PERSISTENT_BASIC",
  "host": "rabbitmq.example.com",
  "port": 5672,
  "virtualHost": "/iot",
  "username": "alarm-publisher",
  "password": "secure-password",
  "automaticRecoveryEnabled": true,
  "connectionTimeout": 60000,
  "handshakeTimeout": 10000,
  "clientProperties": {}
}
```

**出站消息**

Data 和 metadata：未更改。

经 `Success` 连接路由。

**结果**

alarm 已发布到 "alarms-CRITICAL" exchange，routing key 为 "alarm.HighTemperature.temperature-sensor"。消费者可使用 topic exchange 模式订阅特定 alarm 严重程度和类型。

### 示例 3 — 使用 client properties 进行监控

Publish messages with custom client properties that help identify the connection in RabbitMQ management interface.

**Incoming message**

Data:

```json
{
  "value": 42
}
```

**节点配置**

```json
{
  "exchangeNamePattern": "metrics",
  "routingKeyPattern": "performance",
  "messageProperties": "TEXT_PLAIN",
  "host": "rabbitmq.example.com",
  "port": 5672,
  "virtualHost": "/monitoring",
  "username": "metrics-user",
  "password": "secure-password",
  "automaticRecoveryEnabled": true,
  "connectionTimeout": 60000,
  "handshakeTimeout": 10000,
  "clientProperties": {
    "application": "thingsboard",
    "version": "3.6.0",
    "environment": "production",
    "node_id": "rule-engine-1"
  }
}
```

**出站消息**

Data 和 metadata：未更改。

经 `Success` 连接路由。

**结果**

消息已成功发布。client properties 会显示在 RabbitMQ 管理界面中，便于识别是哪台 ThingsBoard 规则引擎节点创建的连接，适用于监控、调试和容量规划。
