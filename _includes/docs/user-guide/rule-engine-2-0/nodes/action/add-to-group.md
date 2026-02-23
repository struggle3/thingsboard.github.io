根据可配置的组名模式，将消息发起者实体添加到实体组中。

## 配置

配置允许您指定如何将实体添加到组，以及当组不存在或实体已属于其他组时的系统行为。

- **Group name pattern（组名模式）** - 定义目标实体组名称的模式。模式支持使用 `${metadataKey}` 或 `$[dataKey]` 模板化，以替换消息元数据或数据中的值。
- **Create new group if not exists（不存在时创建新组）** - 启用后，若未找到匹配模式的实体组则创建新组。禁用时，若目标组不存在则处理失败。
- **Remove from current groups（从当前组中移除）** - 启用后，在将实体添加到目标组之前，会将其从所有当前所属组（除「全部」组外）中移除。这可确保实体仅属于目标组和「全部」组。
- **Groups cache expiration time (sec)（组缓存过期时间，秒）** - 指定缓存实体组记录的最长时间间隔（秒）。值为 0 表示记录永不过期。通过减少对常用组的数据库查询来提升性能。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbAddToGroupConfiguration",
  "type": "object",
  "properties": {
    "groupNamePattern": {
      "type": "string",
      "description": "Target entity group name, supports templatization."
    },
    "createGroupIfNotExists": {
      "type": "boolean",
      "description": "Whether to create a new group if the target group doesn't exist."
    },
    "removeFromCurrentGroups": {
      "type": "boolean",
      "description": "Whether to remove the entity from its current groups before adding to target group."
    },
    "groupCacheExpiration": {
      "type": "integer",
      "description": "Cache expiration time for group records in seconds."
    }
  },
  "required": [
    "groupNamePattern",
    "createGroupIfNotExists",
    "removeFromCurrentGroups",
    "groupCacheExpiration"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点识别消息发起者实体的**所有者**（租户或客户）。
2. 使用消息数据和元数据中的值解析 **Group name pattern** 中的模板。
3. 节点搜索与解析后的组名、实体类型和发起者所有者匹配的现有实体组。
4. 若 **Remove from current groups** 已启用：
    - 节点获取当前包含发起者实体的所有实体组
    - 将实体从除目标组和特殊「全部」组以外的所有组中移除
5. 若目标组存在或 **Create new group if not exists** 已启用：
    - 若组不存在且启用了创建，则使用解析后的名称创建新实体组
    - 将发起者实体添加到目标组
6. 若目标组不存在且禁用了创建，则处理失败
7. 根据 **Groups cache expiration time** 设置缓存组查找结果以提升性能
8. 成功完成后，消息转发至 `Success` 连接。发生错误时，消息路由至 `Failure` 连接。

## 输出连接

- `Success`：
    - 实体已成功添加到目标组。
- `Failure`：
    - 处理过程中发生错误，例如在禁用创建时目标组不存在。

## 示例

### 示例 1 — 将设备添加到组

**传入消息**

发起者：属于租户的 `DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "My device group",
  "createGroupIfNotExists": false,
  "removeFromCurrentGroups": false,
  "groupCacheExpiration": 300
}
```

**系统状态**

存在名为「My device group」且属于租户的设备组。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

发起者设备被添加到「My device group」组。

### 示例 2 — 为目标组名使用模式

**传入消息**

数据：

```json
{
  "location": "Warehouse"
}
```

发起者：属于租户的 `DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "$[location] devices",
  "createGroupIfNotExists": false,
  "removeFromCurrentGroups": false,
  "groupCacheExpiration": 300
}
```

**系统状态**

存在名为「Warehouse devices」且属于租户的设备组。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

模式 `${location}` devices 通过用消息数据中的 location 值替换得到解析，组名变为「Warehouse devices」。发起者设备被添加到「Warehouse devices」组。

### 示例 3 — 组不存在时创建

**传入消息**

发起者：属于租户的 `DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "My device group",
  "createGroupIfNotExists": true,
  "removeFromCurrentGroups": false,
  "groupCacheExpiration": 300
}
```

**系统状态**

名为「My device group」的设备组不存在。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

由于「My device group」组不存在且 `createGroupIfNotExists` 设置为 true，首先在租户层级（与设备相同的层级）创建该组，然后将发起者设备添加到新建的「My device group」组。

### 示例 4 — 从当前组中移除设备

**传入消息**

发起者：属于租户的 `DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "Group A",
  "createGroupIfNotExists": false,
  "removeFromCurrentGroups": true,
  "groupCacheExpiration": 300
}
```

**系统状态**

- 设备组「All」存在
- 设备组「Group A」存在
- 设备组「Group B」存在
- 设备组「Group C」存在
- 发起者设备当前属于「All」、「Group B」和「Group C」组
- 所有组与设备处于同一层级（租户层级）

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

由于 `removeFromCurrentGroups` 设置为 true，发起者设备首先从其当前所属组（「Group B」和「Group C」）中移除，然后被添加到「Group A」组。设备最终属于「Group A」和「All」组。

### 示例 5 — 所有权层级错误

**传入消息**

发起者：属于租户的 `DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "Customer Group",
  "createGroupIfNotExists": false,
  "removeFromCurrentGroups": false,
  "groupCacheExpiration": 300
}
```

**系统状态**

设备组「Customer Group A」存在，但由客户拥有

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

处理失败，因为节点在租户的所有权下查找名为「Customer Group」的组（设备属于租户），但「Customer Group」组存在于客户下。

### 示例 6 — 不支持的实体类型

**传入消息**

发起者：`TENANT` 实体。

**节点配置**

```json
{
  "groupNamePattern": "My Group",
  "createGroupIfNotExists": false,
  "removeFromCurrentGroups": false,
  "groupCacheExpiration": 300
}
```

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

处理失败，因为发起者实体类型 `TENANT` 不支持实体组。
