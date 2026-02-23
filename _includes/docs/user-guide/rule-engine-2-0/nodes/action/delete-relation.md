根据配置的方向、类型以及可选的目标实体，删除消息发起者的关系。

## 配置

- **Direction（方向）**：定义从消息发起者删除的关系方向。
    - *From originator（从发起者）*：删除消息发起者为「from」实体的关系
    - *To originator（到发起者）*：删除消息发起者为「to」实体的关系
- **Relation type（关系类型）**：要删除的关系类型。支持使用 `${metadataKey}` 和 `$[dataKey]` 模式进行模板化。
- **Delete relation with specific entity（删除与特定实体的关系）**：启用时，仅删除与指定目标实体的关系。禁用时，删除指定类型和方向的所有关系。

### 目标实体配置（启用 **Delete relation with specific entity** 时）

- **Type（类型）**：要删除关系的目标实体类型。
- **Entity identifier（实体标识符）**：目标实体的名称、标题或邮箱（取决于实体类型）。支持使用 `${metadataKey}` 和 `$[dataKey]` 模式进行模板化。

支持的目标实体类型：

- *Device*、*Asset*、*Entity View*、*Edge*、*Converter*、*Role* - 使用名称作为实体标识符
- *Customer*、*Dashboard* - 使用标题作为实体标识符
- *User* - 使用邮箱作为实体标识符
- *Tenant* - 无需标识符（使用当前租户）

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDeleteRelationNodeConfiguration",
  "type": "object",
  "properties": {
    "direction": {
      "type": "string",
      "enum": [
        "FROM",
        "TO"
      ],
      "description": "Direction of relations to delete"
    },
    "relationType": {
      "type": "string",
      "description": "Type of relations to delete"
    },
    "deleteForSingleEntity": {
      "type": "boolean",
      "description": "Whether to delete relation with specific entity only"
    },
    "entityType": {
      "type": "string",
      "enum": [
        "TENANT",
        "DEVICE",
        "ASSET",
        "CUSTOMER",
        "ENTITY_VIEW",
        "DASHBOARD",
        "USER",
        "EDGE",
        "CONVERTER",
        "ROLE"
      ],
      "description": "Target entity type (when 'deleteForSingleEntity' is true)"
    },
    "entityNamePattern": {
      "type": "string",
      "description": "Target entity name/title/email pattern (when 'deleteForSingleEntity' is true)"
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **处理关系类型**：处理配置的关系类型模式，用消息中的值替换占位符。
2. **确定删除模式**：
    - 若 **Delete relation with specific entity** 已启用，执行特定实体删除
    - 若禁用，删除指定类型和方向的所有关系
3. **特定实体删除**（启用 **Delete relation with specific entity** 时）：
    - 处理目标实体标识符模式，用消息中的值替换占位符
    - 按类型和处理后的标识符查找目标实体（若实体不存在则处理失败）
    - 删除消息发起者与目标实体之间指定类型和方向的关系
4. **批量删除**（禁用 **Delete relation with specific entity** 时）：
    - 删除涉及消息发起者、指定类型和方向的所有关系
5. **路由消息**：若所有删除均成功则将原始消息路由至 `Success`，否则路由至 `Failure`。

## 输出连接

- `Success`
    - 涉及消息发起者、指定类型和方向的关系均已成功删除
    - 消息发起者与目标实体之间指定类型和方向的关系已删除
- `Failure`
    - 未找到目标实体
    - 处理过程中发生意外错误

## 示例

### 示例 1 — 删除指定类型的所有关系

**传入消息**

任意消息。

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Contains",
  "deleteForSingleEntity": false
}
```

**系统状态**

存在以下关系：

- 发起者到 `Device A`、`Device B`、`Device C` 的类型为 `Contains` 的关系。
- 发起者到 `Asset D` 的类型为 `Uses` 的关系

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

发起者的所有 `Contains` 关系已删除（到 `Device A`、`Device B`、`Device C` 的关系）。
到 `Asset D` 的 `Uses` 关系保持不变。

### 示例 2 — 使用模式删除与特定实体的关系

**传入消息**

发起者：`DEVICE`

数据：

```json
{
  "targetAssetName": "Building"
}
```

元数据：

```json
{
  "relationType": "LocatedIn"
}
```

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "${relationType}",
  "deleteForSingleEntity": true,
  "entityType": "ASSET",
  "entityNamePattern": "$[targetAssetName]"
}
```

**系统状态**

存在以下关系：

- 发起者设备与名为 `Building` 的资产之间的类型为 `LocatedIn` 的关系。
- 发起者与其他资产的各种类型的关系

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

发起者设备与资产 `Building` 之间的 `LocatedIn` 关系已删除。
所有其他关系保持不变。

### 示例 3 — 删除与租户的关系

**传入消息**

任意消息。

**节点配置**

```json
{
  "direction": "TO",
  "relationType": "Owns",
  "deleteForSingleEntity": true,
  "entityType": "TENANT"
}
```

**系统状态**

存在以下关系：

- 当前租户到发起者的类型为 `Owns` 的关系。

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

租户与发起者设备之间的 `Owns` 关系已删除。
注意：无需指定实体标识符，因为仅有一个租户可选：当前租户。

### 示例 4 — 尝试删除与不存在实体的关系

**传入消息**

任意消息。

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Contains",
  "deleteForSingleEntity": true,
  "entityType": "ASSET",
  "entityNamePattern": "nonexistent_asset"
}
```

**系统状态**

系统中不存在名为 `nonexistent_asset` 的资产。

**传出消息**

与传入消息相同，经 `Failure` 连接路由。

**结果**

由于目标实体不存在，处理失败。未修改任何关系。
