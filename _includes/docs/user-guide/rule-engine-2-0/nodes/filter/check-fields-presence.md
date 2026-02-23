检查入站消息 **data** 和/或 **metadata** 中是否存在指定字段。
默认情况下，节点要求**所有**指定字段都存在；可切换为「至少一个」模式。

## 前置条件

入站消息 data 必须为 JSON 对象。

## 配置

### 字段说明

* **消息字段名** — 可选。要在消息 data 中查找的**顶级** JSON 字段名集合。
* **Metadata 字段名** — 可选。要在消息 metadata 中查找的 metadata 键名集合。

{% capture at_least_one_set_required_note %}
尽管每集合均可选，但其中至少一个必须提供至少一个字段（即至少一个集合非空）。
{% endcapture %}
{% include templates/info-banner.md content=at_least_one_set_required_note %}

* **检查所有指定字段是否都存在** — 开关。
    * **启用：** 仅当**所有**列出的消息/metadata 字段都存在时才经 `True` 路由。
    * **禁用：** 当**至少一个**列出的消息/metadata 字段存在时经 `True` 路由。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbCheckMessageNodeConfiguration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "messageNames": {
      "description": "Field names to check in the message data.",
      "type": "array",
      "items": {
        "type": "string",
        "minLength": 1
      },
      "uniqueItems": true
    },
    "metadataNames": {
      "description": "Field names to check in the message metadata.",
      "type": "array",
      "items": {
        "type": "string",
        "minLength": 1
      },
      "uniqueItems": true
    },
    "checkAllKeys": {
      "description": "If true, require all listed fields. If false, require at least one.",
      "type": "boolean",
      "default": true
    }
  },
  "anyOf": [
    {
      "properties": {
        "messageNames": {
          "minItems": 1
        }
      }
    },
    {
      "properties": {
        "metadataNames": {
          "minItems": 1
        }
      }
    }
  ]
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 将 **data** 提取为 JSON 对象，**metadata** 提取为键值对。
2. 评估存在性：
    * 若**检查所有键**已启用：当 `messageNames` 中列出的每个字段均存在于 data **且** `metadataNames` 中列出的每个字段均存在于 metadata 时，经 `True` 路由。
    * 若**检查所有键**已禁用：当任意列出的字段存在于 data **或** metadata 时，经 `True` 路由。
3. 否则经 `False` 路由。若发生错误（如负载不是 JSON 对象），经 `Failure` 路由。

{% capture top_level_keys_note %}
仅检查**顶级**键；不支持嵌套路径（如 `sensor.temp`）。
{% endcapture %}
{% include templates/info-banner.md content=top_level_keys_note %}

{% capture presence_meaning_note %}
存在指**键存在**，无论其值如何（包括 `null` 或空字符串）。
{% endcapture %}
{% include templates/info-banner.md content=presence_meaning_note %}

## 输出连接

* `True`：
    * 当配置的存在条件满足时。
* `False`：
    * 当配置的存在条件不满足时。
* `Failure`：
    * 当入站消息 data 无法解析为 JSON 对象时。
    * 消息处理过程中发生其他意外错误时。

## 示例

以下示例仅展示入站消息的**相关**字段。除非另有说明，其他消息字段可为任意值。

---

### 示例 1 — 所有必填 data 字段都存在 → `True`

**入站消息**

Data:
```json
{
  "temp": 22.5,
  "humidity": 55
}
```

**节点配置**

```json
{
  "messageNames": [
    "temp",
    "humidity"
  ],
  "metadataNames": [],
  "checkAllKeys": true
}
```

**系统状态**

不相关。

**结果**

经 **`True`** 路由。

**说明**

`temp` 和 `humidity` 均存在于负载中。

---

### 示例 2 — 缺少一个必填 data 字段 → `False`

**入站消息**

Data:
```json
{
  "temp": 22.5
}
```

**节点配置**

```json
{
  "messageNames": [
    "temp",
    "humidity"
  ],
  "metadataNames": [],
  "checkAllKeys": true
}
```

**系统状态**

不相关。

**结果**

经 **`False`** 路由。

**说明**

`humidity` 不存在。

---

### 示例 3 — 至少一个 metadata 字段存在 → `True`

**入站消息**

Metadata:
```json
{
  "deviceName": "Pump-42",
  "token": "abc123"
}
```

**节点配置**

```json
{
  "messageNames": [],
  "metadataNames": [
    "token",
    "tenantId"
  ],
  "checkAllKeys": false
}
```

**系统状态**

不相关。

**结果**

经 **`True`** 路由。

**说明**

至少一个列出的 metadata 键（`token`）存在。

---

### 示例 4 — 至少一个 data 字段存在 → `True`

**入站消息**

Data:
```json
{
  "temperature": 123,
  "humidity": 42
}
```

Metadata:
```json
{
  "deviceName": "Sensor-1",
  "deviceType": "TemperatureSensor"
}
```

**节点配置**

```json
{
  "messageNames": [
    "temperature"
  ],
  "metadataNames": [
    "token",
    "tenantId"
  ],
  "checkAllKeys": false
}
```

**系统状态**

不相关。

**结果**

经 **`True`** 路由。

**说明**

至少一个列出的键（`temperature`）存在。

---

### 示例 5 — 无效消息格式 → `Failure`

**入站消息 data**

```
"not a JSON object"
```

**节点配置**

```json
{
  "messageNames": [
    "temp"
  ],
  "metadataNames": [],
  "checkAllKeys": true
}
```

**系统状态**

不相关。

**结果**

**`Failure`**。

**说明**

消息 data 不是 JSON 对象，节点无法检查 data 键。
