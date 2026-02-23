使用 [MQTT 协议](https://learn.microsoft.com/en-us/azure/iot/iot-mqtt-connect-to-iot-hub#sending-device-to-cloud-messages)通过安全 TLS 连接，以 QoS 1（至少一次）向 [Azure IoT Hub](https://azure.microsoft.com/en-us/products/iot-hub) 发布消息。支持基于入站消息动态构建 topic 模式，及包括 SAS 令牌和证书认证在内的多种认证方式。

## 配置

### Topic

指定发布消息的 Azure IoT Hub 主题。支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/)。

### Hostname

Azure IoT Hub 的主机名，格式为 `<iot-hub-name>.azure-devices.net`。

{% capture port_note %}
**注意**：端口固定为 8883（Azure IoT Hub 标准 MQTT 端口）。
{% endcapture %}
{% include templates/info-banner.md content=port_note %}

{% capture connection_behavior_note %}
**注意**：与 Azure IoT Hub 的所有连接均使用以下固定设置：启用 SSL、启用 clean session、QoS 1（至少一次）、无保留消息。
{% endcapture %}
{% include templates/info-banner.md content=connection_behavior_note %}

### Device ID

连接 Azure IoT Hub 的设备标识符。该字段必填，须与 Azure IoT Hub 中注册的设备 ID 匹配。

### Protocol version

连接使用的 MQTT 协议版本。仅支持 **MQTT 3.1.1**。

### Credentials（凭据）

连接 Azure IoT Hub 的认证凭据。节点支持两种凭据类型：

#### SAS Token (Shared Access Signature)

Token-based authentication
using [Azure IoT Hub Shared Access Signatures](https://learn.microsoft.com/en-us/azure/iot-edge/how-to-authenticate-downstream-device#symmetric-key-authentication). This is the
most common authentication method for Azure IoT Hub.

**Configuration**:

- **SAS Key** – The shared access key for the device. This is generated when you register a device in Azure IoT Hub. The node automatically generates the SAS token from this key.
- **CA certificate file** – Optional. The Certificate Authority (CA) certificate for verifying the Azure IoT Hub server. If not provided, the node automatically uses the DigiCert
  Global Root G2 certificate.

{% capture sas_credentials_note %}
**注意**：SAS 密钥和 CA 证书文件可直接上传，或从 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 引用以增强安全性。
{% endcapture %}
{% include templates/info-banner.md content=sas_credentials_note %}

#### PEM Certificate (X.509)

Certificate-based authentication using [X.509 certificates](https://learn.microsoft.com/en-us/azure/iot-edge/how-to-authenticate-downstream-device#x509-ca-signed-authentication).
This provides enhanced security through certificate-based mutual [TLS authentication](https://learn.microsoft.com/en-us/azure/iot/iot-mqtt-connect-to-iot-hub#tls-configuration).

**Configuration**:

- **CA certificate file** – Optional. The Azure IoT Hub CA certificate. If not provided, the node automatically uses the DigiCert Global Root G2 certificate.
- **Client certificate file** – The X.509 client certificate registered with your device in Azure IoT Hub. This certificate must be uploaded to Azure IoT Hub before use.
- **Client private key file** – The private key corresponding to the client certificate.
- **Private key password** – Optional password if the private key file is encrypted.

{% capture cert_credentials_note %}
**注意**：证书和密钥文件可直接上传，或从 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 引用以增强安全性。
{% endcapture %}
{% include templates/info-banner.md content=cert_credentials_note %}

### Additional information

#### Singleton mode

The Azure IoT Hub node operates exclusively in **Singleton mode**. This means:

- The rule node is launched on only one rule engine instance, regardless of how many rule engine instances are running in the cluster
- There is only one MQTT client connection to Azure IoT Hub
- This prevents conflicts with Azure IoT Hub's device connection policies

{% capture singleton_note %}
**注意**：Azure IoT Hub 节点的 Singleton 模式不可禁用。这是平台要求，以确保与 Azure IoT Hub 正确进行设备身份管理。
{% endcapture %}
{% include templates/info-banner.md content=singleton_note %}

#### Force acknowledgement

The force acknowledgement mechanism is controlled by the `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` environment variable. When this variable is set to `true`, it applies to all external
nodes including the Azure IoT Hub node.

**Behavior when force acknowledgement is enabled**:

- The incoming message is acknowledged immediately and a copy is created
- The Azure IoT Hub publish operation executes
- Once the publish operation completes, the message copy is added to the queue for processing by the next node
- This prevents message processing timeouts for slow network connections or Azure IoT Hub throttling

**Behavior when force acknowledgement is disabled** (default):

- The original incoming message is held until the Azure IoT Hub publish operation completes
- The message is then passed to the next node

#### MQTT retransmission

The node uses the platform's internal MQTT client, which includes a retransmission mechanism to improve reliability for QoS 1 messages. When a PUBLISH message is sent, the client
waits for an acknowledgment from Azure IoT Hub. If no acknowledgment is received within a configurable delay period, the message is retransmitted.

The delay between retransmissions follows an exponential backoff strategy with jitter:

- The delay starts from an initial value and doubles with each retry attempt
- A jitter factor introduces random variance (±percentage) to prevent synchronized retries across multiple clients

**Example**: With three maximum attempts, 5,000 ms initial delay, and 0.15 jitter factor, retransmissions occur at approximately:

- 5,000 ms (±15%)
- 10,000 ms (±15%)
- 20,000 ms (±15%)

If no acknowledgment is received after all retry attempts, the message is dropped and routed via the `Failure` connection with an appropriate error message.

**Configuration**:

Retransmission parameters are configured globally in the `thingsboard.yml` file and apply to all MQTT clients on the platform:

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
  "title": "TbAzureIotHubNodeConfiguration",
  "type": "object",
  "properties": {
    "topicPattern": {
      "type": "string",
      "minLength": 1,
      "default": "devices/<device_id>/messages/events/",
      "description": "Azure IoT Hub topic where messages will be published (supports templatization)."
    },
    "host": {
      "type": "string",
      "minLength": 1,
      "description": "Azure IoT Hub hostname in format <iot-hub-name>.azure-devices.net"
    },
    "port": {
      "type": "integer",
      "const": 8883,
      "description": "Port number (fixed at 8883 for Azure IoT Hub)."
    },
    "clientId": {
      "type": "string",
      "minLength": 1,
      "description": "Device identifier (must match Azure IoT Hub device ID)."
    },
    "cleanSession": {
      "type": "boolean",
      "const": true,
      "description": "Always true for Azure IoT Hub (no stored state)."
    },
    "ssl": {
      "type": "boolean",
      "const": true,
      "description": "Always true for Azure IoT Hub (TLS/SSL required)."
    },
    "protocolVersion": {
      "type": "string",
      "const": "MQTT_3_1_1",
      "description": "MQTT protocol version (only MQTT 3.1.1 is supported)."
    },
    "credentials": {
      "type": "object",
      "oneOf": [
        {
          "properties": {
            "type": {
              "const": "SAS"
            },
            "sasKey": {
              "type": "string",
              "description": "Azure IoT Hub shared access key."
            },
            "caCert": {
              "type": "string",
              "description": "Azure IoT Hub CA certificate (optional, defaults to Azure's CA)."
            }
          },
          "required": [
            "type",
            "sasKey"
          ]
        },
        {
          "properties": {
            "type": {
              "const": "CERT_PEM"
            },
            "caCert": {
              "type": "string",
              "description": "Azure IoT Hub CA certificate (optional, defaults to Azure's CA)."
            },
            "cert": {
              "type": "string",
              "description": "X.509 client certificate."
            },
            "privateKey": {
              "type": "string",
              "description": "Client private key."
            },
            "password": {
              "type": "string",
              "description": "Private key password (optional)."
            }
          },
          "required": [
            "type",
            "cert",
            "privateKey"
          ]
        }
      ],
      "description": "Authentication credentials (SAS or X.509 certificate)."
    }
  },
  "required": [
    "topicPattern",
    "host",
    "port",
    "cleanSession",
    "ssl",
    "protocolVersion",
    "credentials"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 规则节点初始化

规则节点初始化时会建立与 Azure IoT Hub 的安全连接。 If no CA certificate is provided, the node automatically uses the DigiCert Global Root G2
certificate. Once the connection is established, it remains open for the lifetime of the rule node, ready to publish messages to Azure IoT Hub.

## 消息处理

对每条入站消息，节点执行以下步骤：

1. If **Force acknowledgement** is enabled, the incoming message is acknowledged immediately and a copy is created.
2. The node processes the **Topic** pattern, replacing templates with values from the incoming message data and metadata to construct the final Azure IoT Hub topic.
3. The node publishes the message data to Azure IoT Hub:
    - The message is published to the constructed topic with **QoS 1 (AT_LEAST_ONCE)**.
    - The connection uses the automatically configured Azure IoT Hub credentials and settings.
4. When the publish operation completes:
    - On success, the original message (or the message copy if force acknowledgement is enabled) is forwarded via the `Success` connection.
    - On failure, error details are added to the message metadata under the `error` key, and the message is forwarded via the `Failure` connection.

## 规则节点关闭

规则节点关闭时会断开与 Azure IoT Hub 的连接并释放相关资源。

关闭发生在以下场景：

- **Rule node configuration is updated** — 节点被销毁并使用新配置重新初始化。
- **Rule node is deleted** — 节点被销毁且不重新初始化。

{% capture shutdown_note %}
**注意**：若规则引擎实例崩溃或被强制终止（如 SIGTERM、SIGKILL），不会执行关闭流程。
{% endcapture %}
{% include templates/info-banner.md content=shutdown_note %}

## 出站消息格式

**成功时**：

- 消息原样经 `Success` 连接转发

**失败时**：

- 在消息 metadata 的 `error` 键下添加错误详情，格式为：`ExceptionClass: error message`
- 其他消息属性保持不变

## 输出连接

- **Success**
    - The message was successfully published to Azure IoT Hub.
    - Azure IoT Hub acknowledged receipt of the message (QoS 1).
- **Failure**
    - The publish operation failed.
    - An unexpected error occurred during processing.

## 示例

### 示例 1 — 使用 SAS 令牌向 Azure IoT Hub 发布设备 telemetry

温度传感器发送需转发到 Azure IoT Hub 的 telemetry 数据。设备已在 Azure IoT Hub 注册并使用 SAS 令牌认证。强制确认已禁用。

**入站消息**

Originator：`DEVICE`（Temperature Sensor）

Metadata：

```json
{
  "deviceId": "temp-sensor-001",
  "deviceType": "TemperatureSensor",
  "ts": 1672531200000
}
```

Data:

```json
{
  "temperature": 22.5,
  "humidity": 65,
  "pressure": 1013.25
}
```

**节点配置**

```json
{
  "topicPattern": "devices/${deviceId}/messages/events/",
  "host": "my-company-hub.azure-devices.net",
  "port": 8883,
  "clientId": "temp-sensor-001",
  "cleanSession": true,
  "ssl": true,
  "protocolVersion": "MQTT_3_1_1",
  "credentials": {
    "type": "SAS",
    "sasKey": "xlR3T8vK2mN5hQ7wP1jY9sZ4fG6bV0cX=="
  }
}
```

**出站消息**

出站消息与入站消息相同。因强制确认已禁用，发布成功后原始入站消息传递至下一节点。

**结果**

节点自动执行：

1. Constructs the MQTT username: `my-company-hub.azure-devices.net/temp-sensor-001/?api-version=2020-09-30`
2. Generates a SAS token from the provided SAS key
3. Establishes a secure TLS connection on port 8883
4. Publishes the message to topic `devices/temp-sensor-001/messages/events/`

The message data is sent to Azure IoT Hub and becomes available for routing and processing by Azure services. The message is then routed via the `Success` connection.
