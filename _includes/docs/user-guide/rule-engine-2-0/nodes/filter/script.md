执行用户自定义函数并返回布尔值。
若函数返回 `true`，消息通过 `True` 连接路由；若返回 `false`，通过 `False` 连接路由。
若脚本执行失败，消息通过 `Failure` 连接路由。
支持 **TBEL** 和 **JavaScript**。

## 配置

### 字段说明

* **脚本语言** — 定义使用的脚本语言。可为 *TBEL* 或 *JavaScript*。

* **脚本内容** — 用于评估入站消息的函数体。
  该脚本必须返回布尔值（`true` 或 `false`），并可访问以下参数：
    * `msg` — 消息数据，通常为对象或数组。
    * `metadata` — 消息元数据。
      在 JavaScript 中为对象，所有值为字符串。
      在 TBEL 中为 `java.util.Map<String, String>`。
    * `msgType` — 消息类型（字符串）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbJsFilterNodeConfiguration",
  "type": "object",
  "required": [
    "scriptLang"
  ],
  "properties": {
    "scriptLang": {
      "type": "string",
      "description": "用于执行函数的脚本语言。",
      "enum": [
        "TBEL",
        "JS"
      ]
    },
    "jsScript": {
      "type": "string",
      "description": "必须返回布尔值的 JavaScript 函数体。当 'scriptLang' 为 'JS' 时使用。"
    },
    "tbelScript": {
      "type": "string",
      "description": "必须返回布尔值的 TBEL 函数体。当 'scriptLang' 为 'TBEL' 时使用。"
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 根据配置的**脚本语言**确定要执行的脚本：
    * 若为 *TBEL*，使用配置的 **TBEL 脚本**。
    * 若为 *JS*，使用配置的 **JavaScript 脚本**。
2. 将脚本作为函数执行。
3. 脚本必须返回布尔值：
    * 若为 `true`，通过 `True` 连接路由。
    * 若为 `false`，通过 `False` 连接路由。
4. 若脚本抛出异常，通过 `Failure` 连接路由。

## 输出连接

* `True`：
    * 若脚本返回 `true`。
* `False`：
    * 若脚本返回 `false`。
* `Failure`：
    * 若脚本返回非布尔值（如字符串或数字）。
    * 若脚本抛出错误或无法求值。

## 示例

### 示例 1 — 使用动态阈值检查的 JavaScript 脚本 → `True`

此示例检查消息类型是否为 `POST_TELEMETRY_REQUEST`。
若是，则遍历消息中所有数值型遥测值，并与元数据中的阈值比较。
若有任意值超过其阈值，返回 `true`。

**入站消息**

数据：

```json
{
  "temperature": 45.2,
  "humidity": 80,
  "pressure": 1010
}
```

元数据：

```json
{
  "temperatureThreshold": "45.0",
  "humidityThreshold": "85"
}
```

消息类型：`POST_TELEMETRY_REQUEST`


**节点配置**

```json
{
  "scriptLang": "JS",
  "jsScript": "if (msgType !== 'POST_TELEMETRY_REQUEST') {\n    return false;\n}\n\nfor (var key in msg) {\n    var thresholdKey = key + 'Threshold';\n    if (typeof msg[key] === 'number' && metadata[thresholdKey] && !isNaN(metadata[thresholdKey])) {\n        if (msg[key] > Number(metadata[thresholdKey])) {\n            return true;\n        }\n    }\n}\n\nreturn false;"
}
```

**结果**：**`True`**

**说明**：温度 (45.2) 超过阈值 (45.0)，因此脚本返回 `true`。

---

### 示例 2 — 使用动态阈值检查的 TBEL 脚本 → `True`

与上一示例逻辑相同，但使用 TBEL 实现。

**入站消息**

数据：

```json
{
  "temperature": 42.1,
  "humidity": 88,
  "pressure": 1010
}
```

元数据：

```json
{
  "temperatureThreshold": "45.0",
  "humidityThreshold": "85"
}
```

消息类型：`POST_TELEMETRY_REQUEST`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "tbelScript": "if (msgType != 'POST_TELEMETRY_REQUEST') {\n    return false;\n}\n\nforeach (key: msg.keySet()) {\n    var thresholdKey = key + 'Threshold';\n    if (metadata.containsKey(thresholdKey)) {\n        var value = msg[key];\n        var threshold = parseDouble(metadata[thresholdKey]);\n        if (value > threshold) {\n            return true;\n        }\n    }\n}\n\nreturn false;"
}
```

**结果**：**`True`**

**说明**：湿度 (88) 超过其阈值 (85)，因此脚本返回 `true`。

---

### 示例 3 — JavaScript 脚本，运行时错误 → `Failure`

**入站消息**

数据：

```json
{
  "temperature": 30
}
```

**节点配置**

```json
{
  "scriptLang": "JS",
  "jsScript": "// 此脚本期望温度在 'data' 对象内。\nreturn msg.data.temperature > 20;"
}
```

**结果**：**`Failure`**

**说明**：`msg.data` 为 `undefined`，访问其属性导致运行时错误。

---

### 示例 4 — TBEL 脚本，运行时错误 → `Failure`

**入站消息**

数据：

```json
{
  "temperature": 30
}
```

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "tbelScript": "// 此脚本期望温度在 'data' 对象内。\nreturn msg.data.temperature > 20;"
}
```

**结果**：**`Failure`**

**说明**：`msg.data` 为 `null`，访问其属性导致运行时错误。
