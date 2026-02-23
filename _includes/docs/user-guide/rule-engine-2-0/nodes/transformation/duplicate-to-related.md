根据指定的关系查询，将入站消息复制到与消息来源实体相关的所有实体。

## 配置

节点使用**关系查询**（Relations query）查找目标实体。

- **Direction** — 指定要搜索的关系方向，可为 *From originator* 或 *To originator*。
- **Max relation level** — 设置遍历嵌套关系的最大深度（如值为 2 可找到与来源实体相关的实体，以及与这些实体相关的实体）。
- **Fetch last level relation only** — 若启用，仅使用在最大指定层级找到的实体。仅在 **Max relation level** 大于 1 时适用。
- **Relation filters** — 用于过滤关系的条件列表。每个过滤器指定：
    - **Relation type** — 要查找的关系类型（如 *Contains*、*Manages*）。
    - **Entity type** — 相关实体的可接受实体类型列表（如 *Device*、*Asset*）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDuplicateMsgToRelatedNodeConfiguration",
  "type": "object",
  "properties": {
    "relationsQuery": {
      "type": "object",
      "description": "Defines the query to find related entities.",
      "properties": {
        "direction": {
          "type": "string",
          "enum": [
            "FROM",
            "TO"
          ],
          "description": "Direction of the relation search."
        },
        "maxLevel": {
          "type": "integer",
          "description": "Maximum level of nested relations to follow."
        },
        "fetchLastLevelOnly": {
          "type": "boolean",
          "description": "If true, only entities found on the 'maxLevel' are returned."
        },
        "filters": {
          "type": "array",
          "description": "List of filters to apply to the relations.",
          "items": {
            "type": "object",
            "properties": {
              "relationType": {
                "type": "string",
                "description": "The type of the relation (e.g., 'Contains')."
              },
              "entityTypes": {
                "type": "array",
                "description": "A list of allowed entity types for the related entity.",
                "items": {
                  "type": "string"
                }
              }
            },
            "required": [
              "relationType",
              "entityTypes"
            ]
          }
        }
      },
      "required": [
        "direction",
        "filters"
      ]
    }
  },
  "required": [
    "relationsQuery"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别入站消息的来源实体。
2. 从来源实体开始执行配置的**关系查询**，查找所有相关实体。
3. 若查询未找到任何匹配的相关实体，处理失败，消息经 `Failure` 路由。
4. 对**每个找到的相关实体**创建一条新消息。该新消息为原始消息的副本，但其来源实体设为该相关实体。
5. 所有新消息经 `Success` 链发送。所有副本成功入队后确认原始消息。

## 输出连接

- **`Success`**：
    - 新消息（每个找到的相关实体一条）经此链发送。
- **`Failure`**：
    - 关系查询未找到任何实体时。
    - 发生其他意外错误时。

## 示例

### 示例 1 — 复制到相关设备

**入站消息**

Originator: 资产 `Building A`

Data: `{"command": "setFanSpeed", "value": "HIGH"}`

**节点配置**

```json
{
  "relationsQuery": {
    "direction": "FROM",
    "maxLevel": 1,
    "filters": [
      {
        "relationType": "Contains",
        "entityTypes": ["DEVICE"]
      }
    ]
  }
}
```

**系统状态**

资产 `Building A` 有两条出站 `Contains` 关系：一条到 `Device HVAC-1`，一条到 `Device HVAC-2`。

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. **Message 1**：
    - **Originator**：`Device HVAC-1`
    - **Data**：`{"command": "setFanSpeed", "value": "HIGH"}`
2. **Message 2**：
    - **Originator**：`Device HVAC-2`
    - **Data**：`{"command": "setFanSpeed", "value": "HIGH"}`

**说明**：节点查询来源实体（`Building A`）包含的设备。找到两个设备，并为每个创建消息副本，将其设为新的来源实体。

-----

### 示例 2 — 复制到相关客户

**入站消息**

Originator: 设备 `Thermostat-Z1`

Data: `{"alert": "battery_low"}`

**节点配置**

```json
{
  "relationsQuery": {
    "direction": "TO",
    "maxLevel": 1,
    "filters": [
      {
        "relationType": "Manages",
        "entityTypes": [
          "CUSTOMER"
        ]
      }
    ]
  }
}
```

**系统状态**

名为 `Customer B` 的客户有一条到设备 `Thermostat-Z1` 的出站 `Manages` 关系。

**出站消息**

经 `Success` 链创建一条新消息：

1. **Message 1**：
    - **Originator**：`Customer B`
    - **Data**：`{"alert": "battery_low"}`

**说明**：节点查找对来源实体（`Thermostat-Z1`）具有 `Manages` 关系的实体。找到 `Customer B` 并以该客户为来源实体创建新消息。适用于将设备告警传播到拥有该设备的客户。
