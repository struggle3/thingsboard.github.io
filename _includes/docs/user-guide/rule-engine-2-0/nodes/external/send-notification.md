通过[通知中心](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}使用通知模板向指定收件人发送通知。

## 配置

### Template

定义通知内容、格式和配送渠道（Web、Email、SMS、Slack 等）的通知模板。从 ThingsBoard 实例中选择已有的[通知模板](/docs/{{docsPrefix}}user-guide/notifications/#templates){:target="_blank"}。

{% capture template_type_note %}
**注意**：仅类型为 **Rule node** 的通知模板可用于本规则节点。
{% endcapture %}
{% include templates/info-banner.md content=template_type_note %}

可使用 `${key}` 语法引用消息 data 字段、metadata 及其他消息属性，在通知模板中使用[入站消息中的值](/docs/{{docsPrefix}}user-guide/notifications/#rule-node){:target="_blank"}。

{% capture template_syntax_note %}
**注意**：即使对于在规则节点中通常使用 `$[key]` 语法的消息 data 字段，通知模板也要求使用 `${key}` 语法。
{% endcapture %}
{% include templates/info-banner.md content=template_syntax_note %}

### Recipients

将接收通知的[收件人组](/docs/{{docsPrefix}}user-guide/notifications/#recipients){:target="_blank"}列表。可选择多个收件人组。通知系统将自动解析并在所有所选组之间去重。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbNotificationNodeConfiguration",
  "type": "object",
  "properties": {
    "templateId": {
      "type": "object",
      "description": "ID of the notification template to use.",
      "properties": {
        "id": {
          "type": "string",
          "format": "uuid"
        },
        "entityType": {
          "type": "string",
          "enum": [
            "NOTIFICATION_TEMPLATE"
          ]
        }
      },
      "required": [
        "id",
        "entityType"
      ]
    },
    "targets": {
      "type": "array",
      "items": {
        "type": "string",
        "format": "uuid"
      },
      "minItems": 1,
      "description": "List of recipient target UUIDs."
    }
  },
  "required": [
    "templateId",
    "targets"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 输出消息格式

节点通过将通知请求统计添加到消息 metadata 来转换入站消息，同时保留原始消息 data。

当通知成功处理并发送时，以下字段添加到消息 metadata：

- `notificationRequestResult` — 包含通知配送统计的 JSON 字符串，包括：
    - `sent` — 各配送渠道成功发送数量的映射
    - `errors` — 各配送渠道失败数量的映射（如有）
    - `totalSent` — 所有渠道成功发送的总数
    - `totalErrors` — 所有渠道失败的总数
    - `error` — 整个通知请求失败时的错误信息（成功时为 null）

**示例：**

原始消息 metadata：

```json
{
  "deviceType": "sensor"
}
```

通知成功发送后，metadata 变为：

```json
{
  "deviceType": "sensor",
  "notificationRequestResult": "{\"sent\":{\"WEB\":1},\"errors\":{},\"totalErrors\":0,\"error\":null,\"totalSent\":1}"
}
```

消息 data 保持不变。

## 消息确认行为

节点的消息确认行为由 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 环境变量控制：

- **设为 `true` 时** — 入站消息在接收后立即被确认并标记为已成功处理。创建包含更新 metadata 的新消息并加入队列供下一节点处理。
- **设为 `false` 时**（默认）— 入站消息在整个通知操作期间保持处理中状态。消息就地转换，其 metadata 使用通知结果更新，通知完成后将修改后的消息传递至下一节点。

## 消息处理逻辑

1. 节点使用入站消息 data、metadata、来源实体信息及配置的模板和收件人创建通知请求。
2. 通知请求异步提交至通知中心，由通知中心向解析出的收件人发送通知。
3. 处理完成时：
    - **Success**：将配送统计以 `notificationRequestResult` 添加到消息 metadata，消息经 `Success` 连接路由。
    - **Failure**：消息经 `Failure` 连接路由。

## 输出连接

- **Success**
    - 通知已成功处理并发送给收件人。
    - 出站消息 metadata 包含配送统计（`notificationRequestResult`），显示各渠道发送数量。
- **Failure**
    - **意外错误**：通知处理过程中发生意外错误。

## 示例

### 示例 1 — 在通知中发送遥测值

发送包含设备最新遥测值的通知。

**入站消息**

Data:

```json
{
  "temperature": 23.5,
  "humidity": 65.2,
  "pressure": 1013.25
}
```

Metadata:

```json
{
  "deviceName": "Weather Station 01",
  "deviceType": "sensor"
}
```

**节点配置**

```json
{
  "templateId": {
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "entityType": "NOTIFICATION_TEMPLATE"
  },
  "targets": [
    "784f394c-42b6-435a-983c-b7beff2784f9"
  ]
}
```

**节点配置**

ID 为 `a1b2c3d4-e5f6-7890-abcd-ef1234567890` 的通知模板具有以下内容：

```text
Weather Update from ${deviceName}

Current readings:
- Temperature: ${temperature}°C
- Humidity: ${humidity}%
- Pressure: ${pressure} hPa

Device type: ${deviceType}
```

**出站消息**

Data：不变。

Metadata:

```json
{
  "deviceName": "Weather Station 01",
  "deviceType": "sensor",
  "notificationRequestResult": "{\"sent\":{\"WEB\":1},\"errors\":{},\"totalErrors\":0,\"error\":null,\"totalSent\":1}"
}
```

经 `Success` 连接路由。

**结果**

通知已通过 Web 界面成功发送给用户。通知内容：

```text
Weather Update from Weather Station 01

Current readings:
- Temperature: 23.5°C
- Humidity: 65.2%
- Pressure: 1013.25 hPa

Device type: sensor
```
