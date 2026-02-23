我们为遥测和属性 API 增加了 JSON 数据结构支持，以便简化设备配置操作。
JSON 支持允许从设备上传数据，并将嵌套对象推送到设备。
可将一份配置 JSON 存为共享属性并推送到设备，也可在规则引擎中处理 JSON 数据并触发告警等。

因此，该改进在 ThingsBoard 存储数据时减少了数据库操作次数。
例如，「temperature」和「humidity」会作为独立行存储在 SQL 或 NoSQL 数据库中，以便高效聚合用于可视化。
由于 JSON 数据无需聚合，可将全部内容存为一行，而无需为每个配置项单独成行。
在某些环境中，通过在单个 JSON 中聚合多个参数，可将数据库操作次数减少 10 倍以上。

通过该 [视频](https://www.youtube.com/watch?v=ErV5Krwhak0&ab_channel=ThingsBoard) 了解更多 JSON 值支持内容。