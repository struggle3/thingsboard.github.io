执行用户自定义函数，将传入消息转换为字符串以用于日志记录。脚本可访问消息数据、元数据和类型以创建自定义日志条目，写入 ThingsBoard 日志文件。
支持 **TBEL** 和 **JavaScript**。

## 配置

节点提供脚本语言选择和代码编辑器以编写日志逻辑。

- **Language Selector（语言选择器）** - 在 **TBEL**（ThingsBoard Expression Language）和 **JavaScript** 之间选择。
- **Script Editor（脚本编辑器）** - 编写日志格式化函数体的文本区域。

### 日志格式化函数

在脚本编辑器中输入的代码作为日志格式化函数体。该函数隐式接收三个参数，在脚本中作为变量可用：

- `msg` - 传入消息的数据，通常为 JSON 对象。
- `metadata` - 传入消息的元数据，为键值对象，所有值为字符串。
- `msgType` - 传入消息的类型，为字符串。

函数必须 **return** 一个字符串，该字符串将以 INFO 日志级别写入 ThingsBoard 日志文件。

### JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "TbLogNodeConfiguration",
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
      "description": "The JavaScript log formatting function body. Used when 'scriptLang' is set to 'JS'."
    },
    "tbelScript": {
      "type": "string",
      "description": "The TBEL log formatting function body. Used when 'scriptLang' is set to 'TBEL'."
    }
  },
  "required": [
    "scriptLang"
  ],
  "additionalProperties": false
}
```
{: .copy-code.expandable-3 }

## 消息处理算法

1. 节点执行用户自定义脚本，传入传入消息的 `msg`、`metadata` 和 `msgType` 作为参数。
2. 脚本返回表示日志消息的字符串值。
3. 返回的字符串以 INFO 日志级别写入 ThingsBoard 日志文件。
4. 成功记录后，原始消息原样传递给 `Success` 链。
5. 若脚本执行期间遇到错误（如语法错误或运行时异常），处理失败，消息路由至 `Failure` 链。

## 输出连接

- `Success`：
    - 成功记录后，原始传入消息经此链发送。
- `Failure`：
    - 脚本执行失败并报错时。

## 示例

### 示例 1 — 基本日志记录

**传入消息**

数据：

```json
{
  "temperature": 24.3,
  "humidity": 58.7
}
```

元数据：

```json
{
  "deviceName": "Sensor-01",
  "deviceType": "default",
  "ts": "1756380600000"
}
```

类型：`POST_TELEMETRY_REQUEST`

**节点配置**

```json
{
  "scriptLang": "TBEL",
  "tbelScript": "return 'Message Type: ' + msgType + ' | Device: ' + metadata.deviceName + ' | Temperature: ' + msg.temperature + '°C | Humidity: ' + msg.humidity + '%';"
}
```

**传出消息**

与传入消息相同，经 `Success` 连接路由。

**结果**

脚本执行在 thingsboard.log 中产生以下日志条目：

```
Message Type: POST_TELEMETRY_REQUEST | Device: Sensor-01 | Temperature: 24.3°C | Humidity: 58.7%
```
