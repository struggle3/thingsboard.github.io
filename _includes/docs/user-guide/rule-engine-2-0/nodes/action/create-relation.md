根据配置的方向和类型，在消息发起者与指定目标实体之间创建关系。

## 配置

### 关系参数

- **Direction（方向）**：从消息发起者角度定义关系方向。
    - *From originator to target entity（从发起者到目标实体）*：创建发起者为「from」实体、目标为「to」实体的关系
    - *From target entity to originator（从目标实体到发起者）*：创建目标为「from」实体、发起者为「to」实体的关系
- **Relation type（关系类型）**：要创建的关系类型（如「Contains」、「Manages」）。支持使用 `$[dataKey]` 和 `${metadataKey}` 模式进行模板化。

### 目标实体

- **Type（类型）**：要与之创建关系的目标实体类型。支持类型：
    - **Device**：按名称定位设备。需要 **Device name** 模式。
    - **Asset**：按名称定位资产。需要 **Asset name** 模式。
    - **Entity View**：按名称定位实体视图。需要 **Entity view name** 模式。
    - **Tenant**：定位当前租户（无需额外字段）。
    - **Customer**：按标题定位客户。需要 **Customer title** 模式。
    - **Dashboard**：按标题定位仪表板。需要 **Dashboard title** 模式。
    - **User**：按邮箱定位用户。需要 **User email** 模式。
    - **Edge**：按名称定位 Edge。需要 **Edge name** 模式。

- **Entity name/title/email pattern（实体名称/标题/邮箱模式）**：标识目标实体的模式。支持使用 `$[dataKey]` 和 `${metadataKey}` 模式进行模板化。
- **Profile name（配置名称）**：对 *Device* 或 *Asset* 类型启用 **Create new entity if it doesn't exist** 时必填。指定新创建实体的设备 Profile 或资产 Profile。
- **Create new entity if it doesn't exist（不存在时创建新实体）**：启用时，若目标实体不存在则创建。适用于 *Device*、*Asset* 和 *Customer* 实体类型。
    - 对于 *Device* 和 *Asset*：需指定 Profile 名称
    - 对于 *Customer*：使用指定标题创建客户

### 高级设置

- **Remove current relations（移除当前关系）**：创建新关系前，删除同一类型和方向的所有现有关系。
- **Change originator to related entity（将发起者更改为相关实体）**：启用时，成功创建关系后将消息发起者更改为目标实体。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbCreateRelationNodeConfiguration",
  "type": "object",
  "properties": {
    "direction": {
      "type": "string",
      "enum": [
        "FROM",
        "TO"
      ],
      "description": "Relation direction from originator perspective"
    },
    "relationType": {
      "type": "string",
      "description": "Type of relation to create"
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
        "EDGE"
      ],
      "description": "Type of target entity"
    },
    "entityNamePattern": {
      "type": "string",
      "description": "Pattern to identify target entity"
    },
    "entityTypePattern": {
      "type": "string",
      "description": "Profile pattern for entity creation"
    },
    "createEntityIfNotExists": {
      "type": "boolean",
      "description": "Whether to create target entity if not found"
    },
    "removeCurrentRelations": {
      "type": "boolean",
      "description": "Whether to remove existing relations of same type/direction"
    },
    "changeOriginatorToRelatedEntity": {
      "type": "boolean",
      "description": "Whether to change message originator to target entity"
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **提取目标实体标识符**：处理配置的实体名称/标题/邮箱模式，用消息数据和元数据中的值替换占位符。

2. **查找或创建目标实体**：
    - 根据类型和标识符搜索目标实体
    - 若实体不存在且 **Create new entity if it doesn't exist** 已启用：
        - 使用合适的 Profile/类型创建新实体
        - 发送实体创建生命周期事件
    - 若实体不存在且禁用创建，处理失败，消息经 `Failure` 路由

3. **移除现有关系**：
    - 若 **Remove current relations** 已启用，删除消息发起者同一类型和方向的所有现有关系

4. **创建关系**：
    - 检查发起者与目标实体之间是否已存在关系
    - 若不存在，使用指定类型和方向创建新关系

5. **路由消息**：
    - **若 Change originator to related entity 已禁用**：将消息路由至 `Success`
    - **若 Change originator to related entity 已启用**：将消息发起者更改为相关实体，并将消息路由至 `Success`

## 输出连接

- `Success`
    - 关系已存在或已成功创建
    - 目标实体不存在且已创建（启用 **Create new entity if it doesn't exist** 时）
    - 若 **Change originator to related entity** 已启用，消息发起者已更改为目标实体
- `Failure`
    - 未找到目标实体且禁用创建
    - 处理过程中发生其他意外错误

## 示例

### 示例 1 — 创建新实体和关系

**传入消息**

发起者：`DEVICE`

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "Contains",
  "entityType": "ASSET",
  "entityNamePattern": "My Asset",
  "createEntityIfNotExists": false,
  "removeCurrentRelations": false,
  "changeOriginatorToRelatedEntity": false
}
```

**系统状态**

存在名为「My Asset」的资产。

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

从发起者设备到「My Asset」创建了「Contains」关系。

### 示例 2 — 带移除的更新关系

**传入消息**

数据：

```json
{
  "targetEntity": "Asset 1"
}
```

发起者：`DEVICE`

**节点配置**

```json
{
  "direction": "FROM",
  "relationType": "ConnectedTo",
  "entityType": "ASSET",
  "entityNamePattern": "$[targetEntity]",
  "createEntityIfNotExists": false,
  "removeCurrentRelations": true,
  "changeOriginatorToRelatedEntity": false
}
```

**系统状态**

- 存在名为「Asset 1」的资产
- 存在名为「Asset 2」的资产
- 发起者设备与资产「Asset 2」已有「ConnectedTo」关系

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

发生以下操作：

- **旧关系已移除**：发起者设备与资产「Asset 2」的现有「ConnectedTo」关系已删除。
- **新关系已创建**：从发起者设备到资产「Asset 1」创建了新的「ConnectedTo」关系。

消息路由至 `Success` 连接。

### 示例 3 — 更改发起者

**传入消息**

发起者：`DEVICE`

**节点配置**

```json
{
  "direction": "TO",
  "relationType": "LocatedIn",
  "entityType": "ASSET",
  "entityNamePattern": "My Asset",
  "createEntityIfNotExists": false,
  "removeCurrentRelations": false,
  "changeOriginatorToRelatedEntity": true
}
```

**系统状态**

存在名为「My Asset」的资产。

**传出消息**

与传入消息相同，但发起者更改为资产「My Asset」。经 `Success` 连接路由。
