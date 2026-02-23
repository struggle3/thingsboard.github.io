将指定的键值对从入站消息 data 复制到其 metadata，或从 metadata 复制到 data。

## 前置条件

若从消息 **data** 复制，其必须为有效 JSON 对象。若消息 data 不是 JSON 对象，节点将原样透传消息。

## 配置

### 字段说明

* **从以下位置复制键值对** — 指定复制操作的方向。可为：
    * *Message to metadata* — 从消息 **data** 复制到 **metadata**。
    * *Metadata to message* — 从 **metadata** 复制到消息 **data**。
* **Keys** — 要从源复制的键集合。**支持 Java 正则表达式。** 若配置的键模式在源中无匹配，则忽略。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbCopyKeysNodeConfiguration",
  "type": "object",
  "properties": {
    "copyFrom": {
      "type": "string",
      "description": "The source of the key-value pairs to copy. 'DATA' means message data, 'METADATA' means message metadata.",
      "enum": [
        "DATA",
        "METADATA"
      ]
    },
    "keys": {
      "type": "array",
      "description": "A set of keys to copy from the source. Java regular expressions are supported.",
      "items": {
        "type": "string"
      }
    }
  },
  "required": [
    "copyFrom",
    "keys"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点检查配置的复制方向（*Message to metadata* 或 *Metadata to message*）。
2. 遍历源（消息 data 或 metadata）中所有键值对。
3. 对源中每个键，检查其是否匹配 **Keys** 配置中列出的任一模式。
4. 若键匹配，将键值对复制到目标。
    * 若目标中已存在同名键，其值将被**覆盖**。
    * 从消息 **data** 复制到 **metadata** 时，任何非文本值（如数字、布尔、JSON 对象、数组）会被转换为字符串表示。
5. 若至少复制一个键值对，创建包含更新后 data 或 metadata 的新消息，传递至下一节点。
6. 若无键匹配或源为空，原始消息原样透传。
7. 若发生意外错误，消息经 `Failure` 路由。

## 输出连接

* `Success`：
    * 处理正常完成（即使未复制任何键）时。
* `Failure`：
    * 处理过程中发生意外错误时。

## 示例

### 示例 1 — 从消息 data 复制到 metadata

**入站消息**

Data:

```json
{
  "temperature": 25.4,
  "humidity": 62,
  "deviceName": "Sensor-A1"
}
```

Metadata:

```json
{
  "ts": "1756280400000"
}
```

**节点配置**

```json
{
  "copyFrom": "DATA",
  "keys": [
    "temperature",
    "humidity"
  ]
}
```

**出站消息**

Data:

```json
{
  "temperature": 25.4,
  "humidity": 62,
  "deviceName": "Sensor-A1"
}
```

Metadata:

```json
{
  "temperature": "25.4",
  "humidity": "62",
  "ts": "1756280400000"
}
```

**输出连接：** `Success`。

**说明：** `temperature` 和 `humidity` 的键值对从消息 data 复制到 metadata。注意数值在 metadata 中会转换为字符串。

-----

### 示例 2 — 从 metadata 复制到消息 data

**入站消息**

Data:

```json
{
  "temp": 21.3
}
```

Metadata:

```json
{
  "deviceType": "Thermostat",
  "location": "Floor 1"
}
```

**节点配置**

```json
{
  "copyFrom": "METADATA",
  "keys": [
    "deviceType",
    "location"
  ]
}
```

**出站消息**

Data:

```json
{
  "temp": 21.3,
  "deviceType": "Thermostat",
  "location": "Floor 1"
}
```

Metadata:

```json
{
  "deviceType": "Thermostat",
  "location": "Floor 1"
}
```

**输出连接：** `Success`。

**说明：** `deviceType` 和 `location` 的键值对从 metadata 复制到消息 data。

-----

### 示例 3 — 使用 Java 正则表达式

**入站消息**

Data:

```json
{
  "sensor_temp": 33.1,
  "sensor_humidity": 45,
  "battery_level": 98,
  "sensor_pressure": 1012
}
```

**节点配置**

```json
{
  "copyFrom": "DATA",
  "keys": [
    "sensor_.*"
  ]
}
```

**出站消息**

Metadata:

```json
{
  "sensor_temp": "33.1",
  "sensor_humidity": "45",
  "sensor_pressure": "1012"
}
```

**输出连接：** `Success`。

**说明：** 正则表达式 `sensor_.*` 匹配 `sensor_temp`、`sensor_humidity` 和 `sensor_pressure`。这些键值对复制到 metadata。`battery_level` 不匹配，未复制。

-----

### 示例 4 — 键覆盖

**入站消息**

Data:

```json
{
  "temperature": 22.5
}
```

Metadata:

```json
{
  "temperature": "18.0",
  "deviceType": "Thermostat"
}
```

**节点配置**

```json
{
  "copyFrom": "DATA",
  "keys": [
    "temperature"
  ]
}
```

**出站消息**

Metadata:

```json
{
  "temperature": "22.5",
  "deviceType": "Thermostat"
}
```

**输出连接：** `Success`。

**说明：** 消息 data 中的 `temperature` 键复制到 metadata，**覆盖**了原有的 `temperature` 值。

-----

### 示例 5 — 将 JSON 对象复制到 metadata

**入站消息**

Data:

```json
{
  "location": {
    "lat": 40.7128,
    "lon": -74.0060
  },
  "status": "active"
}
```

**节点配置**

```json
{
  "copyFrom": "DATA",
  "keys": [
    "location"
  ]
}
```

**出站消息**

Metadata:

```json
{
  "location": "{\"lat\":40.7128,\"lon\":-74.0060}"
}
```

**输出连接：** `Success`。

**说明：** 将 `location` 键从 data 复制到 metadata 时，其值（JSON 对象）会被转换为字符串。
