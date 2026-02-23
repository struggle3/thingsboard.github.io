从客户中取消分配消息发起者。

## 配置

- **Unassign from specific customer if originator is dashboard（发起者为仪表板时从特定客户取消分配）** - 启用时，允许指定从哪个客户取消分配仪表板。
- **Customer title（客户标题）** - 要从中取消分配仪表板的客户的名称。支持使用 `${metadataKey}` 或 `$[dataKey]` 模板化，以替换消息元数据或数据中的值。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbUnassignFromCustomerNodeConfiguration",
  "type": "object",
  "properties": {
    "customerNamePattern": {
      "type": "string",
      "description": "Target customer name for dashboard unassignment, supports templatization"
    }
  },
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

处理算法因发起者实体类型而异：

**对于 `DASHBOARD`：**

1. 检查是否指定 **Customer title**：若未提供客户标题，处理失败并报错。
2. 使用消息数据和元数据中的值解析 **Customer title** 中的模板。
3. 在租户内搜索具有解析后标题的客户。
4. 若客户不存在，处理失败。
5. 从指定客户取消分配仪表板。

**对于其他发起者类型：**

1. 从实体当前所属的任意客户中取消分配。
2. 若实体未分配给任何客户，处理视为成功。

成功完成后，消息转发至 `Success` 连接。发生错误时，消息路由至 `Failure` 连接。

## 输出连接

- `Success`
    - 实体已成功从客户中取消分配，或实体未分配给任何客户。
- `Failure`
    - 处理过程中发生意外错误。

## 示例

### 示例 1 — 从客户取消分配设备

**传入消息**

发起者：`DEVICE`。

**节点配置**

```json
{
  "customerNamePattern": ""
}
```

**系统状态**

- 租户下存在名为「My Customer」的客户。
- 发起者设备分配给「My Customer」。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

设备从「My Customer」中取消分配，成为租户级别实体。

### 示例 2 — 从特定客户取消分配仪表板

**传入消息**

发起者：`DASHBOARD`。

**节点配置**

```json
{
  "customerNamePattern": "Target Customer"
}
```

**系统状态**

- 租户下存在「Target Customer」和「Other Customer」。
- 发起者仪表板分配给这两个客户。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

仪表板从「Target Customer」中取消分配，但仍分配给「Other Customer」。

### 示例 3 — 为仪表板客户标题使用模式

**传入消息**

数据：

```json
{
  "customerName": "Premium"
}
```

元数据：

```json
{
  "region": "North"
}
```

发起者：`DASHBOARD`。

**节点配置**

```json
{
  "customerNamePattern": "$[customerName] ${region}"
}
```

**系统状态**

- 租户下存在名为「Premium North」的客户。
- 发起者仪表板分配给「Premium North」。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

模式 `$[customerName] ${region}` 通过用数据和元数据中的值替换得到解析，结果为「Premium North」。仪表板从此客户中取消分配。

### 示例 4 — 实体未分配给任何客户

**传入消息**

发起者：`ASSET`。

**节点配置**

```json
{
  "customerNamePattern": ""
}
```

**系统状态**

- 发起者资产未分配给任何客户（租户级别实体）。

**传出消息**

传出消息与传入消息相同。经 `Success` 连接路由。

**结果**

由于资产未分配给任何客户，不执行取消分配操作，但处理视为成功。

### 示例 5 — 仪表板与不存在的客户

**传入消息**

发起者：`DASHBOARD`。

**节点配置**

```json
{
  "customerNamePattern": "Non-existent Customer"
}
```

**系统状态**

- 不存在名为「Non-existent Customer」的客户。
- 发起者仪表板分配给其他客户。

**传出消息**

传出消息与传入消息相同。经 `Failure` 连接路由。

**结果**

由于指定的客户「Non-existent Customer」不存在，处理失败并报错。
