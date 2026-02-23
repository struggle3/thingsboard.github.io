根据来源设备的配置名称路由入站消息。

## 前置条件

入站消息的来源实体类型必须为 `DEVICE`。

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

1. 检查入站消息的来源实体类型是否为 `DEVICE`。
    1. 若不是 `DEVICE`，则以 `Failure` 结束处理。
2. 从数据库获取该设备的配置以得到配置名称。
    1. 若未找到配置（例如消息处理时来源实体已不存在），则以 `Failure` 结束处理。
3. 使用标签与获取的配置名称完全匹配的连接将入站消息路由至下游节点。

## 输出连接

* 设备配置名称：
    * 当入站消息的来源实体类型为 `DEVICE` 且已找到该设备的配置时。
* `Failure`：
    * 当入站消息的来源实体类型不是 `DEVICE` 时。
    * 当未找到入站消息来源实体的配置时。
    * 消息处理过程中发生其他意外错误时。

## 示例

以下示例仅展示入站消息的**相关**字段。除非另有说明，其他消息字段可为任意值。

---

### 示例 1 — 来源实体类型为 `DEVICE`，配置名称为「Temperature Sensor」→ 经 **`Temperature Sensor`** 路由

**入站消息**

来源实体类型为 `DEVICE`。

**节点配置**

```json
{}
```

**系统状态**

设备存在且其**配置名称**为 `Temperature Sensor`。

**结果**

经 **`Temperature Sensor`** 路由。

**说明**

节点获取设备的配置，使用**精确的配置名称**作为连接标签。

---

### 示例 2 — 来源实体类型**不是** `DEVICE` → **`Failure`**

**入站消息**

来源实体类型不是 `DEVICE`，例如为 `CUSTOMER` 或其它实体类型。

**节点配置**

```json
{}
```

**系统状态**

不相关。

**结果**

**`Failure`**。

**说明**

该节点要求来源实体类型为 `DEVICE`。

---

### 示例 3 — 处理时未找到设备 → **`Failure`**

**入站消息**

来源实体类型为 `DEVICE`。

**节点配置**

```json
{}
```

**系统状态**

不存在具有该 ID 的设备（例如消息在队列中时已被删除）。

**结果**

**`Failure`**。

**说明**

节点无法获取设备的配置。
