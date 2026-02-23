查找与消息来源实体相关的实体，获取其数据（属性、最新遥测或实体字段），并将结果添加到消息 data 或 metadata。

## 配置

配置窗口允许定义如何查找相关实体以及要获取哪些数据。

- **Relations query** — 定义从消息来源实体开始搜索相关实体的条件。
    - **Direction** — 要搜索的关系方向。
        - *From originator*：搜索来源实体为源的关系。
        - *To originator*：搜索来源实体为目标的关系。
    - **Max relation level** — 关系搜索的最大深度。
    - **Relation filters** — 要应用的过滤器集合。每个过滤器指定：
        - **Relation type**：关系类型（如 `Contains`、`Manages`）。
        - **Entity types**：要查找的实体类型集合（如 `DEVICE`、`ASSET`）。若为空，考虑任意类型的实体。
- **Data to fetch** — 指定从找到的实体获取的数据类型。
    - *Attributes*：获取服务端属性。
    - *Latest Telemetry*：获取最新时序值。
    - *Fields*：从实体对象本身获取字段（如 `Name`、`Profile name`、`Label`、`Created time`）。
- **Attributes/Latest telemetry/Fields mapping** — 定义要获取哪些数据以及如何命名的键值对集合。
    - **Source attribute key/telemetry key/field** 是相关实体上的属性、时序键或实体字段名。
    - **Target key** 是将添加到消息的新键名。
    - 源键和目标键均可使用 `${metadata.key}` 等模板。
- **Add mapped attributes/latest telemetry/fields to** — 确定获取数据的目标位置。
    - *Message*：将获取的键值对添加到消息 data。消息 data 必须为 JSON 对象。
    - *Metadata*：将获取的键值对添加到消息 metadata。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGetRelatedDataNodeConfiguration",
  "type": "object",
  "properties": {
    "relationsQuery": {
      "type": "object",
      "description": "Configuration for finding a related entity."
    },
    "dataToFetch": {
      "type": "string",
      "enum": [
        "ATTRIBUTES",
        "LATEST_TELEMETRY",
        "FIELDS"
      ],
      "description": "The type of data to fetch from the related entity."
    },
    "dataMapping": {
      "type": "object",
      "additionalProperties": {
        "type": "string"
      },
      "description": "Mapping of source keys on the related entity to target keys in the message."
    },
    "fetchTo": {
      "type": "string",
      "enum": [
        "DATA",
        "METADATA"
      ],
      "description": "Destination for the fetched data."
    }
  },
  "required": [
    "relationsQuery",
    "dataToFetch",
    "dataMapping",
    "fetchTo"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别入站消息的来源实体（如具体 Device 或 Asset）。
2. 执行配置中的**Relations Query**查找相关实体。
3. 若未找到相关实体，消息经 `Failure` 连接路由并附带错误。
4. 若找到多个相关实体，节点仅使用查询返回的**第一个**继续处理。
5. 根据**Data to fetch**设置，节点使用 **Data mapping** 中的源键从找到的实体异步请求指定数据。若相关实体上不存在请求的键，则静默忽略。
6. 节点处理 **Data mapping** 规则，将获取的值映射到对应目标键。使用消息 data 和 metadata 解析键中使用的任何模板。
7. 根据**Add mapped attributes/latest telemetry/fields to**设置，将新键值对添加到消息 data 或 metadata。
8. 丰富后的消息经 `Success` 连接发送。

## 输出连接

- `Success`：
    - 消息已成功使用相关实体的数据丰富。
- `Failure`：
    - 使用指定查询未找到相关实体。
    - 处理过程中发生意外错误。

## 示例

### 示例 1 — 使用相关资产的属性丰富 metadata

本示例演示如何从相关资产获取属性并添加到消息 metadata。

**场景**：某建筑中的设备发送温度读数。希望将父「Building」资产上以属性存储的建筑位置添加到消息 metadata。

**入站消息**

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat"
}
```

Originator: 名为 "Thermostat-A7" 的设备

**节点配置**

```json
{
  "relationsQuery": {
    "direction": "TO",
    "maxLevel": 1,
    "filters": [
      {
        "relationType": "Contains",
        "entityTypes": [
          "ASSET"
        ]
      }
    ]
  },
  "fetchTo": "METADATA",
  "dataToFetch": "ATTRIBUTES",
  "dataMapping": {
    "location": "buildingLocation"
  }
}
```

**系统状态**：

* 名为 "Building-1" 的资产具有值为 `{"city": "Kyiv"}` 的服务端属性 `location`。
* 存在从 "Building-1"**到** "Thermostat-A7" 的 `Contains` 关系。

**出站消息**

出站消息与入站消息相同，但其 metadata 已丰富。经 `Success` 连接发送。

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat",
  "buildingLocation": "{\"city\": \"Kyiv\"}"
}
```

**说明**：节点搜索方向为 `TO`、从设备（"Thermostat-A7"）发出的关系。通过 `Contains` 关系找到 "Building-1" 资产。随后获取 `location` 属性，并以新键 `buildingLocation` 将其值添加到消息 metadata。

### 示例 2 — 使用相关设备的遥测丰富 data

**场景**：「Gateway」设备发送健康检查消息。需用其管理的「Sensor」设备的最新 `batteryLevel` 遥测丰富此消息。

**入站消息**

Data:

```json
{
  "status": "OK",
  "uptime": 7200
}
```

Originator: 名为 "Main-Gateway" 的设备

**节点配置**

```json
{
  "relationsQuery": {
    "direction": "FROM",
    "maxLevel": 1,
    "filters": [
      {
        "relationType": "Manages",
        "entityTypes": [
          "DEVICE"
        ]
      }
    ]
  },
  "fetchTo": "DATA",
  "dataToFetch": "LATEST_TELEMETRY",
  "dataMapping": {
    "batteryLevel": "sensor_battery"
  }
}
```

**系统状态**：

* 名为 "Battery-Sensor-1" 的设备具有最新遥测值 `batteryLevel` 为 `87`。
* 存在**从** "Main-Gateway" 到 "Battery-Sensor-1" 的 `Manages` 关系。

**出站消息**

Data:

```json
{
  "status": "OK",
  "uptime": 7200,
  "sensor_battery": 87
}
```

**说明**：节点搜索**从** "Main-Gateway" 开始、类型为 `Manages` 的关系。找到 "Battery-Sensor-1"，获取其最新 `batteryLevel` 遥测，并以键 `sensor_battery` 添加到消息 data。
