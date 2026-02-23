通过 Slack API 向 [Slack](https://slack.com/){:target="_blank"} 频道或用户发送消息。

## 配置

### Message Template

要发送的 Slack 消息内容。该字段支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/){:target="_blank"}。

### Use System Slack Settings

启用时，节点使用[系统设置中配置的 Slack 令牌](/docs/{{docsPrefix}}user-guide/ui/slack-settings/){:target="_blank"}。
可在租户或系统层面集中配置 Slack，无需在单个规则节点中配置。

禁用时，必须在规则节点中直接配置 Slack 令牌。

### Slack API Token

用于认证的 Slack 令牌。

### Slack Channel Type

指定消息的目标类型：

- **Public channel** — 发送到公共 Slack 频道（如 `#general`、`#alerts`）
- **Private channel** — 发送到私有 Slack 频道（如 `#private-alerts`）
- **Direct message** — 向指定用户发送私信（如 `@john.doe`）

### Conversation

消息的目标 Slack 会话。该字段为必填。

会话从下拉列表中选择，列表由 Slack API 动态填充。配置此字段时：

1. 先在 **Slack API Token** 字段中提供有效 Slack 令牌（或确保已配置系统 Slack 设置）
2. 下拉列表将从 Slack 工作空间获取可用会话
3. 从列表中选择目标频道或用户

配置的 Slack 令牌必须能访问该会话。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbSlackNodeConfiguration",
  "type": "object",
  "properties": {
    "messageTemplate": {
      "type": "string",
      "description": "Template for Slack message content. Supports templatization.",
      "minLength": 1
    },
    "useSystemSettings": {
      "type": "boolean",
      "description": "If true, uses system-configured Slack token. If false, uses token configured in this node."
    },
    "botToken": {
      "type": "string",
      "description": "Slack token (xoxb-...). Required when useSystemSettings is false."
    },
    "conversationType": {
      "type": "string",
      "enum": [
        "PUBLIC_CHANNEL",
        "PRIVATE_CHANNEL",
        "DIRECT"
      ],
      "description": "Type of Slack conversation"
    },
    "conversation": {
      "type": "object",
      "description": "Target Slack conversation",
      "properties": {
        "type": {
          "type": "string",
          "enum": [
            "PUBLIC_CHANNEL",
            "PRIVATE_CHANNEL",
            "DIRECT"
          ]
        },
        "id": {
          "type": "string",
          "description": "Slack conversation ID (channel or user ID)",
          "minLength": 1
        },
        "name": {
          "type": "string",
          "description": "Conversation name or username",
          "minLength": 1
        },
        "wholeName": {
          "type": "string",
          "description": "Full name for direct messages"
        },
        "email": {
          "type": "string",
          "description": "Email for direct messages"
        }
      },
      "required": [
        "type",
        "id",
        "name"
      ]
    }
  },
  "required": [
    "messageTemplate",
    "useSystemSettings",
    "conversation"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点不修改入站消息。消息数据和 metadata 均原样传递给链中下一节点。

## 消息确认行为

节点的消息确认行为由环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 控制：

- **设为 `true`** — 入站消息在接收后立即确认并标记为成功处理，创建副本。Slack 发送操作异步执行，完成后副本入队交由下一节点处理。
- **设为 `false`**（默认）— 入站消息在整个 Slack 发送过程中保持处理中状态。Slack 操作完成后将消息传递给下一节点。

## 消息处理算法

1. 节点确定使用的 Slack 令牌：
    - 若启用 **Use System Slack Settings**，使用系统配置的令牌
    - 否则使用节点配置中的令牌
2. 节点根据入站消息的数据和 metadata 处理消息模板，生成消息内容。
3. 通过 Slack API 将消息异步发送到指定的 Slack 会话。
4. 处理完成时：
    - **Success**：消息路由到 `Success` 连接
    - **Failure**：消息路由到 `Failure` 连接

## 输出连接

- **Success**
    - 消息已成功发送到指定的 Slack 会话
- **Failure**
    - 发送消息时发生意外错误

## 示例

### 示例 1 — 向公共频道发送温度告警

设备上报高温时向公共 Slack 频道发送告警。

**入站消息**

数据：

```json
{
  "temperature": 85.3,
  "humidity": 45.2
}
```

Metadata：

```json
{
  "deviceId": "TEMP_SENSOR_01",
  "deviceName": "Temperature Sensor 01",
  "location": "Server Room A"
}
```

**节点配置**

```json
{
  "messageTemplate": "⚠️ *High Temperature Alert*\nDevice: ${deviceName}\nLocation: ${location}\nTemperature: $[temperature]°F",
  "useSystemSettings": true,
  "conversationType": "PUBLIC_CHANNEL",
  "conversation": {
    "type": "PUBLIC_CHANNEL",
    "id": "C01234ABCDE",
    "name": "alerts"
  }
}
```

**出站消息**

数据：未更改

Metadata：未更改

经 `Success` 连接路由。

**结果**

已向 `#alerts` 频道发送 Slack 消息：

```text
⚠️ High Temperature Alert
Device: Temperature Sensor 01
Location: Server Room A
Temperature: 85.3°F
```
