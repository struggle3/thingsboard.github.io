执行用户自定义函数，返回连接标签或连接标签列表。
消息经指定的连接路由。
若脚本返回单个字符串，则视为单元素列表。
若脚本执行失败，消息经 `Failure` 连接路由。
支持 **TBEL** 和 **JavaScript**。

## 配置

### 字段说明

* **脚本语言** — 定义使用的脚本语言。可为 *TBEL* 或 *JavaScript*。
* **脚本内容** — 用于评估入站消息的函数体。
  该脚本必须返回单个字符串或字符串数组（每个字符串为一个连接标签）。
  脚本可访问以下参数：
    * `msg` — 消息数据，通常为对象或数组。
    * `metadata` — 消息元数据。
      在 JavaScript 中为对象，所有值为字符串。
      在 TBEL 中为 `java.util.Map<String, String>`。
    * `msgType` — 消息类型（字符串）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbJsSwitchNodeConfiguration",
  "type": "object",
  "required": [
    "scriptLang"
  ],
  "properties": {
    "scriptLang": {
      "type": "string",
      "description": "Scripting language used to execute the function.",
      "enum": [
        "TBEL",
        "JS"
      ]
    },
    "jsScript": {
      "type": "string",
      "description": "JavaScript function body that must return a string or array of strings. Used when 'scriptLang' is 'JS'."
    },
    "tbelScript": {
      "type": "string",
      "description": "TBEL function body that must return a string or array of strings. Used when 'scriptLang' is 'TBEL'."
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 根据配置的**脚本语言**确定要执行的脚本：
    * 若为 *TBEL*，使用配置的 **TBEL 脚本**。
    * 若为 *JS*，使用配置的 **JavaScript 脚本**。
2. 将脚本作为函数执行。
3. 脚本必须返回：
    * 字符串 — 视为包含该连接标签的单元素数组。
    * 字符串数组 — 作为要经其路由消息的连接列表使用。
4. 若结果不是字符串或字符串数组，或脚本抛出异常，则经 `Failure` 连接路由。

## 输出连接

* 脚本返回的任意连接名称：
    * 若返回值为字符串或字符串数组，消息经相应的连接路由。
* `Failure`：
    * 若脚本返回无效类型（如数字、对象）。
    * 若脚本抛出错误。

## 示例

### 示例 1 — 返回单个字符串 → `A`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "jsScript": "return 'A';"
}
```

**输出连接：** **`A`**。

**说明：** 脚本返回字符串，视为单元素数组，消息经 `A` 路由。

---

### 示例 2 — 返回单元素数组 → `A`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "jsScript": "return ['A'];"
}
```

**输出连接：** **`A`**。

**说明：** 脚本返回单元素数组，消息经 `A` 路由。

---

### 示例 3 — 返回多个连接 → `A`、`B`、`C`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "jsScript": "return ['A', 'B', 'C'];"
}
```

**输出连接：** **`A`**、**`B`**、**`C`**。

**说明：** 脚本返回连接标签数组，消息经其中的每一个路由。

---

### 示例 4 — 根据温度动态路由 → `High`、`Normal` 或 `Low`

**入站消息**

Data:

```json
{
  "temperature": 85
}
```

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "jsScript": "var t = msg.temperature;\nif (t > 80) return 'High';\nif (t > 60) return 'Normal';\nreturn 'Low';"
}
```

**输出连接：** **`High`**。

**说明：** 温度大于 80，因此脚本返回 `"High"`，消息相应路由。
