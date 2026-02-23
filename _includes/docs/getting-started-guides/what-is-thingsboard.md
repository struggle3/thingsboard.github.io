
ThingsBoard 是一款开源IoT平台可助力IoT项目快速开发、管理和扩展；
我们的目标是为您的IoT应用提供开箱即用的云端或本地方案，构建服务端基础设施。

## 功能特性

ThingsBoard帮您实现：

 - 创建设备、资产和客户，并定义它们之间的关系。
 - 采集并可视化来自设备和资产的数据。
 - 通过复杂事件处理分析传入遥测并触发告警。
 - 使用远程过程调用（RPC）控制设备。
 - 基于设备生命周期事件、REST API 事件、RPC 请求等构建工作流。
 - 设计动态响应式仪表盘，向客户展示设备或资产遥测与洞察。
 - 通过可定制规则链启用场景专用功能。
 - 将设备数据推送到其他系统。
 - 更多功能...
 
了解更多功能请参阅[**ThingsBoard功能列表**](/docs/{{docsPrefix}}#features)。

{% if docsPrefix == 'pe/' %}
<object width="100%" data="/images/reference/thingsboard-architecture-pe.svg"></object>
{% elsif docsPrefix == 'paas/' %}
<object width="100%" data="/images/reference/thingsboard-architecture-paas.svg"></object>
{% elsif docsPrefix == 'paas/eu/' %}
<object width="100%" data="/images/reference/thingsboard-architecture-paas-eu.svg"></object>
{% else %}
<object width="100%" data="/images/reference/thingsboard-architecture.svg"></object>
{% endif %}

## 架构

ThingsBoard 设计目标为：

* **可扩展**：采用主流开源技术构建的水平可扩展平台。
* **高容错**：集群中每个节点一致无单点故障。
* **高稳定**：单节点可根据场景处理数万乃至数十万设备，集群可支撑数百万设备。
* **可定制**：通过可定制部件和规则引擎节点轻松扩展新功能。
* **可靠**：数据永不失。

{% unless docsPrefix contains "paas/" %}

更多详情请参阅[**ThingsBoard架构**](/docs/{{docsPrefix}}reference)。

{% endunless %}

## 准备开始？

<p><a href="/docs/{{docsPrefix}}getting-started-guides/helloworld" class="button">Hello World应用</a></p>

{% if (docsPrefix == "pe/") %}
## ThingsBoard作为Google IoT Core替代方案

<p><a href="/google-iot-core-alternative" class="button">了解更多</a></p>

{% endif %}
