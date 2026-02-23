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

此处关注寄存器 `1`，用于表示继电器状态（关/开）。
要读取该寄存器，需在设备配置中将其作为属性/遥测添加。按以下步骤操作：

{% assign readingAttributeAndTimeseries = '
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
        image: /images/gateway/modbus-connector/examples/reading-attributes-and-time-series-2.png,
        title: 点击“**添加属性**”或“**添加遥测**”按钮。此处添加 `relay` 时序数据，故在“**键**”中填 `relay`，将“**类型**”选为 **bits**，“**功能码**”选为“**01 - 读线圈**”，“**位目标类型**”选为“**布尔**”，“**地址**”填 `1`。该地址为要读取的 Modbus 寄存器。
    ===
        image: /images/gateway/modbus-connector/examples/reading-attributes-and-time-series-3.png,
        title: 记得点击“**应用**”按钮保存更改。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=readingAttributeAndTimeseries %}

可以检查属性/遥测是否生效。依次进入“**实体**”→“**设备**”→选择已创建设备→“**最新遥测**”标签，查看 `relay` 遥测值。默认继电器为关，应为 `false`。

![image](/images/gateway/modbus-connector/examples/reading-attributes-and-time-series-4.png)

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
        "attributeUpdates": [],
        "rpc": []
      }
    ]
  }
}
```
