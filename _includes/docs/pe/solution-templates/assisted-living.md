
* TOC
{:toc}

{% include templates/solution-templates.md %}

基于ThingsBoard实现的辅助生活解决方案模板，用于监测住户健康状况与设施安全。
该方案面向养老公寓、护理院及照护机构，使工作人员能实时掌握住户生命体征、室内位置及关键安全事件。

模板整合可穿戴设备（BLE/LoRa腕带）、室内环境传感器和网关，采集遥测、检测异常并触发告警（如紧急按钮、心率/体温异常、烟雾、漏水、门窗开启）。同时提供管理工具，用于管理设施布局（楼层/区域/房间）并将设备分配给住户和房间。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 安装解决方案模板

要了解Assisted Living解决方案的工作方式，请先安装解决方案模板。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](/installations/choose-region/){:target="_blank"}，也可按[专业版安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}自行安装。

- 进入**Solution templates**页面。
- 找到**Assisted living**并点击**Install**。
- 按提供的配置说明操作。
- 安装完成后点击**Close**。
- **Assisted Living Administration**仪表板将自动打开。

安装后，会自动创建完整的住户健康与设施安全监测模拟，无需设备、集成或自定义代码即可开始体验。

{% include images-gallery.html imageCollection="install-solution-template" %}

## 主要应用场景

Assisted Living解决方案模板适用于需要实时保障住户安全、室内可视性与设施状况监测的环境：
- **辅助生活机构**——持续监测住户生命体征、紧急按钮事件及室内位置，以支持及时响应。
- **护理院与长期照护中心**——自动检测健康异常与安全隐患（跌倒/噪音、烟雾、漏水、门窗开启），降低运营风险。
- **认知照护单元**——通过基于RSSI的室内定位及门窗监测，防止走失并快速定位住户。
- **急性后期与康复中心**——跟踪住户活动与康复指标，并对异常生命体征或求救事件启动升级流程。
- **临终关怀与姑息照护机构**——通过环境传感器（温度、湿度、IAQ）监测住户舒适度，并对不安全状况提前告警。
- **独立居住养老社区**——利用可穿戴与房间传感器进行轻度监护，仅在告警提示潜在问题时介入。
- **多楼栋照护园区**——集中管理多层/多区域的布局、人员工作流及告警策略。

## 系统组件

Assisted Living解决方案包含以下核心组件：
- **住户腕带（BLE/LoRa可穿戴设备）**——监测心率、体温等生命体征，提供紧急按钮事件，并发送用于室内定位的信标信号。
- **房间传感器**——监测房间温度、湿度、室内空气质量（IAQ）、烟雾、漏水及门窗开合状态。
- **网关**——BLE或LoRa网关，接收附近传感器与腕带信号并转发至平台。
- **室内定位（基于RSSI）**——住户位置由多网关接收的信标消息推算，系统根据RSSI值判定最近网关并关联住户至对应房间/区域。
- **数据处理与丰富**——入站网关消息去重并补充网关属性（如房间、区域标识）后，路由至相应设备处理链。
- **仪表板可视化**——设施管理仪表板，用于监测住户、房间、告警及管理区域/房间/设备分配。

## 设备

解决方案包含通过网关连接的可穿戴设备与房间传感器。
- **住户腕带**——提供生命体征与位置信号（BLE信标），并生成紧急/噪音/电池遥测。
- **房间传感器**——提供环境与安全遥测，包括IAQ、温度、湿度、烟雾、漏水和门窗状态。
- **网关**——从附近腕带和传感器采集数据并转发至ThingsBoard。

## 仪表板

本解决方案提供**Assisted Living Administration**仪表板，作为监测与管理设施的主界面。

工作人员可：
- 实时监测住户心率和体温。
- 在交互式平面图上跟踪住户位置。
- 检测并处理住户告警（紧急按钮、生命体征异常、噪音）。
- 检测并处理设施告警（烟雾、漏水、门窗状态）。
- 管理区域、房间及住户/设备分配。

<b><font size="3">仪表板结构</font></b>

仪表板包含多种状态：
- **Main state (Overview)**——实时设施视图，含平面图、住户与房间标记、告警列表。
- **Residents state**——住户名册管理，含个人、医疗、紧急联系人及腕带分配。
- **Zones state**——设施层级管理（楼层/区域）及平面图上传。
- **Zone details state**——所选区域的房间映射与设备分配。

{% include images-gallery.html imageCollection="dashboard-structure" %}

## 告警

解决方案使用预配置的[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}，并关联至[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}。Major和Critical严重级别的阈值可直接在仪表板设置中调整。

<b><font size="3">住户告警（腕带）</font></b>
- **紧急按钮**——单次按下触发Major告警，两次及以上触发Critical告警。
- **心率**——脉搏值超出配置的下限/上限时触发。
- **体温**——温度超出配置的下限/上限时触发。
- **高噪音**——噪音超过配置的阈值时触发（可能表示跌倒或遇险）。
- **低电量**——腕带电量低于配置的百分比时触发。

{% include images-gallery.html imageCollection="resident-alarms" %}

<b><font size="3">设施告警（房间传感器）</font></b>
- **安防（门窗）**——门窗开启事件持续超过允许时长时触发。
- **严重隐患**——检测到烟雾或漏水时立即触发。
- **环境**——IAQ、温度或湿度超出配置的舒适范围时触发。
- **传感器电量**——房间传感器电量低于配置的限值时触发。

{% include images-gallery.html imageCollection="infrastructure-alarms" %}


## 规则链

Assisted Living解决方案依赖专用规则链处理网关接入与设备遥测。
- **AL Gateway Rule Chain**——处理来自网关的数据：
  - 对多网关接收的消息去重；
  - 通过负载中的序列号识别目标设备；
  - 补充网关（房间/区域）属性；
  - 按设备类型（房间传感器 vs 腕带）路由消息；
  - 使用最大RSSI值（最近网关）判定住户位置。
- **AL Wristband Device Rule Chain**——保存遥测、评估告警并统计活跃告警数量，告警数传递给对应住户用户实体用于仪表板展示。
- **AL Room Device Rule Chain**——为设施传感器保存遥测并评估告警，与腕带链不同，不将告警数传递给住户用户实体。

{% include images-gallery.html imageCollection="rule-chains" %}

## 总结

Assisted Living解决方案展示了如何使用ThingsBoard构建集成式的住户安全与设施监测平台。
结合可穿戴遥测、房间传感器数据、基于RSSI的室内定位和告警驱动的工作流，使照护人员能更快响应紧急情况、维护舒适居住条件，并在统一管理仪表板中管理设施结构与设备分配。
