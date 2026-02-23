{% include templates/mqtt-broker/pe-tbmq-explore-banner.md %}

**TBMQ {{tbmqSuffix}}** 是一款 {{tbmqDefinition}}<a target="_blank" href="/products/mqtt-broker/">MQTT 消息代理</a>，专为大规模可扩展性和高性能消息路由而设计。
它在单节点部署下可高效处理**数百万**并发客户端连接，并以低延迟实现[每秒数百万条消息](/docs/{{docsPrefix}}mqtt-broker/reference/3m-throughput-single-node-performance-test/)的吞吐。
在集群模式下，TBMQ 的能力进一步扩展，能够支持[大规模 IoT 部署](/docs/{{docsPrefix}}mqtt-broker/reference/100m-connections-performance-test/)，具备卓越的可靠性和吞吐量。

ThingsBoard 在构建可扩展 IoT 应用方面积累了丰富经验，使我们能够识别 MQTT 解决方案中常见的**三种关键模式**：

* **扇入（Fan-in）模式：**
  在此场景中，大量设备产生高消息量，由较少的应用消费。
  这些应用必须可靠地处理所有传入数据流，且不丢失消息。

* **扇出（广播，Fan-out）模式：**
  在此场景中，众多设备订阅特定更新或通知，需高效送达。
  少量传入消息可能产生大量传出更新，形成高输出分发流。

* **点对点（P2P）模式：**
  这是针对性强的一对一通信模型，适用于私信或命令-响应交互等用例。
  消息通过唯一定义的主题在单个发布者与特定订阅者之间直接交换。

基于这些常见模式，我们将 TBMQ 设计为对以上三种模式均能出色支持。
TBMQ 使用 **Java** 开发，依托 **Kafka** 等领先开源技术，提供低延迟消息传递、数据持久化以及平台级水平可扩展性。

## 完整 MQTT 规范支持

TBMQ 完全符合 MQTT 协议，在单节点和集群环境中均对 MQTT 核心功能提供完整支持。
无论您是在构建可扩展的 IoT 解决方案，还是为连接设备提供可靠通信，TBMQ 均满足最新标准，实现无缝互操作性。

### 支持的 MQTT 版本

TBMQ 支持以下 MQTT 版本：

* [MQTT 3.1](https://public.dhe.ibm.com/software/dw/webservices/ws-mqtt/mqtt-v3r1.html)
* [MQTT 3.1.1](https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html)
* [MQTT 5.0](https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html)

我们的实现可在各类用例中提供可靠的性能和兼容性。

## TBMQ 功能

* 所有 MQTT v3.x 功能
* 所有 MQTT v5.0 功能
* 多节点集群支持
* X.509 证书链认证支持
* JWT 认证
* 基于客户端 ID、用户名或 X.509 证书链的访问控制（ACL）
* 客户端会话和订阅的 REST 查询支持
* 消息处理速率限制
* 集群与客户端指标监控
* 未授权客户端
* MQTT WebSocket 客户端
* 与外部系统的集成（HTTP、MQTT、Kafka）
* Kafka 主题和消费者组监控
* Proxy Protocol
* 被阻止的客户端
* MQTT 通道背压支持
{% if docsPrefix == "pe/" %}
* 单点登录（SSO）
* 基于角色的访问控制（RBAC）
* 白标
{% endif %}

## 架构

TBMQ 的设计目标是：

* **可扩展**：平台支持水平扩展，基于领先的开源技术构建；
* **容错**：无单点故障，集群中每个节点相同，确保高可用和容错；
* **健壮高效**：可管理数百万客户端，每秒处理数百万条消息；
* **持久化**：代理确保数据持久化，防止数据丢失。

更多详情请参阅 [**TBMQ 架构**](/docs/{{docsPrefix}}mqtt-broker/architecture)。

## 准备开始？

请按快速入门指南学习基础用法，或直接在我们的公共演示实例上试用 TBMQ——无需安装。

<p><a href="/docs/{{docsPrefix}}mqtt-broker/getting-started/" class="button">Hello World 应用</a> <a target="_blank" href="https://demo.tbmq.io/signup" class="button">试用 TBMQ 实时版</a></p>
