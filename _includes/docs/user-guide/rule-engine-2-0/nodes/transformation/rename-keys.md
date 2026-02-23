根据配置的映射，重命名入站消息或其 metadata 中的键。

## 配置

### 字段说明

* **重命名键的位置** — 指定重命名发生的位置。可为：
    * *Message* — 在消息 **data** 内重命名键。
    * *Message metadata* — 在 **metadata** 内重命名键。
* **Message keys mapping** — 定义如何重命名键。每个映射包含：
    * **当前键名** — 现有键的名称。
    * **新键名** — 键将要改成的名称。

若当前键不存在，则跳过该映射。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbRenameKeysNodeConfiguration",
  "type": "object",
  "properties": {
    "renameIn": {
      "type": "string",
      "enum": [
        "DATA",
        "METADATA"
      ],
      "description": "Where to rename keys: message data or metadata."
    },
    "renameKeysMapping": {
      "type": "object",
      "description": "Key-value map where the key is the original key and the value is the new name.",
      "additionalProperties": {
        "type": "string"
      }
    }
  },
  "required": [
    "renameIn",
    "renameKeysMapping"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 根据配置确定在消息 **data** 还是 **metadata** 中重命名键。
2. 对每个映射：
    * 若键在所选源中存在：
        * 将值复制到新键。
        * 删除旧键。
3. 若至少重命名一个键：
    * 创建包含更新后 data 或 metadata 的新消息。
4. 若无键被重命名：
    * 原样透传原始消息。
5. 若发生意外错误，经 `Failure` 路由消息。

## 输出连接

* `Success`：
    * 处理正常完成（即使未重命名任何键）时。
* `Failure`：
    * 处理过程中发生意外错误时。

## 示例

### 示例 1 — 重命名消息 data 中的键

**入站消息**

Data:

```json
{
  "temperatureCelsius": 22.5
}
```

**节点配置**

```json
{
  "renameIn": "DATA",
  "renameKeysMapping": {
    "temperatureCelsius": "temperature"
  }
}
```

**出站消息**

Data:

```json
{
  "temperature": 22.5
}
```

**输出连接：** `Success`。

**说明：** 消息 data 中的键 `temperatureCelsius` 被重命名为 `temperature`。

---

### 示例 2 — 重命名消息 metadata 中的键

**入站消息**

Metadata:

```json
{
  "deviceModel": "BME250"
}
```

**节点配置**

```json
{
  "renameIn": "METADATA",
  "renameKeysMapping": {
    "deviceModel": "model"
  }
}
```

**出站消息**

Metadata:

```json
{
  "model": "BME250"
}
```

**输出连接：** `Success`。

**说明：** metadata 中的键 `deviceModel` 被重命名为 `model`。

---

### 示例 3 — 键不存在 → 无更改

**入站消息**

Data:

```json
{
  "humidity": 55
}
```

**节点配置**

```json
{
  "renameIn": "DATA",
  "renameKeysMapping": {
    "temperatureCelsius": "temperature"
  }
}
```

**出站消息**

Data:

```json
{
  "humidity": 55
}
```

**输出连接：** `Success`。

**说明：** 消息 data 中无匹配键；原始消息原样透传。

### 示例 4 — 配置错误导致键覆盖

**入站消息**

Data:

```json
{
  "temperatureCelsius": 21.5,
  "temperature": 99
}
```

**节点配置**

```json
{
  "renameIn": "DATA",
  "renameKeysMapping": {
    "temperatureCelsius": "temperature"
  }
}
```

**出站消息**

Data:

```json
{
  "temperature": 21.5
}
```

**输出连接：** `Success`。

**说明：** 键 `temperatureCelsius` 被重命名为 `temperature`。原有的 `temperature` 键被新值 `21.5` 覆盖。此行为反映配置的映射，不作为错误处理。

---

### 示例 5 — 重命名多个键（一个键未找到 → 跳过）

**入站消息**

Metadata:

```json
{
  "deviceName": "Boiler-21",
  "deviceType": "Heater"
}
```

**节点配置**

```json
{
  "renameIn": "METADATA",
  "renameKeysMapping": {
    "deviceName": "name",
    "deviceType": "type",
    "firmwareVersion": "fw"
  }
}
```

**结果**

```json
{
  "name": "Boiler-21",
  "type": "Heater"
}
```

**说明：**
* `deviceName` 重命名为 `name`
* `deviceType` 重命名为 `type`
* `firmwareVersion` 在 metadata 中不存在，跳过且无错误
