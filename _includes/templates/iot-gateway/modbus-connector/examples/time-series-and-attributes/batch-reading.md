我们以 ThingsBoard Modbus 演示服务器为例，可使用 Docker 运行以下命令：

```bash
docker run -it -p 5021:5021 thingsboard/tb-gw-modbus-server:latest
```
{:.copy-code}

服务器在 `0.0.0.0:5021` 可用。服务器结构如下：

| 变量名  | 寄存器类型   | 数据类型  | 地址    |
|:---------------|:----------------|------------|:-----------|
| Temperature    | Holding         | 16int      | 0          |
| Humidity       | Holding         | 16int      | 1          |
| Power          | Holding         | 16int      | 2          |
| Pressure       | Holding         | 16int      | 3          |
| Relay          | Coil            | bits       | 1          |
| -------------- | --------------- | ---------- | ---------- |

为优化发送到 Modbus 服务器的请求数量，可使用高级配置模式下的**批量读取**功能。该功能允许在单次请求中读取多个寄存器，从而显著降低 Modbus 服务器负载并提升性能。

下面举例说明如何正确配置批量读取，以从 Modbus 服务器读取 `temperature`、`humidity`、`power` 和 `pressure` 寄存器。

从上表可知，所需寄存器类型相同（`16int`）且功能码相同（`03 - 读保持寄存器`）。因此可将它们合并为一次批量读取请求。需要读取地址 `0` 到 `3` 的寄存器，地址范围为 `0-3`。
此外，需在 `tag` 字段中使用 `${address}` 等变量以唯一标识批量读取中的每个寄存器。本示例在 `tag` 字段中使用以下表达式：`${unitId}.${type}.${address}`（更多变量信息请参阅[文档相应章节](/docs/iot-gateway/config/modbus/#batch-reading-advanced-configuration-mode-only)）。

将以下配置复制粘贴到 Modbus 连接器高级配置模式：

```json
{
  "master": {
    "slaves": [
      {
        "host": "0.0.0.0",
        "port": 5021,
        "type": "tcp",
        "method": "socket",
        "timeout": 35,
        "byteOrder": "BIG",
        "wordOrder": "LITTLE",
        "retries": true,
        "retryOnEmpty": true,
        "retryOnInvalid": true,
        "pollPeriod": 1000,
        "unitId": 1,
        "deviceName": "Demo Device",
        "deviceType": "default",
        "sendDataOnlyOnChange": true,
        "connectAttemptTimeMs": 5000,
        "connectAttemptCount": 5,
        "waitAfterFailedAttemptsMs": 300000,
        "attributes": [],
        "timeseries": [
          {
            "tag": "${unitId}.${type}.${address}",
            "type": "16int",
            "functionCode": 3,
            "objectsCount": 1,
            "address": "0-3",
            "divider": 10
          }
        ],
        "attributeUpdates": [],
        "rpc": []
      }
    ]
  }
}
```
{:.copy-code}

保存更改并启动连接器后，可以看到对应遥测数据正确更新：

![image](/images/gateway/modbus-connector/examples/batch-reading-overview.png)
