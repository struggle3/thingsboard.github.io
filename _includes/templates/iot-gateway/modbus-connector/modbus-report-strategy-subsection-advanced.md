![image](/images/gateway/modbus-connector/modbus-report-strategy-subsection-advanced.png)

此子部分用于启用数据发送的报告策略，您可以选择以下三种行为之一：

- ON_REPORT_PERIOD - 每隔一段时间（毫秒）收集并发送数据。
- ON_CHANGE - 数据变化后发送。
- ON_CHANGE_OR_REPORT_PERIOD - 在数据变化时或距上次发送超过报告周期时发送。

下表描述了配置报告策略所需的参数：

| **参数** | **默认值**    | **描述**                                                                           |
|:--------------|:---------------------|-------------------------------------------------------------------------------------------
| type          | **ON_REPORT_PERIOD** | 报告策略类型：ON_REPORT_PERIOD、ON_CHANGE_OR_REPORT_PERIOD、ON_CHANGE|
| reportPeriod | **30000**            | 向平台发送数据的周期（毫秒）                                 |
| ---                                 

配置示例：

```text
reportStrategy: {
    "type": "ON_REPORT_PERIOD",
    "reportPeriod": 30000
}
```
