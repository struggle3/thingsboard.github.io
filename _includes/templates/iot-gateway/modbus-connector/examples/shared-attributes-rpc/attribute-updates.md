属性更新允许您更新 Modbus 服务器中的寄存器值。您可以在设备配置页面的「**属性更新**」部分添加新的属性更新。

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

我们关注寄存器「**1**」，我们已将此寄存器添加为键名为 `relay` 的遥测参数。使用遥测是为了便于之后查看通过属性更新更改的值是否已生效。您也可以在设备配置中添加此遥测数据点，或使用保留的 `get` 方法检查该节点的值。

让我们向配置添加属性更新。请按以下步骤操作：

{% assign attributeUpdates = '
    ===
        image: /images/gateway/modbus-connector/examples/select-created-gateway.png,
        title: 在左侧边栏进入「**实体**」→「**网关**」并选择您的网关。
    ===
        image: /images/gateway/modbus-connector/examples/select-connector-configuration.png,
        title: 点击右侧菜单的「**连接器配置**」按钮。
    ===
        image: /images/gateway/modbus-connector/examples/select-device-configuration.png,
        title: 选择已创建的 Modbus 连接器并点击「**主站连接**」选项卡。确保已配置并连接设备（如不清楚操作，请参阅 [入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=modbus){:target="_blank"} 或本指南的 [连接设置](/docs/iot-gateway/config/modbus/#connection-settings) 和 [数据映射](/docs/iot-gateway/config/modbus/#data-mapping) 章节）。点击要配置属性更新的设备上的「**铅笔**」图标。
    ===
        image: /images/gateway/modbus-connector/examples/connector-configuration-attribute-updates-1.png,
        title: 向下滚动到「**属性更新**」部分，点击「**铅笔**」图标编辑属性更新。
    ===
        image: /images/gateway/modbus-connector/examples/connector-configuration-attribute-updates-2.png,
        title: 点击「**添加属性更新**」按钮。本示例中将添加 `relay` 属性更新，因此在「**键**」字段输入 `relay`，选择「**类型**」为 **bits**，「**功能码**」为「**05 - 写单个线圈**」，在「**对象数量**」字段填写 `1`，选择「**位目标类型**」为「**布尔**」，在「**地址**」字段输入「**1**」。
    ===
        image: /images/gateway/modbus-connector/examples/connector-configuration-3.png,
        title: 记得点击「**应用**」按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=attributeUpdates %}

现在可以检查属性更新是否生效。进入「**实体**」→「**设备**」→ 选择已创建的设备 →「**属性**」选项卡 → 选择「**共享属性**」→ 点击「**+**」图标并添加 `relay` 属性，类型设为「**布尔**」、值设为「**True**」。

{% assign attributeUpdates2 = '
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-4.png,
    ===
        image: /images/gateway/opc-ua-connector/examples/attribute-updates-relative-path-5.png,
'
%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=attributeUpdates2 %}

现在检查继电器寄存器的值。在所选设备中进入「**最新遥测**」选项卡，查看 `relay` 遥测的值。应为 `true`，因为我们已将共享属性设为 `true`。

![image](/images/gateway/modbus-connector/examples/result-device-overview-1.png)

尝试将 `relay` 共享属性的值改为 `false`。几秒后，`relay` 遥测值应变为 `false`，说明属性更新工作正常。

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
        "attributeUpdates": [
          {
            "tag": "relay",
            "type": "bits",
            "address": 1,
            "objectsCount": 1,
            "functionCode": 5,
            "bitTargetType": "bool"
          }
        ],
        "rpc": []
      }
    ]
  }
}
```
