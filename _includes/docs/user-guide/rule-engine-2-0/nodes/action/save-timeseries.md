将传入消息数据存储为消息发起者的时序数据。

## 前置条件

节点接受 `POST_TELEMETRY_REQUEST` 类型的消息，支持以下三种**消息数据格式**：

1. 键值对：对象中每个属性名表示时序 key，对应值为时序值。
    ```json
    {
      "temperature": 42.2,
      "humidity": 70
    }
    ```

2. 带时间戳的键值对：对象包含时间戳的 `ts` 属性和键值对的 `values` 属性（格式 1 定义）。
    ```json
    {
      "ts": 1737963587742,
      "values": {
        "temperature": 42.2,
        "humidity": 70
      }
    }
    ```

3. 多条带时间戳的键值对：带时间戳的键值对对象数组（格式 2 定义）。
    ```json
    [
      {
        "ts": 1737963595638,
        "values": {
          "temperature": 42.2,
          "humidity": 70
        }
      },
      {
        "ts": 1737963601607,
        "values": {
          "pressure": 2.56,
          "velocity": 0.553
        }
      }
    ]
    ```

## 配置

### 处理设置

保存时序节点可执行四项操作，每项由可配置的处理策略控制：

- **Time series**：将时序数据保存到数据库的 `ts_kv` 表。
- **Latest values**：若新数据较新，则更新数据库 `ts_kv_latest` 表中的时序数据。
- **WebSockets**：通知 WebSocket 订阅关于时序数据的更新。
- **Calculated fields**：通知计算字段关于时序数据的更新。

对每项操作，可从以下**处理策略**中选择：
{% include docs/user-guide/rule-engine-2-0/processing-strategies-explanation.md %}

{% capture processing_strategies_availability_note %}
**注意**：处理策略自 TB 4.0 起可用。早期 TB 版本的「Skip latest persistence」开关对应 Latest values 的「Skip」策略。
{% endcapture %}
{% include templates/info-banner.md content=processing_strategies_availability_note %}

处理策略可通过**基础**或**高级**处理设置配置。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-processing-settings-modes-switcher-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-processing-settings-modes-switcher-pe.png)
{% endif %}

- **Basic processing settings** - 为所有操作提供预定义策略：
    - On every message：对所有操作应用**每条消息**策略。所有消息都会执行所有操作。
    - Deduplicate：对所有操作应用**去重**策略（指定间隔）。
    - WebSockets only：对 Time series 和 Latest values 应用 **Skip** 策略，对 WebSockets 应用 **每条消息** 策略。
      实际上不会写入数据库；数据仅通过 WebSocket 订阅实时可用。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-basic-processing-settings-options-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-basic-processing-settings-options-pe.png)
{% endif %}

- **Advanced processing settings** - allow you to configure each action’s processing strategy independently.

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-timeseries-advanced-processing-settings-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-timeseries-advanced-processing-settings-pe.png)
{% endif %}

在高级模式下配置处理策略时，某些组合可能导致意外行为。请考虑以下场景：

{% include docs/user-guide/rule-engine-2-0/advanced-processing-strategies-hazards.md %}

鉴于上述场景，独立配置每项持久化操作（包括不同去重间隔）应视为性能优化，而非严格的处理保证。

### 高级设置

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-timeseries-advanced-settings-ce.png)
{% else %}
![image](/images/user-guide/rule-engine-2-0/nodes/action-save-timeseries-advanced-settings-pe.png)
{% endif %}

* **Use server timestamp** - 启用时，当时序数据无显式时间戳时（使用**数据格式 1**），规则节点将使用当前服务器时间。

  在顺序处理场景中，多条消息可能来自不同源且时间戳乱序，使用服务器时间尤为重要。
  数据库层有优化：若新记录时间戳早于前一条，会忽略属性和最新值的更新。
  因此，为确保所有消息被正确处理，在顺序消息处理场景中应启用此参数。

* **Default TTL** - 决定存储数据在数据库中的保留时长。

{% capture zero_ttl_note %}
**注意**：TTL 为 0 表示数据永不过期。
{% endcapture %}
{% include templates/info-banner.md content=zero_ttl_note %}

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgTimeseriesNodeConfiguration",
  "type": "object",
  "properties": {
    "defaultTTL": {
      "type": "integer",
      "description": "Default time series data time-to-live in seconds"
    },
    "useServerTs": {
      "type": "boolean",
      "description": "Whether to use server timestamp when time series data lacks explicit timestamp"
    },
    "processingSettings": {
      "$ref": "#/$defs/ProcessingSettings"
    }
  },
  "required": [
    "defaultTTL",
    "useServerTs",
    "processingSettings"
  ],
  "additionalProperties": false,
  "$defs": {
    "ProcessingSettings": {
      "description": "Polymorphic processing settings for timeseries data",
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
        "timeseries": {
          "$ref": "#/$defs/ProcessingStrategy"
        },
        "latest": {
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
        "timeseries",
        "latest",
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

1. 节点验证消息类型为 `POST_TELEMETRY_REQUEST`。若非此类型，处理失败，消息路由到 `Failure`。
2. 对无显式时间戳的时序数据（**数据格式 1**），节点按以下优先级确定时间戳：
    - 若配置中启用了 **Use server timestamp**，则使用当前服务器时间
    - 若存在，使用消息元数据的 `ts` 属性（UNIX 毫秒）
    - 否则使用消息创建时间戳
3. 节点按以下优先级计算数据 TTL：
    - 若存在，使用消息元数据的 `TTL` 属性（秒）
    - 若节点配置的 **Default TTL** 非 0，则使用该值
    - 否则使用租户配置文件的默认存储 TTL
4. 按配置的处理策略将时序数据保存到数据库。
    - 数据保存后，消息路由到 `Success`
    - 处理过程中发生任何错误时，消息路由到 `Failure`

## 输出连接

- `Success`
    - 消息已成功处理。
- `Failure`
    - 消息类型不是 `POST_TELEMETRY_REQUEST`。
    - 消息数据为空（如 `{}`、`[]` 或 `[{}, {}, {}]`）。
    - 消息处理过程中发生意外错误。

## Examples

### Example 1 — On every message strategy

**Incoming message**

Type: `POST_TELEMETRY_REQUEST`

Originator: `DEVICE`

Data:

```json
{
  "temperature": 23.5,
  "humidity": 65.2,
  "pressure": 1013.25
}
```

**Node configuration**

```json
{
  "defaultTTL": 86400,
  "useServerTs": true,
  "processingSettings": {
    "type": "ON_EVERY_MESSAGE"
  }
}
```

**Outgoing message**

The outgoing message is identical to the incoming one. Routed via the `Success` connection.

**Result**

Three time series values are saved:

- `temperature`: 23.5
- `humidity`: 65.2
- `pressure`: 1013.25

All values use the current server timestamp and will expire after 24 hours (86400 seconds). Data is saved to both `ts_kv` and `ts_kv_latest` tables, WebSocket subscriptions and
calculated fields are notified.

### Example 2 — Timestamped data with Deduplicate strategy

**Incoming message**

Type: `POST_TELEMETRY_REQUEST`

Originator: `DEVICE`

Data:

```json
{
  "ts": 1737963587742,
  "values": {
    "batteryLevel": 85,
    "signalStrength": -65
  }
}
```

**Node configuration**

```json
{
  "defaultTTL": 0,
  "useServerTs": false,
  "processingSettings": {
    "type": "DEDUPLICATE",
    "deduplicationIntervalSecs": 60
  }
}
```

**State of the system**

Message for this device that falls within current interval was already processed.

**Outgoing message**

The outgoing message is identical to the incoming one. Routed via the `Success` connection.

**Result**

Since deduplication is enabled with a 60-second interval and the message was already processed, the data is not persisted to the database. 
WebSocket notifications and calculated fields are also not triggered.

### Example 3 — Multiple timestamped entries

**Incoming message**

Type: `POST_TELEMETRY_REQUEST`

Originator: `DEVICE`

Data:

```json
[
  {
    "ts": 1737963595638,
    "values": {
      "temperature": 22.1,
      "humidity": 60
    }
  },
  {
    "ts": 1737963601607,
    "values": {
      "temperature": 22.3,
      "humidity": 61
    }
  },
  {
    "ts": 1737963607542,
    "values": {
      "temperature": 22.5,
      "humidity": 62
    }
  }
]
```

**Node configuration**

```json
{
  "defaultTTL": 604800,
  "useServerTs": false,
  "processingSettings": {
    "type": "ON_EVERY_MESSAGE"
  }
}
```

**Outgoing message**

The outgoing message is identical to the incoming one. Routed via the `Success` connection.

**Result**

Six time series entries are saved (3 timestamps × 2 keys):

- At timestamp 1737963595638: `temperature` = 22.1, `humidity` = 60
- At timestamp 1737963601607: `temperature` = 22.3, `humidity` = 61
- At timestamp 1737963607542: `temperature` = 22.5, `humidity` = 62

All entries will expire after 7 days (604800 seconds).

### Example 4 — Advanced processing with mixed strategies

**Incoming message**

Type: `POST_TELEMETRY_REQUEST`

Originator: `DEVICE`

Data:

```json
{
  "cpuUsage": 45.7,
  "memoryUsage": 78.2,
  "diskUsage": 62.5
}
```

**Node configuration**

```json
{
  "defaultTTL": 2592000,
  "useServerTs": true,
  "processingSettings": {
    "type": "ADVANCED",
    "timeseries": {
      "type": "DEDUPLICATE",
      "deduplicationIntervalSecs": 300
    },
    "latest": {
      "type": "ON_EVERY_MESSAGE"
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

**State of the system**

Message for this device that falls within current deduplication interval was already processed.

**Outgoing message**

The outgoing message is identical to the incoming one. Routed via the `Success` connection.

**Result**

- Time series data (`ts_kv`) is NOT saved due to deduplication
- Latest values (`ts_kv_latest`) ARE updated with new values
- WebSocket subscriptions ARE notified
- Calculated fields are NOT triggered (SKIP strategy)
- Data has TTL of 30 days (2592000 seconds)

### Example 6 — TTL override from message metadata

**Incoming message**

Type: `POST_TELEMETRY_REQUEST`

Originator: `DEVICE`

Data:

```json
{
  "waterLevel": 3.45,
  "flowRate": 125.8
}
```

Message metadata:

```json
{
  "TTL": 3600
}
```

**Node configuration**

```json
{
  "defaultTTL": 86400,
  "useServerTs": false,
  "processingSettings": {
    "type": "ON_EVERY_MESSAGE"
  }
}
```

**Outgoing message**

The outgoing message is identical to the incoming one. Routed via the `Success` connection.

**Result**

Time series values are saved with TTL of 3600 seconds (1 hour) from metadata, overriding the node's default TTL of 86400 seconds.
