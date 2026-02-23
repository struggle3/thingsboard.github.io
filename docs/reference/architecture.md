---
layout: docwithnav
title: ThingsBoard 架构
description: ThingsBoard 物联网平台架构
redirect_from: "/docs/user-guide/rule-engine-2-0/architecture/"

---

* TOC
{:toc}

ThingsBoard 被设计为将工作负载分布到多个节点，且无单点故障。
每个 ThingsBoard 节点都相同，可处理来自设备和服务器端应用的请求。
 
## 高层概览

 ![image](/images/reference/architecture-in-brief.svg)

#### 设备连接

ThingsBoard 支持 [**MQTT**](/docs/reference/mqtt-api/)、[**LwM2M**](/docs/reference/lwm2m-api/)、[**CoAP**](/docs/reference/coap-api/) 和 [**HTTP**](/docs/reference/http-api/) 作为设备连接协议。
可插件化支持不同协议或自定义现有实现。

#### Rule Engine

ThingsBoard [Rule Engine](/docs/user-guide/rule-engine/) 用于处理来自设备的消息并触发可配置的处理模块（Plugins）。

#### 核心服务

ThingsBoard 包含一套核心服务，可管理以下实体：

 * 设备及其凭据
 * Rule Chain 与 Rule Node
 * 租户与客户
 * 部件与 Dashboard
 * 告警与事件
 
规则可以调用这些 API 的特定子集。例如，规则可为某设备创建告警。

#### 服务端 API 网关

每个 ThingsBoard 服务器为注册用户提供 REST API。
System Telemetry 服务可通过 WebSocket 和 REST API 管理属性和获取时序数据。
System RPC 服务提供 REST API 向设备下发自定义命令。
更多 ThingsBoard REST API 信息请参见[此处](/docs/reference/rest-api/)。

## Actor 模型

[Actor model](https://en.wikipedia.org/wiki/Actor_model) 支持高并发处理来自设备的消息以及服务端 API 调用。
ThingsBoard 使用自研 Actor System 实现（针对使用场景优化），具有以下 Actor 层级：

 ![image](/images/reference/actor-system-hierarchies.svg)

各 Actor 功能简述如下：

 * **App Actor** - 负责管理租户 Actor。
 该 Actor 实例始终常驻内存。
 * **Tenant Actor** - 负责管理租户设备及 Rule Chain Actor。
 该 Actor 实例始终常驻内存。
 * **Device Actor** - 维护设备状态：活跃会话、订阅、待处理 RPC 命令等。
 出于性能考虑在内存中缓存当前设备属性。
 当处理到来自设备的首条消息时创建 Actor；当一定时间内无设备消息时停止该 Actor。
 * **Rule Chain Actor** - 处理收到的消息并分发给 Rule Node Actor。
 该 Actor 实例始终常驻内存。
 * **Rule Node Actor** - 处理收到的消息，并将结果回报给 Rule Chain Actor。
 该 Actor 实例始终常驻内存。
 
## 集群模式

###### Service Discovery

ThingsBoard 使用 Zookeeper 进行服务发现。
所有 ThingsBoard 节点相同，并在 Zookeeper 中注册为临时节点。使用 Apache Curator [path cache receipt](http://curator.apache.org/curator-recipes/path-cache.html) 跟踪所有可用兄弟节点。

###### Consistent Hashing

ThingsBoard 采用 [consistent hashing](https://en.wikipedia.org/wiki/Consistent_hashing) 来保证可扩展性与高可用。
设备 A 在某节点收到的消息可能根据设备 ID 的哈希被转发到其他节点。
尽管这会带来一定网络开销，但能确保同一设备的所有消息在特定服务器上由对应的 Device Actor 处理，具有以下优势：

 * 提高缓存命中率。设备属性和其它设备相关数据由特定服务器上的 Device Actor 获取。
 * 避免竞态条件。特定设备的所有消息在确定的服务器上处理。
 * 可根据设备 ID 将服务端 API 调用路由到目标服务器。
   
下图演示 ThingsBoard 如何处理发往设备 D1 的 RPC 请求。
在此场景中，请求到达服务器 A，而 D1 通过 MQTT 连接到服务器 C。
在最坏情况下，D1 的 Device Actor 可能位于另一台服务器 B 上，与 A 和 C 都不一致。

 ![image](/images/reference/cluster-mode-rpc-request.svg)

## 安全

### 传输加密

作为系统管理员，可配置 ThingsBoard 在 HTTP(s) 和 MQTT 传输上使用安全套接层。
CoAP 的 DTLS 尚未支持。

### 设备认证

ThingsBoard 设计为支持多种设备凭据类型。
当前版本为所有 [协议](/docs/reference/protocols/) 提供基于 Token 的凭据支持，
并为 MQTT 协议提供基于 X.509 证书的凭据支持。详见 [MQTT over SSL](/docs/user-guide/mqtt-over-ssl/) 指南。

## 第三方工具

ThingsBoard 使用以下主要第三方项目：
 
 * Zookeeper - 用于服务协调
 * Cassandra - 作为可扩展且可靠的数据库
 * Kafka（或 RabbitMQ、AWS SQS、Azure Event Hub、Google PubSub）- 作为可扩展消息队列

