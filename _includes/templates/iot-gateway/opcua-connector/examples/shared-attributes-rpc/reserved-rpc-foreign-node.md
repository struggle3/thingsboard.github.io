所有遥测和属性参数均内置 `get` 和 `set` RPC 方法，无需手动配置。

此外，可使用保留 RPC 方法访问 OPC-UA 服务器上的任意节点——即使该节点不属于特定设备。当管理或控制节点位于设备节点树之外时尤其有用。
我们将设备节点设为 `Root\.Objects\.DemoDevice`，但将访问位于 `Root\.Objects\.DemoDeviceInfo\.TextMessage` 的 `TextMessage` 节点，该节点在设备节点树之外。
以下示例使用 Prosys OPC-UA 仿真服务器，地址为 `opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer`。服务器结构如下：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-server-structure-overview-4.png)

我们关注 "**TextMessage**"，其 "**[Path](/docs/iot-gateway/config/opc-ua/#absolute-path)**" 为 `Root\.Objects\.DemoDeviceInfo\.TextMessage`，
且不属于设备节点树。我们以键 `textmessage` 将该节点添加为遥测参数，
便于后续在调用保留 `set` RPC 方法后验证值是否已更改。

```json
"timeseries": [
  {
    "key": "textmessage",
    "type": "path",   
    "path": "${Root\\.Objects\\.DemoDeviceInfo\\.TextMessage}"
  }
]
```
{: .copy-code}

使用保留 `get` 方法检查 textmessage 节点的值。在 RPC 调试终端中执行以下查询获取 textmessage 节点当前值：

```bash
get Root\\.Objects\\.DemoDeviceInfo\\.TextMessage;
```
{: .copy-code}

响应：

```json
{"result":{"value":"HI"}}
```
{: .copy-code}

![image](/images/gateway/opc-ua-connector/examples/opc-ua-reserved-rpc-get-foreign-nodes-result-1.png)

因此 `get` 方法返回 textmessage 节点的当前值，可见 textmessage 为 `HI`。

{% capture difference %}
RPC 调试终端仅用于示例，您可使用任何支持 RPC 调用的其他部件。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

设置 textmessage 节点的值并修改其内容，执行以下查询：

```bash
set Root\\.Objects\\.DemoDeviceInfo\\.TextMessage; New Message
```
{: .copy-code}

响应：

```json
{"result":{"value":"New Message"}}
```
{: .copy-code}

如下截图所示，textmessage 遥测值已变为 `New Message`：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-reserved-rpc-set-foreign-nodes-result-1.png)

再次检查 textmessage 遥测值：

```bash
get Root\\.Objects\\.DemoDeviceInfo\\.TextMessage;
```
{: .copy-code}

响应：

```json
{"result":{"value":"New Message"}}
```
{: .copy-code}

![image](/images/gateway/opc-ua-connector/examples/opc-ua-reserved-rpc-get-foreign-nodes-result-2.png)

上述示例的 OPC-UA 连接器完整配置如下：

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
          "key": "textmessage",
          "type": "path",
          "value": "${Root\\.Objects\\.DemoDeviceInfo\\.TextMessage}"
        }
      ],
      "rpc_methods": []
    }
  ]
}
```
{: .copy-code}
