根据配置的方向和关系类型，检查入站消息来源实体与另一实体（任意实体或指定实体）之间是否存在关系。

## 配置

### 字段说明

#### 关系查询参数

* **方向** — 必填。指定相对于入站消息来源实体的关系方向（*From originator* 或 *To originator*）。
* **关系类型** — 必填。指定要匹配的关系类型（如 *Contains*、*Manages*）。
* **检查与指定实体的关系** — 开关。
    * 启用时，节点检查是否存在与指定方向、类型匹配且指向指定实体的关系。此时会出现两个附加字段：
        * **类型** — 必填。指定目标的实体类型。
        * [实体选择器] — 必填。按名称选择指定实体。字段标签根据所选类型变化（如 Device、Asset、Customer）。
    * 禁用时，节点检查是否存在与所选方向和类型匹配的任意关系，不考虑另一实体。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbCheckRelationNodeConfiguration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "direction": {
      "type": "string",
      "description": "Direction of the relation relative to the originator.",
      "enum": [
        "FROM",
        "TO"
      ]
    },
    "relationType": {
      "type": "string",
      "description": "Type of the relation to match."
    },
    "checkForSingleEntity": {
      "type": "boolean",
      "description": "When enabled, the relation must match a specific target entity."
    },
    "entityType": {
      "type": "string",
      "description": "Type of the entity."
    },
    "entityId": {
      "type": "string",
      "format": "uuid",
      "description": "UUID of the specific entity to check against. Required if 'checkForSingleEntity' is true."
    }
  },
  "required": [
    "direction",
    "relationType",
    "checkForSingleEntity"
  ]
}

```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 若**检查与指定实体的关系**已启用：
    1. 检查是否存在满足以下条件的关系：
        * 配置的**方向**，
        * 指定的**关系类型**，
        * 以及配置的**目标实体**。
    2. 若找到该关系，经 `True` 路由消息；否则经 `False` 路由。
2. 若**检查与指定实体的关系**已禁用：
    1. 搜索与配置的**方向**和**类型**匹配的任意关系。
    2. 若找到至少一个匹配关系，经 `True` 路由消息；否则经 `False` 路由。

## 输出连接

* `True`：
    * 当找到匹配的关系时。
* `False`：
    * 当未找到匹配的关系时。
* `Failure`：
    * 消息处理过程中发生意外错误时。

## 示例

以下示例仅展示入站消息的**相关**字段。除非另有说明，其他消息字段可为任意值。

---

### 示例 1 — 与指定实体的关系存在 → `True`

**入站消息**

任意消息。

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Contains",
  "checkForSingleEntity": true,
  "entityType": "ASSET",
  "entityId": "8c67e3b0-1234-4e9a-9b8c-781be214172f"
}
```

**系统状态**

存在类型为 `Contains` 的、**从**来源实体**到**指定资产的关系。

**结果**

经 **`True`** 路由。

**说明**

找到与方向、类型和目标实体匹配的关系。

---

### 示例 2 — 与指定实体的关系不存在 → `False`

**入站消息**

任意消息。

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Manages",
  "checkForSingleEntity": true,
  "entityType": "ASSET",
  "entityId": "3b4f2d90-7891-4b2d-88d7-d3cfb90ec501"
}
```

**系统状态**

来源实体与指定资产之间不存在类型为 `Manages` 的关系。

**结果**

经 **`False`** 路由。

**说明**

未找到配置的关系。

---

### 示例 3 — 与任意实体的关系存在 → `True`

**入站消息**

任意消息。

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Connected",
  "checkForSingleEntity": false
}
```

**系统状态**

来源实体在 `FROM` 方向至少有到一个实体的 `Connected` 关系。

**结果**

经 **`True`** 路由。

**说明**

存在与方向和类型匹配的关系。

---

### 示例 4 — 无匹配关系 → `False`

**入站消息**

任意消息。

**节点配置**

```json
{
  "direction": "TO",
  "relationType": "Contains",
  "checkForSingleEntity": false
}
```

**系统状态**

来源实体在 `TO` 方向不存在 `Contains` 关系。

**结果**

经 **`False`** 路由。

**说明**

未找到匹配的关系。

---

### 示例 5 — 不考虑多级关系 → `False`

**入站消息**

来源实体为 `CUSTOMER`。

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Contains",
  "checkForSingleEntity": true,
  "entityType": "DEVICE",
  "entityId": "de305d54-75b4-431b-adb2-eb6b9e546013"
}
```

**系统状态**

* 存在**从**客户**到**资产的 `Contains` 关系。
* 该资产**到**目标设备存在另一条 `Contains` 关系。
* 客户与设备之间不存在直接关系。

**结果**

经 **`False`** 路由。

**说明**

节点仅检查**直接**关系。不追踪间接或多级关系（如 客户 → 资产 → 设备）。由于来源实体与目标设备之间无直接关系，结果为 `False`。
