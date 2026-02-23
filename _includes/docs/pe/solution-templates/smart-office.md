
* TOC 
{:toc}

{% include templates/solution-templates.md %}

**Smart office**解决方案模板提供即用型设施管理应用，支持楼宇资产的实时监测、资源跟踪与远程控制。

通过一次安装操作，模板将部署现代办公室的完整数字表示，包括传感器、计量表、HVAC控制、仪表板、告警与设备配置文件。无需自定义规则链、部件或后端配置。

该方案适用于概念验证演示及单设施或多设施的可扩展生产部署。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 主要应用场景

**Smart office**解决方案模板可作为以下场景的基础：
- **高效办公**。维持最佳室内气候与空气质量以提升员工舒适度与绩效。
- **可持续发展与成本控制**。监测能源与用水以发现低效、泄漏与浪费。
- **多址设施管理**。通过统一仪表板在多个楼宇、仓库或商业地产扩展监测与控制。

## 安装解决方案模板

要了解Smart office解决方案的工作方式，请先安装解决方案模板。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](/installations/choose-region/){:target="_blank"}，或按[专业版安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}安装。

- 进入**Solution templates**页面。
- 找到**Smart office**并点击**Install**。
- 按提供的配置说明操作。
- 安装完成后点击**Close**。
- **Smart office**仪表板将自动打开。

安装后，会自动创建办公设施管理的完整模拟，无需设备、集成或自定义代码即可开始体验。

{% include images-gallery.html imageCollection="install-solution-template" %}

## 系统组件

Smart office模板包含：
- **仪表板**。Smart Office仪表板提供环境与用电数据的交互可视化、基于平面图的设备表示、集中告警监测及用户界面中的直接HVAC控制。
- **设备**。解决方案包含已连接并带演示数据的预配置智能传感器、HVAC设备、能源计量表与水表。
- **资产**。创建Office资产表示设施结构，所有设备按真实关系逻辑关联。
- **设备配置文件与逻辑**。为smart-sensor、hvac、energy-meter、water-meter设备提供专用设备配置文件，含环境监测的内置逻辑与预配置告警规则。

**Edge支持**。该解决方案可选择性部署至[ThingsBoard Edge](/docs/edge/){:target="_blank"}以进行本地数据处理与控制。

## 仪表板

Smart Office仪表板作为设施监测与控制的中央指挥中心。

通过仪表板可：
- 观察办公室设备及其位置
- 浏览历史温度、能源与用水数据
- 监测温度告警
- 远程控制HVAC系统（需已连接设备）
- 查看并管理设备详情

<b><font size="3">仪表板状态</font></b>

仪表板包含多种状态：
- **Main state**。在办公室地图或平面图上展示设备列表及位置。
- **Device Details state**。选择设备时打开。
  布局与控件取决于所选设备类型（传感器、HVAC、计量表）。

仪表板可使用ThingsBoard[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}开发工具自定义。

{% include images-gallery.html imageCollection="navigation-between-dashboard-states" %}

## 设备

**Office**资产及四台相关设备将自动创建并带演示数据：
- **Smart sensor**（属于**Tenant**）
- **HVAC**（属于**Tenant**）
- **Energy meter**（属于**Tenant**）
- **Water meter**（属于**Tenant**）

<b><font size="3">遥测格式与测试</font></b>

各设备类型期望特定遥测键。以下示例使用HTTP API，也支持其他连接方式。

**Energy meter**

负载示例：
```json
{"voltage":  220, "frequency":  60, "amperage": 16, "power": 3000, "energy": 300 }
```
{: .copy-code}

**Water meter**

负载示例：
```json
{"water": 2.3, "voltage": 3.9 }
```
{: .copy-code}

**Smart sensor**

负载示例：
```json
{"co2": 500, "tvoc": 0.3, "temperature": 22.5, "humidity": 50, "occupancy": true}
```
{: .copy-code}

**HVAC**

负载示例：
```json
{"airFlow": 300, "targetTemperature": 21.5, "enabled": true}
```
{: .copy-code}

**HVAC控制**

HVAC设备还接受来自仪表板的RPC命令以：
- 开启或关闭系统
- 更改目标温度

RPC通信通过ThingsBoard[RPC API](/docs/{{docsPrefix}}user-guide/rpc/){:target="_blank"}处理。

发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#view-instructions){:target="_blank"}中查找。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/){:target="_blank"}。

## 告警

告警生成由**smart-sensor**[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}中配置的[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}处理。

{% include images-gallery.html imageCollection="alarms-1" %}

告警在仪表板的集中告警部件中展示，方便操作人员快速发现并响应异常状况。

{% include images-gallery.html imageCollection="alarms-2" %}

## 总结

Smart office解决方案模板为设施监测与控制提供即用基础，将环境感知、资源计量、告警与HVAC管理整合于单一解决方案。
支持快速部署、清晰的运营可见性，并易于扩展到真实办公与设施管理场景。
