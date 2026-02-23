将消息来源实体的字段（如名称、类型、标签）添加到消息 data 或 metadata。

## 配置

节点配置允许定义从来源实体字段到消息中新键的映射。

- **来源实体字段映射** — 定义节点核心逻辑。每项将来源实体的源字段映射到输出的目标键。
    - **Source field**：来源实体可用字段的下拉列表（如 *Name*、*Profile name*、*Label*、*Created time*）。
    - **Target key**：将添加到消息 data 或 metadata 的新键。该字段支持模板，可使用消息 data（`$[dataKey]`）或 metadata（`${metadataKey}`）中的值动态创建键。
- **Add mapped originator fields to** — 确定新键值对的放置位置。
    - *Message*：将获取的字段添加到消息 data 负载。消息 data 必须为 JSON 对象。
    - *Metadata*：将获取的字段添加到消息 metadata。
- **Skip empty fields** — 若勾选，来源实体上为空或 null 的源字段将被忽略，不会添加到消息中。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGetOriginatorFieldsNodeConfiguration",
  "type": "object",
  "properties": {
    "fetchTo": {
      "type": "string",
      "enum": [
        "DATA",
        "METADATA"
      ],
      "description": "Destination for the fetched data (message data or metadata)."
    },
    "dataMapping": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "A map where keys are the source field names from the originator and values are the target keys for the message."
    },
    "ignoreNullStrings": {
      "type": "boolean",
      "description": "If true, fields with empty or null values will be skipped."
    }
  },
  "required": [
    "dataMapping",
    "fetchTo"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别入站消息的来源实体（如具体 Device 或 Asset）。
2. 读取**来源实体字段映射**以确定要获取的字段。
3. 对每个映射，使用入站消息的 data 和 metadata 处理 **Target key** 中的模板（如 `${metadataKey}`）。
4. 节点异步从来源实体获取指定**Source field**的值。
5. 若来源实体上不存在源字段，则忽略。若**Skip empty fields**已启用，null 或空值字段也会被忽略。
6. 根据**Add mapped originator fields to**设置，节点将结果键值对（处理后的目标键和获取的字段值）添加到消息 data 或 metadata。
7. 丰富后的消息经 `Success` 连接转发。若发生错误（如尝试向非 JSON 消息体添加字段），原始消息经 `Failure` 连接路由。

## 输出连接

- `Success`：
    - 消息已成功使用来源实体字段丰富。
- `Failure`：
    - 处理过程中发生错误。例如，**Add mapped originator fields to** 设为 `Message` 但消息 data 不是有效 JSON 对象时。

## 示例

### 示例 1 — 将来源实体名称和配置名称添加到 metadata

本示例展示如何用发送消息的设备名称和类型丰富消息。

**场景**：温控器发送温度读数。为后续处理，需要知道该温控器的名称和配置名称，因此将其添加到消息 metadata。

**入站消息**

Metadata:

```json
{
  "ts": "1756479659000"
}
```

Originator: 消息来源为名为 **Thermostat-HVAC-1** 的设备，使用名为 **HVAC Thermostat** 的设备配置。

**节点配置**

```json
{
  "dataMapping": {
    "name": "originatorName",
    "type": "originatorProfileName"
  },
  "fetchTo": "METADATA",
  "ignoreNullStrings": false
}
```

**出站消息**

Metadata:

```json
{
  "ts": "1756479659000",
  "originatorName": "Thermostat-HVAC-1",
  "originatorProfileName": "HVAC Thermostat"
}
```

**说明**：节点从来源设备获取 `Name` 和 `Profile name` 字段，并以新键 `originatorName` 和 `originatorProfileName` 添加到消息 metadata。

### 示例 2 — 将来源实体字段添加到消息 data

本示例展示将来源实体的创建时间添加到消息 data。

**场景**：出于审计目的，需在消息 data 中直接包含发送设备的首次创建时间戳。

**入站消息**

Data:

```json
{
  "humidity": 58.2
}
```

**节点配置**

```json
{
  "dataMapping": {
    "createdTime": "deviceCreatedTime"
  },
  "fetchTo": "DATA",
  "ignoreNullStrings": false
}
```

**出站消息**

消息经 `Success` 连接发送，data 已更新。

Data:

```json
{
  "humidity": 58.2,
  "deviceCreatedTime": "1672531200000"
}
```

**说明**：节点获取来源实体的 `Created Time`（作为 Unix 时间戳字符串），并以键 `deviceCreatedTime` 添加到 JSON 消息 data。
