{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign cloudDocsPrefix = "pe/" %}
{% else %}
{% assign appPrefix = "ThingsBoard CE" %}
{% endif %}

{% capture tb-open-source %}
ThingsBoard是一款开源IoT平台，提供数据采集、处理、可视化和设备管理等一系列功能。
如果您是新用户，建议在开始使用ThingsBoard Edge之前先阅读 [**什么是ThingsBoard？**](/docs/getting-started-guides/what-is-thingsboard/){: target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=tb-open-source %}

**ThingsBoard Edge** 是由ThingsBoard开发的强大软件产品，旨在利用边缘计算能力。

{% if docsPrefix == 'pe/edge/' %}
使用ThingsBoard Edge，可将数据分析和管理带到数据产生的地点——边缘。
无论ThingsBoard PE是[云端](https://thingsboard.cloud){: target="_blank"}还是本地部署，它都能与其无缝同步，满足您的业务需求。

ThingsBoard Edge PE专为**单一**租户和/或**多个**客户设计。
因此，您无法在多个租户之间共享ThingsBoard Edge，不同租户的设备也无法连接到同一个ThingsBoard Edge。
在此类场景下，需要为每个租户单独部署ThingsBoard Edge实例。
{% else %}
使用ThingsBoard Edge，可将数据分析和管理带到数据产生的地点——边缘。
它可根据您的业务需求与ThingsBoard CE轻松同步。

ThingsBoard Edge CE专为**单一**租户和/或**单一**客户设计。
无法在多个租户或客户之间共享ThingsBoard Edge，不同租户或客户和设备也无法连接到同一个ThingsBoard Edge。
在此类情况下，需要为每个租户或客户分别部署多个ThingsBoard Edge实例。
{% endif %}

{% if docsPrefix != 'pe/edge/' %}
{% capture difference %}
需要**白标定制**或**高级功能**？<a href="/docs/pe/edge/" target="_blank">查看Edge专业版文档 →</a>
{% endcapture %}
{% include templates/info-banner.md content=difference %}
{% endif %}

<br>

![image](/images/edge/overview/edge_overview.svg){: style="display: block; margin: auto"}

## ThingsBoard Edge应用场景

- **自动驾驶**
  边缘计算支持以最低延迟采集、处理并响应道路事件。现代自动驾驶汽车每天产生的数据量极大，从5TB到20TB不等。4G或5G网络可能无法承载如此高的吞吐量，而ThingsBoard Edge可以在本地过滤和处理大部分数据，仅将数据子集推送到云端。

- **智慧农业**
  即使在田间位置的云端连接较弱的情况下，也能快速响应偏远地区筒仓通风系统的故障。

- **智能家居**
  在靠近智能家居的位置进行数据处理和分析，可增强敏感用户信息的安全性。智能家居方案的低延迟带来更好的用户体验，终端设备的响应速度比边缘设备连接云端进行决策要快得多。

- **安防解决方案**
  在几秒钟内响应安全违规和威胁是必要能力。边缘计算提供此能力，使云端连接质量变得无关紧要——决策将由现场本地边缘引擎实时做出。

- **院内监护**
  出于医疗设备的数据隐私考虑，数据处理必须在边缘进行。只有医疗设备所需的必要读数推送到云端，其他敏感数据均存储在边缘。在此场景下，边缘处理的另一优势是能够通过实时处理边缘医疗设备数据，尽快响应危急医疗情况。

- **预测性维护**
  在靠近设备的位置处理和存储边缘设备数据，便于在本地分析大量数据。这有助于在生产线发生故障之前检测变化，并根据业务需求仅将生产线上的平均读数发送到云端。

## ThingsBoard Edge功能

使用**ThingsBoard Edge**，您可以获得：

- **本地部署与存储**：在不连接云端的情况下处理和存储本地（边缘）设备的数据。连接恢复后将更新推送到云端。

![image](/images/edge/overview/offline_network_.svg){: style="display: block; margin: auto"}

- **流量过滤**：在ThingsBoard Edge服务上过滤本地（边缘）设备的数据，仅将数据子集推送到云端进行进一步处理或存储。

![image](/images/edge/overview/data_filtering.svg){: style="display: block; margin: auto"}

- **本地告警**：在现场即时响应关键情况，无需云端连接。

![image](/images/edge/overview/alarm.svg){: style="display: block; margin: auto"}

- **实时仪表盘**：监控本地事件和时序数据。
- **本地存储**：当云端连接不可用时，在边缘存储边缘设备的数据，连接恢复后将更新推送到云端。
- **批量更新**：一键更新数千个边缘配置。

![image](/images/edge/overview/update_dashboard.svg){: style="display: block; margin: auto"}

ThingsBoard Edge继承{{appPrefix}}的功能，为连接、管理和处理设备数据提供相同的体验。

它支持以下**ThingsBoard**功能：
* [**Attributes（属性）**](/docs/{{cloudDocsPrefix}}user-guide/attributes/){: target="_blank"} - 为实体分配和管理自定义属性。
* [**Telemetry（遥测）**](/docs/{{cloudDocsPrefix}}user-guide/telemetry/){: target="_blank"} - 从设备采集时序数据的API。
* [**Entities and relations（实体与关系）**](/docs/{{cloudDocsPrefix}}user-guide/entities-and-relations/){: target="_blank"} - 对物理世界对象（如设备和资产）及其关系进行建模。
* [**数据可视化**](/docs/{{cloudDocsPrefix}}guides/#AnchorIDDataVisualization){: target="_blank"} - 开发自定义仪表盘和部件。
* [**Rule engine（规则引擎）**](/docs/{{cloudDocsPrefix}}user-guide/rule-engine-2-0/re-getting-started/){: target="_blank"} - 管理传入遥测和事件的数据处理与动作。
* [**RPC**](/docs/{{cloudDocsPrefix}}user-guide/rpc/){: target="_blank"} - 从边缘和云端两侧向设备发送远程过程调用（RPC），反之亦然。
* [**Audit log（审计日志）**](/docs/{{cloudDocsPrefix}}user-guide/audit-log/){: target="_blank"} - 跟踪用户活动。
* [**API Limits（API限制）**](/docs/{{cloudDocsPrefix}}user-guide/api-limits/){: target="_blank"} - 控制并限制来自单一主机的API请求数量。

{% if docsPrefix == 'pe/edge/' %}
此外，Edge PE支持以下**ThingsBoard PE**功能：
* [**Integrations（集成）**](/docs/user-guide/integrations/){: target="_blank"}
    * 将采用特定载荷格式的现有NB IoT、LoRaWAN、SigFox等设备直接连接到ThingsBoard平台。
    * 从连接至现有IoT平台的设备流式传输数据，以启用实时交互式仪表盘和高效数据处理。
* [**White-labeling（白标定制）**](/docs/pe/user-guide/white-labeling/){: target="_blank"} - 配置自定义菜单、徽标、配色、邮件服务器设置和客户邮件模板等，以便与用户交互。
* [**Scheduler（调度器）**](/docs/pe/user-guide/scheduler/){: target="_blank"} - 通过灵活配置调度各类事件。
* [**Entity Groups（实体分组）**](/docs/pe/user-guide/groups/){: target="_blank"} - 将实体分组、为特定用户组分配角色、为特定用户组授予对特定设备组的特定权限。
{% endif %}

## 项目路线图

<p><a href="/docs/{{docsPrefix}}roadmap" class="button">ThingsBoard Edge路线图</a></p>

## 下一步

<p><a href="/docs/{{docsPrefix}}getting-started" class="button">入门指南</a></p>
