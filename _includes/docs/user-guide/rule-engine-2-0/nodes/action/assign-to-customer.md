将消息发起者分配给指定客户。

## 配置

- **Customer title（客户标题）** - 目标客户的名称。支持使用 `${metadataKey}` 或 `$[dataKey]` 模板化，以替换消息元数据或数据中的值。
- **Create new customer if it doesn't exist（不存在时创建新客户）** - 启用后，若未找到匹配标题的客户则创建新客户。禁用时，若目标客户不存在则处理失败。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbAssignToCustomerNodeConfiguration",
  "type": "object",
  "properties": {
    "customerNamePattern": {
      "type": "string",
      "description": "Target customer name, supports templatization"
    },
    "createCustomerIfNotExists": {
      "type": "boolean",
      "description": "Whether to create a new customer if the target doesn't exist"
    }
  },
  "required": [
    "customerNamePattern"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 使用消息数据和元数据中的值解析 **Customer title** 中的模板。
2. 在租户内搜索具有解析后标题的现有客户。
3. 若客户不存在且 **Create new customer if it doesn't exist** 已启用：
    - 使用解析后的标题创建新客户
    - 为新创建的客户生成 `ENTITY_CREATED` 生命周期事件
4. 若客户不存在且禁用了创建，则处理失败。
5. 将发起者分配给目标客户。
6. 若实体已分配给目标客户，不会进行更改，但处理仍视为成功。
7. 成功完成后，消息转发至 `Success` 连接。发生错误时，消息路由至 `Failure` 连接。

## 输出连接

- `Success`
    - 实体已成功分配给客户，或实体已属于目标客户。
- `Failure`
    - 处理过程中发生错误，例如在禁用创建时目标客户不存在。

## 示例

### 示例 1 — 分配给现有客户

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "customerNamePattern": "My Customer",
  "createCustomerIfNotExists": false
}
```

**系统状态**

- 租户下存在名为「My Customer」的客户。
- 发起者设备未分配给任何客户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

设备被分配给「My Customer」。

### 示例 2 — 为客户名称使用模式

**传入消息**

数据：

```json
{
  "region": "North"
}
```

元数据：

```json
{
  "customerType": "Premium"
}
```

**节点配置**

```json
{
  "customerNamePattern": "$[region] $${customerType}",
  "createCustomerIfNotExists": false
}
```

**系统状态**

租户下存在名为「North Premium」的客户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

模式 `$[region] $${customerType}` 通过用消息数据和元数据中的值替换得到解析，客户名称变为「North Premium」。设备被分配给「North Premium」客户。
