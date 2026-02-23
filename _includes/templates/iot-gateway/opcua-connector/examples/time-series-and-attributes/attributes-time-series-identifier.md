在 OPC UA 连接器中，可使用[标识符](/docs/iot-gateway/config/opc-ua/#identifier-types)访问属性和时序数据。
可通过标识符从与父（设备）节点无关联的节点获取数据。

以下示例使用 Prosys OPC-UA 仿真服务器，地址为 `opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer`。服务器结构如下：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-server-structure-overview-2.png)

我们关注标识符为 `ns=3;i=1011` 的节点 "**Humidity**"。使用该节点获取湿度数据。

在 OPC-UA 连接器中配置湿度数据。按以下步骤操作：

{% assign attributesAndTimeSeriesIdentifierPath = '
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/attributes-time-series-absolute-path-1.png,
        title: 选择 OPC-UA 连接器，点击“**数据映射**”标签。选择要添加时序数据的数据映射（若不清楚如何添加新设备，请参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=opcua){:target="_blank"}或本指南的[数据映射](/docs/iot-gateway/config/opc-ua/#data-mapping)及相应示例）。
    ===
        image: /images/gateway/opc-ua-connector/examples/attributes-time-series-absolute-path-2.png,
        title: 在打开的数据映射窗口中，点击“**时序数据**”或“**属性**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/opc-ua-connector/examples/attributes-time-series-identifier-path-3.png,
        title: 点击“**添加时序数据**”按钮。“**键**”填 `Humidity`，“**类型**”选“**[Identifier](/docs/iot-gateway/config/opc-ua/#identifier-types)**”，“**值**”填 `${ns=3;i=1011}`。这是包含湿度数据的节点的标识符。
    ===
        image: /images/gateway/opc-ua-connector/examples/attributes-time-series-absolute-path-4.png,
        title: 记得点击“**应用**”按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attributesAndTimeSeriesIdentifierPath %}

可以检查湿度数据是否发送正确。进入“**实体**”→“**设备**”，选择已创建设备，在“**时序数据**”部分可看到湿度数据：

![image](/images/gateway/opc-ua-connector/examples/result-device-overview-1.png)

若使用高级配置模式并需用标识符设置湿度数据，可使用以下配置：

```json
{
  "name": "OPCUA",
  "server": {
    "url": "opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer",
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
      "deviceNodePattern": "Root\\.Objects\\.DemoDevice",
      "deviceInfo": {
        "deviceNameExpression": "Demo Device",
        "deviceNameExpressionSource": "constant",
        "deviceProfileExpressionSource": "constant",
        "deviceProfileExpression": "default"
      },
      "attributes": [],
      "timeseries": [
        {
          "key": "Humidity",
          "type": "identifier",
          "value": "${ns=3;i=1011}"
        }
      ],
      "rpc_methods": [],
      "attributes_updates": []
    }
  ]
}
```
