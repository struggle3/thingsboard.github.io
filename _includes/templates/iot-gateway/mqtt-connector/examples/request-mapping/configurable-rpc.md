RPC 到设备允许向直接或通过网关连接至 ThingsBoard 的设备发送 RPC 命令。

假设有设备 `SN-001` 监测室内光照，并通过 MQTT 网关连接至 ThingsBoard。
我们需发送 RPC 命令获取当前光照状态，有两种情况：一种需要响应，另一种不需要响应。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

演示代理运行于 `0.0.0.0:1884`，为 RPC 示例模拟设备。对于可配置 RPC，设备在主题 `sensor/${deviceName}/request/${methodName}/${requestId}` 监听入站命令，在需要响应时于主题 `sensor/${deviceName}/response/${methodName}/${requestId}` 回复。

{% capture difference %}
**请注意：**
RPC 调试终端仅用于示例，您可使用任何支持 RPC 调用的其他部件。
自定义 MQTT 发布器仅用于模拟设备行为，不适用于实际生产场景。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

在 MQTT 连接器中配置 RPC 命令，使 ThingsBoard 能向设备发送命令。

按以下步骤操作：

{% assign CustomRPC = '
    ===
        image: /images/gateway/mqtt-connector/examples/device-name-and-profile-message-json-1.png,
        title: 在左侧边栏进入“**实体**”→“**网关**”并选择您的网关。
    ===
        image: /images/gateway/mqtt-connector/examples/disconnect-request-gateway.png,
        title: 点击右侧菜单中的“**连接器配置**”按钮。
    ===
        image: /images/gateway/mqtt-connector/examples/mqtt-gateway-configuring-11-ce.png,
        title: 选择 MQTT 连接器，点击“**基本**”。在“**请求映射**”下点击“**添加映射**”以添加新的 RPC 映射。
    ===
        image: /images/gateway/mqtt-connector/examples/server-side-rpc-commands-1.png,
        title: 在**请求类型**中选择“**RPC 命令**”。双向 RPC（需要响应）时。
    ===
        image: /images/gateway/mqtt-connector/examples/server-side-rpc-commands-2.png,
        title: **设备名过滤器**填 `.*` 以应用于所有设备，**方法过滤器**填 `echo`，**请求主题表达式**填 `sensor/${deviceName}/request/${methodName}/${requestId}`，**值表达式**填 `${params}`，**响应主题表达式**填 `sensor/${deviceName}/response/${methodName}/${requestId}`，**响应超时**设为合适值（如 10000 毫秒）。
    ===
        image: /images/gateway/mqtt-connector/examples/server-side-rpc-commands-3.png,
        title: 记得点击相应按钮保存更改。
    ===
        image: /images/gateway/mqtt-connector/examples/server-side-rpc-commands-4.png,
        title: 单向 RPC（无需响应）时，点击“**无响应**”标签。**设备名过滤器**填 `.*`，**方法过滤器**填 `no-reply`，**请求主题表达式**填 `sensor/${deviceName}/request/${methodName}/${requestId}`，**值表达式**填 `${params}`。
    ===
        image: /images/gateway/mqtt-connector/examples/server-side-rpc-commands-5.png,
        title: 记得点击相应按钮保存更改。
    '
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=CustomRPC %}

下面演示如何使用该 RPC 配置：

### 示例 1：双向 RPC（有响应）

在 RPC 调试终端部件中执行以下命令发送双向 RPC 请求：

```bash
echo {"deviceName":"SN-001", "methodName":"echo"}
```
{: .copy-code}

网关将：
1. 接收该 RPC 请求
2. 匹配到 "echo" 方法配置
3. 向主题 `sensor/SN-001/request/echo/12345` 发送消息（12345 为唯一请求 ID）
4. 订阅主题 `sensor/SN-001/response/echo/12345` 等待响应
5. 收到响应后返回给 ThingsBoard

![image](/images/gateway/mqtt-connector/examples/result-device-overview-rpc-1.png)

### 示例 2：单向 RPC（无响应）

在 RPC 调试终端部件中执行以下命令发送单向 RPC 请求：

```bash
no-reply {"deviceName":"SN-001", "methodName":"no-reply"}
```
{: .copy-code}

网关将：
1. 接收该 RPC 请求
2. 匹配到 "no-reply" 方法配置
3. 向主题 `sensor/SN-001/request/no-reply/12345` 发送消息（12345 为唯一请求 ID）
4. 不等待响应

![image](/images/gateway/mqtt-connector/examples/result-device-overview-rpc-2.png)

若使用高级配置模式，可使用以下配置：

```json
{
  "broker": {
    "host": "127.0.0.1",
    "port": 1884,
    "clientId": "ThingsBoard_gateway",
    "version": 5,
    "maxMessageNumberPerWorker": 10,
    "maxNumberOfWorkers": 100,
    "keepAlive": 60,
    "cleanSession": true,
    "cleanStart": true,
    "sessionExpiryInterval": 0,
    "security": {
      "type": "anonymous"
    }
  },
  "mapping": [
    {
      "topicFilter": "sensor/data",
      "subscriptionQos": 1,
      "converter": {
        "type": "json",
        "deviceInfo": {
          "deviceNameExpressionSource": "message",
          "deviceNameExpression": "${serialNumber}",
          "deviceProfileExpressionSource": "message",
          "deviceProfileExpression": "${sensorType}"
        },
        "timeout": 60000,
        "attributes": [
    
        ],
        "timeseries": [
          {
            "type": "string",
            "key": "temperature",
            "value": "${temp}"
          }
        ]
      }
    }
  ],
  "requestsMapping": {
    "serverSideRpc": [
      {
        "type": "twoWay",
        "deviceNameFilter": ".*",
        "methodFilter": "echo",
        "requestTopicExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
        "responseTopicExpression": "sensor/${deviceName}/response/${methodName}/${requestId}",
        "responseTopicQoS": 1,
        "responseTimeout": 10000,
        "valueExpression": "${params}"
      },
      {
        "type": "oneWay",
        "deviceNameFilter": ".*",
        "methodFilter": "no-reply",
        "requestTopicExpression": "sensor/${deviceName}/request/${methodName}/${requestId}",
        "valueExpression": "${params}"
      }
    ]
  }
}
```
{:.copy-code.expandable-15}
