通过 [Twilio](https://www.twilio.com/messaging/channels/sms){:target="_blank"} 消息服务向指定号码发送短信。

## 配置

- **Phone Number From** — 发送方 Twilio 号码或 Messaging Service SID。须为 E.164 格式（如 `+19995550123`）。该字段支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。
- **Phone Numbers To** — 接收短信的号码列表（逗号分隔）。该字段支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。
- **Twilio Account SID** — Twilio 账户标识。
- **Twilio Account Token** — Twilio 认证令牌。

{% capture credentials_note %}
**注意**：若使用 Professional Edition，建议使用 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 安全存储账户令牌。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbTwilioSmsNodeConfiguration",
  "type": "object",
  "properties": {
    "numberFrom": {
      "type": "string",
      "description": "Twilio phone number or Messaging Service SID (E.164 format). Supports templatization."
    },
    "numbersTo": {
      "type": "string",
      "description": "Comma-separated list of target phone numbers. Supports templatization."
    },
    "accountSid": {
      "type": "string",
      "description": "Twilio Account SID"
    },
    "accountToken": {
      "type": "string",
      "description": "Twilio Account Token"
    }
  },
  "required": [
    "numberFrom",
    "numbersTo",
    "accountSid",
    "accountToken"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点不修改入站消息。消息数据和 metadata 均原样传递给链中下一节点。

## 消息确认行为

节点的消息确认行为由环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 控制：

- **设为 `true`** — 入站消息在接收后立即确认并标记为成功处理，创建副本。短信发送异步执行，完成后副本入队交由下一节点处理。
- **设为 `false`**（默认）— 入站消息在整个短信发送过程中保持处理中状态。短信操作完成后将消息传递给下一节点。

## 消息处理算法

1. 节点处理 from 模板，从入站消息数据和 metadata 中提取发送方号码。
2. 节点处理 to 模板，从入站消息数据和 metadata 中提取目标号码。
3. 短信内容直接取自入站消息 data payload。去除首尾引号，并将转义换行符（`\n`）转换为实际换行。
4. 通过 Twilio 异步向每个指定号码发送短信。
5. 处理完成时：
    - **Success**：所有短信成功发送后将消息路由到 `Success` 连接。
    - **Failure**：若任一条短信发送失败，将消息路由到 `Failure` 连接。

## 输出连接

- **Success**
    - 短信已成功发送到所有指定号码。
- **Failure**
    - 发送短信时发生意外错误。

## 示例

### 示例 1 — 发送 alarm 通知

设备触发 alarm 时发送短信告警。

**入站消息**

数据：

```json
"Device Temperature Sensor 01 has triggered HIGH_TEMPERATURE alarm"
```

Metadata：

```json
{
  "deviceName": "Temperature Sensor 01",
  "alarmType": "HIGH_TEMPERATURE",
  "userPhone": "+15551234567",
  "twilioNumber": "+15559876543"
}
```

**节点配置**

```json
{
  "numberFrom": "${twilioNumber}",
  "numbersTo": "${userPhone}",
  "accountSid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "accountToken": "your_auth_token_here"
}
```

**出站消息**

数据：未更改。

Metadata：未更改。

经 `Success` 连接路由。

**结果**

已从 +15559876543 向 +15551234567 发送短信：

```text
Device Temperature Sensor 01 has triggered HIGH_TEMPERATURE alarm
```

### 示例 2 — 多收件人

向多个号码发送短信通知。

**入站消息**

数据：

```json
"Critical: Water leak detected in Warehouse A"
```

Metadata：

```json
{
  "emergencyContacts": "+15551234567,+15559876543,+15555555555",
  "companyPhone": "+15551111111"
}
```

**节点配置**

```json
{
  "numberFrom": "${companyPhone}",
  "numbersTo": "${emergencyContacts}",
  "accountSid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "accountToken": "your_auth_token_here"
}
```

**出站消息**

数据：未更改。

Metadata：未更改。

经 `Success` 连接路由。

**结果**

已从 +15551111111 向三位收件人（+15551234567、+15559876543、+15555555555）发送短信：

```text
Critical: Water leak detected in Warehouse A
```
