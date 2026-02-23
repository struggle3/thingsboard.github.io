
* TOC 
{:toc}

{% include templates/solution-templates.md %}

**Site fleet tracking**解决方案模板提供即用型矿区监测与车队跟踪应用。安装后可部署带地理围栏区域、实时机械跟踪、计算字段及预配置告警的完整数字孪生，用于安全与运营监测。

该方案面向矿山、采石场及大型工地等重工业场景。操作人员可监测机械位置、跟踪移动与燃料消耗，并在无需硬件集成的情况下验证地理围栏逻辑。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 主要应用场景

该解决方案模板可作为以下场景的蓝图：
- **露天采矿**。通过测量在装载与卸载区域停留时间跟踪“装载-运输-倾倒”循环。
- **建筑工地**。监测车队位置并执行授权运营边界。
- **采石场运营**。跟踪燃料消耗并检测过载或超速事件，减少停机与运营风险。

## 安装解决方案模板

要了解Site Fleet Tracking解决方案的工作方式，请先安装解决方案模板。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](/installations/choose-region/){:target="_blank"}，或按[专业版安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}安装。

- 进入**Solution templates**页面。
- 找到**Site fleet tracking**并点击**Install**。
- 按提供的配置说明操作。
- 安装完成后点击**Close**。
- **Mine site monitoring**仪表板将自动打开。

安装后，会自动创建粘土矿的完整模拟，无需设备、集成或自定义代码即可开始体验。

{% include images-gallery.html imageCollection="install-solution-template" %}

## 系统组件

Site Fleet Tracking解决方案包含以下主要组件：
- **设备**——模拟真实遥测（位置、速度、燃料液位、载重、液压压力）的演示挖掘机与运输卡车。
- **资产**——带有Loading、Unloading、Restricted等多运营区域的矿区资产。
- **仪表板可视化**——提供实时监测、分析与设备和区域钻取视图的交互仪表板。
- **地理围栏逻辑**——自动检测机械在区域内存在并计算各区停留时间。
- **设备配置文件与逻辑**——为挖掘机与运输卡车提供专用[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}，包含地理围栏、派生遥测与数据聚合的[计算字段](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}，以及安全与运营条件的预配置[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}。

## 仪表板

本解决方案提供全面的Mine Site Monitoring仪表板。该仪表板作为监测车队活动、区域利用率、燃料消耗与安全事件的中央控制界面。

<b><font size="3">仪表板结构</font></b>

仪表板分为多种逻辑状态：
- **Main state**——提供整个场地的总览，包括地图上的实时机械位置、Loading/Unloading/Restricted区域的KPI卡及日燃料消耗。
- **Machines list**——展示各挖掘机与运输卡车的详细信息，含当前状态与活跃告警。
- **Zones list**——显示所有已定义场地区域及各区域内的机械。

各状态下，仪表板显示由规则链与遥测阈值生成的活跃及历史[告警](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"}。

仪表板状态间的导航使操作人员可快速聚焦特定机械、区域或安全事件。

{% include images-gallery.html imageCollection="navigation-between-dashboard-states" %}

<b><font size="4">仪表板交互与模拟</font></b>

Site Fleet Tracking仪表板支持交互式模拟，可在无真实硬件的情况下演示解决方案行为。
- **钻取导航**——点击表格中的机械或从地图提示框选择See details，可查看详细遥测历史、告警与计算指标。
- **区域详情**——点击区域可查看该区域内所有机械及关联告警。
- **交互地图模拟**——地图上的机械标记可拖动，可将机械从一个区域拖到另一个区域以模拟位置变化。

拖动机械标记会更新其经纬度遥测，自动触发地理围栏逻辑、重新计算停留时间指标，并在违反区域规则时生成告警。

仪表板可进一步使用ThingsBoard[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/){:target="_blank"}开发指南进行自定义。

## 设备

解决方案自带预配置的演示设备，模拟工作中的车队：
- **Excavator A**（属于**Tenant**）
- **Excavator B**（属于**Tenant**）
- **Haul truck A**（属于**Tenant**）
- **Haul truck B**（属于**Tenant**）
- **Haul truck C**（属于**Tenant**）

<b><font size="3">测试遥测上传</font></b>

可通过向任意演示设备发送遥测数据模拟实时设备行为。

解决方案期望遥测包括<span class="code-light">latitude</span>、<span class="code-light">longitude</span>、<span class="code-light">speed</span>、<span class="code-light">fuelLevel</span>及设备特定参数：
- <span class="code-light">hydraulicPressure</span>（挖掘机）
- <span class="code-light">loadWeight</span>（运输卡车）

**运输卡车遥测负载示例：**

```
{ "latitude": 36.215322, "longitude": -88.665637, "speed": 18.5, "fuelLevel": 72.3, "loadWeight": 56000 }
```
{: .copy-code}

**HTTP API请求示例：**

{% if docsPrefix == null or docsPrefix == "pe/" %}
```bash
curl -v -X POST \
-d "{\"latitude\":36.215322,\"longitude\":-88.665637,\"speed\":18.5,\"fuelLevel\":72.3,\"loadWeight\":56000}" \
https://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry \
--header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/" %}
```shell
curl -v -X POST \
-d "{\"latitude\":36.215322,\"longitude\":-88.665637,\"speed\":18.5,\"fuelLevel\":72.3,\"loadWeight\":56000}" \
https://thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry \
--header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}
{% if docsPrefix == "paas/eu/" %}
```shell
curl -v -X POST \
-d "{\"latitude\":36.215322,\"longitude\":-88.665637,\"speed\":18.5,\"fuelLevel\":72.3,\"loadWeight\":56000}" \
https://eu.thingsboard.cloud/api/v1/$ACCESS_TOKEN/telemetry \
--header "Content-Type:application/json"
```
{: .copy-code}
{% endif %}

其中
{% if docsPrefix == null or docsPrefix == "pe/" %}- **$THINGSBOARD_HOST_NAME** - 平台运行的主机名或IP地址。{% endif %}
- **$ACCESS_TOKEN** - 设备访问令牌。

发送遥测后，打开仪表板即可在地图、KPI卡与告警中观察实时更新。

[其他设备连接方式](/docs/{{docsPrefix}}getting-started-guides/connectivity/){:target="_blank"}（MQTT、CoAP、LwM2M等）同样支持。

## 告警

告警生成由**Excavator**和**Haul truck**[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}中配置的[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}处理。

{% include images-gallery.html imageCollection="configured-alarms" %}

## 计算字段

解决方案使用[计算字段](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}派生额外遥测、检测地理围栏事件并计算运营指标。
计算字段配置于：
- **Excavator**设备配置文件
- **Haul truck**设备配置文件
- **Mine site**资产配置文件

**已配置的计算字段：**

{% include images-gallery.html imageCollection="configured-calculated-fields" %}

## 总结

Site fleet tracking解决方案模板为重工业车队监测提供完整的数字孪生。
结合实时位置跟踪、地理围栏、计算指标与告警驱动的安全逻辑，使操作人员可从单一仪表板监测场地活动、提升安全并优化车队利用率。
