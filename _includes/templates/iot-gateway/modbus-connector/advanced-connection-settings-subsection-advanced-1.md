您可配置其他设置，如：TLS 连接、轮询时间、字节序和字序等。下表描述了相关参数：

| **参数**             | **默认值**  | **描述**                                                               |
|:--------------------------|:-------------------|-------------------------------------------------------------------------------
| timeout                   | **35**             | 连接 Modbus 服务器的超时时间（秒）                            |
| byteOrder                 | **LITTLE**         | 字节读取顺序                                                        |
| wordOrder                 | **LITTLE**         | 读取多个寄存器时的字顺序                             |
| retries                   | **true**           | 是否重试向主站发送数据。可选值：true 或 false  |
| retriesOnEmpty            | **true**           | 数据为空时是否重试向主站发送                            |
| retriesOnInvalid          | **true**           | 发送失败时是否重试向主站发送                           |
| pollPeriod                | **5000**           | 检查从站属性和遥测的周期（毫秒） |
| connectAttemptTimeMs      | **5000**           | 连接主站前的等待时间（毫秒）              |
| connectAttemptCount       | **5**              | 通过 ThingsBoard 网关进行的连接尝试次数        |
| waitAfterFailedAttemptsMs | **300000**         | 再次尝试向主站发送数据前的等待时间（毫秒）     |
| ---                       

![image](/images/gateway/modbus-connector/advanced-connection-settings-advanced-1-ce.png)

<br>
示例：

```json
"master": {
  "slaves": [
    {
      "timeout": 35,
      "byteOrder": "LITTLE",
      "wordOrder": "LITTLE",
      "retries": true,
      "retryOnEmpty": true,
      "retryOnInvalid": true,
      "pollPeriod": 5000,
      "sendDataOnlyOnChange": true,
      "connectAttemptTimeMs": 5000,
      "connectAttemptCount": 5,
      "waitAfterFailedAttemptsMs": 300000,
    }
  ]
}
```