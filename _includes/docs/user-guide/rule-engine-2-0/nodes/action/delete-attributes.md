根据配置的作用域和属性键，从消息发起者删除指定属性。

## 配置

- **Attributes scope（属性作用域）**：定义从消息发起者删除属性的作用域。
    - *Server attributes（服务端属性）*：从服务端作用域（`SERVER_SCOPE`）删除
    - *Shared attributes（共享属性）*：从共享作用域（`SHARED_SCOPE`）删除
    - *Client attributes（客户端属性）*：从客户端作用域（`CLIENT_SCOPE`）删除
- **Attributes keys（属性键）**：要删除的属性键集合。支持使用 `${metadataKey}` 和 `$[dataKey]` 模式进行模板化。

### 高级设置

- **Send attributes deleted notification（发送属性已删除通知）**：启用时，成功删除后向消息发起者的默认 Rule Chain 发送 `ATTRIBUTES_DELETED` 事件。
  此类事件示例：

类型：`ATTRIBUTES_DELETED`

发起者：与原始消息发起者相同

数据包含已删除属性键集合：

```json
{
  "attributes": ["deletedKey1", "deletedKey2"]
}
```

元数据包含执行删除的 Rule 节点 ID 及已删除属性的作用域：

```json
{
  "ruleNodeId": "3567a4c0-924c-11f0-b7fc-93ceb833d90b",
  "scope": "SERVER_SCOPE"
}
```

- **Force notification to the device（强制通知设备）**：启用时，强制向设备发送通知。仅适用于 *Shared attributes* 作用域。或可通过在传入消息中将 `notifyDevice` 元数据键设为 `"true"` 触发设备通知。

通知包含已删除属性键集合：
```json
{
  "deleted": ["key1", "key2"]
}
```

### 作用域覆盖

可使用传入消息中的 `scope` 元数据键动态覆盖属性作用域。若提供，将覆盖节点设置中配置的作用域。

支持的 `scope` 值：

- `SERVER_SCOPE` - 服务端属性作用域
- `SHARED_SCOPE` - 共享属性作用域
- `CLIENT_SCOPE` - 客户端属性作用域

若提供，值必须与上述常量之一完全匹配（区分大小写）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgDeleteAttributesNodeConfiguration",
  "type": "object",
  "properties": {
    "scope": {
      "type": "string",
      "enum": [
        "SERVER_SCOPE",
        "SHARED_SCOPE",
        "CLIENT_SCOPE"
      ],
      "description": "Attribute scope for deletion"
    },
    "keys": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Set of attribute keys to delete"
    },
    "sendAttributesDeletedNotification": {
      "type": "boolean",
      "description": "Whether to send attributes deleted notification event"
    },
    "notifyDevice": {
      "type": "boolean",
      "description": "Whether to force device notification (shared scope only)"
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. **处理属性键**：处理每个配置的属性键模式，用消息中的值替换占位符。
2. **过滤有效键**：从处理后列表中移除重复键并过滤空/空白键。
3. **确定属性作用域**：
    - 若消息中有 `scope` 元数据值则使用
    - 若无元数据作用域则回退到配置的作用域
4. **无键时跳过处理**：若处理后无有效键剩余，直接将消息路由至 `Success`，不执行任何删除。
5. **删除属性**：使用处理后的键列表和已确定的作用域从消息发起者删除指定属性。
6. **处理通知**：
    - 对于共享作用域：若已配置或 `notifyDevice` 元数据设为 true，则应用设备通知
    - 若 `sendAttributesDeletedNotification` 已启用，向发起者默认 Rule Chain 发送 `ATTRIBUTES_DELETED` 事件
7. **路由消息**：根据删除操作结果将原始消息路由至 `Success` 或 `Failure`。

## 输出连接

- `Success`
    - 已从消息发起者成功删除属性
    - 未提供属性键（处理后键列表为空）
    - 若 **Send attributes deleted notification** 已启用，向发起者默认 Rule Chain 发送 `ATTRIBUTES_DELETED` 事件
    - 若 **Force notification to the device** 已启用且属性作用域为 `SHARED_SCOPE`，向设备发送已删除属性的通知
- `Failure`
    - 处理过程中发生意外错误

## 示例

### 示例 1 — 删除指定属性

**传入消息**

元数据：`{}`

**节点配置**

```json
{
  "scope": "SERVER_SCOPE",
  "keys": [
    "attribute1",
    "attribute2"
  ],
  "sendAttributesDeletedNotification": false,
  "notifyDevice": false
}
```

**系统状态**

发起者具有服务端属性：`attribute1`、`attribute2`、`attribute3`

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

从发起者删除 `attribute1` 和 `attribute2` 服务端属性。`attribute3` 保持不变。
未发送任何事件或通知。

### 示例 2 — 使用模式的动态键删除

**传入消息**

数据：

```json
{
  "attributeFromData": "attribute1"
}
```

元数据：

```json
{
  "attributeFromMetadata": "attribute2"
}
```

发起者：`DEVICE`

**节点配置**

```json
{
  "scope": "SERVER_SCOPE",
  "keys": [
    "$[attributeFromData]",
    "${attributeFromMetadata}",
    "attribute3"
  ],
  "sendAttributesDeletedNotification": false,
  "notifyDevice": false
}
```

**系统状态**

设备具有客户端属性：`sensorReading=123`、`lastUpdate=2023-10-15`、`staticKey=value`、`keepThis=data`

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

从发起者删除 `attribute1`、`attribute2` 和 `attribute3` 服务端属性。未发送任何事件或通知。

### 示例 3 — 共享属性作用域覆盖

**传入消息**

发起者：`DEVICE`

元数据：

```json
{
  "scope": "SHARED_SCOPE"
}
```

**节点配置**

```json
{
  "scope": "SERVER_SCOPE",
  "keys": [
    "sharedAttribute"
  ],
  "sendAttributesDeletedNotification": false,
  "notifyDevice": true
}
```

**系统状态**

设备具有共享属性：`sharedAttribute`

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

发生以下操作：

- **作用域覆盖**：尽管配置为 `SERVER_SCOPE`，节点使用消息元数据中的 `SHARED_SCOPE`
- **属性已删除**：从共享作用域移除 `sharedValue`
- **设备通知**：因共享作用域且 `notifyDevice` 设为 `true`，设备收到属性删除通知
