通过 [Twilio](https://www.twilio.com/voice){:target="_blank"} 语音服务，使用文本转语音技术向指定号码发送语音消息。

## 配置

### Phone settings（电话设置）

- **Phone Number From** — 呼叫发起方 Twilio 号码。须为 E.164 格式（如 `+19995550123`）。该字段支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。
- **Phone Numbers To** — 接收语音呼叫的号码列表（逗号分隔）。该字段支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。

### Account settings

- **Twilio Account SID** – Your Twilio account identifier.
- **Twilio Account Token** – Your Twilio authentication token.

{% capture credentials_note %}
**注意**：若使用 Professional Edition，建议使用 [Secrets storage](/docs/pe/user-guide/secrets-storage/){:target="_blank"} 安全存储账户令牌。
{% endcapture %}
{% include templates/info-banner.md content=credentials_note %}

### Voice settings（语音设置）

- **Voice provider** — 使用的文本转语音提供商。
- **Language** — 语音消息的语言，对应 Twilio 支持的语言。
- **Voice** — 使用的语音类型。

### Audio output settings（音频输出设置）

- **Pitch** — 音高调整百分比（默认：`100`）。值越大音调越高，越小音调越低。
- **Rate** — 语速百分比（默认：`100`）。值越大语速越快，越小语速越慢。
- **Volume** — 音量调整（单位：分贝，默认：`0`）。正值增大音量，负值减小。
- **Pause before talking** — 语音消息开始播放前的暂停时长（秒）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbTwilioVoiceNodeConfiguration",
  "type": "object",
  "properties": {
    "numberFrom": {
      "type": "string",
      "description": "Twilio phone number (E.164 format). Supports templatization."
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
    },
    "provider": {
      "type": "string",
      "description": "Voice provider"
    },
    "language": {
      "type": "string",
      "description": "Voice language"
    },
    "voice": {
      "type": "string",
      "description": "Voice type"
    },
    "pitch": {
      "type": "integer",
      "description": "Pitch percentage (default: 100)"
    },
    "rate": {
      "type": "integer",
      "description": "Speaking rate percentage (default: 100)"
    },
    "volume": {
      "type": "integer",
      "description": "Volume in decibels (default: 0)"
    },
    "startPause": {
      "type": "integer",
      "description": "Pause duration before speaking in seconds"
    }
  },
  "required": [
    "numberFrom",
    "numbersTo",
    "accountSid",
    "accountToken",
    "language",
    "voice",
    "pitch",
    "rate",
    "volume"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点不修改入站消息。消息数据和 metadata 均原样传递给链中下一节点。

## 消息确认行为

节点的消息确认行为由环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 控制：

- **设为 `true`** — 入站消息在接收后立即确认并标记为成功处理，创建副本。语音呼叫异步执行，完成后副本入队交由下一节点处理。
- **设为 `false`**（默认）— 入站消息在整个语音呼叫过程中保持处理中状态。语音呼叫完成后将消息传递给下一节点。

## 消息处理算法

1. 节点处理 from 模板，从入站消息数据和 metadata 中提取主叫号码。
2. 节点处理 to 模板，从入站消息数据和 metadata 中提取被叫号码。
3. 语音消息内容直接取自入站消息数据，去除首尾引号。
4. 使用 Twilio TwiML 构建语音响应：
    - 播报前按配置暂停指定时长
    - 使用指定语言、语音、音高、语速和音量的文本转语音配置
5. 通过 Twilio 异步向每个指定号码发起语音呼叫。
6. 处理完成时：
    - **Success**：所有语音呼叫成功发起后将消息路由到 `Success` 连接。
    - **Failure**：若任一起呼失败，将消息路由到 `Failure` 连接。

## 输出连接

- **Success**
    - 已成功向所有指定号码发起语音呼叫。
- **Failure**
    - 发起语音呼叫时发生意外错误（如号码无效或 Twilio API 错误）。

## 示例

### 示例 1 — 发送 alarm 通知

设备触发 alarm 时发送语音告警。

**入站消息**

数据：

```json
"Attention. Device Temperature Sensor 01 has triggered a high temperature alarm."
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
  "accountToken": "your_auth_token_here",
  "language": "EN_US",
  "voice": "WOMAN",
  "pitch": 100,
  "rate": 100,
  "volume": 0,
  "startPause": 1
}
```

**出站消息**

数据：未更改。

Metadata：未更改。

经 `Success` 连接路由。

**结果**

已从 +15559876543 向 +15551234567 发起语音呼叫。1 秒暂停后，收件人将听到：

```text
Attention. Device Temperature Sensor 01 has triggered a high temperature alarm.
```
