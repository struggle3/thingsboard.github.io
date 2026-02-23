将入站消息复制到按名称和类型动态解析的实体组内的每个实体。

## 配置

节点按名称查找目标实体组。查找逻辑取决于配置。

- **Type** — 组内实体的实体类型（如 *Device*、*Asset*）。
- **Entity group name** — 要查找的组名称。该字段支持模板，可从消息 data 或 metadata 动态提取名称（如 `${groupName}`）。
- **Search entity group on Tenant level only** — 启用后，仅在租户直接拥有的组中查找。
- **Consider originator as a group owner** — 启用后，从消息来源实体的层级开始查找组（若来源实体为 Tenant 或 Customer）。禁用时，从来源实体直接拥有者的层级开始查找。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDuplicateMsgToGroupByNameNodeConfiguration",
  "type": "object",
  "properties": {
    "groupType": {
      "type": "string",
      "enum": [
        "DEVICE",
        "ASSET",
        "ENTITY_VIEW",
        "CUSTOMER",
        "USER",
        "DASHBOARD",
        "EDGE"
      ],
      "description": "The type of entities in the target group."
    },
    "groupName": {
      "type": "string",
      "description": "The name of the entity group. Supports templates."
    },
    "searchEntityGroupForTenantOnly": {
      "type": "boolean",
      "description": "If true, the search is restricted to the Tenant level only."
    },
    "considerMessageOriginatorAsAGroupOwner": {
      "type": "boolean",
      "description": "If true and originator is Tenant or Customer, search starts from originator's level."
    }
  },
  "required": [
    "groupType",
    "groupName",
    "searchEntityGroupForTenantOnly",
    "considerMessageOriginatorAsAGroupOwner"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点通过处理入站消息 data 和 metadata 上的配置模式来解析**组名称**。
2. 根据配置标志和消息来源实体确定组查找的起点。
    - 若**Search entity group on Tenant level only**已启用，仅在 Tenant 下查找组。
    - 若**Consider originator as a group owner**已启用（且来源实体为 Tenant 或 Customer），从来源实体本身开始查找。
    - 否则，从消息来源实体的直接拥有者（如拥有设备的 Customer）层级开始查找。
3. 节点查找与解析出的名称和配置类型匹配的实体组。若在起点层级未找到组，沿拥有层级向上查找（如从 Customer 到 Tenant）。
4. 若在层级中任何地方都未找到匹配组，处理失败。
5. 找到组后，节点获取其所有成员实体列表。
6. 对组内**每个实体**创建一条新消息。该新消息为原始消息的副本，但将来源实体设为组中的当前实体。
7. 所有新消息经 `Success` 链发送。所有副本成功入队后确认原始消息。
8. 若找到目标实体组但为空，处理失败，原始消息经 `Failure` 链路由。

## 输出连接

- `Success`：
    - 新消息（组内每个实体一条）经此链发送。
- `Failure`：
    - 未找到与名称和类型匹配的实体组时。
    - 找到的实体组为空时。
    - 发生其他意外错误时。

## 示例

### 示例 1 — 从来源实体的拥有者开始查找

**入站消息**

Originator: `Device A`

Data: `{"command": "update_firmware"}`

**节点配置**

```json
{
  "groupType": "DEVICE",
  "groupName": "Factory A Devices",
  "searchEntityGroupForTenantOnly": false,
  "considerMessageOriginatorAsAGroupOwner": false
}
```

**系统状态**

- Tenant 拥有 `Customer A`。
- `Customer A` 拥有 `Device A`。
- `Customer A` 还拥有名为 `Factory A Devices` 的设备组，包含 `Device B` 和 `Device C`。

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. **Message 1**：
    - **Originator**：`Device B`
    - **Data**：`{"command": "update_firmware"}`
2. **Message 2**：
    - **Originator**：`Device C`
    - **Data**：`{"command": "update_firmware"}`

**说明**：由于 `considerMessageOriginatorAsAGroupOwner` 为 `false`，查找从 `Device A` 的拥有者 `Customer A` 开始。在 `Customer A` 下找到组 `Factory A Devices`，将消息复制到其成员。

-----

### 示例 2 — 层级查找（拥有者到租户）

**入站消息**

Originator: `Asset X`

Data: `{"status": "maintenance_required"}`

**节点配置**

```json
{
  "groupType": "ASSET",
  "groupName": "All Factory Assets",
  "searchEntityGroupForTenantOnly": false,
  "considerMessageOriginatorAsAGroupOwner": false
}
```

**系统状态**

- Tenant 拥有 `Customer B`。
- `Customer B` 拥有 `Asset X`。
- `Customer B` **未**拥有名为 `All Factory Assets` 的资产组。
- **Tenant** 拥有名为 `All Factory Assets` 的资产组，包含 `Asset Y` 和 `Asset Z`。

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. **Message 1**：
    - **Originator**：`Asset Y`
    - **Data**：`{"status": "maintenance_required"}`
2. **Message 2**：
    - **Originator**：`Asset Z`
    - **Data**：`{"status": "maintenance_required"}`

**说明**：查找从来源实体的拥有者 `Customer B` 开始，但未找到组。随后沿层级自动上移到 Tenant，在 Tenant 找到组并将消息复制到其成员。

-----

### 示例 3 — 仅限 Tenant 层级查找

**入站消息**

Originator: `Device A`

Data: `{"command": "check_status"}`

**节点配置**

```json
{
  "groupType": "DEVICE",
  "groupName": "Building Monitors",
  "searchEntityGroupForTenantOnly": true,
  "considerMessageOriginatorAsAGroupOwner": false
}
```

**系统状态**

- Tenant 拥有 `Customer A`。
- `Customer A` 拥有 `Device A`。
- `Customer A` 拥有名为 `Building Monitors` 的设备组，包含 `Device B`。
- Tenant 也拥有名为 `Building Monitors` 的设备组，包含 `Device C` 和 `Device D`。

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. **Message 1**：
    - **Originator**：`Device C`
    - **Data**：`{"command": "check_status"}`
2. **Message 2**：
    - **Originator**：`Device D`
    - **Data**：`{"command": "check_status"}`

**说明**：由于 `searchEntityGroupForTenantOnly` 为 true，查找仅限于 Tenant 层级。尽管在 `Customer A`（来源实体的拥有者）下存在同名组，也会被忽略。节点找到 Tenant 拥有的组并将消息复制到其成员（`Device C` 和 `Device D`）。
