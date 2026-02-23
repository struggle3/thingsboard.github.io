根据配置将入站消息的来源实体更换为另一实体。来源实体可更换为：

* **Customer** — 当前来源实体的客户。
* **Tenant** — 当前来源实体的租户。
* **Related entity** — 与当前来源实体相关的实体。
* **Alarm originator** — 告警的来源实体（若当前来源实体为告警）。
* **Entity by name pattern** — 通过配置的名称模式在数据库中查找的实体。

## 配置

### 字段说明

* **New originator** — 指定将哪个实体设为出站消息的新来源实体。可为：
    * *Customer* — 分配给当前来源实体的客户。
    * *Tenant* — 拥有当前来源实体的租户。
    * *Related entity* — 与当前来源实体相关的实体，使用配置的**关系查询**解析。
    * *Alarm originator* — 产生告警的实体；仅当当前来源实体为 `ALARM` 时可用。
    * *Entity by name pattern* — 通过**Type**和配置的**Name pattern**在数据库中查找的实体。

若 *New originator* 配置为 *Related entity*，需指定**关系查询**以解析新来源实体：

* **Direction** — 指定相对于当前来源实体的关系方向（*From originator* 或 *To originator*）。
* **Max relation level** — 要追踪的嵌套关系的最大层级。未指定时无层级限制。
* **Fetch last level relation only** — 启用后仅考虑**Max relation level**层级的关系，其余丢弃。禁用时考虑所有层级找到的实体。该字段仅在 **Max relation level** 设为非 1 时显示。
* **Relation filters** — 找到的关系必须满足的过滤器列表。
    * **Relation type** — 找到的关系必须具有此类型。
    * **Entity type** — 相关实体必须匹配的实体类型集合。

若 *New originator* 配置为 *Entity by name pattern*，需指定以下字段以查找新来源实体：

* **Type** — 要查找的实体类型。可为：*Device*、*Asset*、*Entity View*、*User* 或 *Edge*。
* **Name pattern** — 要查找的实体的名称模式。例如 `MyDevice`，或使用模板 `${deviceName}`。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbChangeOriginatorNodeConfiguration",
  "type": "object",
  "properties": {
    "originatorSource": {
      "description": "Specifies which entity to set as the new originator for the outgoing message.",
      "type": "string",
      "enum": [
        "CUSTOMER",
        "TENANT",
        "RELATED",
        "ALARM_ORIGINATOR",
        "ENTITY"
      ]
    },
    "relationsQuery": {
      "description": "Configuration for finding a related entity. Used only when 'originatorSource' is 'RELATED'.",
      "type": "object"
    },
    "entityType": {
      "description": "The type of entity to look for. Used only when 'originatorSource' is 'ENTITY'.",
      "type": "string"
    },
    "entityNamePattern": {
      "description": "The name pattern of the entity to find. Used only when 'originatorSource' is 'ENTITY'.",
      "type": "string"
    }
  },
  "required": [
    "originatorSource"
  ]
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 根据配置尝试查找新来源实体
    1. 若找到，将消息来源实体更换为新实体，并经 `Success` 路由消息。
    2. 若未找到，经 `Failure` 路由消息。

## 输出连接

* `Success`：
    * 找到并更换新来源实体时。
* `Failure`：
    * 未找到新来源实体时。
    * 消息处理过程中发生意外错误时。

## 示例

### 示例 1 — 将来源实体更换为客户

**入站消息**

来源实体为资产。

**节点配置**

```json
{
  "originatorSource": "CUSTOMER"
}
```

**系统状态**

来源资产分配给 ID 为 `781a4826-8334-11f0-8de9-0242ac120002` 的客户。

**出站消息**

来源实体为 ID `781a4826-8334-11f0-8de9-0242ac120002` 的 `CUSTOMER`。

**输出连接：** `Success`。

**说明：** 因入站消息来源实体（资产）分配给客户，找到客户并将来源实体更换为该客户。

---

### 示例 2 — 将来源实体更换为租户

**入站消息**

任意消息。

**节点配置**

```json
{
  "originatorSource": "TENANT"
}
```

**系统状态**

处理在 ID 为 `a8b88d08-8339-11f0-8de9-0242ac120002` 的租户下进行。

**出站消息**

与入站消息相同，但来源实体为 ID `a8b88d08-8339-11f0-8de9-0242ac120002` 的 `TENANT`。

**输出连接：** `Success`。

**说明：** 消息处理始终在某个租户下进行，因此总能找到租户，来源实体更换为该租户。

---

### 示例 3 — 将来源实体更换为相关实体

**入站消息**

来源实体为名为 `Parent Asset` 的资产。

**节点配置**

```json
{
  "originatorSource": "RELATED",
  "relationsQuery": {
    "direction": "FROM",
    "maxLevel": 1,
    "filters": [
      {
        "relationType": "Contains",
        "entityTypes": []
      }
    ]
  }
}
```

**系统状态**

系统具有以下关系：

Level 1: `Parent Asset` -- Contains --> `Child Device`

Level 2: `Child Device` -- Contains --> `Grandchild Device`

**出站消息**

与入站消息相同，但来源实体更换为 `Child Asset`。

**输出连接**: `Success`。

**说明**: 节点从 `Parent Asset` 开始查找相关实体。在 level 1 找到 `Child Device`。因 `maxLevel` 为 1，查找止于此，`Child Device` 成为新来源实体。Level 2 的 `Grandchild Device` 被忽略。

---

### 示例 4 — 将来源实体更换为告警来源实体

**入站消息**

来源实体为 `ALARM`。

**节点配置**

```json
{
  "originatorSource": "ALARM_ORIGINATOR"
}
```

**系统状态**

入站告警的来源实体为 ID `c4d81246-8341-11f0-8de9-0242ac120002` 的设备。

**出站消息**

与入站消息相同，但来源实体为 ID `c4d81246-8341-11f0-8de9-0242ac120002` 的 `DEVICE`。

**输出连接**: `Success`。

**说明**: 入站消息来源实体为告警。节点成功识别创建告警的实体（设备）并将其设为出站消息的新来源实体。

---

### 示例 5 — 按名称模式将来源实体更换为指定实体

**入站消息**

Metadata:

```json
{
  "sensorName": "Sensor-T1000"
}
```

**节点配置**

```json
{
  "originatorSource": "ENTITY",
  "entityType": "DEVICE",
  "entityNamePattern": "${sensorName}"
}
```

**系统状态**

存在名为 `Sensor-T1000`、ID 为 `e6f15598-8345-11f0-8de9-0242ac120002` 的设备。

**出站消息**

来源实体为 ID `e6f15598-8345-11f0-8de9-0242ac120002` 的 `DEVICE`。

**输出连接**: `Success`。

**说明**: 节点通过用消息 metadata 中的值替换，解析名称模式 `${sensorName}`，得到名称 `Sensor-T1000`。随后找到具有该名称的设备并成功更换来源实体。
