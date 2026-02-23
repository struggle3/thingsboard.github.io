查找与消息来源实体相关的设备，获取其属性和/或最新遥测，并将结果添加到消息 data 或 metadata。

## 配置

配置窗口分为两大部分：**Device relations query** 和 **Related device attributes**。

### Device relations query

该部分定义从消息来源实体开始查找相关设备的条件。

- **Direction**：要搜索的关系方向。
    - **From originator**：搜索消息来源实体为源的关系。
    - **To originator**：搜索消息来源实体为目标的关系。
- **Max relation level**：关系搜索的最大深度（如 `1` 表示直接相关的设备）。
- **Fetch last level relation only**：开关，仅处理在最后一层关系找到的实体。
- **Relation type**：要查找的关系类型（如 `Contains`、`Manages`）。
- **Device profiles**：用于过滤的设备配置集合。仅考虑匹配其中任一配置的设备。

### Related device attributes

该部分指定从查询找到的相关设备获取哪些数据。所有输入字段均支持使用消息或 metadata 中的值的模板。

- **Client attributes**：要获取的客户端属性键集合。
- **Shared attributes**：要获取的共享属性键集合。
- **Server attributes**：要获取的服务端属性键集合。
- **Latest telemetry**：要获取的最新遥测键集合。
- **Fetch latest telemetry with timestamp**：若启用，获取的遥测值将为包含值和其时间戳的 JSON 对象（如 `{"ts":1672531200000, "value":42}`）。否则仅获取值。
- **Add selected attributes to**：确定添加获取数据的位置。
    - *Message*：将键值对添加到消息 data（负载）。消息 data 必须为 JSON 对象。
    - *Metadata*：将键值对添加到消息 metadata。
- **Tell failure if any of the attributes are missing**：若启用，当相关设备上找不到任一指定的属性或遥测键时，消息将经 `Failure` 链路由。若禁用，缺失的键被忽略。

## 消息处理逻辑

1. 节点识别入站消息的来源实体。
2. 执行**Device relations query**查找相关设备。
3. 若未找到相关设备，消息经 `Failure` 连接路由。
4. 若找到多个相关设备，节点仅使用查询返回的**第一个**继续处理。
5. 从找到的设备异步获取指定的属性和遥测。
6. 若**Tell failure if any of the attributes are missing**已启用，且相关设备上不存在任一请求的键，消息经 `Failure` 连接路由并附带说明缺失键的错误信息。
7. 处理获取的数据：
    * **属性前缀**：获取的属性的键会自动添加前缀以表示其范围：
        * 客户端属性：`cs_`（如 `cs_attributeKey`）
        * 共享属性：`shared_`（如 `shared_attributeKey`）
        * 服务端属性：`ss_`（如 `ss_attributeKey`）
    * **遥测**：最新遥测的键**不**添加前缀。
8. 根据**Add selected attributes to**设置，将新键值对添加到消息 data 或 metadata。
9. 丰富后的消息经 `Success` 连接发送。

## 输出连接

- `Success`：
    - 消息已成功使用相关设备的数据丰富。
- `Failure`：
    - 使用指定查询未找到相关设备。
    - **Tell failure if any of the attributes are missing**已启用，且至少一个指定的属性或遥测键未找到。
    - 处理过程中发生意外错误。

## 示例

### 示例 1：使用相关设备的服务端属性丰富 metadata

本示例演示如何将相关设备的服务端属性添加到消息 metadata。

**场景**：「Gateway」设备发送状态消息。希望添加父「HVAC Controller」设备的 `buildingId`（存储在控制器上的服务端属性）。

**入站消息**

Metadata:

```json
{
  "deviceName": "Main Gateway",
  "deviceType": "gateway"
}
```

Originator: 名为 "Main Gateway" 的设备

**节点配置**

```json
{
  "deviceRelationsQuery": {
    "fetchLastLevelOnly": false,
    "direction": "TO",
    "maxLevel": "1",
    "relationType": "Manages",
    "deviceTypes": [
      "hvac-controller"
    ]
  },
  "tellFailureIfAbsent": true,
  "fetchTo": "METADATA",
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "serverAttributeNames": [
    "buildingId"
  ],
  "latestTsKeyNames": [],
  "getLatestValueWithTs": false
}
```

**系统状态**：

* 名为 "HVAC-Controller-01" 的设备（配置为 `hvac-controller`）具有值为 `BLD-123` 的服务端属性 `buildingId`。
* 存在**从** "HVAC-Controller-01" **到** "Main Gateway" 的 `Manages` 关系。

**出站消息**

出站消息与入站消息相同，但其 metadata 已丰富。经 `Success` 连接发送。

Metadata:

```json
{
  "deviceName": "Main Gateway",
  "deviceType": "gateway",
  "ss_buildingId": "BLD-123"
}
```

**说明**：节点搜索**到** "Main Gateway" 的关系，找到 "HVAC-Controller-01" 设备。随后获取 `buildingId` 服务端属性，并以带前缀的键 `ss_buildingId` 将其值添加到消息 metadata。

### 示例 2：使用遥测丰富消息 data

**场景**：「Pump Controller」设备发送命令确认。需用其包含的「Pressure Sensor」设备的最新 `pressure` 读数丰富此消息。

**入站消息**

Data:

```json
{
  "command": "START",
  "status": "CONFIRMED"
}
```

Originator: 名为 "Pump-Controller-A" 的设备

**节点配置**

- **Device relations query**：
    - Direction: `From originator`
    - Max relation level: `1`
    - Relation type: `Contains`
    - Device profiles: `pressure-sensor`
- **Related device attributes**：
    - Latest telemetry: `pressure`
    - Fetch latest telemetry with timestamp: `Enabled`
    - Add selected attributes to: `Message`

```json
{
  "deviceRelationsQuery": {
    "fetchLastLevelOnly": false,
    "direction": "FROM",
    "maxLevel": "1",
    "relationType": "Contains",
    "deviceTypes": [
      "pressure-sensor"
    ]
  },
  "tellFailureIfAbsent": true,
  "fetchTo": "METADATA",
  "clientAttributeNames": [],
  "sharedAttributeNames": [],
  "serverAttributeNames": [],
  "latestTsKeyNames": [
    "pressure"
  ],
  "getLatestValueWithTs": true
}
```

**系统状态**：

* 名为 "Pressure-Sensor-X1" 的设备（配置为 `pressure-sensor`）在时间戳 `1725282600000` 具有 `pressure` 的最新遥测值 `120.5`。
* 存在**从** "Pump-Controller-A" 到 "Pressure-Sensor-X1" 的 `Contains` 关系。

**出站消息**

出站消息 data 已使用遥测读数丰富。

Data:

```json
{
  "command": "START",
  "status": "CONFIRMED",
  "pressure": {
    "ts": 1725282600000,
    "value": 120.5
  }
}
```

**说明**：节点搜索**从** "Pump-Controller-A" 发出的关系，找到 "Pressure-Sensor-X1"。获取其最新带时间戳的 `pressure` 遥测，并将 resulting JSON 对象以键 `pressure` 添加到消息 data。
