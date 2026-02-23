设备名和配置文件可根据节点值动态设置。本示例使用[相对路径](/docs/iot-gateway/config/opc-ua/#relative-path)指定设备名和配置文件。

以下示例使用 Prosys OPC-UA 仿真服务器，地址为 `opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer`。服务器结构如下：

![image](/images/gateway/opc-ua-connector/examples/opc-ua-server-structure-overview-1.png)

我们关注节点 "**DeviceModelName**" 和 "**DeviceSeries**"。将用它们分别设置设备名和配置文件。

在 OPC-UA 连接器中配置设备名和配置文件。按以下步骤操作：

{% assign deviceNameAndProfileRelativePath = '
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-1.png,
        title: 在右侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-2.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-3.png,
        title: 选择已创建的 OPC-UA 连接器，点击“**数据映射**”标签。首先配置父（或设备）节点。点击“**+ 添加映射**”按钮。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-4.png,
        title: 在打开的窗口中，“设备节点”填 `Root\.Objects\.DemoDevice`，“**来源**”选“**[Path](/docs/iot-gateway/config/opc-ua/#relative-path)**”。这是要创建设备的父节点的绝对路径。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-5.png,
        title: “**名称**”填 `${DeviceModelName}`，“**来源**”选“**[Path](/docs/iot-gateway/config/opc-ua/#relative-path)**”。这是包含设备名的节点的相对路径。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-6.png,
        title: “**配置文件名称**”填 `${DeviceSeries}`，“**来源**”选“**[Path](/docs/iot-gateway/config/opc-ua/#relative-path)**”。这是包含设备配置文件的节点的相对路径。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-7.png,
        title: 还需至少添加一个属性/时序数据，因为连接器不会添加无可读数据的设备（可使用任意预装的 Prosys OPC-UA 仿真服务器节点）。点击“**属性**”旁的“**铅笔**”图标。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-absolute-path-8.png,
        title: 在打开的窗口中，点击“**添加属性**”按钮并按对应图片填写字段。
    ===
        image: /images/gateway/opc-ua-connector/examples/device-name-and-profile-relative-path-9.png,
        title: 记得点击“**保存**”按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=deviceNameAndProfileRelativePath %}

可以检查设备名和配置文件是否正确设置。进入“**实体**”→“**设备**”，设备名应为 `Demo Device`，配置文件为 `Demo Series`。

![image](/images/gateway/opc-ua-connector/examples/result-device-overview.png)

若使用高级配置模式并需用相对路径设置设备名和配置文件，可使用以下配置：

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
        "deviceNameExpression": "${DeviceModelName}",
        "deviceNameExpressionSource": "path",
        "deviceProfileExpressionSource": "path",
        "deviceProfileExpression": "${DeviceSeries}"
      },
      "attributes": [
        {
          "key": "some_key",
          "type": "identifier",
          "value": "${ns=3;i=1001}"
        }
      ],
      "timeseries": [],
      "rpc_methods": [],
      "attributes_updates": []
    }
  ]
}
```
