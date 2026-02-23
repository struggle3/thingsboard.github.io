将入站消息类型与配置的消息类型集合进行比对。若类型在集合中，消息经 `True` 路由；否则经 `False` 路由。

## 配置

### 字段说明

* **选择消息类型** — 必填。用于比对的消息类型集合；至少需指定一个。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgTypeFilterNodeConfiguration",
  "type": "object",
  "required": [
    "messageTypes"
  ],
  "additionalProperties": false,
  "properties": {
    "messageTypes": {
      "description": "Non-empty set of message types to check against.",
      "type": "array",
      "items": {
        "type": "string"
      },
      "uniqueItems": true,
      "minItems": 1
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 确定入站消息的**类型**。
2. 检查类型是否在配置的集合中。
    1. 若在，则通过 `True` 将消息路由至下游节点。
    2. 若不在，则通过 `False` 将消息路由至下游节点。

## 输出连接

* `True`：
    * 当入站消息类型匹配节点配置的任一消息类型时。
* `False`：
    * 当入站消息类型不匹配节点配置的任一消息类型时。
* `Failure`：
    * 消息处理过程中发生意外错误时。

## 示例

### 示例 1 — 消息类型匹配 → `True`

**入站消息**

消息类型为 `POST_TELEMETRY_REQUEST`。

**节点配置**

```json
{
  "messageTypes": [
    "POST_TELEMETRY_REQUEST",
    "POST_ATTRIBUTES_REQUEST"
  ]
}
```

**系统状态**

不相关。

**结果**

经 **`True`** 路由。

**说明**

消息类型在配置的集合中。

---

### 示例 2 — 消息类型不匹配 → `False`

**入站消息**

消息类型为 `POST_TELEMETRY_REQUEST`。

**节点配置**

```json
{
  "messageTypes": [
    "POST_ATTRIBUTES_REQUEST",
    "TO_SERVER_RPC_REQUEST"
  ]
}
```

**系统状态**

不相关。

**结果**

经 **`False`** 路由。

**说明**

消息类型不在配置的集合中。
