根据来源实体类型路由入站消息。消息经其标签与实体类型**规范名称**完全匹配的输出连接转发。

## 配置

### 字段说明

无可配置字段。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "EmptyNodeConfiguration",
  "type": "object",
  "properties": {},
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 确定入站消息的来源实体类型并查找其规范名称。
2. 使用标签与规范名称**完全匹配**的连接将消息路由至下游节点。

## 输出连接

* 来源实体类型的规范名称
    * 适用于所有消息；消息经标签与规范名称完全匹配的连接路由。
* `Failure`：
    * 消息处理过程中发生意外错误时。

## 示例

以下示例仅展示入站消息的**相关**字段。除非另有说明，其他消息字段可为任意值。

---

### 示例 1 — 来源实体类型为 `DEVICE` → 经 **`Device`** 路由

**入站消息**

来源实体类型为 `DEVICE`。

**节点配置**

```json
{}
```

**系统状态**

不相关。

**结果**

经 **`Device`** 路由。

**说明**

`DEVICE` 的规范名称为 `Device`。节点通过具有该标签的连接路由消息。

---

### 示例 2 — 来源实体类型为 `ENTITY_VIEW` → 经 **`Entity View`** 路由

**入站消息**

来源实体类型为 `ENTITY_VIEW`。

**节点配置**

```json
{}
```

**系统状态**

不相关。

**结果**

经 **`Entity View`** 路由。

**说明**

`ENTITY_VIEW` 的规范名称为 `Entity View`。节点通过具有该标签的连接路由消息。

---

### 示例 3 — 来源实体类型为 `AI_MODEL` → 经 **`AI model`** 路由

**入站消息**

来源实体类型为 `AI_MODEL`。

**节点配置**

```json
{}
```

**系统状态**

不相关。

**结果**

经 **`AI model`** 路由。

**说明**

`AI_MODEL` 的规范名称为 `AI model`。节点通过具有该标签的连接路由消息。
