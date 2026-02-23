每个遥测和属性参数都自带 `GET` 和 `SET` RPC 方法，无需手动配置。

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

我们关注寄存器 `1`，这是一个线圈寄存器。我们将使用此寄存器设置遥测参数的值。该寄存器类型为 `bits`，因此遥测参数也使用 `bits` 类型。该遥测的配置如下：

```json
{
    "tag": "relay",
    "type": "bits",
    "address": 1,
    "objectsCount": 1,
    "functionCode": 1,
    "bitTargetType": "bool"
}
```

让我们使用保留的 `get` 方法检查继电器寄存器的值。要获取继电器寄存器的当前值，在 RPC 调试终端运行以下查询：

```bash
get type=bits;functionCode=1;objectsCount=1;address=1;
```

响应：

```json
{"result":{"value":false}}
```

![image](/images/gateway/modbus-connector/examples/reserved-rpc-result-1.png)

因此，`get` 方法返回继电器寄存器的当前值，可以看到继电器处于关闭状态。

{% capture difference %}
RPC 调试终端仅用于示例演示，您也可以使用任何支持 RPC 调用的其他部件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

要设置继电器寄存器的值并打开继电器，请运行以下查询：

```bash
set type=bits;functionCode=5;objectsCount=1;address=1;value=1;
```

响应：

```json
{"result":{"value":"1"}}
```

如下方截图所示，继电器遥测值已变为 `1`：

![image](/images/gateway/modbus-connector/examples/reserved-rpc-result-2.png)

再次检查继电器遥测的值：现在为 `true`，因为在 Modbus 连接器中，布尔值由整数转换而来——`0` = `false`，`1` = `true`（任意非零为 `true`）——因此寄存器值 `1` 会被报告为 `true`。

```bash
get type=bits;functionCode=3;objectsCount=1;address=1;
```

响应：

```json
{"result":{"value":true}}
```

![image](/images/gateway/modbus-connector/examples/reserved-rpc-result-3.png)

上述示例的 Modbus 连接器完整配置如下：

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
        "byteOrder": "LITTLE",
        "wordOrder": "LITTLE",
        "retries": true,
        "retryOnEmpty": true,
        "retryOnInvalid": true,
        "pollPeriod": 1000,
        "connectAttemptTimeMs": 500,
        "connectAttemptCount": 5,
        "waitAfterFailedAttemptsMs": 30000,
        "type": "tcp",
        "attributes": [],
        "timeseries": [
          {
            "tag": "relay",
            "type": "bits",
            "address": 1,
            "objectsCount": 1,
            "functionCode": 1,
            "bitTargetType": "bool"
          }
        ],
        "attributeUpdates": [],
        "rpc": []
      }
    ]
  }
}
```
