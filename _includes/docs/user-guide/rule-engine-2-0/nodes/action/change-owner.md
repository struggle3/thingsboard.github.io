将消息发起者实体的所有者更改为指定的租户或客户。

## 配置

配置允许指定目标所有者类型，以及当目标所有者不存在时系统的行为。

- **Owner type（所有者类型）** - 指定新所有者的类型。可为 *Tenant*（租户）或 *Customer*（客户）。
- **Customer title（客户标题）**（仅适用于 *Customer* 类型）- 目标客户的名称。支持使用 `${metadataKey}` 或 `$[dataKey]` 模板化，以替换消息元数据或数据中的值。
- **Create new customer if it doesn't exist（不存在时创建新客户）**（仅适用于 *Customer* 类型）- 启用时，若未找到匹配标题的客户则创建新客户。禁用时，若目标客户不存在则处理失败。
- **Create new customer on the same level as message originator（在与消息发起者同级创建新客户）**（仅适用于 *Customer* 类型）- 与 **Create new customer if it doesn't exist** 同时启用时，将新客户创建为发起者实体当前所有者的子客户。禁用时，在租户级别创建客户。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbChangeOwnerNodeConfiguration",
  "type": "object",
  "properties": {
    "ownerType": {
      "type": "string",
      "enum": [
        "TENANT",
        "CUSTOMER"
      ],
      "description": "Type of the new owner"
    },
    "ownerNamePattern": {
      "type": "string",
      "description": "Target customer name, supports templatization. Only applicable when 'ownerType' is 'CUSTOMER'"
    },
    "createOwnerIfNotExists": {
      "type": "boolean",
      "description": "Whether to create a new customer if the target doesn't exist"
    },
    "createOwnerOnOriginatorLevel": {
      "type": "boolean",
      "description": "Whether to create new customer as sub-customer of current owner"
    }
  },
  "required": [
    "ownerType"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点从传入消息中识别 **发起者实体**。
2. 根据 **Owner type** 配置：
    - 若为 *Tenant*：
        - 将发起者实体的所有者更改为租户
    - 若为 *Customer*：
        - 使用消息数据和元数据中的值解析 **Customer title** 中的模板
        - 在租户内搜索具有解析后标题的现有客户
        - 若客户不存在且 **Create new customer if it doesn't exist** 已启用：
            - 使用解析后的标题创建新客户
            - 若 **Create new customer on the same level as message originator** 已启用，新客户将作为发起者当前所有者的子客户创建
            - 否则，在租户级别创建新客户
            - 为新创建的客户生成 `ENTITY_CREATED` 生命周期事件
        - 若客户不存在且禁用了创建，则处理失败
3. 将发起者实体的所有者更改为目标所有者（租户或客户）
4. 若实体已属于目标所有者，则不进行更改，但操作仍视为成功
5. 成功完成后，消息转发至 `Success` 连接。发生错误时，消息路由至 `Failure` 连接。

## 输出连接

- `Success`
    - 实体所有者已成功更改，或实体已属于目标所有者。
- `Failure`
    - 处理过程中发生错误，例如在禁用创建时目标客户不存在，或不支持的实体类型。

## 示例

### 示例 1 — 将所有者更改为租户

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "ownerType": "TENANT"
}
```

**系统状态**

- 租户下存在名为「My Customer」的客户。
- 发起者设备属于该客户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

设备所有权从客户转移至租户。

### 示例 2 — 将所有者更改为现有客户

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "ownerType": "CUSTOMER",
  "ownerNamePattern": "My Customer",
  "createOwnerIfNotExists": false,
  "createOwnerOnOriginatorLevel": false
}
```

**系统状态**

- 发起者设备属于租户。
- 租户下存在名为「My Customer」的客户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

设备所有权从租户转移至「My Customer」。

### 示例 3 — 为客户名称使用模式

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

发起者：`ASSET`。

**节点配置**

```json
{
  "ownerType": "CUSTOMER",
  "ownerNamePattern": "${customerType} - $[region] Region",
  "createOwnerIfNotExists": false,
  "createOwnerOnOriginatorLevel": false
}
```

**系统状态**

- 租户下存在名为「Premium - North Region」的客户。
- 发起者资产属于租户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

模式 `${customerType} - $[region] Region` 通过用元数据和数据中的值替换得到解析，结果为「Premium - North Region」。资产所有权转移至该客户。

### 示例 4 — 不存在时创建客户

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "ownerType": "CUSTOMER",
  "ownerNamePattern": "New Customer",
  "createOwnerIfNotExists": true,
  "createOwnerOnOriginatorLevel": false
}
```

**系统状态**

- 不存在名为「New Customer」的客户。
- 发起者设备属于租户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

由于客户「New Customer」不存在且 `createOwnerIfNotExists` 为 true，将在顶层创建标题为「New Customer」的新客户。随后将设备所有权转移至新创建的客户。为新创建的客户生成 `ENTITY_CREATED` 生命周期事件。

### 示例 5 — 在发起者级别创建子客户

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "ownerType": "CUSTOMER",
  "ownerNamePattern": "Sub Customer",
  "createOwnerIfNotExists": true,
  "createOwnerOnOriginatorLevel": true
}
```

**系统状态**

- 租户下存在「Parent Customer」。
- 发起者设备属于「Parent Customer」。
- 不存在名为「Sub Customer」的客户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

由于 `createOwnerIfNotExists` 和 `createOwnerOnOriginatorLevel` 均为 true，将作为「Parent Customer」（设备当前所有者）的子客户创建新客户「Sub Customer」。随后将设备所有权转移至「Sub Customer」。

### 示例 6 — 实体已属于目标所有者

**传入消息**

发起者：`ASSET`。

**节点配置**

```json
{
  "ownerType": "CUSTOMER",
  "ownerNamePattern": "Target Customer",
  "createOwnerIfNotExists": false,
  "createOwnerOnOriginatorLevel": false
}
```

**系统状态**

- 租户下存在「Target Customer」。
- 发起者资产属于「Target Customer」。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

由于资产已属于「Target Customer」，不执行所有权更改，但操作视为成功。

### 示例 7 — 客户不存在且创建已禁用

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "ownerType": "CUSTOMER",
  "ownerNamePattern": "Non-existent Customer",
  "createOwnerIfNotExists": false,
  "createOwnerOnOriginatorLevel": false
}
```

**系统状态**

- 不存在名为「Non-existent Customer」的客户。
- 发起者设备属于租户。

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

由于目标客户不存在且 `createOwnerIfNotExists` 为 false，处理失败并返回错误。
