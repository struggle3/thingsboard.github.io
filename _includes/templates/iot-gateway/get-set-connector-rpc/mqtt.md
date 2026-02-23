### GET 方法

使用 GET 方法可订阅 MQTT topic 并接收消息。

```bash
get requestTopicExpression=<requestTopicExpression>;responseTopicExpression=<responseTopicExpression>;value=<value>;
```
{: .copy-code}

其中：
- `<requestTopicExpression>` - 发布请求的 topic；
- `<responseTopicExpression>` - 订阅响应的 topic；
- `<value>` - 要发送的值。

例如，本示例中可从 MQTT topic **"data/light_level"** 读取房间光照度值，并需订阅 **"data/response"** topic 接收响应。
要读取房间光照度值，请运行以下查询：

```bash
get requestTopicExpression=data/get_light_level;responseTopicExpression=data/response;value=${params};
```
{: .copy-code}

下面查看从 MQTT topic **"data/response"** 接收到的数据：

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/mqtt-get-set-rpc-1.png)
{: refdef}


### SET 方法

使用 SET 方法可向 MQTT topic 发布消息。

```bash
set requestTopicExpression=data/set_light_level;value=${params};
```
{: .copy-code}

其中：
- `<requestTopicExpression>` - 发布请求的 topic；
- `<value>` - 要发送的值。

例如，本示例中可将房间光照度值写入 MQTT topic **"data/light_level"**。
要设置房间光照度值，请运行以下查询：

```bash
set requestTopicExpression=data/set_light_level;value=80;
```
{: .copy-code}

下方截图中可见已成功向 MQTT topic **"data/set_light_level"** 发送 SET 请求：

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/mqtt-get-set-rpc-2.png)
{: refdef}

通过发送双向 GET RPC 请求，查看 SET 方法在 **"data/light_level"** MQTT topic 中的结果。
要读取房间光照度值以确认已更新，请运行以下查询：

```bash
get requestTopicExpression=data/get_light_level;responseTopicExpression=data/response;value=${params};
```
{: .copy-code}

下方截图中可见 SET 请求后房间光照度值已更新为 80：

{:refdef: style="text-align: left;"}
![image](/images/gateway/get-set-connector-rpc/mqtt-get-set-rpc-3.png)
{: refdef}
