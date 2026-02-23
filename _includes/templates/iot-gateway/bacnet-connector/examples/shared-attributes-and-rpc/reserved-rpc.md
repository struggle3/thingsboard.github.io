每个遥测和属性参数默认都有 `GET` 和 `SET` RPC 方法，因此您无需手动配置。

例如，我们将使用连接了继电器的 BACnet 控制器。我们还知道该继电器的对象 ID 为：`Binary Input:1`。

我们将使用此对象 ID 通过 `GET` RPC 方法读取继电器值，并通过 `SET` RPC 方法设置继电器值。此遥测的配置如下：

```json
{
  "key": "relay",
  "objectType": "binaryInput",
  "objectId": 1,
  "propertyId": "presentValue"
}
```

让我们使用保留的 `GET` 方法检查继电器值。要获取继电器当前值，请在 RPC 调试终端中运行以下查询：

```bash
get objectType=binaryInput;objectId=1;propertyId=presentValue;
```

响应：

```json
{"result": {"value":  "inactive"}}
```

![image](/images/gateway/bacnet-connector/examples/reserved-rpc-result-1.png)

因此，`GET` 方法返回继电器的当前值，我们可以看到继电器处于关闭状态。

{% capture difference %}
RPC 调试终端仅用于示例目的，您可以使用任何支持 RPC 调用的部件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

要设置继电器值并打开继电器，请运行以下查询：

```bash
set objectType=binaryInput;objectId=1;propertyId=presentValue;value=1;
```

响应：

```json
{"result": {"value": 1}}
```

如您从下方截图所见，继电器遥测值已变为 `1`：

![image](/images/gateway/bacnet-connector/examples/reserved-rpc-result-2.png)

此外，让我们再次检查继电器遥测值：

```bash
get objectType=binaryInput;objectId=1;propertyId=presentValue;
```

响应：

```json
{"result": {"value":  "active"}}
```

![image](/images/gateway/bacnet-connector/examples/reserved-rpc-result-3.png)

上述示例的 BACnet 连接器完整配置如下
**（请务必使用正确的设备 host 和 port）**：

```json
{
  "application": {
    "objectName": "TB_gateway",
    "host": "YOUR_HOST",
    "port": 47808,
    "objectIdentifier": 599,
    "vendorIdentifier": 15,
    "maxApduLengthAccepted": 1476,
    "segmentationSupported": "segmentedBoth",
    "deviceDiscoveryTimeoutInSec": 5
  },
  "devices": [
    {
      "altResponsesAddresses": [],
      "host": "YOUR_DEVICE_HOST",
      "port": 47808,
      "deviceInfo": {
        "deviceNameExpression": "${objectName}",
        "deviceProfileExpression": "default",
        "deviceNameExpressionSource": "expression",
        "deviceProfileExpressionSource": "constant"
      },
      "pollPeriod": 10000,
      "timeseries": [
        {
          "key": "relay",
          "objectType": "binaryInput",
          "objectId": 1,
          "propertyId": "presentValue"
        }
      ],
      "attributes": [],
      "attributeUpdates": [],
      "serverSideRpc": []
    }
  ]
}
```
{:.copy-code}
