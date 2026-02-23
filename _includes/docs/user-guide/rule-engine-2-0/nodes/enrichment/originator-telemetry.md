在指定时间范围内获取消息来源实体的时序数据，并将结果添加到消息 metadata。

## 配置

节点配置分为三大部分：选择数据、定义时间窗口、指定获取策略。

- **Time series keys** — 从消息来源实体获取的时序键列表。可使用替换模式从消息 data（`$[dataKey]`）或 metadata（`$[metadataKey]`）获取键。
- **Fetch interval** — 定义时序查询的时间窗口。
    - **Relative time window**（默认）：获取相对于当前时刻的时间范围内的数据。例如，将 **Interval start** 设为 *2 Minutes*、**Interval end** 设为 *1 Minute* 将获取两分钟前到一分钟前的数据。
    - **Use dynamic interval**：启用后，区间起止由消息或 metadata 中的值确定。替换后的值必须为毫秒级 Unix 时间戳。
        - **Interval start**：区间起点的模板（如 `${startMillis}`）。
        - **Interval end**：区间终点的模板（如 `${endMillis}`）。
- **Fetch strategy** — 决定如何从指定区间选择数据点。
    - **First**：获取区间内时间戳最早的单条数据点。
    - **Last**：获取区间内时间戳最晚的单条数据点。
    - **All**：获取区间内的数据点集合。此模式启用额外查询参数：
        - **Data aggregation function**：可选，应用于区间内所有数据点的函数。选项包括 *None*、*Min*、*Max*、*Average*、*Sum*、*Count*。使用聚合函数时，节点返回单一聚合数据点。
        - **Order by timestamp**：按时间戳以 *Ascending* 或 *Descending* 排序获取的数据。仅在聚合函数选择 *None* 时使用。
        - **Limit**：按时间戳以 *Ascending* 或 *Descending* 排序获取的数据。仅在聚合函数选择 *None* 时使用。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbGetTelemetryNodeConfiguration",
  "type": "object",
  "properties": {
    "latestTsKeyNames": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Set of time series keys to fetch."
    },
    "useMetadataIntervalPatterns": {
      "type": "boolean",
      "description": "If true, use templates for the interval; otherwise, use a relative time window."
    },
    "startInterval": {
      "type": "integer",
      "description": "Value for the relative interval start."
    },
    "startIntervalTimeUnit": {
      "type": "string",
      "enum": [
        "MILLISECONDS",
        "SECONDS",
        "MINUTES",
        "HOURS",
        "DAYS"
      ],
      "description": "Time unit for the relative interval start (e.g., 'MINUTES')."
    },
    "endInterval": {
      "type": "integer",
      "description": "Value for the relative interval end."
    },
    "endIntervalTimeUnit": {
      "type": "string",
      "enum": [
        "MILLISECONDS",
        "SECONDS",
        "MINUTES",
        "HOURS",
        "DAYS"
      ],
      "description": "Time unit for the relative interval end (e.g., 'MINUTES')."
    },
    "startIntervalPattern": {
      "type": "string",
      "description": "Template for the dynamic interval start timestamp (in ms)."
    },
    "endIntervalPattern": {
      "type": "string",
      "description": "Template for the dynamic interval end timestamp (in ms)."
    },
    "fetchMode": {
      "type": "string",
      "enum": [
        "FIRST",
        "LAST",
        "ALL"
      ],
      "description": "Strategy for fetching data points."
    },
    "orderBy": {
      "type": "object",
      "description": "Sort order for the 'ALL' fetch mode."
    },
    "aggregation": {
      "type": "string",
      "enum": [
        "MIN",
        "MAX",
        "AVG",
        "SUM",
        "COUNT",
        "NONE"
      ],
      "description": "Aggregation function for the 'ALL' fetch mode."
    },
    "limit": {
      "type": "integer",
      "description": "Maximum number of data points to fetch in 'ALL' mode.",
      "minimum": 2,
      "maximum": 1000
    }
  },
  "required": [
    "latestTsKeyNames",
    "fetchMode"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点识别入站消息的**来源实体**（如具体 Device 或 Asset）。
2. 根据配置确定获取区间 `[startTs, endTs]`：
    * 若使用**相对时间窗口**，根据当前时间计算时间戳（如 `now - startInterval` 到 `now - endInterval`）。
    * 若使用**动态区间**，从消息或 metadata 解析模式得到起止时间戳。
3. 节点在计算得到的区间内异步查询数据库获取指定的遥测键，应用配置的**获取策略**。
4. 将获取的数据添加到消息 **metadata**。添加的值始终为字符串。
    * 对于 `First` 和 `Last` 策略，结果为单一遥测值，转为字符串（如 `"25.5"`）。
    * 对于 `All` 策略，结果为数据点的 JSON 数组，随后转为单一字符串（如 `'[{"ts":1672531200000,"value":25.5},{"ts":1672531260000,"value":26.1}]'`）。
    * 若使用聚合函数，结果为包含单一聚合数据点的字符串化 JSON 数组。
5. 丰富后的消息传递给 `Success` 连接。若发生错误（如无效区间 `startTs > endTs`），原始消息传递给 `Failure` 连接。

## 输出连接

- `Success`：消息已成功使用请求的遥测数据丰富。
- `Failure`：处理过程中发生错误。时间区间无效（如开始时间晚于结束时间）或数据库通信问题时可能发生。

## 示例

### 示例 1 — 获取区间内第一个值

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
  "latestTsKeyNames": [
    "temperature"
  ],
  "useMetadataIntervalPatterns": false,
  "startInterval": 60,
  "startIntervalTimeUnit": "MINUTES",
  "endInterval": 1,
  "endIntervalTimeUnit": "MILLISECONDS",
  "fetchMode": "FIRST"
}
```

**系统状态**

设备 `Thermostat-A7` 在过去一小时内有多条温度读数。最早的一条为 `22.4`。

**出站消息**

出站消息与入站消息相同，但其 metadata 已使用获取的值丰富。经 `Success` 连接发送。

Metadata:

```json
{
  "deviceName": "Thermostat-A7",
  "deviceType": "thermostat",
  "temperature": "22.4"
}
```

### 示例 2 — 获取区间内所有值

**入站消息**

Metadata:

```json
{
  "deviceName": "Humidifier-B1"
}
```

**节点配置**

```json
{
  "latestTsKeyNames": [
    "humidity"
  ],
  "useMetadataIntervalPatterns": false,
  "startInterval": 5,
  "startIntervalTimeUnit": "MINUTES",
  "endInterval": 1,
  "endIntervalTimeUnit": "MILLISECONDS",
  "fetchMode": "ALL",
  "orderBy": "ASC",
  "aggregation": "NONE",
  "limit": 3
}
```

**出站消息**

将 `humidity` 键添加到 metadata。其值为包含区间内所有找到数据点的 JSON 数组的字符串。

Metadata:

```json
{
  "deviceName": "Humidifier-B1",
  "humidity": "[{\"ts\":1756479300000,\"value\":45.2},{\"ts\":1756479360000,\"value\":45.8},{\"ts\":1756479420000,\"value\":46.1}]"
}
```

### 示例 3 — 对区间内数据聚合

**入站消息**

Metadata: `{}`

**节点配置**

```json
{
  "latestTsKeyNames": [
    "temperature"
  ],
  "useMetadataIntervalPatterns": false,
  "startInterval": 10,
  "startIntervalTimeUnit": "MINUTES",
  "endInterval": 1,
  "endIntervalTimeUnit": "MILLISECONDS",
  "fetchMode": "ALL",
  "orderBy": "ASC",
  "aggregation": "AVG",
  "limit": 1000
}
```

**出站消息**

聚合结果以包含单一对象的字符串化 JSON 数组返回。

Metadata:

```json
{
  "temperature": "[{\"ts\":1756479000000,\"value\":24.75}]"
}
```

{% capture aggregation_timestamp_note %}
**注意**：结果中的时间戳（`ts`）对应聚合区间的起点。
{% endcapture %}
{% include templates/info-banner.md content=aggregation_timestamp_note %}

### 示例 4 — 使用消息 data 中的动态区间

**入站消息**

Data:

```json
{
  "start": 1756470000000,
  "end": 1756473600000
}
```

**节点配置**

```json
{
  "latestTsKeyNames": [
    "vibration"
  ],
  "useMetadataIntervalPatterns": true,
  "startIntervalPattern": "${start}",
  "endIntervalPattern": "${end}",
  "fetchMode": "ALL",
  "orderBy": "DESC",
  "aggregation": "NONE",
  "limit": 50
}
```

**出站消息**

节点使用消息 data 中的 `start` 和 `end` 定义查询区间。获取的 `vibration` 数据添加到 metadata。

Metadata:

```json
{
  "vibration": "[{\"ts\":1756473540000,\"value\":0.12},{\"ts\":1756473480000,\"value\":0.15}]"
}
```
