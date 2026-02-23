根据可配置的实体组名称模式，将消息发起者实体从实体组中移除。

## 配置

- **Group name pattern（组名称模式）** - 定义目标实体组名称的模式。支持使用 `${metadataKey}` 或 `$[dataKey]` 模板化，以替换消息元数据或数据中的值。
- **Groups cache expiration time (sec)（组缓存过期时间（秒））** - 指定缓存实体组记录的最大时间间隔（秒）。0 表示记录永不过期。通过减少对常用组的数据库查询提高性能。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbRemoveFromGroupConfiguration",
  "type": "object",
  "properties": {
    "groupNamePattern": {
      "type": "string",
      "description": "Target entity group name, supports templatization."
    },
    "groupCacheExpiration": {
      "type": "integer",
      "description": "Cache expiration time for group records in seconds."
    }
  },
  "required": [
    "groupNamePattern",
    "groupCacheExpiration"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点识别消息发起者实体的 **所有者**（租户或客户）。
2. 使用消息数据和元数据中的值解析 **Group name pattern** 中的模板。
3. 节点搜索与解析后组名称、实体类型和发起者所有者匹配的现有实体组。
4. 若目标组存在：将发起者实体从目标组移除，除非目标组为特殊组「All」
5. 若目标组不存在，处理失败
6. 组查询根据 **Groups cache expiration time** 设置进行缓存以提高性能
7. 成功完成后，消息转发至 `Success` 连接。发生错误（如组不存在）时，消息路由至 `Failure` 连接。

## 输出连接

- `Success`
    - 实体已成功从目标组移除。
- `Failure`
    - 处理过程中发生错误，如目标组不存在。

## 示例

### 示例 1 — 从组中移除设备

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "My device group",
  "groupCacheExpiration": 300
}
```

**系统状态**

- 发起者设备属于租户
- 存在名为「My device group」的设备组，属于租户
- 发起者设备当前为「My device group」的成员

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

发起者设备从「My device group」组中移除。

### 示例 2 — 为目标组名称使用模式

**传入消息**

数据：

```json
{
  "location": "Warehouse"
}
```

发起者：`DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "$[location] devices",
  "groupCacheExpiration": 300
}
```

**系统状态**

- 发起者设备属于租户
- 存在名为「Warehouse devices」的设备组，属于租户
- 发起者设备当前为「Warehouse devices」的成员

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

模式 `$[location] devices` 通过用消息数据中的 location 值替换得到解析，组名变为「Warehouse devices」。发起者设备从「Warehouse devices」组中移除。

### 示例 3 — 组不存在

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "Non-existent group",
  "groupCacheExpiration": 300
}
```

**系统状态**

- 发起者设备属于租户
- 不存在名为「Non-existent group」的设备组。

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

由于组「Non-existent group」不存在，处理失败并返回指示未找到实体组的错误消息。

### 示例 4 — 设备不在指定组中

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "Target Group",
  "groupCacheExpiration": 300
}
```

**系统状态**

- 存在设备组「Target Group」
- 发起者设备不是「Target Group」的成员

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

即使设备不是「Group A」的成员，移除操作仍成功完成。系统将其视为成功操作（幂等行为）。

### 示例 5 — 所有权层级错误

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "groupNamePattern": "Customer Group",
  "groupCacheExpiration": 300
}
```

**系统状态**

- 发起者设备属于租户
- 设备组「Customer Group」存在但属于客户

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

由于节点在租户所有权下查找名为「Customer Group」的组（因设备属于租户），但「Customer Group」组在客户下存在，处理失败。

### 示例 6 — 不支持的实体类型

**传入消息**

发起者：`TENANT`。

**节点配置**

```json
{
  "groupNamePattern": "My Group",
  "groupCacheExpiration": 300
}
```

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

由于发起者实体类型 `TENANT` 不支持实体组，处理失败。
