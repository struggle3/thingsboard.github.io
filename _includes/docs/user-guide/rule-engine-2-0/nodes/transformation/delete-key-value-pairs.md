从入站消息 data 或其 metadata 中删除指定的键值对。

## 前置条件

若从消息 **data** 删除，其必须为有效 JSON 对象。若消息 data 不是 JSON 对象，节点将原样透传消息。

## 配置

### 字段说明

* **从以下位置删除键值对** — 指定删除操作发生的位置。可为：
    * *Message* — 从消息 **data** 删除键值对。
    * *Metadata* — 从 **metadata** 删除键值对。
* **Keys** — 要从源中删除的键集合。**支持 Java 正则表达式。** 若配置的键模式在源中无匹配，则忽略。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDeleteKeysNodeConfiguration",
  "type": "object",
  "properties": {
    "deleteFrom": {
      "type": "string",
      "enum": [
        "DATA",
        "METADATA"
      ],
      "description": "Where to delete key-value pairs from: message data or metadata."
    },
    "keys": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "A set of keys to delete from the source. Java regular expressions are supported."
    }
  },
  "required": [
    "deleteFrom",
    "keys"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点检查配置的删除源（*Message* 或 *Metadata*）。
2. 遍历源中所有键。
3. 对每个键，检查其是否匹配 **Keys** 配置中列出的任一模式。
4. 所有匹配的键值对从源中移除。
5. 若至少删除一个键值对，创建包含更新后 data 或 metadata 的新消息，经 `Success` 传递至下一节点。
6. 若无键匹配或源为空，原始消息经 `Success` 原样透传。
7. 若发生意外错误，消息经 `Failure` 路由。

## 输出连接

* `Success`：
    * 处理正常完成（即使未删除任何键）时。
* `Failure`：
    * 处理过程中发生意外错误时。

## 示例

### 示例 1 — 从 data 删除

**入站消息**

Data:

```json
{
  "temperature": 25.4,
  "humidity": 62,
  "internal_id": "xyz-123",
  "deviceName": "Sensor-A1"
}
```

**节点配置**

```json
{
  "deleteFrom": "DATA",
  "keys": [
    "internal_id",
    "deviceName"
  ]
}
```

**出站消息**

Data:

```json
{
  "temperature": 25.4,
  "humidity": 62
}
```

**输出连接：** `Success`。

**说明：** `internal_id` 和 `deviceName` 的键值对从消息 data 中删除。

-----

### 示例 2 — 从 metadata 删除

**入站消息**

Metadata:

```json
{
  "deviceType": "Thermostat",
  "location": "Floor 1",
  "rssi": "-56",
  "snr": "12.1"
}
```

**节点配置**

```json
{
  "deleteFrom": "METADATA",
  "keys": [
    "rssi",
    "snr"
  ]
}
```

**出站消息**

Metadata:

```json
{
  "deviceType": "Thermostat",
  "location": "Floor 1"
}
```

**输出连接：** `Success`。

**说明：** `rssi` 和 `snr` 的键值对从 metadata 中删除。

-----

### 示例 3 — 使用 Java 正则表达式

**入站消息**

Data:

```json
{
  "temp_main": 33.1,
  "humidity": 45,
  "pressure": 1012,
  "temp_ambient": 21.5
}
```

**节点配置**

```json
{
  "deleteFrom": "DATA",
  "keys": [
    "temp_.*"
  ]
}
```

**出站消息**

Data:

```json
{
  "humidity": 45,
  "pressure": 1012
}
```

**输出连接：** `Success`。

**说明：** 正则表达式 `temp_.*` 匹配 `temp_main` 和 `temp_ambient`。这些键值对从消息 data 中删除。

-----

### 示例 4 — 无匹配键

**入站消息**

Data:

```json
{
  "temperature": 22.5,
  "humidity": 55
}
```

**节点配置**

```json
{
  "deleteFrom": "DATA",
  "keys": [
    "pressure"
  ]
}
```

**出站消息**

Data:

```json
{
  "temperature": 22.5,
  "humidity": 55
}
```

**输出连接：** `Success`。

**说明：** 消息 data 中不存在 `pressure` 键，故无任何删除。原始消息原样透传。
