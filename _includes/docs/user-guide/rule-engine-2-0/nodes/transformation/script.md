执行用户自定义函数以转换入站消息。脚本可修改消息的 data、metadata 和 type。
根据脚本逻辑，可产生一条修改后的消息或多条新消息，每条均可有定制内容。
支持 **TBEL** 和 **JavaScript**。

## 配置

节点提供脚本语言选择和代码编辑器以编写转换逻辑。

- **语言选择** — 在 **TBEL**（ThingsBoard Expression Language）与 **JavaScript** 之间选择。
- **脚本编辑器** — 编写转换函数体的文本区域。

### 转换函数

脚本编辑器中的代码作为转换函数体。该函数隐式接收三个参数，在脚本中作为变量使用：

- `msg` — 入站消息的 data，通常为 JSON 对象。
- `metadata` — 入站消息的 metadata，键值对象，所有值为字符串。
- `msgType` — 入站消息的类型，字符串。

函数必须**返回**一个对象（单条输出消息）或对象数组（多条输出消息）。每个对象必须包含以下键：

- `msg` — 新出站消息的 data。
- `metadata` — 新消息的 metadata。
- `msgType` — 新消息的 type。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbTransformMsgNodeConfiguration",
  "type": "object",
  "properties": {
    "scriptLang": {
      "type": "string",
      "enum": [
        "JS",
        "TBEL"
      ],
      "description": "The scripting language to use."
    },
    "jsScript": {
      "type": "string",
      "description": "The JavaScript transformation function body. Used when 'scriptLang' is set to 'JS'."
    },
    "tbelScript": {
      "type": "string",
      "description": "The TBEL transformation function body. Used when 'scriptLang' is set to 'TBEL'."
    }
  },
  "required": [
    "scriptLang"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理逻辑

1. 节点执行用户自定义脚本，传入入站消息的 `msg`、`metadata` 和 `msgType` 作为参数。
2. 脚本返回值决定输出：
    - 若返回**单个对象**，准备一条新消息。
    - 若返回**对象数组**，为数组中每个对象准备一条新消息。
3. 对每条要创建的新消息，节点构建其内容：
    - 使用脚本返回对象中的 `msg`、`metadata` 和 `msgType` 值。
    - 消息来源实体及其他属性从原始消息保留。
4. 所有新消息经 `Success` 链发送。所有新消息成功入队后确认原始消息。
5. 若脚本执行时出错（如语法错误或运行时异常），原始消息经 `Failure` 链路由。

## 输出连接

- `Success`：
    - 一条或多条转换后的消息经此链发送。
- `Failure`：
    - 脚本执行出错时。

## 示例

### 示例 1 — 准备多条 REST API 请求

本示例演示如何从单条触发消息生成多条出站消息。
当需要从外部 API 获取数据，且不同遥测信息需单独请求时，这是常见场景。

**场景**：入站消息指定要从外部系统获取的指标列表。
脚本节点充当请求生成器，遍历列表并为每个指标创建独立的、格式化的 JSON-RPC 请求消息。
这些消息随后可被「rest api call」节点分别处理。

**入站消息**

Data:

```json
{
  "metrics": [
    "voltage",
    "pressure",
    "signalStrength"
  ],
  "startTime": 1756289924769,
  "endTime": 1756389984769
}
```

Metadata:

```json
{
  "apiKey": "abc-123-def-456",
  "serialId": "19092601"
}
```

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "tbelScript": "// This array will hold the outgoing API request messages\nvar outgoingMessages = [];\n\n// Get the required values from the incoming message and metadata\nvar apiKey = metadata.apiKey;\nvar serialId = metadata.serialId;\nvar startTime = msg.startTime;\nvar endTime = msg.endTime;\n\n// Loop through each metric specified in the incoming message's data\nforeach(metric: msg.metrics) {\n    // For each metric, construct the body of the JSON-RPC request\n    var rpcRequestBody = {\n        jsonrpc: \"2.0\",\n        method: \"getData\",\n        version: \"v10.1\",\n        id: 1,\n        params: {\n            apiToken: apiKey,\n            serialId: serialId,\n            metric: metric, // This is the current metric from the array\n            startTime: startTime,\n            endTime: endTime\n        }\n    };\n\n    // Create the final outgoing message object\n    var outgoingMessage = {\n        // The API request body becomes the data of the new message\n        msg: rpcRequestBody,\n        // We can pass along the original metadata\n        metadata: metadata,\n        // Set a new type to indicate this is an API request\n        msgType: 'API_REQUEST'\n    };\n\n    // Add the newly created message to our list of outputs\n    outgoingMessages.push(outgoingMessage);\n}\n\n// Return the array of messages. One message will be sent for each metric\nreturn outgoingMessages;"
}
```

```javascript
// This array will hold the outgoing API request messages
var outgoingMessages = [];

// Get the required values from the incoming message and metadata
var apiKey = metadata.apiKey;
var serialId = metadata.serialId;
var startTime = msg.startTime;
var endTime = msg.endTime;

// Loop through each metric specified in the incoming message's data
foreach(metric: msg.metrics) {
    // For each metric, construct the body of the JSON-RPC request
    var rpcRequestBody = {
        jsonrpc: "2.0",
        method: "getData",
        version: "v10.1",
        id: 1,
        params: {
            apiToken: apiKey,
            serialId: serialId,
            metric: metric, // This is the current metric from the array
            startTime: startTime,
            endTime: endTime
        }
    };

    // Create the final outgoing message object
    var outgoingMessage = {
        // The API request body becomes the data of the new message
        msg: rpcRequestBody,
        // We can pass along the original metadata
        metadata: metadata,
        // Set a new type to indicate this is an API request
        msgType: 'API_REQUEST'
    };

    // Add the newly created message to our list of outputs
    outgoingMessages.push(outgoingMessage);
}

// Return the array of messages. One message will be sent for each metric
return outgoingMessages;
```

**出站消息**

经 `Success` 连接创建并发送三条新消息，对应原始消息中请求的每个指标一条。

* Message 1: 请求 `voltage`
    * Data:
      ```json
      {
        "jsonrpc": "2.0",
        "method": "getData",
        "version": "v10.1",
        "id": 1,
        "params": {
          "apiToken": "abc-123-def-456",
          "serialId": "19092601",
          "metric": "voltage",
          "startTime": 1756389924769,
          "endTime": 1756389984769
        }
      }
      ```
    * Type: `API_REQUEST`
* Message 2: 请求 `pressure`
    * Data: （同上，但 `metric` 为 `pressure`）
* Message 3: 请求 `signalStrength`
    * Data: （同上，但 `metric` 为 `signalStrength`）

**说明**：脚本遍历入站消息中的 metrics 数组。对数组中每一项，构建完整的 JSON-RPC 请求体，用入站消息（`startTime`、`endTime`）和其 metadata（`apiKey`、`serialId`）填充。结果为三条不同消息，每条 ready 用于查询特定指标的 API。

### 示例 2 — 解析 REST API 响应

本示例演示如何将具有自定义数据结构的消息转换为 ThingsBoard 可存储的单一标准化遥测消息。
从外部系统或第三方 API 获取数据时，这是常见场景。

**场景**：「rest api call」节点查询外部 API 并收到非标准格式的响应。
脚本节点解析该响应，提取相关值，并将消息 data 重新格式化为可用「save time series」节点保存的结构。

**入站消息**

Data:

```json
{
  "eventUuid": "68b03dde7eb1ad4ff09cadfe",
  "serialId": "19092601",
  "filters": {
    "sensorChannel": 1
  },
  "metric": "pressure",
  "unit": "kPa",
  "observations": [
    {
      "time": "2025-08-28T11:30:00Z",
      "value": 101.3
    },
    {
      "time": "2025-08-28T11:31:00Z",
      "value": 101.2
    },
    {
      "time": "2025-08-28T11:32:00Z",
      "value": 101.4
    },
    {
      "time": "2025-08-28T11:33:00Z",
      "value": 101.5
    },
    {
      "time": "2025-08-28T11:34:00Z",
      "value": 101.3
    }
  ]
}
```

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "tbelScript": "// Initialize an object to build the outgoing message\nvar output = {};\n\n// Create an array to store the formatted telemetry\nvar parsedTelemetry = [];\n\n// Loop through each observation in the incoming message\nforeach(observation: msg.observations) {\n    // Create a 'values' object for the current reading\n    var values = {};\n\n    // Set the telemetry key (e.g., \"pressure\") and its value.\n    values.put(msg.metric, observation.value);\n    // Add the formatted data point to the results array\n    parsedTelemetry.add({\n        // 'ts': Parse the time string and convert to a Unix timestamp (ms)\n        ts: new Date(observation.time).getTime(), // 'values': The telemetry key-value pair\n        values: values\n    });\n}\n\n// Set the outgoing message's data to the array of telemetry\noutput.msg = parsedTelemetry;\n\n// Copy the original metadata to the new message\noutput.metadata = metadata;\n\n// Set the message type for telemetry processing\noutput.msgType = \"POST_TELEMETRY_REQUEST\";\n\n// Return the complete outgoing message object\nreturn output;"
}
```

```javascript
// Initialize an object to build the outgoing message
var output = {};

// Create an array to store the formatted telemetry
var parsedTelemetry = [];

// Loop through each observation in the incoming message
foreach(observation: msg.observations) {
    // Create a 'values' object for the current reading
    var values = {};

    // Set the telemetry key (e.g., "pressure") and its value.
    values.put(msg.metric, observation.value);
    // Add the formatted data point to the results array
    parsedTelemetry.add({
        // 'ts': Parse the time string and convert to a Unix timestamp (ms)
        ts: new Date(observation.time).getTime(), // 'values': The telemetry key-value pair
        values: values
    });
}

// Set the outgoing message's data to the array of telemetry
output.msg = parsedTelemetry;

// Copy the original metadata to the new message
output.metadata = metadata;

// Set the message type for telemetry processing
output.msgType = "POST_TELEMETRY_REQUEST";

// Return the complete outgoing message object
return output;
```

**出站消息**

原始消息被转换并经 `Success` 链发送。

Data:

```json
[{
    "ts": 1756380600000,
    "values": {
        "pressure": 101.3
    }
}, {
    "ts": 1756380660000,
    "values": {
        "pressure": 101.2
    }
}, {
    "ts": 1756380720000,
    "values": {
        "pressure": 101.4
    }
}, {
    "ts": 1756380780000,
    "values": {
        "pressure": 101.5
    }
}, {
    "ts": 1756380840000,
    "values": {
        "pressure": 101.3
    }
}]
```

Message type: `POST_TELEMETRY_REQUEST`

**说明**：脚本处理包含自定义格式批量观测的入站消息。遍历 observations 数组，将每项转换为标准的 ThingsBoard 时间序列格式。具体做法是将时间字符串转为 Unix 时间戳，并使用顶层 metric 字段（`pressure`）作为动态遥测键。
