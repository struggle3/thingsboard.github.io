## 保留 RPC 方法

`GET` 和 `SET` RPC 方法为开箱即用，无需手动配置。

假设有设备 `SN-001` 监测室内光照，并通过 MQTT 网关连接至 ThingsBoard。
我们需发送 RPC 命令获取当前光照状态，有两种情况：一种需要响应，另一种不需要响应。此外，还需通过发送命令更新室内光照，且不期望响应。

以下示例使用 ThingsBoard MQTT 演示代理，可通过 Docker 及以下命令运行：

```bash
docker run -it -p 1884:1884 thingsboard/tb-gw-mqtt-broker:latest
```
{:.copy-code}

代理运行于 `0.0.0.0:1884`，模拟的设备在主题 `data/get_light_level` 上监听获取当前光照，并在主题 `data/response` 上回复。
该设备还在主题 `data/set_light_level` 上监听以更新光照值。

{% capture difference %}
**请注意：**
RPC 调试终端仅用于示例，您可使用任何支持 RPC 调用的其他部件。
自定义 MQTT 发布器仅用于模拟设备行为，不适用于实际生产场景。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 示例 1：获取当前光照（双向 RPC 带响应）

在 RPC 调试终端部件中执行以下命令发送双向 RPC 请求：

```bash
get requestTopicExpression=data/get_light_level;responseTopicExpression=data/response;value=${params};
```
{: .copy-code}

网关将：
1. 接收该 RPC 请求
2. 处理内置 "get" 方法
3. 向主题 `data/get_light_level` 发送带指定参数的消息
4. 订阅主题 `data/response` 等待响应
5. 收到响应后返回给 ThingsBoard

![image](/images/gateway/mqtt-connector/examples/result-device-overview-reserved-rpc-1.png)

### 示例 2：获取当前光照（单向 RPC 无响应）

在 RPC 调试终端部件中执行以下命令发送单向 RPC 请求：

```bash
get requestTopicExpression=data/get_light_level;value=${params};
```
{: .copy-code}

网关将：
1. 接收该 RPC 请求
2. 处理内置 "get" 方法
3. 向主题 `data/get_light_level` 发送带指定参数的消息
4. 因未指定响应主题而不等待响应

![image](/images/gateway/mqtt-connector/examples/result-device-overview-reserved-rpc-2.png)

### 示例 3：SET 新光照（单向 RPC）

在 RPC 调试终端部件中执行以下命令设置新的光照值：

```bash
set requestTopicExpression=data/set_light_level;value=90;
```
{: .copy-code}

网关将：
1. 接收该 RPC 请求
2. 处理内置 "set" 方法
3. 向主题 `data/set_light_level` 发送值 "90"
4. 因未指定响应主题而不等待响应

![image](/images/gateway/mqtt-connector/examples/result-device-overview-reserved-rpc-3.png)

### 示例 4：检查更新后的光照（双向 RPC 带响应）

设置新光照后，可执行以下命令验证更新值：

```bash
get requestTopicExpression=data/get_light_level;responseTopicExpression=data/response;value=${params};
```
{: .copy-code}

网关将按示例 1 处理该请求，响应中应能看到更新后的光照值。

![image](/images/gateway/mqtt-connector/examples/result-device-overview-reserved-rpc-4.png)

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
    "serverSideRpc": []
  }
}
```
{:.copy-code.expandable-15}
