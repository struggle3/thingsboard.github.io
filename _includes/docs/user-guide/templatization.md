* TOC
{:toc}

Templatization 是指使用预定义 template 将值动态插入或替换到文本中的过程。
这些 template 充当变量的占位符，之后可用实际数据填充。

在 rule engine 上下文中，template 用于在运行时从入站消息中提取数据。
这在 rule node 配置中尤其有用，templatization 可将配置字段中的静态值替换为入站消息的实时值，实现动态配置。
从而更灵活、自动地处理数据，便于根据不同输入执行条件操作。

## Syntax

Template 以美元符号（`$`）开头，后跟方括号及其中的 key 名称。
方括号（`[]`）用于 message payload 的 key，花括号（`{}`）用于 message metadata 的 key。
例如： 
- `$[messageKey]` - 从入站消息 payload 中提取 `messageKey` 的值。
- `${metadataKey}` - 从入站消息 metadata 中提取 `metadataKey` 的值。

上例中，`messageKey` 和 `metadataKey` 表示 message payload 或 message metadata 中可能存在的任意 key 名称。

## Example

看一个示例。第一个 JSON 是 message payload，第二个是 message metadata：

```json
{
  "temperature": 26.5,
  "humidity": 75.2,
  "soilMoisture": 28.9,
  "windSpeed": 26.2,
  "location": "riverside"
}
```
```json
{
  "deviceType": "weather_sensor",
  "deviceName": "weather1",
  "ts": "1685379440000"
}
```

假设检测到异常高风速，要将该遥测读数发送到某外部 REST API。
每次读数需关联特定 device 和 location，这些信息仅在运行时可用。
我们可使用 template 提取必要数据并构建发送数据的 URL：

`example-base-url.com/report-reading?location=$[location]&deviceName=${deviceName}` 

该 template 将解析为： 

`example-base-url.com/report-reading?location=riverside&deviceName=weather1`

Template 适用于配置时未知具体值、但运行时会有值的场景。

## Notes

- Template 可与普通文本混合使用。例如："Fuel tanks are filled to `$[fuelLevel]`%"。
- 可使用点号访问 JSON 对象的嵌套 key：`$[object.key]`。
- 若指定 key 不存在，或关联值为 object 或 array，template 字符串将原样返回。
- 有两个特殊 template，可将整个 message payload 或 message metadata 序列化为 JSON 字符串：
  - `$[*]` – 该 template 被替换为完整 message payload 的 JSON 字符串。例如，若 template 为 "Raw data received: `$[*]`" 且入站 message payload 为 `{"mode": "eco", "targetTemp": 21, "active": true}`，则结果为 "Raw data received: {"mode":"eco","targetTemp":21,"active":true}"。
  - `${*}` – 类似地，该 template 被替换为完整 message metadata 的 JSON 字符串。例如，若 template 为 "Enriching data with context: `${*}`" 且 metadata 为 `{"vehicleId": "TRUCK-042", "region": "EU-Central", "customer": "LogisticsCorp"}`，则结果为 "Enriching data with context: {"vehicleId":"TRUCK-042","region":"EU-Central","customer":"LogisticsCorp"}"。

为说明不同数据类型下的行为，看一个示例。以下是消息 payload：
```json
{
    "number": 123.45,
    "string": "text",
    "boolean": true,
    "array": [1, 2, 3],
    "object": {
        "property": "propertyValue"
    },
    "null": null
}
```
以下为 template 与提取值的对照表：

| **Template**       | **Extracted value** |
|--------------------|---------------------|
| $[number]          | 123.45              |
| $[string]          | text                |
| $[boolean]         | true                |
| $[array]           | $[array]            |
| $[object]          | $[object]           |
| $[object.property] | propertyValue       |
| $[null]            | null                |
| $[doesNotExist]    | $[doesNotExist]     |
