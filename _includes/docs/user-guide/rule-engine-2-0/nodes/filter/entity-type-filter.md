将入站消息的来源实体类型与配置的实体类型集合进行比对。若类型在集合中，消息经 `True` 路由；否则经 `False` 路由。

## 配置

### 字段说明

* **选择实体类型** — 用于比对的实体类型集合；至少需指定一个。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbOriginatorTypeFilterNodeConfiguration",
  "type": "object",
  "required": [
    "originatorTypes"
  ],
  "additionalProperties": false,
  "properties": {
    "originatorTypes": {
      "description": "Non-empty set of originator entity types to check against.",
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

1. 判断入站消息的来源实体类型是否匹配任一已配置的实体类型。
    1. 若匹配，则通过 `True` 将消息路由至下游节点。
    2. 若不匹配，则通过 `False` 将消息路由至下游节点。

## 输出连接

* `True`：
    * 当入站消息的来源实体类型匹配节点配置的任一实体类型时。
* `False`：
    * 当入站消息的来源实体类型不匹配节点配置的任一实体类型时。
* `Failure`：
    * 消息处理过程中发生意外错误时。

## 示例

以下示例仅展示入站消息的**相关**字段。除非另有说明，其他消息字段可为任意值。

---

### 示例 1 — 实体类型匹配 → `True`

**入站消息**

来源实体类型为 `ASSET`。

**节点配置**

```json
{
  "originatorTypes": [
    "ASSET",
    "DEVICE"
  ]
}
```

**系统状态**

不相关。

**结果**

经 **`True`** 路由。

**说明**

入站消息的来源实体类型在配置的集合中，因此消息经 `True` 路由。

### 示例 2 — 实体类型不匹配 → `False`

**入站消息**

来源实体类型为 `TENANT`。

**节点配置**

```json
{
  "originatorTypes": [
    "ASSET",
    "DEVICE"
  ]
}
```

**系统状态**

不相关。

**结果**

经 **`False`** 路由。

**说明**

入站消息的来源实体类型不在配置的集合中，因此消息经 `False` 路由。
