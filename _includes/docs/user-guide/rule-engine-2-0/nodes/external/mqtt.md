向外部 MQTT broker 发布消息，使用 QoS 1（至少一次）及可配置的保留设置。支持基于入站消息数据动态构建 topic 模式，及包括 TLS/SSL 加密在内的多种认证方式。

## 配置

### Topic pattern

指定发布消息的 MQTT 主题。该字段为必填，支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/) 以根据入站消息 data 或 metadata 动态构造主题名。

### Connection settings（连接设置）

- **Host** — MQTT broker 的主机名或 IP 地址。该字段为必填。
- **Port** — MQTT broker 的端口号。该字段为必填。
- **Connection timeout (sec)** — 建立与 MQTT broker 连接时的最大等待时间（秒），超时则连接失败。该字段为必填。

### Client ID

MQTT 客户端的可选标识符。若留空，节点将自动生成 Client ID，格式为 `netty-mqtt/` 后接 8 位随机字母数字字符。

**自动生成 Client ID 示例**：`netty-mqtt/aB3dEf7G`

#### Singleton mode and cluster deployment（单例模式与集群部署）

平台以集群（微服务）模式运行时，规则节点可在两种模式下运行：

- **Singleton mode enabled**（默认）— 无论集群中有多少规则引擎实例，规则节点仅在其中一个实例上启动，即只有一个 MQTT 客户端连接。
- **Singleton mode disabled** — 规则节点在所有规则引擎实例上启动。若有三个规则引擎实例，则会启动三个规则节点，建立三个 MQTT 客户端连接。

可通过节点配置界面中的 **Singleton/Disabled** 开关切换单例模式。

#### Multiple connections issue（多连接问题）

大多数 MQTT broker 不允许同一 Client ID 建立多个并发连接。当集群中多个规则节点实例使用相同 Client ID 尝试连接时，broker 会拒绝重复的客户端连接，导致失败。

#### Solving the multiple connections issue（解决多连接问题）

有两种解决方案：

**Option 1: Enable Singleton mode** — 确保集群中仅启动一个规则节点实例，只建立一个 broker 客户端连接。由于仅有一个客户端，不会发生 Client ID 冲突。

**Option 2: Enable Add Service ID as suffix to Client ID** — 允许多个规则节点实例同时连接。启用时，Service ID 会自动附加到指定的 Client ID 作为后缀。因每个规则引擎实例具有唯一 Service ID，每个规则节点实例会创建具有唯一标识符的客户端。

**示例**：若 Client ID 为 `my-client`，三个规则引擎实例的 Service ID 分别为 `tb-rule-engine-1`、`tb-rule-engine-2`、`tb-rule-engine-3`，最终 Client ID 为：

- `my-client_tb-rule-engine-1`
- `my-client_tb-rule-engine-2`
- `my-client_tb-rule-engine-3`

#### Client ID length restrictions（Client ID 长度限制）

允许的最大 Client ID 长度取决于协议版本：

- **MQTT 3.1**：最大 23 字符
- **MQTT 3.1.1 和 MQTT 5**：最大 256 字符

使用 **Add Service ID as suffix** 时，请确保 Client ID 与 Service ID 后缀的总长度不超过上述限制。若生成的 Client ID 超出最大长度，节点将报错失败。

### Message settings（消息设置）

#### Parse to plain text

控制发布前如何处理消息 data：

- **Disabled**（默认）— 消息 data 原样发布。
- **Enabled** — 若消息 data 为 JSON 编码字符串（用双引号包裹），则移除外层 JSON 编码。

**示例**：

消息 data：`"\"Temperature is 25.5°C\""`

- Parse to plain text **OFF**：发布 `"\"Temperature is 25.5°C\""`（带 JSON 编码）
- Parse to plain text **ON**：发布 `"Temperature is 25.5°C"`（无外层引号）

{% capture parse_note %}
**注意**：此设置仅影响 JSON 编码的字符串（用双引号包裹的字符串）。普通 JSON 对象如 `{"temperature":25.5}` 无论如何设置均原样发布。
{% endcapture %}
{% include templates/info-banner.md content=parse_note %}

#### Quality of Service（服务质量）

所有消息均以 **QoS 1 (AT_LEAST_ONCE)** 发布。这保证消息至少送达 broker 一次，网络异常时可能多次送达。QoS 等级不可配置。

#### Retained（保留）

- **Disabled**（默认）— broker 不保留消息。
- **Enabled** — broker 保留消息并向 topic 的后续订阅者投递，即使他们在消息发布后才订阅。

保留消息适用于发布设备状态或配置，以便新订阅者订阅时立即收到。

### Protocol version（协议版本）

选择连接使用的 MQTT 协议版本。可用选项：

- **MQTT 3.1** — 旧版，Client ID 限制 23 字符
- **MQTT 3.1.1** — 最广泛支持的版本（默认）
- **MQTT 5** — 最新版本，功能增强

{% capture protocol_note %}
**注意**：请确认 MQTT broker 支持所选协议版本。大多数现代 broker 支持 MQTT 3.1.1 和 MQTT 5。
{% endcapture %}
{% include templates/info-banner.md content=protocol_note %}

### Session settings（会话设置）

#### Clean session

- **Enabled**（默认）— broker 不为客户端存储任何会话状态。客户端重连时从干净状态开始。
- **Disabled** — broker 为客户端存储会话状态及未投递的 QoS 1、QoS 2 消息。客户端重连时可接收断开期间队列中的消息。

因本规则节点仅发布消息且不订阅任何 topic，通常应保持 clean session 启用。

### Security settings（安全设置）

#### Enable SSL

- **Disabled**（默认）— 连接使用明文 TCP，无加密。
- **Enabled** — 连接使用 TLS/SSL 加密。启用时需配置凭据。

### Credentials（凭据）

连接 MQTT broker 的认证凭据。可用凭据类型：

#### Anonymous（匿名）

无需认证。当 MQTT broker 允许匿名连接时使用。

#### Basic（基本）

用户名与密码认证。

**配置**：

- **Username** — MQTT broker 认证用户名
- **Password** — MQTT broker 认证密码

#### PEM Certificate（PEM 证书）

使用 PEM 编码文件的证书认证。通过双向 TLS 提供最高安全级别。

**配置**：

- **Server CA certificate file** — 签署 broker 证书的 CA 证书，用于验证 broker 身份。
- **Client certificate file** — 客户端公钥证书，发送给 broker 用于客户端认证。
- **Client private key file** — 与客户端证书对应的客户端私钥。
- **Private key password** — 私钥文件加密时的可选密码。

{% capture cert_requirement_note %}
**注意**：使用 PEM 凭据时，至少需提供 Server CA 证书文件，或同时提供 Client 证书与 Client 私钥文件。
{% endcapture %}
{% include templates/info-banner.md content=cert_requirement_note %}

{% capture credentials_note %}
**注意**：证书和密钥文件可直接上传，或从 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 引用以增强安全性。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### Advanced settings（高级设置）

#### Force acknowledgement（强制确认）

强制确认机制由环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 控制。该变量设为 `true` 时，适用于包括本 MQTT 节点在内的所有外部节点。

**启用强制确认时的行为**：

- 入站消息立即被确认并创建副本
- 执行 MQTT 发布操作
- 发布完成后，消息副本加入队列供下一节点处理
- 可避免慢速 MQTT broker 导致的消息处理超时

**禁用强制确认时**（默认）：

- 原始入站消息在 MQTT 发布完成前保持占用
- 随后将消息传递至下一节点

#### MQTT retransmission（MQTT 重传）

节点使用平台内部 MQTT 客户端，包含重传机制以提高 QoS 1 消息的可靠性。发送 PUBLISH 消息后，客户端等待 broker 确认。若在可配置的延迟时间内未收到确认，则重传消息。

重传间隔采用带抖动的指数退避策略：

- 延迟从初始值开始，每次重试翻倍
- 抖动因子引入随机偏差（±百分比）以避免多客户端同步重试

**示例**：最大尝试 3 次、初始延迟 5,000 ms、抖动因子 0.15 时，重传大致发生在：

- 5,000 ms（±15%）
- 10,000 ms（±15%）
- 20,000 ms（±15%）

若所有重试后仍未收到确认，消息将被丢弃并经 `Failure` 连接路由并附带适当错误信息。

**配置**：

重传参数在 `thingsboard.yml` 中全局配置，适用于平台上所有 MQTT 客户端：

```yaml
mqtt:
  client:
    retransmission:
      max_attempts: "${TB_MQTT_CLIENT_RETRANSMISSION_MAX_ATTEMPTS:3}"
      initial_delay_millis: "${TB_MQTT_CLIENT_RETRANSMISSION_INITIAL_DELAY_MILLIS:5000}"
      jitter_factor: "${TB_MQTT_CLIENT_RETRANSMISSION_JITTER_FACTOR:0.15}"
```

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMqttNodeConfiguration",
  "type": "object",
  "properties": {
    "topicPattern": {
      "type": "string",
      "minLength": 1,
      "description": "MQTT topic where messages will be published (supports templatization)."
    },
    "host": {
      "type": "string",
      "minLength": 1,
      "description": "Hostname or IP address of the MQTT broker."
    },
    "port": {
      "type": "integer",
      "minimum": 1,
      "maximum": 65535,
      "description": "Port number of the MQTT broker."
    },
    "connectTimeoutSec": {
      "type": "integer",
      "minimum": 1,
      "description": "Maximum time to wait for connection establishment (seconds)."
    },
    "clientId": {
      "type": "string",
      "description": "Optional MQTT client identifier. Leave empty for auto-generated ID."
    },
    "appendClientIdSuffix": {
      "type": "boolean",
      "description": "Whether to append Service ID as suffix to Client ID."
    },
    "retainedMessage": {
      "type": "boolean",
      "description": "Whether the broker should retain the message for future subscribers."
    },
    "cleanSession": {
      "type": "boolean",
      "description": "Whether to start with a clean session (no stored state)."
    },
    "ssl": {
      "type": "boolean",
      "description": "Whether to use TLS/SSL encryption."
    },
    "parseToPlainText": {
      "type": "boolean",
      "description": "Whether to convert JSON message data to plain text."
    },
    "protocolVersion": {
      "type": "string",
      "enum": [
        "MQTT_3_1",
        "MQTT_3_1_1",
        "MQTT_5"
      ],
      "description": "MQTT protocol version to use."
    },
    "credentials": {
      "type": "object",
      "description": "Authentication credentials for the MQTT broker."
    }
  },
  "required": [
    "topicPattern",
    "host",
    "port",
    "connectTimeoutSec",
    "cleanSession",
    "ssl",
    "retainedMessage",
    "parseToPlainText",
    "protocolVersion",
    "credentials"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 规则节点初始化

规则节点初始化时会建立与 MQTT broker 的连接：

1. 节点使用配置的 **Credentials** 在 **Host** 和 **Port** 处连接 broker。
2. 连接使用配置的 **Protocol version** 和 **Clean session** 设置。
3. 若启用 **SSL**，建立 TLS 安全连接。
4. 连接须在 **Connection timeout** 规定时间内完成，否则初始化失败。

连接建立后，在规则节点生命周期内保持打开，随时可发布消息。

## 消息处理

对每条入站消息，节点执行以下步骤：

1. 若启用 **Force acknowledgement**，入站消息立即被确认并创建副本。
2. 节点处理 **Topic pattern**，用入站消息 data 和 metadata 中的值替换模板，构建最终 MQTT topic。
3. 若启用 **Parse to plain text**，处理消息 data 以移除外层 JSON 编码。
4. 节点将消息 payload 发布到 MQTT broker：
    - 消息以 **QoS 1 (AT_LEAST_ONCE)** 发布到构建的 topic。
    - 按配置应用 **Retained** 标志。
5. 发布操作完成时：
    - 成功：原始消息（或启用强制确认时的消息副本）经 `Success` 连接转发。
    - 失败：在消息 metadata 的 `error` 键下添加错误详情，消息经 `Failure` 连接转发。

## 规则节点关闭

规则节点关闭时，会断开与 MQTT broker 的连接并释放相关资源。

关闭发生在以下场景：

- **Rule node configuration is updated** — 节点被销毁并使用新配置重新初始化。
- **Rule node is deleted** — 节点被销毁且不重新初始化。

{% capture shutdown_note %}
**注意**：若规则引擎实例崩溃或被强制终止（如 SIGTERM、SIGKILL），不会执行关闭流程。
{% endcapture %}
{% include templates/info-banner.md content=shutdown_note %}

## 出站消息格式

出站消息格式取决于 **Force acknowledgement** 设置：

**禁用强制确认时**（默认）：

- 出站消息为原始入站消息
- 消息 data、metadata、originator 和 type 保持不变

**启用强制确认时**：

- 出站消息为原始入站消息的副本
- 副本为独立消息实例，但包含相同的 data、metadata、originator 和 type

**失败时**：

- 在消息 metadata 的 `error` 键下添加错误详情，格式为：`ExceptionClass: error message`
- 其他消息属性保持不变

## 输出连接

- **Success**
    - 消息已成功发布到 MQTT broker。
- **Failure**
    - 因网络问题或 broker 错误导致发布失败。
    - 处理过程中发生意外错误。

## 示例

### 示例 1 — 向云 MQTT broker 发布 telemetry

温度传感器发送需转发到云 MQTT broker 的 telemetry 数据。消息按设备类型和名称发布到对应 topic。强制确认已禁用。

**入站消息**

Originator：`DEVICE`（Temperature Sensor）

Metadata：

```json
{
  "deviceType": "temperature",
  "deviceName": "sensor-warehouse-01",
  "ts": 1672531200000
}
```

Data：

```json
{
  "temperature": 22.5,
  "humidity": 65
}
```

**节点配置**

```json
{
  "topicPattern": "factory/sensors/${deviceType}/${deviceName}",
  "host": "mqtt.cloud-provider.com",
  "port": 8883,
  "connectTimeoutSec": 10,
  "clientId": "thingsboard-publisher",
  "appendClientIdSuffix": true,
  "retainedMessage": false,
  "cleanSession": true,
  "ssl": true,
  "parseToPlainText": false,
  "protocolVersion": "MQTT_3_1_1",
  "credentials": {
    "type": "basic",
    "username": "factory-user",
    "password": "secure-password"
  }
}
```

**出站消息**

出站消息与入站消息相同。因强制确认已禁用，发布成功后原始入站消息传递至下一节点。

**结果**

消息通过 TLS 安全连接和用户名/密码认证，发布到云 MQTT broker 的 topic `factory/sensors/temperature/sensor-warehouse-01`。JSON payload 原样发布。随后消息经 `Success` 连接路由。
