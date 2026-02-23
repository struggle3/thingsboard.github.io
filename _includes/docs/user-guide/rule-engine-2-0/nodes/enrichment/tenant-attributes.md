从消息来源实体的**租户**获取服务端属性或最新时序数据，并添加到消息 data 或 metadata。

## 配置

配置允许指定从租户获取哪些数据以及如何映射到出站消息中的新键。

- **Mapping of tenant's** — 指定从租户获取的数据类型。
    - *Attributes*：从租户获取服务端属性。
    - *Latest telemetry*：从租户获取时序键的最新值。
- **Attributes/Latest telemetry mapping** — 键值对列表，定义如何获取数据并添加到消息。
    - **Source attribute/telemetry key**：租户实体上的属性或遥测键名。
    - **Target key**：在消息 data 或 metadata 中存储获取值的键。
    - **Source attribute/telemetry key** 和 **Target key** 均支持使用 `${metadataKey}` 或 `$[dataKey]` 从消息 metadata 或 data 替换值的模板。
- **Add mapped attributes/latest telemetry to** — 确定获取数据的目标位置。
    - *Message*：将获取的键值对添加到消息 data。若原始消息 data 不是有效 JSON 对象，处理将失败。
    - *Metadata*：将获取的键值对添加到消息 metadata。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGetTenantAttributeNodeConfiguration",
  "type": "object",
  "properties": {
    "dataToFetch": {
      "type": "string",
      "enum": [
        "ATTRIBUTES",
        "LATEST_TELEMETRY"
      ],
      "description": "Specifies the type of data to fetch from the tenant (server-side attributes or latest time series)."
    },
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
      "description": "A map where keys are the source attribute/telemetry keys on the tenant and values are the target keys in the message."
    }
  },
  "required": [
    "dataToFetch",
    "fetchTo",
    "dataMapping"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别与入站消息来源实体关联的**租户**。
2. 使用消息 data 和 metadata 解析 **Source attribute/telemetry key** 和 **Target key** 字段中的模板。
3. 根据配置，异步向租户实体请求指定的服务端属性或最新时序值。
4. 若请求的键在租户上不存在，则忽略。消息处理继续使用成功找到的数据。
5. 根据**Add mapped attributes/latest telemetry to**设置，将获取的键值对添加到消息 data 或 metadata。
6. 丰富后的消息转发至 `Success` 连接。若发生错误（如尝试向非 JSON 消息 data 添加数据），消息经 `Failure` 连接路由。

## 输出连接

- `Success`：
    - 消息已成功使用租户的请求数据丰富。
- `Failure`：
    - 处理过程中发生错误，例如 **Add mapped attributes/latest telemetry to** 设为 *Message* 但消息 data 不是有效 JSON 对象时。

## 示例

### 示例 1 — 丰富 metadata

**入站消息**：

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat"
}
```

**节点配置**：

```json
{
  "dataToFetch": "ATTRIBUTES",
  "fetchTo": "METADATA",
  "dataMapping": {
    "exampleSourceKey": "exampleTargetKey"
  }
}
```

**出站消息**：

出站消息经 `Success` 连接发送，metadata 已丰富。

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat",
  "exampleTargetKey": "exampleValue"
}
```

### 示例 2 — 丰富 data

**入站消息**：

Data:

```json
{}
```

Metadata:

```json
{
  "deviceName": "Boiler-B2",
  "deviceType": "boiler"
}
```

**节点配置**：

```json
{
  "dataToFetch": "ATTRIBUTES",
  "fetchTo": "DATA",
  "dataMapping": {
    "${deviceType}SourceKey": "exampleTargetKey"
  }
}
```

**出站消息**：

出站消息经 `Success` 连接发送，data 已丰富。

Data:
```json
{
  "exampleTargetKey": "exampleValue"
}
```
