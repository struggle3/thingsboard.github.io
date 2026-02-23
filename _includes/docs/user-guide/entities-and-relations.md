* TOC
{:toc}

## 实体概览

ThingsBoard 提供界面和 REST API，用于在 IoT 应用中配置、管理多种实体类型及其关系。
支持的实体包括：

 - **[Tenants](/docs/{{docsPrefix}}user-guide/ui/tenants/)** — 可将 tenant 视为独立的业务实体：拥有或生产设备与资产的个人或组织；tenant 可有多个 tenant administrator 用户及大量 customers、devices 和 assets；
 - **[Customers](/docs/{{docsPrefix}}user-guide/ui/customers/)** — customer 也是独立业务实体：购买或使用 tenant 设备/资产的个人或组织；customer 可有多个用户及大量设备/资产；
 - **[Users](/docs/{{docsPrefix}}user-guide/ui/users/)** — 用户可浏览 dashboard 并管理实体；
 - **[Devices](/docs/{{docsPrefix}}user-guide/ui/devices/)** — 基础 IoT 实体，可上报 telemetry 并处理 RPC 命令，例如传感器、执行器、开关；
 - **[Assets](/docs/{{docsPrefix}}user-guide/ui/assets/)** — 抽象 IoT 实体，可与其他设备或资产建立关系，如工厂、田地、车辆；
 - **[Entity Views](/docs/{{docsPrefix}}user-guide/entity-views/)** — 用于仅向 customer 共享部分设备或资产数据；
 - **[Alarms](/docs/{{docsPrefix}}user-guide/alarms/)** — 标识资产、设备或其他实体异常的事件；
 - **[Dashboards](/docs/{{docsPrefix}}user-guide/dashboards/)** — IoT 数据的可视化及通过界面控制特定设备；
 - **Rule Node** — 处理消息、实体生命周期事件等的处理单元；
 - **Rule Chain** — 定义 [Rule Engine](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 中的处理流程，可包含多个 rule 节点及与其他 rule chain 的链接；

每个实体支持：

 - **[Attributes](/docs/{{docsPrefix}}user-guide/attributes/)** — 与实体关联的静态或半静态 key-value 对，如序列号、型号、固件版本；
 - **[Time-series data](/docs/{{docsPrefix}}user-guide/telemetry/)** — 可存储、查询和可视化时间序列数据点，如温度、湿度、电量；
 - **[Relations](#relations)** — 指向其他实体的有向连接，如 contains、manages、owns、produces。

部分实体支持 profile：

  - **[Tenant Profiles](/docs/{{docsPrefix}}user-guide/tenant-profiles/)** — 包含多个 tenant 的通用设置：实体、API 和限速等。每个 Tenant 在任一时刻仅有一个 profile。
  - **[Device Profiles](/docs/{{docsPrefix}}user-guide/device-profiles/)** — 包含多个设备的通用设置：处理与传输配置等。每个 Device 在任一时刻仅有一个 profile。
  - **[Asset Profiles](/docs/{{docsPrefix}}user-guide/asset-profiles/)** — 包含多个资产的通用设置：处理配置等。每个 Asset 在任一时刻仅有一个 profile。

{% if docsPrefix == "pe/" %}
**[Entity Groups](/docs/pe/user-guide/groups/)**：

ThingsBoard Professional Edition 支持为 Customers、Users、Devices、Assets、Entity Views 和 Dashboards 配置 Entity Groups。
每个实体可同时属于多个 group。Entity Group 始终有所有者 — 特定 Tenant 或 Customer。
group 内所有实体必须为相同实体类型（例如不能将 device 和 asset 放入同一 group）。
Entity Groups 可用于 dashboards 和数据处理，其存在的主要原因是支持 IoT 的高级基于角色的访问控制（[RBAC](/docs/pe/user-guide/rbac/)）。

**[Integrations](/docs/user-guide/integrations/)** 和 **[Data Converters](/docs/user-guide/integrations/#data-converters)**：

ThingsBoard Platform Integrations 功能面向两类主要使用场景 / 部署方式：

  - 将采用特定 payload 格式的现有 NB IoT、LoRaWAN、SigFox 等设备直接接入 ThingsBoard 平台。
  - 从已接入现有IoT平台的设备流式传输数据，以支持实时交互式 dashboard 和高效数据处理。

Data Converters 是 Platform Integrations 功能的一部分，用于将设备的原始 payload 转换为 ThingsBoard 使用的格式，反之亦然。

{% endif %}

本文档概述上述功能，提供获取更多详情的链接及实际使用示例。

## Relations

Entity relation 定义同一 [Tenant](/docs/{{docsPrefix}}user-guide/ui/tenants/) 下两个 ThingsBoard 实体之间的连接。
关系类型可自定义，如 Contains、Manages、Supports 等，且为有向关系。
可将 ThingsBoard 的 relations 理解为面向对象中的 [Has-a](https://en.wikipedia.org/wiki/Has-a) 关系。

Relations 用于在 ThingsBoard 中建模物理世界对象。以下示例便于理解。
假设要构建应用：从土壤湿度和温度传感器采集数据，在 dashboard 上展示，检测问题、触发告警并控制灌溉。
再假设需支持多个地块，每块有数百个传感器，地块可进一步按地理区域分组。

下图说明这些实体如何在 ThingsBoard 中配置和存储：

![image](/images/user-guide/entities-and-relations.svg)


参见["添加和删除资产"](/docs/pe/user-guide/ui/assets/#add-and-delete-assets)与["管理资产关系"](/docs/pe/user-guide/ui/assets/#manage-asset-relations)，了解如何通过管理界面配置实体。也可使用 [REST API](/docs/reference/rest-client/) 以编程方式创建实体和 relations。

## 下一步

**为资产与设备分配属性**

ThingsBoard 支持为实体分配并管理属性，可在此了解：
<p><a href="/docs/{{docsPrefix}}user-guide/attributes" class="button">设备属性管理</a></p>


**从设备上报 telemetry 数据**

ThingsBoard 支持处理设备及其他实体的 telemetry 数据，可在此了解：
<p><a href="/docs/{{docsPrefix}}user-guide/telemetry" class="button">Telemetry 数据管理</a></p>

**创建告警规则**

ThingsBoard 支持通过 Rule Engine 为设备等实体创建告警，可在此了解：
<p><a href="/docs/{{docsPrefix}}user-guide/alarms" class="button">告警管理</a></p>

**设计你的 dashboard**

请[导入](/docs/{{docsPrefix}}user-guide/ui/dashboards/#dashboard-import)以下[**dashboard**](/docs/{{docsPrefix}}user-guide/resources/region_fields_dashboard.json)，其中演示了 Map、Alarm、Entity Table 和 Charts 部件。
