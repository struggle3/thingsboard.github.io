根据配置和入站消息，将入站消息转换为适合邮件发送的格式。准备好的消息经 `Success` 连接发送，并应路由至**发送邮件**节点进行实际投递。

## 配置

### 发件人

- **From** — 发件人邮箱地址。

### 收件人

- **To** — 主要收件人邮箱地址，逗号分隔。
- **Cc** — 抄送收件人邮箱地址，逗号分隔。
- **Bcc** — 密送收件人邮箱地址，逗号分隔。

### 邮件主题与内容

- **Subject** — 邮件主题行。
- **Mail body type** — 决定邮件正文的处理方式。
    - *Plain text* — 正文以纯文本发送，无格式。
    - *HTML* — 正文以 HTML 渲染，支持格式、链接和图片。
    - *Use body type template* — 正文类型（HTML 或纯文本）在运行时根据模板确定。
        - **Body type template** — 模板（如 `${useHtml}`），应根据入站消息 data 或 metadata 解析为 `"true"`（HTML）或 `"false"`（纯文本）。
- **Body** — 邮件正文内容。

{% capture templatization_support_note %}
**注意：** 所有输入字段均支持模板。
{% endcapture %}
{% include templates/info-banner.md content=templatization_support_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgToEmailNodeConfiguration",
  "type": "object",
  "properties": {
    "fromTemplate": {
      "type": "string",
      "description": "Template for the sender's email address (From)."
    },
    "toTemplate": {
      "type": "string",
      "description": "Template for the primary recipients' email addresses (To), comma-separated."
    },
    "ccTemplate": {
      "type": "string",
      "description": "Template for the carbon copy recipients' email addresses (Cc), comma-separated."
    },
    "bccTemplate": {
      "type": "string",
      "description": "Template for the blind carbon copy recipients' email addresses (Bcc), comma-separated."
    },
    "subjectTemplate": {
      "type": "string",
      "description": "Template for the email subject line."
    },
    "bodyTemplate": {
      "type": "string",
      "description": "Template for the email body content."
    },
    "mailBodyType": {
      "type": "string",
      "description": "Determines the content type of the email body.",
      "enum": [
        "false",
        "true",
        "dynamic"
      ]
    },
    "isHtmlTemplate": {
      "type": "string",
      "description": "Template to dynamically determine if the body is HTML. Used when 'mailBodyType' is 'dynamic'. Should resolve to 'true' or 'false'."
    }
  },
  "required": [
    "fromTemplate",
    "toTemplate",
    "subjectTemplate",
    "bodyTemplate",
    "mailBodyType"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点接收入站消息。
2. 通过替换模板为对应值，处理所有已配置的模板字段（`From`、`To`、`Cc`、`Bcc`、`Subject`、`Body`、`Body type template`）。
3. 在 `Subject` 和 `Body` 字段中处理**特殊模式**：
    - **日期格式** — 可使用模式 `%d{...}` 插入当前日期时间，花括号内为 Java `SimpleDateFormat` 模式（如 `Device Alert at %d{yyyy-MM-dd HH:mm:ss}`）。使用的日期为消息处理时的时间戳。
    - **时区** — 日期格式可支持时区。若入站消息 metadata 包含名为 `emailTimezone` 的键且为有效时区 ID（如 `Europe/Kyiv` 或 `America/New_York`），将应用该时区。否则使用服务器默认时区。
4. 节点检查入站消息 metadata 中的特定键以包含**附件**或**内嵌图片**：
    - `attachments` — 文件 UUID 的逗号分隔字符串（系统 Blob Entity ID）。每个文件将作为邮件附件。
    - `reports` — 报告 UUID 的逗号分隔字符串。系统将附加对应的报告文件。
    - `images` — 表示 Content-ID（CID）到 data URL 映射的 JSON 字符串（如 `{"logo": "data:image/png;base64,..."}`）。可在 HTML 邮件正文中使用 `<img src="cid:logo">` 内嵌图片。
5. 处理完成后，节点构建类型为 `SEND_EMAIL` 的消息。该新消息的 data 是包含所有邮件详情（from、to、subject、body 等）的 JSON 对象。
6. 该新 `SEND_EMAIL` 消息经 `Success` 连接路由。

## 输出连接

- `Success`：
    - 转换后的类型为 `SEND_EMAIL` 的消息经此连接发送。
- `Failure`：
    - 转换过程中发生错误时发送原始消息。

## 示例

### 示例 1：准备告警邮件

本示例展示当设备温度读数过高时，如何配置节点以准备基本告警邮件。

**场景**：设备发送带温度读数的消息。若温度过高，使用「创建告警」节点创建 `High Temperature` 告警。告警创建相关消息随后路由至「to email」节点。

**入站消息**

Data:

```json
{
  "id": {
    "entityType": "ALARM",
    "id": "0bb1683d-4ce1-4c94-8fa8-0a12aa1e77e3"
  },
  "createdTime": 1756464801953,
  "tenantId": {
    "entityType": "TENANT",
    "id": "e37d0ee0-84bb-11f0-aa77-9bb4115aa01d"
  },
  "customerId": null,
  "type": "High Temperature",
  "originator": {
    "entityType": "DEVICE",
    "id": "dd312c60-84c0-11f0-aa77-9bb4115aa01d"
  },
  "severity": "CRITICAL",
  "acknowledged": false,
  "cleared": false,
  "assigneeId": null,
  "startTs": 1756464801946,
  "endTs": 1756464801946,
  "ackTs": 0,
  "clearTs": 0,
  "assignTs": 0,
  "propagate": false,
  "propagateToOwner": false,
  "propagateToOwnerHierarchy": false,
  "propagateToTenant": false,
  "propagateRelationTypes": [],
  "originatorName": "device",
  "originatorLabel": "device",
  "assignee": null,
  "name": "High Temperature",
  "status": "ACTIVE_UNACK",
  "details": {
    "temperatureValue": 95.5,
    "temperatureThreshold": 90
  }
}
```

Metadata:

```json
{
  "deviceName": "TempSensor-A1",
  "deviceType": "Temperature Sensor"
}
```

**节点配置**

```json
{
  "fromTemplate": "alarms@yourcompany.com",
  "toTemplate": "example@yourcompany.com",
  "ccTemplate": null,
  "bccTemplate": null,
  "subjectTemplate": "${deviceType} - ${deviceName}: High temperature alarm",
  "mailBodyType": "false",
  "bodyTemplate": "A temperature of $[details.temperatureValue] exceeds the threshold of $[details.temperatureThreshold]."
}
```

**出站消息**

经 `Success` 链发送类型为 `SEND_EMAIL` 的消息。其 data 为表示待发送邮件的 JSON 对象：

```json
{
  "from": "alarms@yourcompany.com",
  "to": "example@yourcompany.com",
  "cc": null,
  "bcc": null,
  "subject": "Temperature Sensor - TempSensor-A1: High temperature alarm",
  "body": "A temperature of 95.5 exceeds the threshold of 90.",
  "attachments": null,
  "reports": null,
  "images": null,
  "html": false
}
```

**说明**：节点使用替换模式动态构建邮件。主题通过从消息 metadata 取 `${deviceType}` 和 `${deviceName}` 生成。正文使用消息 data 中的值构建，特别是 `$[details.temperatureValue]` 和 `$[details.temperatureThreshold]`。如出站消息所示，这些占位符被入站消息中的对应值替换，形成可发送的完整邮件。
