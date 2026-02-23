* TOC
{:toc}

TBMQ HTTP 集成提供了一种通过 HTTP 协议将设备 MQTT 消息转发至外部系统的简便方式。
它作为 TBMQ 与外部应用之间的**桥梁**，确保数据交换顺畅可靠。

## 数据流概述

TBMQ HTTP 集成支持将 MQTT 消息转发至外部 HTTP 服务：

1. **设备（客户端）发布 MQTT 消息**到匹配集成**主题过滤器**的主题。
2. **TBMQ 代理接收消息**并转发至 TBMQ Integration Executor。
3. **TBMQ Integration Executor 处理消息**，将其格式化为 HTTP 请求并转发至外部服务。
4. **外部服务接收请求**并相应处理数据。

![image](/images/mqtt-broker/integrations/tbmq-http-integration.png)

## 前置条件

设置集成前，请确保：

- 有正在运行的 **[TBMQ](/docs/{{docsPrefix}}mqtt-broker/install/installation-options/)** 实例。
- 有可接收 HTTP 请求的外部服务（如 **[ThingsBoard Cloud](/docs/paas/getting-started-guides/what-is-thingsboard-cloud/)**）。
- 有可发布 MQTT 消息的客户端（如 **[TBMQ WebSocket Client](/docs/{{docsPrefix}}mqtt-broker/user-guide/ui/websocket-client/)**）。

## 创建 ThingsBoard 集成

本教程以 **ThingsBoard** 作为接收 TBMQ HTTP 请求的外部服务，也可使用其他兼容 HTTP 的服务。

按照官方 **[ThingsBoard HTTP 集成指南](/docs/paas/user-guide/integrations/http/)** 在 ThingsBoard Cloud 上创建集成。

创建 HTTP 集成后：

1. 打开**详情页**并启用**调试模式**以验证数据接收。
2. **复制 HTTP 端点 URL**，下一步将用到。

{% include images-gallery.html imageCollection="tb-endpoint-url" %}

## 创建 TBMQ HTTP 集成

1. 进入**集成**页面，点击 “+” 创建新集成。
2. 选择 **HTTP** 作为集成类型，点击**下一步**。
3. 在**主题过滤器**页面点击**下一步**，订阅默认主题 `tbmq/#`。
4. 在**配置**步骤，粘贴 ThingsBoard 集成的**端点 URL**。
5. 打开**高级设置**，将**负载内容类型**设为 `JSON`。
6. 点击**添加**保存集成。

{% include images-gallery.html imageCollection="add-http-integration" %}

> 可使用“检查连接”按钮发送 HEAD 请求测试与已配置 HTTP 端点的连通性。

### Topic Filters

{% include templates/mqtt-broker/user-guide/integrations/topic-filters.md %}

### 配置

|**字段**|**描述**|
|:-|:-|-
| **仅发送消息负载** | 启用时，传入消息的负载按原样转发。禁用时，发送包含负载及其他属性的 JSON 对象。 |
| **端点 URL** | 发送 HTTP 请求的外部服务 URL。 |
| **请求方法** | 定义请求方式。支持：`GET`、`POST`、`PUT`、`DELETE`。 |
| **凭证** | 支持的认证选项： |
| | **匿名** – 无需认证。 |
| | **基本认证** – 使用 `用户名` 和 `密码` 认证。 |
| | **PEM 认证** – 使用 PEM 证书认证。 |
| **Headers** | 添加到 HTTP 请求头的键值对集合。 |
| **负载内容类型** | 定义请求体格式。支持：`JSON`、`Text`、`Binary (Base64)`。 |
| **解析失败时按二进制发送** | 启用时，`JSON` 或 `Text` 解析失败的消息将作为二进制负载发送。禁用时，失败消息不会发送。 |
| **读取超时** | 请求在超时前等待响应的最长时间。 |
| **最大并行请求数** | 限制并发 HTTP 请求数。 |
| **最大响应大小** | 定义允许的传入响应最大大小。 |
| **Metadata** | 可用于额外处理的自定义元数据。 |
|---

### 事件

{% include templates/mqtt-broker/user-guide/integrations/events.md %}

## 发送上行消息

发送消息请按以下步骤：

1. 进入**WebSocket Client**页面。
2. 选择“WebSocket Default Connection”或其他可用连接，点击**连接**。确保“连接状态”显示为 `Connected`。
3. 将“主题”字段设为 `tbmq/http-integration`，以匹配集成的主题过滤器 `tbmq/#`。
4. 点击**发送**图标发布消息。
5. 成功后，消息应出现在“消息”表中。

{% include images-gallery.html imageCollection="send-uplink-message" %}

消息发布后：

1. 在 **ThingsBoard Cloud** 中打开 HTTP 集成详情。
2. 进入**事件**标签页。
3. 若配置正确，应看到状态为 **'OK'** 的事件及类似如下的消息负载：

```json
{
    "payload": {
        "temperature": 25
    },
    "topicName": "tbmq/http-integration",
    "clientId": "tbmq_7QUvZzow",
    "eventType": "PUBLISH_MSG",
    "qos": 1,
    "retain": false,
    "tbmqIeNode": "tbmq_ie_node",
    "tbmqNode": "tbmq_node",
    "ts": 1742553324248,
    "props": {},
    "metadata": {
        "integrationName": "HTTP integration"
    }
}
```

消息说明：

- **payload**：MQTT 消息内容。
- **topicName**：发布消息的 MQTT 主题。
- **clientId**：发布消息的 MQTT 客户端 ID。
- **eventType**：MQTT 事件类型，此处为已发布消息（当前唯一支持的类型）。
- **qos**：传入消息使用的服务质量等级。
- **retain**：表示消息是否为保留 MQTT 消息。
- **tbmqIeNode**：处理消息的 Integration Executor 服务节点 ID。
- **tbmqNode**：接收消息的 TBMQ 代理节点 ID。
- **ts**：接收消息时的时间戳（毫秒）。
- **props**：MQTT 5.0 用户属性或其他 MQTT 属性。
- **metadata**：从集成配置添加的额外元数据，默认包含处理消息的集成名称。

{% include images-gallery.html imageCollection="http-integration-result" %}
