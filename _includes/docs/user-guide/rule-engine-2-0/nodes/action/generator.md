按可配置的内容和间隔定期生成消息。

## 配置

### 生成参数

- **Generated messages limit（生成消息限制）**：停止前要生成的消息数。设为 0 表示不限制。
- **Generation frequency in seconds（生成频率（秒））**：消息生成之间的时间间隔（秒）。

### 发起者

指定生成消息的发起者实体。配置取决于所选实体类型：

- **Type（类型）**：将作为生成消息发起者的实体类型。支持类型包括：
    - Device
    - Asset
    - Entity View
    - Current Tenant（当前租户）
    - Customer
    - User
    - Dashboard
    - Edge
    - Current Rule Node（当前 Rule 节点）
    - Converter
    - Integration
    - Scheduler Event
    - Blob Entity
    - Role
    - Entity Group（实体组）

#### 按发起者类型配置：

- **Current Tenant / Current Rule Node**：无需额外配置。使用当前租户或生成器节点本身作为发起者。

- **Entity Group**：需要额外组配置：
    - **Group Owner（组所有者）**：组的所有者
    - **Entity Type（实体类型）**：组内实体的类型
    - **Group（组）**：要使用的具体实体组

- **所有其他类型**：需要选择用作发起者的具体实体。

### 生成器函数

在脚本编辑器中输入的代码作为生成器函数体。该函数隐式接收三个参数，在脚本中作为变量可用：

- `prevMsg` - 先前生成消息的数据，通常为 JSON 对象。
- `prevMetadata` - 先前生成消息的元数据，为键值对象，所有值为字符串。
- `prevMsgType` - 先前生成消息的类型，为字符串。

对于第一条生成的消息（无先前消息时）：

- `prevMsg` 为空 JSON 对象 `{}`
- `prevMetadata` 为空 JSON 对象 `{}`
- `prevMsgType` 为空字符串 `""`

函数必须 **return** 包含以下键的对象：

- `msg` - 新传出消息的数据。
- `metadata` - 新消息的元数据。
- `msgType` - 新消息的类型。

### 队列

- **Queue（队列）**：选择用于持久化和可靠性的队列。未选择时使用「Main」队列。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbMsgGeneratorNodeConfiguration",
  "type": "object",
  "properties": {
    "msgCount": {
      "type": "integer",
      "description": "Number of messages to generate (0 = unlimited)"
    },
    "periodInSeconds": {
      "type": "integer",
      "description": "Generation frequency in seconds"
    },
    "originatorId": {
      "type": "string",
      "description": "ID of the originator entity"
    },
    "originatorType": {
      "type": "string",
      "enum": [
        "DEVICE",
        "ASSET",
        "ENTITY_VIEW",
        "TENANT",
        "CUSTOMER",
        "USER",
        "DASHBOARD",
        "EDGE",
        "RULE_NODE",
        "CONVERTER",
        "INTEGRATION",
        "SCHEDULER_EVENT",
        "BLOB_ENTITY",
        "ROLE",
        "ENTITY_GROUP"
      ],
      "description": "Type of the originator entity"
    },
    "scriptLang": {
      "type": "string",
      "enum": [
        "TBEL",
        "JS"
      ],
      "description": "Script language for generator function"
    },
    "jsScript": {
      "type": "string",
      "description": "JavaScript generator function"
    },
    "tbelScript": {
      "type": "string",
      "description": "TBEL generator function"
    }
  }
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

生成器节点独立于传入消息运行，即不接受来自其他 Rule 节点的消息（仅自调度消息触发生成）。
处理遵循以下周期：

1. 节点收到自调度的 `GENERATOR_NODE_SELF_MSG` 消息
2. 执行生成器函数，可访问先前生成的消息
3. 创建新消息：
    - 发起者设为配置的实体
    - 数据、元数据和类型来自脚本执行结果
4. 经 `Success` 连接路由生成的消息
5. 若未达到消息数限制，调度下一生成周期
6. 增加当前消息计数

## 输出连接

- `Success`
    - 生成的消息
- `Failure`
    - 生成器脚本失败或生成期间发生其他意外错误时的自调度消息

## 示例

### 示例 1 — 基本每日消息生成

**节点配置**

```json
{
  "msgCount": 0,
  "periodInSeconds": 86400,
  "originatorType": "RULE_NODE",
  "scriptLang": "TBEL",
  "tbelScript": "var msg = {};\nvar metadata = {};\nvar msgType = \"CUSTOM\";\n\nreturn { msg: msg, metadata: metadata, msgType: msgType };"
}
```

**生成的消息**

类型：`CUSTOM`

数据：

```json
{}
```

元数据：

```json
{}
```

发起者：`RULE_NODE`（生成器节点本身）

**结果**

每天一次（每 86400 秒），节点生成空消息，无限运行。

### 示例 2 — 顺序计数器消息

**节点配置**

```json
{
  "msgCount": 3,
  "periodInSeconds": 60,
  "originatorType": "DEVICE",
  "originatorId": "3bc2eb60-8d77-11f0-8a6c-59050cd4204f",
  "scriptLang": "TBEL",
  "tbelScript": "var counter = 1;\nif (!prevMsg.isEmpty()) {\n    counter = prevMsg.counter + 1;\n}\n\nvar msg = {\n    counter: counter\n};\n\nvar metadata = {};\nvar msgType = \"POST_TELEMETRY_REQUEST\";\n\nreturn { msg: msg, metadata: metadata, msgType: msgType };"
}
```

**传出消息**

**第 1 条消息**

类型：`POST_TELEMETRY_REQUEST`

数据：

```json
{
  "counter": 1
}
```

发起者：ID 为 `3bc2eb60-8d77-11f0-8a6c-59050cd4204f` 的 `DEVICE`

**第 2 条消息**

类型：`POST_TELEMETRY_REQUEST`

数据：

```json
{
  "counter": 2
}
```

发起者：ID 为 `3bc2eb60-8d77-11f0-8a6c-59050cd4204f` 的 `DEVICE`

**第 3 条消息**

类型：`POST_TELEMETRY_REQUEST`

数据：

```json
{
  "counter": 3
}
```

发起者：ID 为 `3bc2eb60-8d77-11f0-8a6c-59050cd4204f` 的 `DEVICE`

**结果**

节点恰好生成 3 条消息，每分钟一条，counter 字段从 1 递增到 3，然后停止。
