* TOC
{:toc}

{% assign sinceVersion = "4.0.0" %}
{% include templates/since.md %}

基于ThingsBoard实现的SCADA（Supervisory Control and Data Acquisition）系统模板，用于石油天然气钻井过程自动化。
SCADA系统使操作人员可实时监测钻井参数、控制设备并预防突发情况。ThingsBoard作为IoT平台，支持采集、处理并可视化来自传感器与控制器的数据，使钻井更安全、高效、可预测。

<br>
<object width="100%" data="/images/solutions/scada-drilling-system/scada-systems-in-drilling-scheme.svg"></object>

## 安装解决方案模板

要了解SCADA Drilling system模板的工作方式，请先安装。

您需要ThingsBoard专业版访问权限。最简单的方式是使用[ThingsBoard Cloud](https://thingsboard.io/installations/choose-region/){:target="_blank"}。
也可按[安装指南](/docs/user-guide/install/pe/installation-options/){:target="_blank"}自行安装。

- 进入“**Solution templates**”页面，找到“**SCADA Oil & Gas Drilling system**”并点击“**Install**”开始安装。
- 将提供该解决方案的配置说明，请按步骤操作。
- 完成后点击“**Close**”完成设置并进入仪表板。

{% include images-gallery.html imageCollection="go-to-drilling-solution-templates-page-1" %}

## 系统组件

SCADA Oil & Gas Drilling系统包含：

- **设备**——安装在钻井设备上的传感器与执行器，采集转速、张力、液位等钻井参数数据。
- **Modbus**协议——设备间数据交换的主要通信协议，确保可靠连接及设备与SCADA系统的无缝集成。
- **网关**——将传感器数据传至ThingsBoard平台的设备，在网络中进行转换和转发以供进一步处理。
- **ThingsBoard**——IoT平台，用于数据采集、分析与可视化，支持操作人员访问信息并为关键参数变化设置告警。
- **仪表板可视化**——SCADA仪表板清晰呈现所有钻井过程，支持实时监测与决策。

## 仪表板

本解决方案开发了全面的SCADA Oil & Gas Drilling系统仪表板，支持对转速、深度、张力、流量等关键钻井参数的实时监测与控制。
操作人员可管理设备（泵、转盘、防喷器），分析钻机、钻头与钻井液状态，并跟踪负载与振动水平。
系统包含交互图表、告警日志与通知，有助于预防事故并提升运营效率。

![image](/images/solutions/scada-drilling-system/go-to-drilling-dashboard-2-pe.png)

**仪表板结构：**

- **Main drilling SCADA system state**——实时监测钻井参数（速度、深度、张力、流量），控制泵、转盘与防喷器。
- **Data monitoring SCADA system state**——跟踪钻头位置、井口压力、泥浆流量、机械张力、钻井绩效、设备状态及环境条件，分析温度、振动与气体浓度以预防故障。
- **Drilling rig state**——监测与控制转速、提升速度与钻机压力，实时进行负载分析与钻井进度跟踪。
- **Preventer (BOP) state**——确保井口压力控制，监测泄漏、泥浆温度与气体浓度，并提供实时压力趋势分析。
- **Drill bit state**——跟踪钻井速度、钻头位置、振动与温度，优化钻速与效率。
- **Drilling mud state**——监测与控制钻井液属性，确保润滑、冷却与循环正常。
- **Drawwork state**——控制钻具提升与下放，调节速度、方向与张力，并跟踪振动与位置。
- **Alarms state**——记录实时告警与警告，便于快速响应故障、异常压力或异常温度。

通过导航按钮在仪表板状态间切换，以跟踪和管理各钻井组件的详情。

{% include images-gallery.html imageCollection="drilling-dashboard-1" %}

可尝试修改部分设备配置，如设置更大井深、调整钻井速度或关闭泵，并观察操作结果。

{% include images-gallery.html imageCollection="drilling-dashboard-2" %}

<br>
**移动端视图**

移动端视图展示仪表板的灵活性，支持在平板与智能手机等不同设备上管理并监测SCADA Oil & Gas Drilling系统。

{% include images-gallery.html imageCollection="scada-mobile" %}

<object width="40%" data="/images/solutions/scada-drilling-system/drilling-tablet-and-mobile.png"></object>

## 总结

SCADA与ThingsBoard平台在钻井中的应用显著提升了运营效率与安全。通过全面监测系统，操作人员可跟踪所有关键钻井过程参数、及时响应变化并降低设备故障风险。传感器、通信协议与强大分析工具的结合，使智能钻机得以实现，确保最大生产率及应对潜在中断的韧性。
