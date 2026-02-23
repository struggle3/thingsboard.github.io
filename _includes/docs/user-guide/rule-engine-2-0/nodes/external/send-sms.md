通过配置的短信提供商向指定电话号码发送短信。

## 配置

### Phone Numbers To Template

将接收短信的电话号码，逗号分隔。该字段支持[模板](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。

### SMS Message Template

要发送的短信内容。该字段支持[模板](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。

### Use System SMS Provider Settings

启用后，节点使用[系统设置中配置的短信提供商](/docs/{{docsPrefix}}user-guide/ui/sms-provider-settings/){:target="_blank"}。
可在租户或系统级集中配置短信提供商，而无需逐个配置规则节点。

禁用后，必须直接在规则节点中配置短信提供商。支持以下短信提供商类型：

#### AWS SNS

用于短信配送的 Amazon Simple Notification Service。所需配置：

- **AWS Access Key ID** — 具有 SNS 权限的 AWS IAM 访问密钥 ID。
- **AWS Secret Access Key** — AWS IAM 私密访问密钥。
- **AWS Region** — SNS 的 AWS 区域（如 `us-east-1`、`eu-west-1`）。

#### Twilio

Twilio 消息服务。所需配置：

- **Phone Number From** — 发送方 Twilio 电话号码或 Messaging Service SID（E.164 格式，如 `+19995550123`）。
- **Twilio Account SID** — Twilio 账户标识符。
- **Twilio Account Token** — Twilio 认证令牌。

#### SMPP

用于直接运营商对接的 SMS Messaging Peer-to-Peer 协议。SMPP 配置详情请参阅 [SMPP 协议规范](https://smpp.org/){:target="_blank"}。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSendSmsNodeConfiguration",
  "type": "object",
  "properties": {
    "numbersToTemplate": {
      "type": "string",
      "description": "Template for target phone number(s). Supports templatization."
    },
    "smsMessageTemplate": {
      "type": "string",
      "description": "Template for SMS message content. Supports templatization."
    },
    "useSystemSmsSettings": {
      "type": "boolean",
      "description": "If true, uses system-configured SMS provider. If false, uses provider configured in this node."
    },
    "smsProviderConfiguration": {
      "description": "SMS provider configuration (required when useSystemSmsSettings is false).",
      "oneOf": [
        {
          "type": "object",
          "title": "AWS SNS",
          "properties": {
            "type": {
              "type": "string",
              "enum": [
                "AWS_SNS"
              ]
            },
            "accessKeyId": {
              "type": "string",
              "description": "AWS Access Key ID"
            },
            "secretAccessKey": {
              "type": "string",
              "description": "AWS Secret Access Key"
            },
            "region": {
              "type": "string",
              "description": "AWS region (e.g., us-east-1)"
            }
          },
          "required": [
            "type",
            "accessKeyId",
            "secretAccessKey",
            "region"
          ]
        },
        {
          "type": "object",
          "title": "Twilio",
          "properties": {
            "type": {
              "type": "string",
              "enum": [
                "TWILIO"
              ]
            },
            "numberFrom": {
              "type": "string",
              "description": "Twilio phone number or Messaging Service SID"
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
            "type",
            "numberFrom",
            "accountSid",
            "accountToken"
          ]
        },
        {
          "type": "object",
          "title": "SMPP",
          "properties": {
            "type": {
              "type": "string",
              "enum": [
                "SMPP"
              ]
            }
          },
          "required": [
            "type"
          ],
          "description": "SMPP configuration with additional provider-specific properties"
        }
      ]
    }
  },
  "required": [
    "numbersToTemplate",
    "smsMessageTemplate",
    "useSystemSmsSettings"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点不修改入站消息。消息 data 和 metadata 均原样传递至链中下一节点。

## 消息确认行为

节点的消息确认行为由 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 环境变量控制：

- **设为 `true` 时** — 入站消息在接收后立即被确认并标记为已成功处理。创建消息副本。短信发送操作异步进行，完成后将副本加入队列供下一节点处理。
- **设为 `false` 时**（默认）— 入站消息在整个短信发送操作期间保持处理中状态。短信操作完成后将消息传递至下一节点。

## 消息处理逻辑

1. 节点处理电话号码模板，从入站消息 data 和 metadata 中提取目标电话号码。
2. 节点处理短信内容模板，使用入站消息 data 和 metadata 中的值创建消息内容。
3. 通过系统配置的短信提供商或节点专用的短信提供商配置异步发送短信。
4. 处理完成时：
    - **Success**：消息经 `Success` 连接路由。
    - **Failure**：消息经 `Failure` 连接路由。

## 输出连接

- **Success**
    - 短信已成功发送至所有指定电话号码。
- **Failure**
    - 短信发送过程中发生意外错误（如无效电话号码格式、短信提供商认证失败、网络错误）。

## 示例

### 示例 1 — 发送温度告警

设备上报高温时发送短信告警。

**入站消息**

Data:

```json
{
  "temperature": 85.3,
  "humidity": 45.2
}
```

Metadata:

```json
{
  "deviceName": "Temperature Sensor 01",
  "userPhone": "+15551234567"
}
```

**节点配置**

```json
{
  "numbersToTemplate": "${userPhone}",
  "smsMessageTemplate": "Device ${deviceName} has high temperature $[temperature]",
  "useSystemSmsSettings": true
}
```

**出站消息**

Data：不变。

Metadata：不变。

经 `Success` 连接路由。

**结果**

向 +15551234567 发送短信：

```text
Device Temperature Sensor 01 has high temperature 85.3
```
