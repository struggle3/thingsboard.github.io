每个 telemetry 和 attribute 参数都 `GET` 和 `SET` RPC 方法，无需手动配置。

我们将使用 Prosys OPC-UA Simulation Server 作为示例，其地址为 `opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer`。服务器结构如下：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-server-structure-overview-3.png)

我们关注标识符为 `ns=3;i=1012` 的 "**Relay**" 节点，已将其添加为 key 为 `relay` 的 telemetry 参数，路径使用节点标识符 `${ns=3;i=1012}`，该 telemetry 的配置如下：

```json
"timeseries": [
  {
    "key": "relay",
    "path": "${ns=3;i=1012}"
  }
]
```

使用保留的 `get` 方法检查 relay 节点的值。要获取 relay 节点当前值，请在 RPC debug terminal 中运行以下查询：

```bash
get ns=3;i=1012;
```

响应：

```json
{"result":  {"value":  false}}
```

![image](/images/gateway/opc-ua-connector/examples/opc-ua-reserved-rpc-get-result-1.png)

因此，`get` 方法返回 relay 节点的当前值，可以看到 relay 处于关闭状态。

{% capture difference %}
RPC Debug Terminal 仅用于示例，您可使用任何支持 RPC 调用的部件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

要设置 relay 节点的值并开启 relay，请运行以下查询：

```bash
set ns=3;i=1012; true
```

响应：

```json
{"result":  {"value":  true}}
```

如下图所示，relay telemetry 值已变为 `true`：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-reserved-rpc-set-result-1.png)

我们再次检查 relay telemetry 的值：

```bash
get ns=3;i=1012;
```

响应：

```json
{"result":  {"value":  true}}
```

![image](/images/gateway/opc-ua-connector/examples/opc-ua-reserved-rpc-get-result-2.png)

上述示例的 OPC-UA connector 完整配置如下：

```json
{
  "server": {
    "url": "opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 3600000,
    "enableSubscriptions": true,
    "subCheckPeriodInMillis": 100,
    "showMap": false,
    "security": "Basic128Rsa15",
    "identity": {
      "type": "anonymous"
    },
    "pollPeriodInMillis": 5000
  },
  "mapping": [
    {
      "deviceNodePattern": "Root\\.Objects\\.DemoDevice",
      "deviceNodeSource": "path",
      "deviceInfo": {
        "deviceNameExpression": "Demo Device",
        "deviceNameExpressionSource": "constant",
        "deviceProfileExpression": "default",
        "deviceProfileExpressionSource": "constant"
      },
      "attributes": [],
      "attributes_updates": [],
      "timeseries": [
        {
          "key": "relay",
          "type": "identifier",
          "value": "${ns=3;i=1012}"
        }
      ],
      "rpc_methods": []
    }
  ]
}
```
