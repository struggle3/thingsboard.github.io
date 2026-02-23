Attribute 更新允许您更新 OPC-UA 服务器中的节点值。 
您可在设备配置页面的 "**Attribute updates**" 部分添加新的 attribute 更新。

我们将使用 Prosys OPC-UA Simulation Server 作为示例，其地址为 `opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer`。
服务器结构如下：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-server-structure-overview-3.png)

#### 示例：继电器控制（相对路径）

我们关注 "**Relay**" 节点，已将其添加为 key 为 `relay` 的 telemetry 参数。我们使用 telemetry 以便后续方便查看通过 attribute 更新修改的值是否已生效。您也可在设备配置中添加此 telemetry 数据点，或使用保留的 `get` RPC 方法检查节点值。

让我们在配置中添加 attribute 更新。请按以下步骤操作：

{% assign attributeUpdatesRelativePath = '
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-1.png,
        title: 在右侧边栏中进入 "**Entities**" → "**Gateways**" 并选择您的网关。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-2.png,
        title: 在右侧菜单中点击 "**Connectors configuration**"（连接器配置）按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-1.png,
        title: 选择已创建的 OPC-UA connector，点击 "**Data mapping**" 选项卡。请确保已配置并连接设备（若不知如何操作，请参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=opcua){:target="_blank"}或本指南的 [Connection settings](/docs/iot-gateway/config/opc-ua/#connection-settings) 和 [Data mapping](/docs/iot-gateway/config/opc-ua/#data-mapping) 部分）。点击要配置 attribute 更新的设备旁的 "**Pencil**"（铅笔）图标。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-2.png,
        title: 向下滚动至 "**Attribute updates**" 部分，点击 "**Pencil**" 图标编辑 attribute 更新。
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-3.png,
        title: 点击 "**Add attribute update**" 按钮。本示例中我们将添加 `relay` attribute 更新，在 "**Key**" 字段输入 `relay`，将 "**Type**" 选为 **Path**，在 "**Value**" 字段输入 `${Relay}`。这是要更新的设备节点的相对路径。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-9.png,
        title: 请记得点击 "**Apply**" 按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attributeUpdatesRelativePath %}

现在我们可以检查 attribute 更新是否生效。进入 "**Entities**" → "**Devices**" → 选择已创建设备 → "**Attributes**" 选项卡 → 
选择 "**Shared attributes**" → 点击 "**+**" 图标并添加类型为 "**Boolean**"、值为 "**True**" 的 `relay` attribute。

{% assign attributeUpdatesRelativePath2 = '
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-4.png,
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-5.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=attributeUpdatesRelativePath2 %}

现在检查 relay 节点的值。在所选设备中进入 "**Last telemetry**" 选项卡，查看 `relay` telemetry 的值。由于我们将 shared attribute 设为 `true`，应显示为 `true`。

![image](/images/gateway/opc-ua-connector/examples/result-device-overview-2.png)

尝试将 `relay` shared attribute 的值改为 `false`。几秒钟后，您应能看到 `relay` telemetry 值已变为 `false`，说明 attribute 更新已正确生效。

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
      "attributes_updates": [
        {
          "key": "relay",
          "type": "path",
          "value": "${Relay}"
        }
      ],
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
