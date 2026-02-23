使用配置的 system 和 user prompt 向大语言模型（LLM）发送请求，可选包含文件资源。Prompt 可根据入站消息动态填充。将 AI 生成内容作为出站消息的 data 返回。

## 配置

### AI model（AI 模型）

选择处理请求的 LLM。**Model** 下拉列表显示 [AI models](/docs/{{docsPrefix}}samples/analytics/ai-models/){:target="_blank"} 页面中已配置的模型。选择模型后，节点会自动应用该模型的所有设置，包括 provider 凭据、model ID 及可选参数。

可点击 **Create new** 按钮在界面中直接添加新 AI 模型。

### Prompt settings（Prompt 设置）

Prompt 定义 AI 模型的上下文与任务。两个字段均支持 [templatization](/docs/{{docsPrefix}}user-guide/templatization/) 以动态融入入站消息数据。

#### System prompt

设置 AI 的高级上下文、人设和约束。该字段可选，若指定则不可为空。最大长度：500,000 字符。

System prompt 建立影响整次交互的规则，如期望语气、响应格式或 expertise 领域。

**示例**：

```
You are a helpful agricultural expert. Your goal is to analyze sensor data and provide farming advice. Respond only in valid JSON.
```

#### User prompt

包含 AI 需回答的具体任务或问题。该字段必填且不可为空。最大长度：500,000 字符。

**示例**：

```
Based on these readings, is the soil moisture optimal for planting corn? Readings: $[*]
```

#### Templatization（模板化）

可使用 [templatization](/docs/{{docsPrefix}}user-guide/templatization/) 使 prompt 动态化。可用模板：

- `$[*]` — 用完整消息 data 的 JSON 字符串替换
- `${*}` — 用所有消息 metadata 的 JSON 字符串替换
- `$[key]` — 用消息 data 中的指定值替换
- `${key}` — 用消息 metadata 中的指定值替换

**示例**：若 user prompt 为 `Telemetry readings: $[*]`，入站 data 为：

```json
{
  "temperature": 25.5,
  "humidity": 62
}
```

模板将生成：`Telemetry readings: {"temperature":25.5,"humidity":62}`

### AI resources（AI 资源）

附加文件以向 AI 模型提供额外上下文。资源与 prompt 一起发送，可包含文档、图片或其它支持的文件类型。

#### Adding resources（添加资源）

点击 **AI resources** 字段，从资源库选择一个或多个文件，或点击 **Create new** 上传新文件。资源类型须为 **General**。

#### Supported resource types（支持的资源类型）

要在 AI 请求中包含附加资源，节点需将其转换为三种支持的内容类型之一。转换由资源的 media type 决定：

| Media Type        | Content Type | Description                                                       |
|-------------------|--------------|-------------------------------------------------------------------|
| `text/*`          | Text         | 纯文本、markdown、CSV 等。内容以 UTF-8 解码 |
| `application/pdf` | PDF          | PDF 文档。内容为 Base64 编码                          |
| `image/*`         | Image        | 图片文件（JPEG、PNG、GIF 等）。内容为 Base64 编码     |

{% capture resource_fallback_note %}
**注意**：若资源的 media type 不在上表中，节点会尝试将其内容解码为 UTF-8 文本。
{% endcapture %}
{% include templates/info-banner.md content=resource_fallback_note %}

{% capture resource_support_note %}
**注意**：实际支持的资源类型（文件、图片、PDF 等）取决于使用的 AI 模型集成。节点可将资源转换为上述内容类型，但并非所有模型 provider 都支持所有内容类型。
{% endcapture %}
{% include templates/info-banner.md content=resource_support_note %}

### Response format（响应格式）

指定 AI 模型输出的结构。

- **Text** — 最灵活，所有模型均支持。AI 生成无结构约束的自由文本。输出不保证特定格式，但可通过 prompt 中的明确指示让模型生成结构化数据（如 JSON）。

- **JSON** — 指示模型生成语法有效的 JSON 响应。模型根据 prompt 上下文决定 JSON 结构。

- **JSON Schema** — 强制模型生成严格符合 [JSON Schema](https://json-schema.org/) 定义结构的 JSON。确保可靠、可预测的输出。

{% capture json_support_note %}
**注意**：使用 Amazon Bedrock、Anthropic 或 GitHub Models 的模型时，不支持 JSON 和 JSON Schema 模式。这些 provider 仅支持 Text 模式。
{% endcapture %}
{% include templates/info-banner.md content=json_support_note %}

#### JSON Schema format（JSON Schema 格式）

选择 **JSON Schema** 时，需提供定义期望响应结构的 schema。解析器支持 JSON Schema 规范的特定子集：

**支持的特性：**

- **Types**：`string`、`integer`、`number`、`boolean`、`object`、`array`、`null`
- **General keywords**：`title`（用作 schema 名）、`description`、`enum`（须为字符串数组）
- **Object keywords**：`properties`、`required`、`additionalProperties`（boolean，默认 true）
- **Array keywords**：`items`

**不支持的特性：**

- 校验类关键字如 `pattern`、`minLength`、`maxLength`、`minimum`、`maximum` 等
- 高级 schema 组合关键字如 `allOf`、`anyOf`、`oneOf`、`not`
- 条件 schema 与 dependencies

**Example schema:**

```json
{
  "title": "SoilAnalysis",
  "type": "object",
  "properties": {
    "moisture_level": {
      "type": "number",
      "description": "Soil moisture percentage"
    },
    "optimal_for_planting": {
      "type": "boolean",
      "description": "Whether conditions are optimal"
    },
    "recommendation": {
      "type": "string",
      "description": "Action recommendation"
    }
  },
  "required": [
    "moisture_level",
    "optimal_for_planting"
  ]
}
```

### Advanced settings

#### Timeout

The maximum time the node will wait for a response from the AI model before the request fails. Valid range: 1 to 600 seconds (10 minutes).

{% capture timeout_warning %}
**重要**：复杂任务或较慢模型可能需要更多时间生成响应。超时过短可能导致请求不必要失败。
Consider the typical response time of your chosen model when configuring this value.
{% endcapture %}
{% include templates/warn-banner.md content=timeout_warning %}

#### Force acknowledgement（强制确认）

- **Enabled** — 入站消息立即被确认。 A new message is created to carry the AI's response and is then added to the queue for processing by the next
  node. This prevents message processing timeouts for long-running AI requests.
- **Disabled** – The original incoming message is transformed. Its data is replaced with the AI's response, and this modified message is passed to the next node.

{% capture force_ack_env_note %}
**注意**：环境变量 `ACTORS_RULE_EXTERNAL_NODE_FORCE_ACK` 设为 `true` 时，会覆盖此设置并强制对所有外部节点立即确认。
{% endcapture %}
{% include templates/info-banner.md content=force_ack_env_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbAiNodeConfiguration",
  "type": "object",
  "properties": {
    "modelId": {
      "type": "object",
      "properties": {
        "entityType": {
          "type": "string",
          "enum": [
            "AI_MODEL"
          ]
        },
        "id": {
          "type": "string",
          "format": "uuid"
        }
      },
      "required": [
        "entityType",
        "id"
      ],
      "description": "Reference to the configured AI model."
    },
    "systemPrompt": {
      "type": "string",
      "minLength": 1,
      "maxLength": 500000,
      "description": "Optional high-level context and constraints for the AI (supports templatization)."
    },
    "userPrompt": {
      "type": "string",
      "minLength": 1,
      "maxLength": 500000,
      "description": "Required specific task or question for the AI (supports templatization)."
    },
    "resourceIds": {
      "type": "array",
      "items": {
        "type": "string",
        "format": "uuid"
      },
      "description": "Optional list of resource IDs to include as context (files, documents, images)."
    },
    "responseFormat": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "enum": [
            "TEXT",
            "JSON",
            "JSON_SCHEMA"
          ],
          "description": "The format type for the AI response."
        },
        "schema": {
          "type": "object",
          "description": "JSON Schema for structured responses (required when type is JSON_SCHEMA)."
        }
      },
      "required": [
        "type"
      ]
    },
    "timeoutSeconds": {
      "type": "integer",
      "minimum": 1,
      "maximum": 600,
      "description": "Maximum time to wait for AI response (1-600 seconds)."
    },
    "forceAck": {
      "type": "boolean",
      "description": "Whether to acknowledge the incoming message immediately."
    }
  },
  "required": [
    "modelId",
    "userPrompt",
    "responseFormat",
    "timeoutSeconds"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 若启用 **Force acknowledgement**，入站消息立即被确认。
2. The node constructs an AI request:
    - The **system prompt** (if specified) and **user prompt** are processed, replacing templates with values from the incoming message data and metadata.
    - If resources are configured, each resource is loaded from the database and converted to the appropriate content type (text, PDF, or image) based on its media type.
    - The chat request is assembled with the system message (if specified), user message containing the processed user prompt and any resource contents, and the configured response
      format.
3. The chat request is sent to the configured AI model with the specified timeout.
4. When the AI responds:
    - The response text is validated to ensure it is a valid JSON object (if not, it is wrapped in a JSON object with a `response` key).
    - The response replaces the incoming message data (or is sent as a new message if force acknowledgement is enabled).
    - The originator, message type, and metadata from the incoming message remain unchanged.
5. The resulting message is forwarded via the `Success` connection.

## 输出连接

- **Success**
    - AI 模型成功处理请求并在配置的超时内返回响应。
- **Failure**
    - 对 AI 模型的请求超过配置的 **Timeout**。
    - 未找到配置的 AI 模型。
    - 配置的资源未找到、类型不受支持或不属于当前租户。
    - 从数据库加载资源数据失败。
    - AI 模型 provider 返回错误。
    - 处理过程中发生意外错误。

## 示例

### 示例 1 — 带技术文档参考的数据分析

分析温度传感器 telemetry 数据并以 JSON 格式提供建议。附加包含设备技术文档的 PDF 资源，帮助 AI 理解传感器规格和最佳工作范围。

**入站消息**

Originator：`DEVICE`（Temperature Sensor）

Data：

```json
{
  "temperature": 28.5,
  "humidity": 75,
  "timestamp": 1672531200000
}
```

**Node configuration**

```json
{
  "modelId": {
    "entityType": "AI_MODEL",
    "id": "1b2e3f4a-5b6c-7d8e-9f0a-1b2c3d4e5f6a"
  },
  "systemPrompt": "You are an HVAC system advisor. Analyze sensor readings and provide actionable recommendations in JSON format with fields: status (string), recommendation (string), and urgency (low/medium/high).",
  "userPrompt": "Analyze these sensor readings based on the device specifications in the attached technical documentation: $[*]",
  "resourceIds": [
    "d5e6f7a8-b9c0-1234-defg-456789abcdef"
  ],
  "responseFormat": {
    "type": "JSON"
  },
  "timeoutSeconds": 30,
  "forceAck": false
}
```

**出站消息**

Data：

```json
{
  "status": "Temperature and humidity exceed recommended operating range",
  "recommendation": "Increase cooling and activate dehumidifier. Consider maintenance check as readings approach upper specification limits.",
  "urgency": "medium"
}
```

经 `Success` 连接路由。

**结果**

AI 模型结合设备技术文档（PDF 资源）分析了传感器数据，根据厂商规格提供了结构化建议。原始消息 data 被 AI 的 JSON 响应替换。
