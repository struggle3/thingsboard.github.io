通过将资产/设备的属性更改复制到关联的实体视图，在实体视图上保存/更新或删除属性（取决于消息类型），
并为每个处理过的实体视图创建新消息，该消息与原始消息完全一致，但发起者更改为实体视图。

## 配置

此节点无配置选项。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "EmptyNodeConfiguration",
  "type": "object",
  "properties": {},
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点验证传入消息为以下支持类型之一：`ATTRIBUTES_UPDATED`、`ATTRIBUTES_DELETED`、`ACTIVITY_EVENT`、`INACTIVITY_EVENT` 或 `POST_ATTRIBUTES_REQUEST`。
2. 验证消息元数据非空。
3. 若消息元数据为空或消息类型不支持，消息路由至 `Failure` 连接。
4. 节点根据消息类型确定 **属性作用域**：
    - 对于 `POST_ATTRIBUTES_REQUEST`：使用 `CLIENT_SCOPE`
    - 对于其他消息类型：使用 `scope` 键从消息元数据中提取作用域
5. 节点获取与消息发起者关联的所有 **实体视图**。
6. 对每个找到的实体视图：
    - 检查当前系统时间是否在实体视图的开始和结束时间范围内。若此检查失败，跳过该实体视图且不进行处理。
    - 根据实体视图的属性 key 配置确定应复制的属性
    - **按消息类型处理**：
        - 对于 `ATTRIBUTES_DELETED` 消息：从实体视图中删除指定属性（仅实体视图中配置的属性）
        - 对于其他消息类型：在实体视图上保存/更新属性（仅实体视图中配置的属性）
    - **创建新消息**：创建与原始消息完全一致的新消息，但将发起者更改为实体视图 ID 而非原始资产/设备 ID
    - **消息转发**：新创建的消息转发至 `Success` 连接
7. **原始消息处理**：原始消息被确认，不再继续沿 Rule Chain 传递

## 输出连接

- `Success`
    - 属性已成功复制到实体视图，且消息发起者已更改为实体视图
    - 若发起者有关联的多个实体视图，可能产生多条消息
- `Failure`
    - 消息元数据为空
    - 不支持的消息类型
    - 发生其他意外错误

## 示例

### 示例 1 — 将属性复制到实体视图

**传入消息**

类型：`POST_ATTRIBUTES_REQUEST`

数据：

```json
{
  "key1": "value1",
  "key2": "value2",
  "key3": "value3"
}
```

发起者：名为 `device` 的 `DEVICE`。

**系统状态**

- 设备 `device` 有关联的实体视图 `deviceView`
- 实体视图配置为复制以下客户端属性：`["key1", "key2"]`
- 当前时间在实体视图的时间范围内

**传出消息**

类型：`POST_ATTRIBUTES_REQUEST`

数据：

```json
{
  "key1": "value1",
  "key2": "value2",
  "key3": "value3"
}
```

发起者：名为 `deviceView` 的 `ENTITY_VIEW`

经 `Success` 连接路由。

**结果**

仅 `key1` 和 `key2` 属性复制到实体视图（按实体视图配置）。`key3` 属性未复制，因其不在实体视图的属性过滤器中。消息发起者从设备更改为实体视图。

原始传入消息已确认。

### 示例 2 — 多个实体视图

**传入消息**

类型：`ATTRIBUTES_UPDATED`

数据：

```json
{
  "key1": "value1",
  "key2": "value2"
}
```

元数据：

```json
{
  "scope": "SERVER_SCOPE"
}
```

发起者：名为 `device` 的 `DEVICE`

**系统状态**

- 设备 `device` 有两个关联的实体视图：`deviceView1` 和 `deviceView2`
- `deviceView1` 配置为复制以下服务端属性 `["key1"]`
- `deviceView2` 配置为复制以下服务端属性 `["key2"]`
- 当前系统时间在两个实体视图的时间范围内

**传出消息**

产生两条消息，每条都是传入消息的精确副本，仅发起者不同：

消息 1：

- 发起者：名为 `deviceView1` 的 `ENTITY_VIEW`
- 经 `Success` 连接路由

消息 2：

- 发起者：名为 `deviceView2` 的 `ENTITY_VIEW`
- 经 `Success` 连接路由

**结果**

`key1` 属性复制到 `deviceView1`，`key2` 属性复制到 `deviceView2`。生成两条独立消息，发起者分别为不同实体视图。

原始传入消息已确认。

### 示例 3 — 从实体视图删除属性

**传入消息**

类型：`ATTRIBUTES_DELETED`

数据：

```json
{
  "attributes": [
    "key1",
    "key2",
    "key3"
  ]
}
```

元数据：

```json
{
  "scope": "SERVER_SCOPE"
}
```

发起者：名为 `device` 的 `DEVICE`

**系统状态**

- 设备 `device` 有关联的实体视图 `deviceView`
- 实体视图配置为复制以下服务端属性：`["key1", "key2"]`
- 当前时间在实体视图的时间范围内

**传出消息**

传出消息与传入消息相同，但发起者更改为名为 `deviceView` 的 `ENTITY_VIEW`。
经 `Success` 连接路由。

**结果**

仅从实体视图中删除 `key1` 和 `key2` 属性。`key3` 的删除被忽略，因其不在实体视图的属性过滤器中。

### 示例 4 — 实体视图超出时间范围

**传入消息**

类型：`ATTRIBUTES_UPDATED`

数据：

```json
{
  "key": "value"
}
```

发起者：名为 `device` 的 `DEVICE`

**系统状态**

- 设备 `device` 有关联的实体视图 `deviceView`
- 实体视图配置为复制以下服务端属性：`["key"]`
- 实体视图时间范围：结束时间在 1 小时前（已过期）

**传出消息**

不产生传出消息。

**结果**

由于实体视图超出其有效时间范围，未复制任何属性。原始消息已确认，但不生成新消息。

### 示例 5 — 不支持的消息类型

**传入消息**

类型：`POST_TELEMETRY_REQUEST`

**传出消息**

消息路由至 `Failure` 连接。

**结果**

由于 `POST_TELEMETRY_REQUEST` 不是此 Rule 节点支持的消息类型，处理失败。

### 示例 6 — 空元数据

**传入消息**

类型：`ATTRIBUTES_UPDATED`

元数据：`{}`（空）

**传出消息**

消息路由至 `Failure` 连接。

**结果**

由于消息元数据为空（需要用于确定属性作用域），处理失败。
