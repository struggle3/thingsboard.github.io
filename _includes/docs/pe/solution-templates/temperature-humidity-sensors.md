
* TOC 
{:toc}

{% include templates/solution-templates.md %}

**Temperature & Humidity sensors**解决方案模板提供即用型环境条件监测系统。通过一次安装操作，模板将部署包含仪表板、设备、告警、用户与访问控制的完整功能解决方案。

该模板使您可立即从最终用户角度评估并演示解决方案，而无需手动配置规则链、仪表板或设备配置文件。

该方案适用于概念验证部署，也可作为智能建筑、办公、零售及冷链监测等生产IoT应用的基础。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 主要应用场景

该解决方案模板可作为以下场景的基线：
- **智能家居**。监测室内气候并实现HVAC系统自动化。
- **智能办公**。通过维持最佳温湿度提升舒适度与生产力。
- **零售与冷链**。监测冰箱与储藏单元以检测温度违规并防止产品变质。

## 安装解决方案模板

要了解Temperature & Humidity sensors解决方案的工作方式，请先安装解决方案模板。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](/installations/choose-region/){:target="_blank"}，或按[专业版安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}安装。

- 进入**Solution templates**页面。
- 找到**Temperature & Humidity sensors**并点击**Install**。
- 按提供的配置说明操作。
- 安装完成后点击**Close**。
- **Temperature & Humidity**仪表板将自动打开。

安装后，会自动创建环境条件监测的完整模拟，无需设备、集成或自定义代码即可开始体验。

{% include images-gallery.html imageCollection="install-solution-template" %}

## 系统组件

Temperature & Humidity sensors模板包含：
- **仪表板**。Temperature & Humidity仪表板提供传感器遥测的实时可视化、告警管理、传感器配置及带设备位置的交互地图。
- **设备**。解决方案包含两台已连接并立即提供演示遥测的预配置演示温度传感器。
- **设备配置文件与逻辑**。包含内置逻辑及高温与低湿条件预配置告警的Temperature Sensor设备配置文件。
- **Customers与Users**。系统包含一个演示customer（Customer D）及两位具有预定义基于角色的访问控制的只读customer用户。

**Edge支持**。该解决方案可选择性部署至[ThingsBoard Edge](/docs/edge/){:target="_blank"}以进行本地数据处理并降低延迟。

## 仪表板

Temperature & Humidity仪表板展示来自多传感器的遥测数据，并提供告警管理与设备配置工具。

![image](/images/solutions/temperature-sensors/temperature-humidity-sensors-template-1.png)

通过仪表板可：
- 添加新传感器
- 在地图上放置传感器
- 配置告警阈值
- 浏览历史遥测数据
- 管理传感器设置

<b><font size="3">仪表板状态</font></b>

仪表板包含两种状态：
- **Main state**。在地图上展示所有传感器表格及位置。
- **Sensor Details state**。选择传感器行时打开。
  支持查看历史温度与湿度数据、编辑传感器参数并更改位置。

仪表板可使用ThingsBoard[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}开发工具完全自定义。

## 设备

自动创建两台演示设备：
- **Sensor T1**（属于**Tenant**）
- **Sensor C1**（属于**Customer D**）

解决方案要求设备使用以下键以JSON格式发布遥测数据：

```json
{
  "temperature": 42,
  "humidity": 73
}
```
{: .copy-code}

也支持[其他连接方式](/docs/{{docsPrefix}}getting-started-guides/connectivity/){:target="_blank"}（MQTT、CoAP、LwM2M等）。

## 告警

告警生成由**Temperature Sensor**[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}中配置的[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}处理。

| Entity Profile     | Alarm Type       | Severity |
| ------------------ | ---------------- | -------- |
| Temperature Sensor | High Temperature | Critical |
| Temperature Sensor | Low Humidity     | Major    |

告警阈值及启用/禁用状态可直接通过仪表板使用**Edit Sensor**操作修改。

{% include images-gallery.html imageCollection="solution-alarms" %}

## Customers

为演示多租户与数据隔离，解决方案创建了示例customer：
- Customer名称：Customer D
- 分配设备：Sensor C1

**Customer用户**

以下用户已创建并分配给Customer D：
- Toni Collier (toni.collier@thingsboard.io)
- Sheri Addison (sheri.addison@thingsboard.io)

这些用户：
- 对仪表板具有只读权限
- 仅可见**Customer D**所拥有的设备
- 无权修改仪表板或租户级实体

可通过管理界面创建更多[Customers](/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"}和[Users](/docs/{{docsPrefix}}user-guide/ui/users/){:target="_blank"}。可重新分配设备归属以使传感器对特定customers可见。

## 总结

Temperature & Humidity Sensors解决方案模板提供开箱即用的监测解决方案，含实时可视化、可配置告警与内置访问控制。
支持快速上手，既是演示也是生产环境监测用例的坚实基础。
