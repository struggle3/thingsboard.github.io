
* TOC
{:toc}

## 简介

本文介绍单体架构，包括高层架构图、各组件间的数据流说明及部分架构选型说明。

请注意，自 ThingsBoard v2.2 起，平台支持 [**微服务**](/docs/{{docsPrefix}}reference/msa/) 部署模式。
尽管微服务更适合高可用、可水平扩展的场景，不少 ThingsBoard 用户仍倾向于先以单实例起步，后续再扩展。

我们也推荐在开发与原型验证阶段使用单体模式。

在单体模式下，所有 ThingsBoard 组件运行于同一 Java 虚拟机 (JVM) 中，共享同一操作系统资源。
由于 ThingsBoard 采用 Java 编写，单体架构的明显优势是可最小化运行 ThingsBoard 所需内存。
在资源受限环境中，可用 256 或 512 MB RAM 启动并运行 ThingsBoard 进程。
明显劣势是，若某个组件（如 MQTT 传输）负载过高，可能影响其他组件。
例如，若 ThingsBoard 进程的 OS 文件描述符上限为 4096，则无法并行打开超过 4096 个 MQTT 会话及 WebSocket 用户会话。

## 架构图

 <object width="80%" data="/images/reference/mono-architecture.svg"></object>

## 传输组件

ThingsBoard 提供基于 MQTT、HTTP 和 CoAP 的 API，供设备应用或固件使用。
各协议 API 由独立的服务器组件提供，属于 ThingsBoard“传输层”。
完整组件列表及对应文档页如下：

* HTTP 传输组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/http-api/)
* MQTT 传输组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/mqtt-api/)，
  并启用网关 API，见[此处](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)；
* CoAP 传输组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/coap-api/)；
* LwM2M 传输组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/lwm2m-api/)。

各传输组件将数据推送给 Rule Engine，并可能调用核心服务向数据库发起请求，以校验设备凭据等。

由于 ThingsBoard 在传输层与核心服务之间采用非常简单的通信协议，
实现自定义传输协议支持（如纯 TCP 上的 CSV、UDP 上的二进制负载等）较为容易。
建议查看现有传输 [实现](https://github.com/thingsboard/thingsboard/tree/master/common/transport/mqtt) 入手，或 [联系我们](/docs/contact-us/) 获取帮助。

## Rule Engine 组件

ThingsBoard Rule Engine 负责按用户定义的逻辑和流程处理到达的消息。
更多信息请参见对应 [文档页](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。

## 核心服务

核心服务负责处理：

 * [REST API](/docs/{{docsPrefix}}reference/rest-api/) 调用；
 * 实体遥测与属性变更的 WebSocket [订阅](/docs/{{docsPrefix}}user-guide/telemetry/#websocket-api)；
 * 设备 [连接状态](/docs/{{docsPrefix}}user-guide/device-connectivity-status/)（活跃/非活跃）监控。

ThingsBoard 节点使用 Actor System 实现租户、设备、Rule Chain 与 Rule Node Actor。
平台节点可加入集群，各节点地位平等。服务发现通过 Zookeeper 完成。
ThingsBoard 节点之间使用基于实体 ID 的 consistent hashing 算法路由消息。
因此，同一实体的消息在同一 ThingsBoard 节点上处理。平台使用 [gRPC](https://grpc.io/) 在 ThingsBoard 节点间发送消息。

**注意**：ThingsBoard 作者计划在未来版本中使用 Kafka 替代 gRPC 进行节点间消息交换。
主要考虑是在性能与延迟上做出小幅牺牲，换取 Kafka consumer groups 带来的持久可靠投递与自动负载均衡。

## 外部系统

可通过 Rule Engine 将消息从 ThingsBoard 推送到外部系统。
可将数据推送到外部系统、进行处理，并将处理结果回传至 ThingsBoard 进行可视化。
详见 Rule Engine 文档与指南。
