以下示例使用 ThingsBoard Modbus 演示服务器，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 5021:5021 thingsboard/tb-gw-modbus-server:latest
```
{:.copy-code}

服务器地址为 `0.0.0.0:5021`，结构如下：

| 变量名       | 寄存器类型 | 数据类型 | 地址   |
|:-------------|:-----------|----------|:-------|
| Temperature  | Holding    | 16int    | 0      |
| Humidity     | Holding    | 16int    | 1      |
| Power        | Holding    | 16int    | 2      |
| Pressure     | Holding    | 16int    | 3      |
| Relay        | Coil       | bits     | 1      |
| -------------- | --------------- | ---------- | ---------- |

使用 Modbus 设备时，常需将寄存器读到的数值乘以某个系数才能得到正确值。例如，若寄存器中功率为 `2534`，而实际需要 `253400` 瓦，则需乘以 100。
在设备配置中，可在属性和遥测设置里使用“**乘数**”字段实现。按以下步骤配置带乘数的寄存器读取：

{% assign multiplierInAttributesAndTimeseries = '
    ===
        image: /images/gateway/modbus-connector/examples/select-created-gateway.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/modbus-connector/examples/select-connector-configuration.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/modbus-connector/examples/select-device-configuration.png,
        title: 选择已创建的 Modbus 连接器并点击“**主站连接**”标签。请确保已配置并连接设备（若不清楚如何操作，可参阅[入门指南](/docs/iot-gateway/getting-started/?connectorsCreation=modbus){:target="_blank"}或本指南中的[连接设置](/docs/iot-gateway/config/modbus/#connection-settings)和[数据映射](/docs/iot-gateway/config/modbus/#data-mapping)）。点击要配置属性更新的设备旁的“**铅笔**”图标。
    ===
        image: /images/gateway/modbus-connector/examples/reading-attributes-and-time-series-1.png,
        title: 向下滚动至“**属性**或**时序数据**”部分，点击“**铅笔**”图标编辑属性和遥测。
    ===
        image: /images/gateway/modbus-connector/examples/multiplier-attributes-and-time-series-1.png,
        title: 点击“**添加属性**”或“**添加遥测**”按钮。此处添加 `power` 时序数据，故在“**键**”中填 `power`，将“**类型**”选为 **16int**，“**功能码**”选为“**03 - 读保持寄存器**”，“**地址**”填 `2`，启用“**修改器**”，将“**类型**”选为“**乘数**”，“**值**”填 `10`。
    ===
        image: /images/gateway/modbus-connector/examples/multiplier-attributes-and-time-series-2.png,
        title: 记得点击“**应用**”按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=multiplierInAttributesAndTimeseries %}

可以检查带乘数的遥测是否生效。依次进入“**实体**”→“**设备**”→选择已创建设备→“**最新遥测**”标签，查看 `power` 遥测值。

![image](/images/gateway/modbus-connector/examples/multiplier-attributes-and-time-series-3.png)

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
            "tag": "power",
            "type": "16int",
            "address": 2,
            "objectsCount": 1,
            "functionCode": 3,
            "multiplier": 10
          }
        ],
        "attributeUpdates": [],
        "rpc": []
      }
    ]
  }
}
```
