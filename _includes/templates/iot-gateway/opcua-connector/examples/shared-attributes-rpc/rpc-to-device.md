RPC 到设备允许在特定设备上执行 OPC-UA 服务器的方法。
需注意，调用的方法必须在 OPC-UA 服务器上已定义。

以下示例使用 ThingsBoard OPC-UA 演示服务器，可通过 Docker 及以下命令运行：
```bash
docker run -it -p 4840:4840 thingsboard/tb-gw-opcua-server:latest
```

服务器端点 URL 为：`opc.tcp://0.0.0.0:4840/freeopcua/server/`。

#### 示例：乘法运算

我们关注 "**multiply**" 方法节点，该方法将我们传入的两个数字相乘。
要调用该方法，需先配置 OPC-UA 连接器以支持 RPC 调用。按以下步骤操作：

{% assign rpcToDevice = '
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-1.png,
        title: 在右侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-1.png,
        title: 选择已创建的 OPC-UA 连接器，点击“**数据映射**”标签。请确保已配置并连接设备（若不清楚如何操作，请参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=opcua){:target="_blank"}或本指南的[连接设置](/docs/iot-gateway/config/opc-ua/#connection-settings)和[数据映射](/docs/iot-gateway/config/opc-ua/#data-mapping)）。点击要配置 RPC 方法的设备旁的“**铅笔**”图标。
    ===
        image: /images/gateway/opc-ua-connector/examples/rpc-to-device-1.png,
        title: 向下滚动至“**RPC 方法**”部分，点击“**铅笔**”图标编辑 RPC 方法。
    ===
        image: /images/gateway/opc-ua-connector/examples/rpc-to-device-2.png,
        title: 点击“添加方法”按钮。此处添加 `multiply` 方法，故在“**方法**”中填 `multiply`，在“**参数**”中填该方法接受的参数，此处为两个数字，可填任意数字。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-9.png,
        title: 记得点击“**应用**”按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=rpcToDevice %}

配置完成后，在 RPC 调试终端部件中执行以下命令调用方法：

```bash
multiply
```

此情况下，将使用配置中的参数（默认参数）调用方法。
此处参数为 5 和 4，结果为：

![image](/images/gateway/opc-ua-connector/examples/result-device-overview-5.png)

也可在 RPC 调试终端部件中直接传入参数调用方法：

```bash
multiply [3,4]
```

响应：

![image](/images/gateway/opc-ua-connector/examples/result-device-overview-6.png)

上述示例的 OPC-UA 连接器完整配置如下：

```json
{
  "name": "OPCUA",
  "server": {
    "url": "opc.tcp://0.0.0.0:4840/freeopcua/server/",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 3600000,
    "pollPeriodInMillis": 5000,
    "enableSubscriptions": false,
    "subCheckPeriodInMillis": 100,
    "showMap": false,
    "security": "Basic128Rsa15",
    "identity": {
      "type": "anonymous"
    }
  },
  "mapping": [
    {
      "deviceNodeSource": "path",
      "deviceNodePattern": "Root\\.Objects\\.MyObject",
      "deviceInfo": {
        "deviceNameExpression": "Demo Device",
        "deviceNameExpressionSource": "constant",
        "deviceProfileExpression": "default",
        "deviceProfileExpressionSource": "constant"
      },
      "attributes": [],
      "timeseries": [
        {
          "key": "some_key",
          "type": "path",
          "value": "${some_key}"
        }
      ],
      "rpc_methods": [
        {
          "method": "multiply",
          "arguments": [
            {
              "type": "integer",
              "value": 5
            },
            {
              "type": "integer",
              "value": 4
            }
          ]
        }
      ],
      "attributes_updates": []
    }
  ]
}
```
