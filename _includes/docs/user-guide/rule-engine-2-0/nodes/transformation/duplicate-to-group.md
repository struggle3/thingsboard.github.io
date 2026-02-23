将入站消息复制到指定实体组内的每个实体。对每个实体，创建一条以该实体为新来源实体的新消息。

## 前置条件

若节点配置了**Entity group is message originator**（实体组即消息来源）并启用，入站消息**必须**来自类型为 `ENTITY_GROUP` 的实体。若来源实体为其他类型（如 `DEVICE` 或 `ASSET`），消息将经 `Failure` 链路由。

## 配置

节点有两种配置模式。

### 模式 1：指定实体组

默认模式，手动选择目标实体组。

- **Entity group is message originator** — 禁用（开关关闭）。
- **Owner** — 实体组的拥有者（如指定 Customer 或 Tenant）。
- **Type** — 组内实体的实体类型（如 *Device*、*Asset*）。
- **Select entity group** — 要复制消息到的具体实体组。

### 模式 2：来源实体即实体组

在此模式下，目标实体组由入站消息来源实体动态确定。

- **Entity group is message originator** — 启用（开关打开）。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbDuplicateMsgToGroupNodeConfiguration",
  "type": "object",
  "properties": {
    "entityGroupIsMessageOriginator": {
      "type": "boolean",
      "description": "If true, the message originator is expected to be the entity group. If false, a specific 'entityGroupId' must be provided."
    },
    "entityGroupId": {
      "type": "object",
      "description": "Object containing entity type and UUID of the target entity group. Required when 'entityGroupIsMessageOriginator' is false.",
      "properties": {
        "entityType": {
          "const": "ENTITY_GROUP"
        },
        "id": {
          "type": "string",
          "format": "uuid",
          "description": "The UUID of the target entity group."
        }
      },
      "additionalProperties": false
    }
  },
  "required": [
    "entityGroupIsMessageOriginator"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点根据配置确定目标**实体组**：
    - 若选择具体组，使用该组。
    - 若**Entity group is message originator**已启用，检查入站消息来源实体是否为 `ENTITY_GROUP`。若不是，处理失败。若是，则将该来源实体作为目标组。
2. 节点获取目标实体组所有成员实体列表。
3. 对组内**每个实体**创建一条新消息。该新消息为原始消息的副本，但其来源实体设为组中的当前实体。
4. 所有新消息经 `Success` 链发送。所有副本成功入队后确认原始消息。
5. 若目标实体组为空或不存在，原始消息经 `Failure` 链路由。

## 输出连接

- `Success`：
    - 新消息（组内每个实体一条）经此链发送。
- `Failure`：
    - 目标实体组为空时。
    - **Entity group is message originator** 已启用，但实际消息来源实体不是实体组时。
    - 发生其他意外错误时。

## 示例

### 示例 1 — 复制到指定设备组

**入站消息**

Data: `{"targetTemperature": 100}`

**节点配置**

{% capture status_property_note %}
**注意：** `entityGroupId` 中的 UUID 为 `Thermostats Floor 1` 组的占位符。
{% endcapture %}
{% include templates/info-banner.md content=status_property_note %}

```json
{
  "entityGroupIsMessageOriginator": false,
  "entityGroupId": {
    "entityType": "ENTITY_GROUP",
    "id": "a1b2c3d4-e5f6-7890-1234-567890abcdef"
  }
}
```

**系统状态**

名为 `Thermostats Floor 1` 的设备组存在，ID 为 `a1b2c3d4-e5f6-7890-1234-567890abcdef`，包含 `Thermostat A` 和 `Thermostat B`。

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. **Message 1**：
    - **Originator**：`Thermostat A`
    - **Data**：`{"targetTemperature": 100}`
2. **Message 2**：
    - **Originator**：`Thermostat B`
    - **Data**：`{"targetTemperature": 100}`

**说明**：原始消息复制到 `Thermostats Floor 1` 实体组的所有成员（`Thermostat A`、`Thermostat B`）。

---

### 示例 2 — 入站消息的来源实体为实体组

**入站消息**

Originator: 名为 `All sensors` 的实体组

Data: `{"command": "reboot"}`

**节点配置**

```json
{
  "entityGroupIsMessageOriginator": true
}
```

**系统状态**

名为 `All sensors` 的实体组存在，包含 `Sensor A` 和 `Sensor B`。

**出站消息**

经 `Success` 链创建并发送两条新消息：

1. **Message 1**：
    - Originator: `Sensor X`
    - Data: `{"command": "reboot"}`
2. **Message 2**：
    - Originator: `Sensor Y`
    - Data: `{"command": "reboot"}`

**说明**：入站消息的来源实体为实体组本身。节点将消息复制到该组所有成员。
