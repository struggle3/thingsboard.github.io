RPC 到设备允许向直接连接或通过网关连接到 ThingsBoard 的设备发送 RPC 命令。

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

我们希望通过 RPC 到设备从演示设备获取温度值。
要调用此方法，首先需要配置 Modbus 连接器以支持 RPC 调用。请按以下步骤操作：

{% assign rpcToDevice = '
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
        image: /images/gateway/modbus-connector/examples/rpc-to-device-1.png,
        title: 向下滚动到「**RPC 请求**」部分，点击「**铅笔**」图标编辑 RPC 方法。
    ===
        image: /images/gateway/modbus-connector/examples/rpc-to-device-2.png,
        title: 点击「**添加请求**」按钮。在「**方法**」字段填写 `getTemperature`，选择「类型」为「16int」，「**功能码**」为「**03 - 读保持寄存器**」，在「对象数量」字段填写 `1`，在「**地址**」字段输入「**0**」。
    ===
        image: /images/gateway/modbus-connector/examples/rpc-to-device-3.png,
        title: 记得点击「**应用**」按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=rpcToDevice %}

配置已完成，让我们检查如何调用该方法。在 RPC 调试终端部件中运行以下命令：

```bash
getTemperature
```

响应：

![image](/images/gateway/modbus-connector/examples/rpc-to-device-4.png)

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
            "tag": "some_key",
            "type": "16int",
            "address": 0,
            "objectsCount": 1,
            "functionCode": 3
          }
        ],
        "attributeUpdates": [],
        "rpc": [
          {
            "tag": "getTemperature",
            "type": "16int",
            "address": 0,
            "objectsCount": 1,
            "functionCode": 3
          }
        ]
      }
    ]
  }
}
```
