从消息来源实体获取属性和/或最新时序数据，并将结果添加到消息 data 或 metadata。

## 配置

节点配置允许指定从不同数据源获取哪些键以及将结果放置的位置。

- **Client attributes** — 要获取的客户端属性键列表。获取的键将添加前缀 `cs_`。
- **Shared attributes** — 要获取的共享属性键列表。获取的键将添加前缀 `shared_`。
- **Server attributes** — 要获取的服务端属性键列表。获取的键将添加前缀 `ss_`。
- **Latest telemetry** — 要获取最新值的时序键列表。这些键不添加前缀。
    - **Fetch latest telemetry with timestamp** — 若勾选，最新遥测值以包含值和其时间戳的 JSON 对象返回（如 `{"ts":1672531200000, "value": "42"}`）。若不勾选，仅返回原始值。
- **Add originator attributes to** — 确定获取数据的目标位置。
    - *Message*：将获取的键值对添加到消息 data。消息 data 必须为 JSON 对象。
    - *Metadata*：将获取的键值对添加到消息 metadata。
- **Tell failure if attribute or telemetry are missing** — 若勾选，当来源实体上不存在任一指定键时，消息经 `Failure` 连接路由。若不勾选，缺失的键被忽略，消息携带已找到的数据经 `Success` 连接继续。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGetAttributesNodeConfiguration",
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
    "clientAttributeNames": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Set of client-side attribute keys to fetch."
    },
    "sharedAttributeNames": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Set of shared attribute keys to fetch."
    },
    "serverAttributeNames": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Set of server-side attribute keys to fetch."
    },
    "latestTsKeyNames": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Set of time series keys for which to fetch the latest values."
    },
    "getLatestValueWithTs": {
      "type": "boolean",
      "description": "If true, fetches telemetry with its timestamp as a JSON object."
    },
    "tellFailureIfAbsent": {
      "type": "boolean",
      "description": "If true, routes the message to 'Failure' if any key is not found."
    }
  },
  "required": [
    "fetchTo"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别入站消息的来源实体（如具体 Device 或 Asset）。
2. 异步向该来源实体请求配置中指定的属性和最新遥测值。
3. 节点检查是否找到所有请求的键。若**Tell failure if attribute or telemetry are missing**已启用且任一键缺失，原始消息经 `Failure` 连接路由，并附带说明缺失键的错误信息。
4. 对每个成功获取的属性，为其键添加前缀：
    * 客户端属性：`cs_`
    * 共享属性：`shared_`
    * 服务端属性：`ss_`
    * 时序键**不**添加前缀。
5. 根据**Add originator attributes to**设置，节点将新键值对添加到消息 data 或 metadata。
6. 丰富后的消息经 `Success` 连接发送。

## 输出连接

- `Success`：
    - 消息已成功使用请求数据丰富。
- `Failure`：
    - 数据获取过程中发生错误。
    - 请求的键未找到，且**Tell failure if attribute or telemetry are missing**已启用。

## 示例

### 示例 1 — 使用属性丰富 metadata

本示例演示如何获取服务端属性并将其添加到消息 metadata，供后续过滤节点使用。

**场景**：设备发送温度读数。需要用存储在设备上的 `tempThreshold` 属性丰富消息，以便后续「script」节点可检查温度是否超过该阈值。

**入站消息**

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat"
}
```

**节点配置**

```json
{
  "fetchTo": "METADATA",
  "serverAttributeNames": [
    "tempThreshold"
  ],
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "latestTsKeyNames": [],
  "tellFailureIfAbsent": true,
  "getLatestValueWithTs": false
}
```

**系统状态**

消息来源实体（设备）具有值为 `25` 的服务端属性 `tempThreshold`。

**出站消息**

出站消息与入站消息相同，但其 metadata 已丰富。经 `Success` 连接发送。

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat",
  "ss_tempThreshold": "25"
}
```

**说明**：节点识别消息来源实体，获取其服务端属性 `tempThreshold`，添加 `ss_` 前缀，并将键值对 `ss_tempThreshold: "25"` 添加到消息 metadata。

### 示例 2 — 使用最新时序值丰富 data（无时间戳）

**入站消息**

Data:

```json
{
  "pressure": 1013
}
```

**节点配置**

```json
{
  "fetchTo": "DATA",
  "serverAttributeNames": [],
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "latestTsKeyNames": [
    "temperature",
    "humidity"
  ],
  "tellFailureIfAbsent": false,
  "getLatestValueWithTs": false
}
```

**出站消息**

Data:

```json
{
  "pressure": 1013,
  "temperature": 25.5,
  "humidity": 40.7
}
```

### 示例 3 — 使用最新时序值丰富 metadata（无时间戳）

**入站消息**

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat"
}
```

**节点配置**

```json
{
  "fetchTo": "METADATA",
  "serverAttributeNames": [],
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "latestTsKeyNames": [
    "temperature",
    "humidity"
  ],
  "tellFailureIfAbsent": false,
  "getLatestValueWithTs": false
}
```

**出站消息**

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat",
  "humidity": "40.7",
  "temperature": "32.2"
}
```

### 示例 4 — 使用最新时序值丰富 data（含时间戳）

**入站消息**

Data:

```json
{
  "pressure": 1013
}
```

**节点配置**

```json
{
  "fetchTo": "DATA",
  "serverAttributeNames": [],
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "latestTsKeyNames": [
    "temperature",
    "humidity"
  ],
  "tellFailureIfAbsent": false,
  "getLatestValueWithTs": true
}
```

**出站消息**

Data:

```json
{
  "pressure": 1013,
  "temperature": {
    "ts": 1756479586801,
    "value": 32.2
  },
  "humidity": {
    "ts": 1756479659223,
    "value": 40.7
  }
}
```

### 示例 5 — 使用最新时序值丰富 metadata（含时间戳）

**入站消息**

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat"
}
```

**节点配置**

```json
{
  "fetchTo": "METADATA",
  "serverAttributeNames": [],
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "latestTsKeyNames": [
    "temperature",
    "humidity"
  ],
  "tellFailureIfAbsent": false,
  "getLatestValueWithTs": true
}
```

**出站消息**

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat",
  "humidity": "{\"ts\":1756479659223,\"value\":40.7}",
  "temperature": "{\"ts\":1756479586801,\"value\":32.2}"
}
```
