* TOC
{:toc}

{% assign sinceVersion = "4.0.0" %}
{% include templates/since.md %}

SCADA（Supervisory Control and Data Acquisition）系统在能源监测与管理中扮演关键角色，为发电、配电与用电提供实时洞察。

借助ThingsBoard平台，企业可集成高级SCADA解决方案，优化能效、降低成本并提升系统可靠性。
从多能源源采集、分析与可视化数据的能力，帮助操作人员做出明智决策并快速响应变化。
以上均体现在我们的SCADA Energy解决方案中，展示如何通过ThingsBoard轻松高效地管理能源系统。

<br>
<object width="100%" data="/images/solutions/scada-energy-management/scada-energy-management-scheme.svg"></object>

## 主要应用场景

具备能源监测能力的SCADA系统广泛应用于多行业，包括：

- **工业设施**。在制造厂中用于监测、控制与优化机器和过程的能耗。
- **可再生能源电站**。在太阳能与风电场管理中必不可少，实时跟踪发电量、绩效与系统健康。
- **公用事业与电网**。SCADA通过监管配电、负载平衡与故障检测支撑电网稳定性。
- **智能建筑**。通过管理照明、HVAC与电气系统提升商业与住宅建筑能效。
- **数据中心**。监测能耗、保障持续供电并管理备用系统以避免停机。

## 系统组件

SCADA Energy管理系统包含：

- **设备**。安装在能源源的传感器与执行器，采集并传输如太阳能板状态、风机转速、变压器输入输出电压、发电机绩效指标等数据。
- **Modbus协议**。设备间数据交换的主要通信协议，确保可靠连接及设备与SCADA系统的无缝集成。
- **网关**。将传感器数据传至ThingsBoard平台的设备，在网络中进行转换和转发以供进一步处理。
- **ThingsBoard**。IoT平台，用于数据采集、分析与可视化，支持操作人员访问信息并为关键参数变化设置告警。
- **仪表板可视化**。在统一仪表板中跟踪太阳能、风能、电池、发电机与用电数据，使能源管理人员做出更明智、更快速的决策。

## 安装解决方案模板

要了解SCADA Energy management模板的工作方式，请先安装。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](https://{{hostName}}/signup){:target="_blank"}。
也可按[安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}自行安装。

- 进入“**Solution templates**”页面，找到“**SCADA Energy management**”并点击“**Install**”开始安装。
- 将提供该解决方案的配置说明，请按步骤操作。
- 完成后点击“**Close**”完成设置并进入仪表板。

{% include images-gallery.html imageCollection="go-to-scada-energy-management-solution-templates" %}

## 仪表板

SCADA System for Smart Energy Management仪表板用于能源资源的实时监测、控制与优化。
使操作人员可跟踪能源系统状态、分析能源流、监管发电机、逆变器、变压器、电池、太阳能板与风机的绩效。
仪表板通过内置告警与历史数据分析帮助检测故障、预防故障并提升能效。
确保可靠供电、减少能源损失并促进多能源源的无缝整合。

![image](/images/solutions/scada-energy-management/scada-energy-management-4-pe.png)

<br>

**仪表板结构**

通过导航按钮在仪表板状态间切换，以跟踪和管理各能源组件的详情。

- <b>Main dashboard state</b>。提供能源系统总览，展示电源状态（太阳能、风能、电池、变压器、发电机）、实时能源流与用电。电网输入、用电量、电池水平等关键指标均以交互控件展示，用于管理电源。
- <b>Inverters state</b>。聚焦逆变器绩效与负载分配，按相（L1、L2、L3）展示电压、电流与功率输出，含实时图表及过载、过热等问题的告警区。
- <b>Solar panels state</b>。实时监测太阳能板绩效：照度、电压与功率输出，含电压、电流与温度的历史趋势及发电问题的告警。
- <b>Wind turbine state</b>。跟踪风机数据：风速、转子转速与功率输出，图表展示转子转速与能源趋势，告警通知过度振动或速度尖峰等问题。
- <b>Batteries state</b>。展示储能状态，包括电量（SOC）、循环次数与电压，图表跟踪充放电电流、温度与电压趋势，告警区突出电池健康或运行问题。
- <b>Power transformer state</b>。展示变压器绩效：输入/输出电压、电流与频率，实时能源流监测配合历史图表及变压器故障或不稳定告警。
- <b>Generator state</b>。提供发电机运行洞察：燃料水平、电压、电流与油温，展示运行时间、维护状态及关键状况告警，确保备用电源可靠。
- <b>Consumption state</b>。以日、月为单位可视化能耗，图表展示用电量、电压、电流与频率以优化能效，告警标记异常用电或系统问题。
- <b>Alarms state</b>。列出所有活跃与历史系统告警，含时间戳、严重级别与状态，用户可确认或解决与故障、振动及绩效偏差相关的告警。

{% include images-gallery.html imageCollection="energy-management-dashboard" %}

<br>
**移动端视图**

移动端视图展示仪表板的灵活性，支持在平板与智能手机等不同设备上管理并监测SCADA Energy management。

<object width="40%" data="/images/solutions/scada-energy-management/mobile-view-scada-energy-management.png"></object>
