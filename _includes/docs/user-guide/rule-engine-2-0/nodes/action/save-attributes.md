将入站消息数据存储为消息 originator 的 attribute 数据。

## 前置条件

该节点接受类型为 `POST_ATTRIBUTES_REQUEST` 的消息，并要求消息数据为 JSON 对象，每个属性名表示 attribute 的 key，对应的值表示 attribute 的 value。例如：

```json
{
  "firmware_version": "1.0.1",
  "serial_number": "SN-001"
}
```

## 配置

### 处理设置

save attributes 节点可执行三种操作，每种操作由可配置的处理策略控制：

- **Attributes**：将 attribute 数据保存到数据库。
- **WebSockets**：向 WebSocket 订阅通知 attribute 数据更新。
- **Calculated fields**：向 calculated fields 通知 attribute 数据更新。

对于每种操作，您可选择下列 **processing strategies**（处理策略）：
{% include docs/user-guide/rule-engine-2-0/processing-strategies-explanation.md %}

{% capture processing_strategies_availability_note %}
**说明**：Processing strategies 自 TB 4.0 起可用。
{% endcapture %}
{% include templates/info-banner.md content=processing_strategies_availability_note %}

processing strategies 可通过 **Basic** 或 **Advanced processing settings** 设置。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-processing-settings-modes-switcher-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-processing-settings-modes-switcher-pe.png)
{% endif %}

- **Basic processing settings** — 为所有操作提供预设策略：
    - On every message：对所有操作应用 **On every message** 策略。所有消息都会执行所有操作。
    - Deduplicate：对所有操作应用 **Deduplicate** 策略（指定间隔）。
    - WebSockets only：除 WebSocket 通知外，所有操作应用 **Skip** 策略，WebSocket 通知使用 **On every message** 策略。
      实际效果为：不写入数据库；数据仅通过 WebSocket 订阅实时可用。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-basic-processing-settings-options-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-basic-processing-settings-options-pe.png)
{% endif %}

- **Advanced processing settings** — 允许为每个操作独立配置处理策略。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-attributes-advanced-processing-settings-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-attributes-advanced-processing-settings-pe.png)
{% endif %}

在高级模式下配置处理策略时，某些组合可能导致意外行为。请考虑以下场景：

{% include docs/user-guide/rule-engine-2-0/advanced-processing-strategies-hazards.md %}

鉴于上述场景，将每个持久化操作独立配置（包括设置不同的去重间隔）的能力应视为性能优化，而非严格的处理保证。

### Scope

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-attributes-scope-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-attributes-scope-pe.png)
{% endif %}

节点支持三种属性范围：*客户端属性*、*共享属性*和*服务端属性*。可在节点配置中设置默认范围，也可通过在消息 metadata 中指定有效的 `scope` 属性进行覆盖。

支持的 `scope` 值：

- `CLIENT_SCOPE` 对应 *客户端属性*
- `SHARED_SCOPE` 对应 *共享属性*
- `SERVER_SCOPE` 对应 *服务端属性*

若消息 metadata 包含无效的 `scope` 值（如 `INVALID_SCOPE`），消息处理将失败。

### Advanced settings

![image](/images/user-guide/rule-engine-2-0/nodes/action-save-attributes-advanced-settings.png)

* **Save attributes only if the value changes** — 若启用，节点将入站属性与当前存储值比较，仅保存新增、值已变更或数据类型不同的属性。

{% capture concurrent_writes_note %}
**注意**：避免对同一属性进行并发写入，因为变更检测非事务性，此类情况下可能产生意外结果。
{% endcapture %}
{% include templates/info-banner.md content=concurrent_writes_note %}

{% capture last_updated_ts_note %}
**注意**：若因值未变更而跳过属性保存，属性的最后更新时间戳将不会更新。
{% endcapture %}
{% include templates/info-banner.md content=last_updated_ts_note %}

* **Send attributes updated notification** — 若启用，节点对 `SHARED_SCOPE` 和 `SERVER_SCOPE` 属性向来源实体的默认规则链发送 [Attributes Updated](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#predefined-message-types) 事件。
* **Force notification to the device** — 若启用，节点始终向有活跃订阅的设备发送属性更新通知。若禁用，设备通知由消息 metadata 中的 `notifyDevice` 属性控制（缺失时默认为 `true`）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgAttributesNodeConfiguration",
  "type": "object",
  "properties": {
    "scope": {
      "type": "string",
      "description": "Scope for attribute processing (e.g., SERVER_SCOPE, CLIENT_SCOPE, SHARED_SCOPE)"
    },
    "notifyDevice": {
      "type": "boolean",
      "description": "Whether to notify the device about attribute changes"
    },
    "sendAttributesUpdatedNotification": {
      "type": "boolean",
      "description": "Whether to send 'ATTRIBUTES_UPDATED' event to the originator's default rule chain"
    },
    "updateAttributesOnlyOnValueChange": {
      "type": "boolean",
      "description": "Whether to update attributes only when values change"
    },
    "processingSettings": {
      "$ref": "#/$defs/ProcessingSettings"
    }
  },
  "required": [
    "scope",
    "notifyDevice",
    "sendAttributesUpdatedNotification",
    "updateAttributesOnlyOnValueChange",
    "processingSettings"
  ],
  "additionalProperties": false,
  "$defs": {
    "ProcessingSettings": {
      "description": "Polymorphic processing settings for attributes data",
      "discriminator": {
        "propertyName": "type"
      },
      "oneOf": [
        {
          "$ref": "#/$defs/OnEveryMessage"
        },
        {
          "$ref": "#/$defs/WebSocketsOnly"
        },
        {
          "$ref": "#/$defs/Deduplicate"
        },
        {
          "$ref": "#/$defs/Advanced"
        }
      ]
    },
    "OnEveryMessage": {
      "type": "object",
      "properties": {
        "type": {
          "const": "ON_EVERY_MESSAGE"
        }
      },
      "required": [
        "type"
      ],
      "additionalProperties": false
    },
    "WebSocketsOnly": {
      "type": "object",
      "properties": {
        "type": {
          "const": "WEBSOCKETS_ONLY"
        }
      },
      "required": [
        "type"
      ],
      "additionalProperties": false
    },
    "Deduplicate": {
      "type": "object",
      "properties": {
        "type": {
          "const": "DEDUPLICATE"
        },
        "deduplicationIntervalSecs": {
          "type": "integer",
          "minimum": 1,
          "maximum": 86400,
          "description": "Deduplication interval in seconds (1 second to 1 day)"
        }
      },
      "required": [
        "type",
        "deduplicationIntervalSecs"
      ],
      "additionalProperties": false
    },
    "Advanced": {
      "type": "object",
      "properties": {
        "type": {
          "const": "ADVANCED"
        },
        "attributes": {
          "$ref": "#/$defs/ProcessingStrategy"
        },
        "webSockets": {
          "$ref": "#/$defs/ProcessingStrategy"
        },
        "calculatedFields": {
          "$ref": "#/$defs/ProcessingStrategy"
        }
      },
      "required": [
        "type",
        "attributes",
        "webSockets",
        "calculatedFields"
      ],
      "additionalProperties": false
    },
    "ProcessingStrategy": {
      "description": "Polymorphic processing strategy",
      "discriminator": {
        "propertyName": "type"
      },
      "oneOf": [
        {
          "$ref": "#/$defs/OnEveryMessageStrategy"
        },
        {
          "$ref": "#/$defs/DeduplicateStrategy"
        },
        {
          "$ref": "#/$defs/SkipStrategy"
        }
      ]
    },
    "OnEveryMessageStrategy": {
      "type": "object",
      "properties": {
        "type": {
          "const": "ON_EVERY_MESSAGE"
        }
      },
      "required": [
        "type"
      ],
      "additionalProperties": false
    },
    "DeduplicateStrategy": {
      "type": "object",
      "properties": {
        "type": {
          "const": "DEDUPLICATE"
        },
        "deduplicationIntervalSecs": {
          "type": "integer",
          "minimum": 1,
          "maximum": 86400,
          "description": "Deduplication interval in seconds (1 second to 1 day)"
        }
      },
      "required": [
        "type",
        "deduplicationIntervalSecs"
      ],
      "additionalProperties": false
    },
    "SkipStrategy": {
      "type": "object",
      "properties": {
        "type": {
          "const": "SKIP"
        }
      },
      "required": [
        "type"
      ],
      "additionalProperties": false
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点验证消息类型是否为 `POST_ATTRIBUTES_REQUEST`。若不是，处理失败并将消息路由到 `Failure` 连接。

2. 节点解析消息数据以提取属性键值对。若数据为空，处理结束并将消息路由到 `Success` 连接。

3. 节点按下列优先级确定属性作用域：
    - 消息 metadata 中的 `scope` 属性值（若存在且有效：`CLIENT_SCOPE`、`SHARED_SCOPE` 或 `SERVER_SCOPE`）
    - 若 metadata 中提供无效的 scope（如 `INVALID_SCOPE`），处理失败并将消息路由到 `Failure` 连接
    - 若 metadata 未提供 scope，则使用节点配置的默认 scope

4. 若启用 **Save attributes only if the value changes**（仅当值变更时保存属性），节点执行变更检测：
    - 从数据库获取所有入站属性 key 的当前值
    - 将每个入站属性与其当前存储值比较
    - 仅保留下列属性：
        - 新增（当前未存储）
        - 与当前存储值不同
        - 与当前存储数据类型不同
    - 若未检测到变更，处理结束并将消息路由到 `Success` 连接

5. 节点按下列优先级确定设备通知设置：
    - 若配置中启用 **Force notification to the device**，始终发送通知
    - 否则检查消息 metadata 中的 `notifyDevice` 属性：
        - 若缺失或为空字符串：默认发送通知
        - 若存在：仅当值为 `true`（不区分大小写）时发送通知

6. 按配置的处理策略将属性保存到数据库。保存完成时：
    - 成功：处理成功，消息路由到 `Success` 连接
    - 失败：处理失败，消息路由到 `Failure` 连接
    - 若启用 **Send attributes updated notification**，会向 originator 的默认规则链发布 `ATTRIBUTES_UPDATED` 事件（针对 `SHARED_SCOPE` 和 `SERVER_SCOPE` 属性）

## 输出连接

- `Success`
    - 入站消息被成功处理时
- `Failure`
    - 入站消息类型不是 `POST_ATTRIBUTES_REQUEST` 时
    - 入站消息 payload 无法解析为属性键值对时
    - 入站消息 metadata 包含非空 `scope` 属性且其值不是有效作用域（即 `CLIENT_SCOPE`、`SHARED_SCOPE` 或 `SERVER_SCOPE`）时
    - 消息处理过程中发生意外错误时

## 示例

### 示例 1 — On every message 策略

**入站消息**

类型：`POST_ATTRIBUTES_REQUEST`

Originator：`DEVICE`

数据：

```json
{
  "firmware_version": "1.0.1",
  "serial_number": "SN-001",
  "last_maintenance": "2025-01-15"
}
```

**节点配置**

```json
{
  "scope": "SERVER_SCOPE",
  "notifyDevice": false,
  "sendAttributesUpdatedNotification": true,
  "updateAttributesOnlyOnValueChange": false,
  "processingSettings": {
    "type": "ON_EVERY_MESSAGE"
  }
}
```

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

保存了三个服务器属性：

- `firmware_version`: "1.0.1"
- `serial_number`: "SN-001"
- `last_maintenance`: "2025-01-15"

WebSocket 订阅和 calculated fields 收到通知。由于 scope 为 `SERVER_SCOPE`，会向 originator 的默认规则链发送 `ATTRIBUTES_UPDATED` 事件。

### 示例 2 — 使用 Deduplicate 策略的属性

**入站消息**

类型：`POST_ATTRIBUTES_REQUEST`

Originator：`DEVICE`

数据：

```json
{
  "battery_level": 85,
  "signal_strength": -65,
  "location": "Building A, Floor 2"
}
```

**节点配置**

```json
{
  "scope": "CLIENT_SCOPE",
  "notifyDevice": true,
  "sendAttributesUpdatedNotification": false,
  "updateAttributesOnlyOnValueChange": false,
  "processingSettings": {
    "type": "DEDUPLICATE",
    "deduplicationIntervalSecs": 120
  }
}
```

**系统状态**

该设备在当前 120 秒间隔内的消息已处理过。

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

由于启用了 120 秒去重间隔且该消息已处理过，属性不会保存到数据库。也不会触发 WebSocket 通知和 calculated fields。

### 示例 3 — 混合策略的高级处理

**入站消息**

类型：`POST_ATTRIBUTES_REQUEST`

Originator：`DEVICE`

数据：

```json
{
  "cpu_usage": 45.7,
  "memory_usage": 78.2,
  "disk_usage": 62.5
}
```

**节点配置**

```json
{
  "scope": "SHARED_SCOPE",
  "notifyDevice": false,
  "sendAttributesUpdatedNotification": true,
  "updateAttributesOnlyOnValueChange": false,
  "processingSettings": {
    "type": "ADVANCED",
    "attributes": {
      "type": "DEDUPLICATE",
      "deduplicationIntervalSecs": 300
    },
    "webSockets": {
      "type": "ON_EVERY_MESSAGE"
    },
    "calculatedFields": {
      "type": "SKIP"
    }
  }
}
```

**系统状态**

该设备在当前去重间隔内的消息已处理过。

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

- 由于去重，属性未保存到数据库
- WebSocket 订阅已收到通知
- Calculated fields 未触发（SKIP 策略）
- 由于属性未保存，不发送 `ATTRIBUTES_UPDATED` 事件

### 示例 4 — 仅当值变更时保存属性

**入站消息**

类型：`POST_ATTRIBUTES_REQUEST`

Originator：`DEVICE`

数据：

```json
{
  "temperature_threshold": 25.0,
  "humidity_threshold": 70.0,
  "maintenance_scheduled": true
}
```

**节点配置**

```json
{
  "scope": "SERVER_SCOPE",
  "notifyDevice": false,
  "sendAttributesUpdatedNotification": true,
  "updateAttributesOnlyOnValueChange": true,
  "processingSettings": {
    "type": "ON_EVERY_MESSAGE"
  }
}
```

**系统状态**

当前已存储属性：

- `temperature_threshold`: 25.0（值相同）
- `humidity_threshold`: 65.0（值不同）
- `maintenance_scheduled`: 未存储（新属性）

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

因变更检测仅保存两个属性：

- `humidity_threshold`: 70.0（值从 65.0 变为 70.0）
- `maintenance_scheduled`: true（新属性）

`temperature_threshold` 未保存，因其值未变更。WebSocket 订阅和 calculated fields 仅对被变更属性收到通知。

### 示例 5 — 从消息 metadata 覆盖 scope

**入站消息**

类型：`POST_ATTRIBUTES_REQUEST`

Originator：`DEVICE`

数据：

```json
{
  "power_setting": "low"
}
```

Metadata：

```json
{
  "scope": "CLIENT_SCOPE"
}
```

**节点配置**

```json
{
  "scope": "SERVER_SCOPE",
  "notifyDevice": false,
  "sendAttributesUpdatedNotification": true,
  "updateAttributesOnlyOnValueChange": false,
  "processingSettings": {
    "type": "ON_EVERY_MESSAGE"
  }
}
```

**出站消息**

出站消息与入站消息相同。经 `Success` 连接路由。

**结果**

保存了一个客户端属性（使用 metadata 中的 scope）：

- `power_setting`: "low"

由于客户端属性不触发该通知，不会发送 `ATTRIBUTES_UPDATED` 事件。
