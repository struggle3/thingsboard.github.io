
* TOC 
{:toc}

{% include templates/solution-templates.md %}

Waste Management模板代表用于监测与控制垃圾箱满度的解决方案。使用该方案，您可监测垃圾箱的布置、满度，并查看垃圾箱相关统计。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 仪表板

本解决方案中创建了**Waste Management Administration**仪表板，展示来自垃圾传感器的数据。

### Waste Management Administration

Waste Management Administration具有多种状态：**Main state**和**Bin state**。

在**Main state**下可：
- 借助交互地图核查所需垃圾箱的位置与填充情况；
- 实时接收数据；
- 跟踪垃圾箱满度的主要指标；
- 查看并管理所有可用传感器；
- 控制满度与电量相关的通知系统；

<br>

要切换至**Bin state**，请点击传感器总列表中目标传感器所在行，或点击交互地图上特定传感器卡片/弹出框中的"details"。

<br>

在**Bin state**下可：
- 查看并编辑特定垃圾箱的基本信息与传感器位置；
- 监测垃圾与电量的基本统计；
- 控制电量与电池水平相关的通知系统。

您可随时通过仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义"Waste Management Administration"仪表板。


## 设备

我们已创建10个垃圾监测传感器并加载了演示数据。已创建设备及其凭据列表见解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。解决方案要求传感器设备上报满度水平与电池电量。最简JSON负载示例：

```json
{"fullLevel": 42, "batteryLevel": 77 }
```
{: .copy-code}


发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查找。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

## 告警
告警由"Waste Sensor"<a href="/docs/{{docsPrefix}}user-guide/device-profiles/" target="_blank">设备配置文件</a>中的两条<a href="https://thingsboard.io/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules" target="_blank">告警规则</a>生成。
用户可通过"Waste Management"仪表板的"Edit Sensor"表单开启/关闭告警并配置告警阈值。
