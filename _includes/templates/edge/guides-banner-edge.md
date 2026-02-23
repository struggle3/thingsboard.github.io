{% if currentGuide != "GettingStartedGuide" %}
- [Getting started guide](/docs/{{docsPrefix}}getting-started/)（入门指南）- 快速概览 ThingsBoard Edge 主要功能。预计 15–30 分钟完成：
{% endif %}
{% if currentGuide != "InstallationGuides" %}
- [Installation guides](/docs/user-guide/install/{{docsPrefix}}installation-options/)（安装指南）- 了解如何在各种操作系统上安装 ThingsBoard Edge 并连接到 ThingsBoard Server。
{% endif %}
- Edge 规则引擎：
{% if currentGuide != "RuleChainTemplates" %}
  - [Rule Chain Templates](/docs/{{docsPrefix}}rule-engine/rule-chain-templates/)（规则链模板）- 了解如何使用 ThingsBoard Edge 规则链模板。
{% endif %}
{% if currentGuide != "ProvisionRuleChainFromCloudToEdge" %}
  - [Provision Rule Chains from cloud to edge](/docs/{{docsPrefix}}rule-engine/provision-rule-chains/)（从云端向 Edge 下发规则链）- 了解如何从云端向 Edge 下发边缘规则链。
{% endif %}
{% if currentGuide != "GrpcOverSsl" %}
- 安全：
  - [gRPC over SSL/TLS](/docs/{{docsPrefix}}user-guide/grpc-over-ssl/) - 了解如何为 Edge 与云端之间的通信配置 gRPC over SSL/TLS。
{% endif %}
- 功能：
{% if currentGuide != "EdgeStatus" %}
  - [Edge Status](/docs/{{docsPrefix}}features/edge-status/)（Edge 状态）- 了解 ThingsBoard Edge 上的 Edge Status 页面。
{% endif %}
{% if currentGuide != "CloudEvents" %}
  - [Cloud Events](/docs/{{docsPrefix}}features/cloud-events/)（云端事件）- 了解 ThingsBoard Edge 上的 Cloud Events 页面。
{% endif %}    
- 使用场景：
{% if currentGuide != "ManageAlarmsAndRpcRequestsOnEdgeDevices" %}
  - [Manage alarms and RPC requests on edge devices](/docs/{{docsPrefix}}use-cases/manage-alarms-rpc-requests/)（在边缘设备上管理告警和 RPC 请求）- 本指南展示如何在 Edge 上生成本地告警并向连接到 Edge 的设备发送 RPC 请求：
{% endif %}
{% if currentGuide != "DataFilteringAndTrafficReduce" %}
  - [Data filtering and traffic reduce](/docs/{{docsPrefix}}use-cases/data-filtering-traffic-reduce/)（数据过滤与流量削减）- 本指南展示如何从 Edge 向云端仅发送过滤后的设备数据：
{% endif %}
{% if currentGuide != "EdgeRoadmap" %}
- [Roadmap](/docs/{{docsPrefix}}roadmap)（路线图）- ThingsBoard Edge 路线图。
{% endif %}
