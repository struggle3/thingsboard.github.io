获取来源设备的凭据并将其添加到消息 data 或 metadata。

## 配置

节点仅有单一配置选项，用于确定获取的凭据应放置的位置。

- **Fetch credentials to** — 确定新凭据字段的目标位置。
    - **Message**：将获取的凭据添加到消息 data。消息 data 必须为 JSON 对象。
    - **Metadata**：将获取的凭据添加到消息 metadata。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbFetchDeviceCredentialsNodeConfiguration",
  "type": "object",
  "properties": {
    "fetchTo": {
      "type": "string",
      "enum": [
        "DATA",
        "METADATA"
      ],
      "description": "Destination for the fetched credentials (message data or metadata)."
    }
  },
  "required": [
    "fetchTo"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点首先检查消息来源实体是否为 `DEVICE`。若来源实体为其他类型（如 `ASSET`、`CUSTOMER`），消息经 `Failure` 连接传递。
2. 随后异步从数据库获取来源设备的凭据。若未找到凭据，消息也经 `Failure` 连接传递。
3. 若找到凭据，节点准备添加两个新字段：
    * `credentialsType`：凭据类型（如 `ACCESS_TOKEN`、`X509_CERTIFICATE`、`MQTT_BASIC`）。
    * `credentials`：凭据值。该字段格式取决于目标：
        * 添加到 *Message* 时，对于复杂凭据（如 MQTT Basic）`credentials` 为 JSON 对象，其他（如 Access Token）为简单字符串。
        * 添加到 *Metadata* 时，`credentials` 值始终为字符串。对于复杂凭据，为字符串化的 JSON 对象。
4. 根据**Fetch credentials to**设置，节点将 `credentialsType` 和 `credentials` 键值对添加到消息 data 或 metadata。
5. 丰富后的消息经 `Success` 连接转发。若发生错误（如来源实体不是设备，或尝试向非 JSON 消息体添加），原始消息经 `Failure` 连接路由。

## 输出连接

- `Success`：
    - 设备凭据已成功获取并添加到消息。
- `Failure`：
    - 消息来源实体不是 `DEVICE`。
    - 无法找到来源设备的凭据。
    - **Fetch credentials to** 设为 *Message*，但消息 data 不是有效 JSON 对象。

## 示例

### 示例 1 — 将设备访问令牌添加到 metadata

**入站消息**

Metadata:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter"
}
```

Originator: 来源实体为具有 **Access Token** 凭据（`sm001_token_123`）的设备。

**节点配置**

```json
{
  "fetchTo": "METADATA"
}
```

**出站消息**

消息经 `Success` 连接发送，metadata 已更新。

Metadata:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter",
  "credentialsType": "ACCESS_TOKEN",
  "credentials": "sm001_token_123"
}
```

**说明**：节点获取来源实体的凭据，将 `credentialsType` 和 `credentials` 添加到消息 metadata。`credentials` 为包含设备访问令牌的字符串。

### 示例 2 — 将 MQTT 凭据添加到 metadata

**入站消息**

Data:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter"
}
```

Originator: 来源实体为具有 **MQTT Basic** 凭据（`"{"clientId":"clientId123","userName":"username","password":"password"}"`）的设备。

**节点配置**

```json
{
  "fetchTo": "METADATA"
}
```

**出站消息**

消息经 `Success` 连接发送，metadata 已更新。

Metadata:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter",
  "credentialsType": "MQTT_BASIC",
  "credentials": "{\"clientId\":\"clientId123\",\"userName\":\"username\",\"password\":\"password123\"}"
}
```

**说明**：节点获取设备的 MQTT Basic 凭据并添加到消息 metadata。`credentials` 字段为包含凭据的字符串化 JSON 对象。

### 示例 3 — 将 X.509 凭据添加到 metadata

**入站消息**

Metadata:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter"
}
```

Originator: 来源实体为具有 **X.509** 凭据（`o3Qwq2xqQz1pQ3R1Z1wYH9MYx3q2Yw2aC0EXAMPLE+CERIFICATEpQxG4b1g0O7r2kVq8pQIDAQAB`）的设备。

**节点配置**

```json
{
  "fetchTo": "METADATA"
}
```

**出站消息**

消息经 `Success` 连接发送，metadata 已更新。

Metadata:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter",
  "credentialsType": "X509_CERTIFICATE",
  "credentials": "o3Qwq2xqQz1pQ3R1Z1wYH9MYx3q2Yw2aC0EXAMPLE+CERIFICATEpQxG4b1g0O7r2kVq8pQIDAQAB"
}
```

**说明**：节点获取设备的 X.509 凭据并添加到消息 metadata。`credentials` 字段为不含头尾的 X.509 证书字符串。

### 示例 4 — 将设备访问令牌添加到 data

**入站消息**

Data:

```json
{
  "temperature": 33,
  "humidity": 56.2
}
```

Originator: 来源实体为具有 **Access Token** 凭据（`sm001_token_123`）的设备。

**节点配置**

```json
{
  "fetchTo": "DATA"
}
```

**出站消息**

消息经 `Success` 连接发送，data 已更新。

Data:

```json
{
  "temperature": 33,
  "humidity": 56.2,
  "credentialsType": "ACCESS_TOKEN",
  "credentials": "sm001_token_123"
}
```

**说明**：节点获取来源实体的凭据，将 `credentialsType` 和 `credentials` 添加到消息 data。`credentials` 为包含设备访问令牌的字符串。

### 示例 5 — 将 MQTT 凭据添加到 data

**入站消息**

Data:

```json
{
  "temperature": 33,
  "humidity": 56.2
}
```

Originator: 来源实体为具有 **MQTT Basic** 凭据（`"{"clientId":"clientId123","userName":"username","password":"password"}"`）的设备。

**节点配置**

```json
{
  "fetchTo": "DATA"
}
```

**出站消息**

消息经 `Success` 连接发送，data 已更新。

Data:

```json
{
  "deviceName": "SmartMeter-001",
  "deviceType": "SmartMeter",
  "credentialsType": "MQTT_BASIC",
  "credentials": {
    "clientId": "clientId123",
    "userName": "username",
    "password": "password"
  }
}
```

**说明**：节点获取设备的 MQTT Basic 凭据并添加到消息 data。`credentials` 字段为包含凭据的 JSON 对象。

### 示例 6 — 将 X.509 凭据添加到 metadata

**入站消息**

Data:

```json
{
  "temperature": 33,
  "humidity": 56.2
}
```

Originator: 来源实体为具有 **X.509** 凭据（`o3Qwq2xqQz1pQ3R1Z1wYH9MYx3q2Yw2aC0EXAMPLE+CERIFICATEpQxG4b1g0O7r2kVq8pQIDAQAB`）的设备。

**节点配置**

```json
{
  "fetchTo": "DATA"
}
```

**出站消息**

消息经 `Success` 连接发送，data 已更新。

Data:

```json
{
  "temperature": 33,
  "humidity": 56.2
  "credentialsType": "X509_CERTIFICATE",
  "credentials": "o3Qwq2xqQz1pQ3R1Z1wYH9MYx3q2Yw2aC0EXAMPLE+CERIFICATEpQxG4b1g0O7r2kVq8pQIDAQAB"
}
```

**说明**：节点获取设备的 X.509 凭据并添加到消息 data。`credentials` 字段为不含头尾的 X.509 证书字符串。
