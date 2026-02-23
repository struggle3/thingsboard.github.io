RPC 到连接器允许从 ThingsBoard IoT 网关界面向连接器发送命令。
需注意，调用的方法必须在 OPC-UA 服务器上已定义。

{% capture difference %}
**请注意**：RPC 到连接器将在每个配置了 OPC-UA 连接器的设备上执行该方法。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

以下示例使用 ThingsBoard OPC-UA 演示服务器，可通过 Docker 及以下命令运行：
```bash
docker run -it -p 4840:4840 thingsboard/tb-gw-opcua-server:latest
```

服务器端点 URL 为：`opc.tcp://0.0.0.0:4840/freeopcua/server/`。

#### 示例：继电器控制

下面展示 RPC 到连接器的实际用法。OPC-UA 服务器上有 "set_relay" 方法，
可开关继电器。该方法接受布尔参数，`true` 打开继电器，`false` 关闭继电器。调用该方法的步骤如下：

{% assign rpcToConnector = '
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-1.png,
        title: 在右侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/rpc-to-connector-1.png,
        title: 选择已创建的 OPC-UA 连接器，点击“**RPC**”图标。请确保已配置并连接设备（若不清楚如何操作，请参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=opcua){:target="_blank"}或本指南的[连接设置](/docs/iot-gateway/config/opc-ua/#connection-settings)和[数据映射](/docs/iot-gateway/config/opc-ua/#data-mapping)）。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=rpcToConnector %}

先打开继电器。在“**方法**”中填 `set_relay`，在“**参数**”中填 `true`，再点击“**发送**”按钮。

![image](/images/gateway/opc-ua-connector/examples/rpc-to-connector-2.png)

响应中包含 `true`，表示方法已成功执行且继电器已打开：

![image](/images/gateway/opc-ua-connector/examples/rpc-to-connector-3.png)

最后关闭继电器。在“**方法**”中填 `set_relay`，在“**参数**”中填 `false`，再点击“**发送**”按钮：

![image](/images/gateway/opc-ua-connector/examples/rpc-to-connector-4.png)

结果：

![image](/images/gateway/opc-ua-connector/examples/rpc-to-connector-5.png)

上述示例的 OPC-UA 连接器完整配置如下：

```json
{
  "server": {
    "url": "opc.tcp://0.0.0.0:4840/freeopcua/server/",
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
      "deviceNodePattern": "Root\\.Objects\\.MyObject",
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
          "key": "Frequency",
          "type": "path",
          "value": "${Frequency}"
        }
      ],
      "rpc_methods": []
    }
  ]
}
```
