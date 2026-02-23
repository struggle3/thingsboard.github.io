
* TOC 
{:toc}

{% include templates/solution-templates.md %}

AIR Quality Monitoring模板是一套通用的空气污染监测与设备管理解决方案。使用该模板，您可通过污染监测站监测特定区域的臭氧、PM2.5、PM10、CO、SO2、NO2等污染物，并基于此计算AQI。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 仪表板

本解决方案包含2个仪表板，展示来自多传感器的数据：**Public Air Quality Monitoring Dashboard**和**Administration Air Quality Monitoring Dashboard**。

### 公共仪表板

**Public Air Quality Monitoring Dashboard**具有多种状态：**City state**和**Sensor state**。

在**City state**下可：
- 监测基于主要污染物计算的AQI；
- 使用带按AQI等级着色的标记的空气质量监测站交互地图；
- 控制某位置或特定传感器的温度与湿度；
- 查看当前、本周、本月的AQI等级历史；

<br>
点击地图上任一标记即可切换至**Sensor state**（也可通过点击其他设备标记切换至其他传感器）。

<br>
在**Sensor state**下可：
- 监测特定传感器的AQI；
- 查看PM2.5、PM10、NO2、CO、SO2、O3等污染物的详情，点击任一图块将弹出说明、通用建议及该污染物的统计信息；
- 查看特定传感器在当期、本周、本月的AQI等级历史；

### 管理仪表板

**Administration Dashboard**同样具有多种状态：**Main state**和**Sensor state**。

在**Main state**下可：
- 查看所有现有传感器列表及其基本信息和状态；
- 创建、编辑和删除传感器；
- 浏览并清除空气监测传感器的告警；
- 按电池电量（百分比）和断连时长（小时）等参数为传感器配置告警规则；
- 通过标记查看传感器放置位置；

<br>
点击传感器列表中的某一项可切换至**Sensor state**。

<br>
在**Sensor state**下可：
- 管理特定传感器的全部信息；
- 查看并编辑传感器详情（如传感器ID、标签、位置）；
- 查看传感器测量值（连接状态、电池电量、AQI、污染物）；
- 在图表上跟踪传感器当前电池电量；
- 在交互地图上查看传感器位置并支持手动修改；
- 浏览并清除当前空气监测传感器的告警；
- 在图表上跟踪连接状态。

您可随时通过仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义"AIR Quality Monitoring"仪表板。

## 设备

我们已创建5个空气质量监测传感器并为它们加载了演示数据。已创建设备及其凭据列表见解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。**解决方案要求传感器设备上报所有污染物值、温度、湿度和电池电量。最简JSON负载示例：**

```json
{"temperature": 42, "humidity": 73, "pm25": 24.4, "pm10": 30, "no2": 13, "co": 2.8, "so2": 7, "o3": 0.164, "batteryLevel": 77 }
```
{: .copy-code}

发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查找。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

## 告警

告警由"AIR Sensor"<a href="/docs/{{docsPrefix}}user-guide/device-profiles/" target="_blank">设备配置文件</a>中的两条<a href="https://thingsboard.io/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules" target="_blank">告警规则</a>生成。
用户可通过"Air Quality Monitoring"仪表板的"Edit Sensor"表单开启/关闭告警，并配置告警阈值。
