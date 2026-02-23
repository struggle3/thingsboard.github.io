属性更新允许更新 OPC-UA 服务器中的节点值。
可在设备配置页的“**属性更新**”部分添加新的属性更新。

以下示例使用 Prosys OPC-UA 仿真服务器，地址为 `opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer`。
服务器结构如下：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-server-structure-overview-4.png)

### 示例：文本消息编辑（标识符）

我们关注节点 "**TextMessage**"，以键 `text_message` 将其添加为遥测参数。
使用遥测便于后续通过属性更新查看值是否已变更。
您也可在设备配置中添加该遥测数据点，或使用保留 `get` 方法检查节点值。

按以下步骤添加属性更新配置：
- 进入“**实体**”→“**网关**”（右侧边栏）。
- 选择您的网关。
- 点击“**连接器**”标签。
- 选择 OPC-UA 连接器并点击“**数据映射**”标签。
- 请确保已配置并连接设备（若不清楚如何操作，请参阅入门指南或连接设置与数据映射部分）。点击要配置属性更新的设备旁的“**铅笔**”图标。
- 向下滚动至“**属性更新**”部分，点击“**铅笔**”图标编辑属性更新。
- 点击“**添加属性更新**”按钮。此处添加 `text_message` 属性更新，故在“**键**”中填 `text_message`，“**类型**”选 **Identifier**，“**值**”填
  `${ns=2;i=1005}`。这是要更新的 OPC-UA 服务器节点的标识符。
- 记得点击“**应用**”按钮保存更改。

{% assign attributeUpdatesIdentifier = '
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-1.png,
        title: 在右侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-1.png,
        title: 选择已创建的 OPC-UA 连接器，点击“**数据映射**”标签。请确保已配置并连接设备（若不清楚如何操作，请参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=opcua){:target="_blank"}或本指南的[连接设置](/docs/iot-gateway/config/opc-ua/#connection-settings)和[数据映射](/docs/iot-gateway/config/opc-ua/#data-mapping)）。点击要配置属性更新的设备旁的“**铅笔**”图标。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-identifier-1.png,
        title: 向下滚动至“**属性更新**”部分，点击“**铅笔**”图标编辑属性更新。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-identifier-2.png,
        title: 点击“**添加属性更新**”按钮。此处添加 `text_message` 属性更新，故在“**键**”中填 `text_message`，“**类型**”选 **Identifier**，“**值**”填 `${ns=2;i=1005}`。这是要更新的 OPC-UA 服务器节点的标识符。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-9.png,
        title: 记得点击“**应用**”按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attributeUpdatesIdentifier %}

可以检查属性更新是否生效。进入“**设备**”→选择已创建设备→“**属性**”标签→
选择“**共享属性**”→点击“**+**”图标，添加 `text_message` 属性，类型为“**字符串**”，值设为“**Hello from Gateway!**”。

{% assign attributeUpdatesIdentifier2 = '
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-4.png,
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-identifier-3.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=attributeUpdatesIdentifier2 %}

在所选设备的“**最新遥测**”标签中检查文本消息节点的值。因共享属性已设为 `Hello from Gateway!`，`text_message` 遥测值应为 `Hello from Gateway!`。

![image](/images/gateway/opc-ua-connector/examples/result-device-overview-4.png)

尝试将 `text_message` 共享属性的值改为 `Hello from <your_name>!`。几秒后，
`text_message` 遥测值应变为 `Hello from <your_name>!`，说明属性更新已正确生效。

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
      "deviceNodeSource": "path",
      "deviceNodePattern": "Root\\.Objects\\.DemoDevice",
      "deviceInfo": {
        "deviceNameExpression": "Demo Device",
        "deviceNameExpressionSource": "constant",
        "deviceProfileExpression": "default",
        "deviceProfileExpressionSource": "constant"
      },
      "attributes": [],
      "timeseries": [
        {
          "key": "text_message",
          "type": "identifier",
          "value": "${ns=3;i=1018}"
        }
      ],
      "rpc_methods": [],
      "attributes_updates": [
        {
          "key": "text_message",
          "type": "identifier",
          "value": "${ns=3;i=1018}"
        }
      ]
    }
  ]
}
```
