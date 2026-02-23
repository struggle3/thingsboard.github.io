* TOC
{:toc}

{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign cloudDocsPrefix = "pe/" %}
{% else %}
{% assign appPrefix = "ThingsBoard CE" %}
{% endif %}

## 概述

本文提供 ThingsBoard Edge 架构的高层概览，包括架构图、各组件间数据流说明及核心架构选型的解释。

ThingsBoard Edge 各组件在单个 Java 虚拟机（JVM）内启动，共享操作系统资源。
在资源受限环境下，仅需 256 或 512 MB 内存即可部署运行 ThingsBoard Edge 进程。

ThingsBoard Edge 旨在具备以下特性：

* **可扩展**：将计算与数据分析分散到数千个边缘节点。
* **稳定高效**：单个 Edge 可处理最多约 1000 台设备，视[使用场景](/docs/{{docsPrefix}}use-cases/overview/)与硬件而定。
* **可定制**：通过可定制部件和规则引擎节点轻松扩展功能。
* **持久可靠**：Edge 将全部消息和事件写入持久化层；必要时可将指定消息传输至云端。

## 架构图

下图展示 Edge 的核心组件及其提供的接口。

<object width="80%" data="/images/reference/edge-architecture.svg"></object>

## Cloud Manager 服务

ThingsBoard **Edge** 通过 gRPC 协议与云端（{{appPrefix}}）通信，由 **Cloud Manager** 管理该连接。

一方面，Cloud Manager 检查云端队列中的新事件，一旦就绪即推送至云端。

另一方面，它处理来自 {{appPrefix}} 服务器的所有事件并做相应处理。

Cloud Manager 使用自动生成的 **Routing key** 与 **Secret** 配对连接云端实例。

为增强安全，可在 **SSL/TLS** 之上建立 **gRPC** 连接。详见 [gRPC over SSL/TLS](/docs/{{docsPrefix}}user-guide/grpc-over-ssl/) 指南。

## 传输组件

ThingsBoard Edge 提供基于 MQTT、HTTP 和 CoAP 的 API，供设备应用/固件使用。
每种协议 API 由 ThingsBoard Edge「传输层」中的独立组件提供。

ThingsBoard Edge 支持 ThingsBoard CE/PE 标准设备通信协议：

* HTTP Transport 组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/http-api/)；
* MQTT Transport 组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/mqtt-api/)，并支持网关 API，见[此处](/docs/{{docsPrefix}}reference/gateway-mqtt-api/)；
* CoAP Transport 组件提供设备 API，见[此处](/docs/{{docsPrefix}}reference/coap-api/)。

各传输组件将数据推送至规则引擎，部分还可调用核心服务向数据库发起设备凭证校验等请求。

## 规则引擎组件

ThingsBoard Edge 规则引擎负责按用户定义的逻辑与流程处理传入消息。
规则引擎使用 Actor 系统为主要实体（如规则链和规则节点）创建 actor。
ThingsBoard Edge 规则引擎架构与服务器端规则引擎一致，但配置略有不同——Edge 使用规则链模板替代标准规则链。
规则链模板详情请参阅[文档页面](/docs/{{docsPrefix}}rule-engine/rule-chain-templates/)。

## 核心服务

ThingsBoard Edge Core 处理 [REST API](/docs/{{cloudDocsPrefix}}reference/rest-api/) 调用和 WebSocket [订阅](/docs/{{cloudDocsPrefix}}user-guide/telemetry/#websocket-api)。
此外，它还维护活跃设备会话的最新信息，并监控设备[连接状态](/docs/{{cloudDocsPrefix}}user-guide/device-connectivity-status/)。
ThingsBoard Edge Core 使用 Actor 系统为租户、设备等关键实体实现 actor。

## ThingsBoard Edge Web UI

ThingsBoard Edge 内置基于 Express.js 框架的轻量组件，用于托管静态 Web UI。
这些组件完全无状态，所需配置极少。
静态 Web UI 包含应用包；加载后，应用即开始使用 ThingsBoard Edge Core 提供的 REST API 和 WebSockets API。

## 外部系统

ThingsBoard Edge 的消息可通过规则引擎推送至外部系统。
可将数据发送到外部系统进行处理，再将处理结果回传至 ThingsBoard Edge 进行可视化。
更多细节请参阅规则引擎文档与指南。

### 下一步

<p><a href="/docs/edge/getting-started" class="button">快速入门指南</a></p>