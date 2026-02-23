* TOC
{:toc}

{% include templates/solution-templates.md %}

Fuel Level Monitoring解决方案模板提供完整的即用型固定储罐液位监测系统。支持液位实时可视化、基于储罐几何的自动容积计算、消耗与补液跟踪，以及主动告警管理。

通过一次安装操作，解决方案将部署完整功能仪表板、设备配置文件、规则链、告警及演示设备。

该模板适用于工业、农业、建筑及车队 depot 场景，需要精确燃料库存跟踪和关键状况的早期检测。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 主要应用场景

该解决方案模板可作为以下场景的蓝图：
- **仪表板**。Fuel Level Monitoring仪表板提供带按状态着色的储罐标记的交互地图、集中告警管理、储罐创建与配置工具，以及燃料消耗与补液事件的历史分析。
- **设备**。解决方案包含4个预配置的储罐传感器设备，已连接并立即提供演示遥测数据。
- **设备配置文件与处理逻辑**。包含预配置告警规则的专用Tank设备配置文件，以及Fuel Monitoring规则链，用于处理告警统计、传感器状态计算与设备连接管理。
- **容积计算引擎**。解决方案包含支持9种预定义储罐形状的容积计算引擎，自动将传感器高度测量值转换为容积，并支持填充高度和剩余空间两种传感器类型。

## 安装解决方案模板

要了解Fuel level monitoring解决方案的工作方式，请先安装解决方案模板。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](/installations/choose-region/){:target="_blank"}，或按[专业版安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}安装。

- 进入**Solution templates**页面。
- 找到**Fuel level monitoring**并点击**Install**。
- 按提供的配置说明操作。
- 安装完成后点击**Close**。
- **Fuel level monitoring**仪表板将自动打开。

安装后，会自动创建完整的固定储罐液位监测模拟，无需设备、集成或自定义代码即可开始体验。

{% include images-gallery.html imageCollection="install-solution-template" %}

## 仪表板

本解决方案中已创建仪表板。该仪表板包含2种专用于监测储罐燃料液位、查看消耗统计及管理设备的状态。

**Main state：**
- 通过可按状态过滤的彩色标记展示储罐位置与状态，每种颜色代表不同状态（如正常、低电量、告警条件等）；
- 显示所有储罐列表，支持编辑、删除或新增储罐，并展示剩余燃料百分比、温度、电量、连接状态等关键数据；用户可选择不同储罐并在多种计量单位间切换；
- 监控与燃料液位、温度、电量相关的所有告警列表，并允许用户配置告警触发条件；

{% include images-gallery.html imageCollection="dashboard-main-state" %}

**Tank state**展示特定储罐的剩余燃料液位，提供可编辑字段与位置等储罐详情，显示带时间戳的消耗与补充记录，以图表展示液位与消耗趋势，并列示该储罐相关所有告警。

{% include images-gallery.html imageCollection="dashboard-tank-state" %}

储罐与单位的选项进一步增强用户界面，使监测与管理更精确，同时简化界面以加快导航并提升体验，满足储罐燃料液位相关的多种监测与管理需求。

## 设备

我们已创建9个传感器并加载了演示数据。解决方案要求传感器设备上报温度、燃料液位和电池电量。最简JSON负载示例：

```text
{"battery": 77, "fuelLevel": 91, "fuelHeight": 125, "temperature": 32 }
```
{: .copy-code}

发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查找。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

## 液位测量表示

本仪表板可根据“填充高度”或“剩余空间”计算展示的储罐形状容积。
- **填充高度：**仪表板根据“填充高度”计算不同储罐形状的容积，实现灵活且精确的液位表示。
- **剩余空间：**容积也可按储罐“剩余空间”计算，并考虑如“Sensor gap”等额外成分（表示高度计算中未包含的储罐部分），使储罐容积计算更灵活、更精细，尤其当储罐颈部等特定部分不参与容积计算时。

有关基于“填充高度”或“剩余空间”计算储罐容积的更详细说明，可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查看。

## 告警

告警由“Tank Sensor”[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)中的四条[告警规则](/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules)生成。用户可通过"Fuel Level Monitoring"仪表板的“Alarm rules”表单配置告警规则。

## 总结

Fuel Level Monitoring解决方案提供跨资产的燃料液位与消耗的实时可见性。通过遥测、计算指标与告警，有助于检测异常使用、防止短缺并优化补油流程。
该模板提供即用基础，通过集中燃料监测减少停机、提升运营效率。
