Modbus 设备的寄存器可能表示枚举值，例如运行模式、状态码或错误状态。为便于理解，可使用 ThingsBoard IoT 网关 Modbus 连接器的枚举映射功能将其映射为可读字符串。该功能适用于所有寄存器类型，可用于上行数据（属性和时序数据）及上行 RPC 到设备调用。下面说明如何在 Modbus 连接器配置中设置枚举映射。

以下示例使用 ThingsBoard Modbus 演示服务器，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 5021:5021 thingsboard/tb-gw-modbus-server:latest
```
{:.copy-code}

服务器地址为 `0.0.0.0:5021`，结构如下：

| 变量名         | 寄存器类型 | 数据类型 | 地址   |
|:---------------|:-----------|----------|:-------|
| Temperature    | Holding    | 16int    | 0      |
| Humidity       | Holding    | 16int    | 1      |
| Power          | Holding    | 16int    | 2      |
| Pressure       | Holding    | 16int    | 3      |
| Operational Mode | Holding | 16int    | 4      |
| Relay          | Coil       | bits     | 1      |
| --------------   | --------------- | ---------- | ---------- |

我们要将 `Operational Mode` 和 `Relay` 寄存器映射为可读字符串。`Operational Mode` 可能取值为：
- `1`：正常模式
- `2`：维护模式
- `3`：标定模式

`Relay` 可能取值为：
- `0`：关闭
- `1`：开启

要为这些寄存器配置枚举映射，需在每个寄存器配置中定义 `variants` 参数。该参数为对象，键为可能的寄存器值，值为对应的可读描述。

将以下配置复制粘贴到 Modbus 连接器高级配置模式中：
```json
{
  "master": {
    "slaves": [
      {
        "host": "0.0.0.0",
        "port": 5021,
        "method": "socket",
        "unitId": 1,
        "deviceName": "Demo Device",
        "deviceType": "default",
        "timeout": 35,
        "byteOrder": "BIG",
        "wordOrder": "BIG",
        "retries": true,
        "retryOnEmpty": true,
        "retryOnInvalid": true,
        "pollPeriod": 1000,
        "connectAttemptTimeMs": 500,
        "connectAttemptCount": 5,
        "waitAfterFailedAttemptsMs": 1000,
        "type": "tcp",
        "attributes": [],
        "timeseries": [
          {
            "tag": "operational_mode",
            "type": "16int",
            "address": 4,
            "objectsCount": 1,
            "functionCode": 3,
            "variants": {
              "1": "Normal Mode",
              "2": "Service Mode",
              "3": "Calibration Mode"
            }
          },
          {
            "tag": "relay",
            "type": "bits",
            "address": 1,
            "objectsCount": 1,
            "functionCode": 1,
            "bitTargetType": "int",
            "variants": {
              "0": "OFF",
              "1": "ON"
            }
          }
        ],
        "attributeUpdates": [],
        "rpc": []
      }
    ]
  }
}
```
{:.copy-code.expandable-15}

应用该配置后，`operational_mode` 和 `relay` 寄存器在上行数据中会映射为相应的可读字符串，便于理解 Modbus 设备数据：

![image](/images/gateway/modbus-connector/examples/enum-mapping-overview.png)
