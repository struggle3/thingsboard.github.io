使用 JSONPath 表达式从入站消息 **data** 中提取一部分，并将其设为新的消息 data。

## 前置条件

入站消息 **data** 必须为有效 JSON 对象或数组。若 data 不是有效 JSON，消息将经 `Failure` 链路由。

## 配置

### 字段说明

* **JSONPath** — 用于查询入站消息 data 的 JSONPath 表达式。该查询结果将完全替换原始消息 data。
    * 默认值为 `$`，表示整个根 JSON 对象或数组。使用默认值将使原始消息原样透传。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbJsonPathNodeConfiguration",
  "type": "object",
  "properties": {
    "jsonPath": {
      "type": "string",
      "description": "The JSONPath expression to apply to the message data."
    }
  },
  "required": [
    "jsonPath"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点将配置的 **JSONPath** 表达式应用到入站消息 data。
2. 若表达式成功找到一个或多个元素：
    * 消息的 **data** 被 JSONPath 查询结果替换。
    * 消息经 `Success` 链发送。
3. 若配置的 JSONPath 在消息 data 中未找到，原始消息经 `Failure` 链发送。
4. 若入站消息 data 不是有效 JSON，消息经 `Failure` 链发送。

## 输出连接

* `Success`：
    * JSONPath 表达式成功求值时。
* `Failure`：
    * 消息 data 不是有效 JSON 时。
    * 消息 data 中未找到指定的 JSONPath 表达式时。
    * 处理过程中发生意外错误时。

## 示例

以下示例仅展示入站消息、规则节点配置和系统状态的**相关**部分。

-----

### 示例 1 — 选择嵌套属性

**入站消息**

Data:

```json
{
  "device": {
    "name": "Thermostat A1",
    "type": "TH-01"
  },
  "telemetry": {
    "temperature": 23.5,
    "humidity": 55
  }
}
```

**节点配置**

```json
{
  "jsonPath": "$.telemetry"
}
```

**出站消息**

Data:

```json
{
  "temperature": 23.5,
  "humidity": 55
}
```

**输出连接：** `Success`。

**说明：** JSONPath 表达式 `$.telemetry` 选中 `telemetry` 对象。该对象成为新的消息 data，替换原始内容。

-----

### 示例 2 — 选择数组元素

**入站消息**

Data:

```json
{
  "device_profiles": [
    {
      "name": "default",
      "isDefault": true
    },
    {
      "name": "low_power",
      "isDefault": false
    }
  ]
}
```

**节点配置**

```json
{
  "jsonPath": "$.device_profiles[1].name"
}
```

**出站消息**

Data:

```json
"low_power"
```

**输出连接：** `Success`。

**说明：** 表达式从 `device_profiles` 数组的第二个元素（索引 1）选中 `name` 属性。结果字符串 `"low_power"` 成为新的消息 data。

-----

### 示例 3 — 路径未找到

**入站消息**

Data:

```json
{
  "temperature": 25.1
}
```

**节点配置**

```json
{
  "jsonPath": "$.humidity"
}
```

**出站消息**

原始消息经 `Failure` 链路由。

**输出连接：** `Failure`。

**说明：** 消息 data 根级别不包含 `humidity` 键。因路径未找到，消息视为失败。

-----

### 示例 4 — 使用过滤器选择子集

**入站消息**

Data:

```json
{
  "readings": [
    {
      "type": "temperature",
      "value": 19
    },
    {
      "type": "humidity",
      "value": 78
    },
    {
      "type": "temperature",
      "value": 21
    }
  ]
}
```

**节点配置**

```json
{
  "jsonPath": "$.readings[?(@.type == 'temperature')]"
}
```

**出站消息**

Data:

```json
[
  {
    "type": "temperature",
    "value": 19
  },
  {
    "type": "temperature",
    "value": 21
  }
]
```

**输出连接：** `Success`。

**说明：** JSONPath 过滤器表达式 `[?(@.type == 'temperature')]` 选中 `readings` 数组中 `type` 为 "temperature" 的所有对象。结果数组成为新的消息 data。
