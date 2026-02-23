
* TOC 
{:toc}

{% include templates/solution-templates.md %}

Smart Irrigation模板代表通用田间灌溉解决方案，用于配置田地及相关设备。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 仪表板

本解决方案中创建了Smart Irrigation仪表板，展示来自多土壤湿度传感器的数据。该仪表板包含2种状态：**Main state**和**Field state**。

在**Main state**下可：
- 在交互地图上监测现有田地的平均土壤湿度；
- 在列表中监测相关土壤作物的田地，并按需添加新田地；
- 为各田地设置灌溉应用的限值；
- 通过图表实时监测土壤湿度历史；
- 监测未满足设定条件时触发的告警；

<br>
要进入**Field state**，请在Field区域点击目标传感器所在行，或在交互地图上选择所需田地。

<br>
在**Field state**下可：
- 监测灌溉状态；
- 设置并编辑灌溉开启计划及触发条件；
- 查看土壤湿度统计；
- 监测已触发的告警；
- 管理土壤湿度传感器并在交互地图上查看；
- 查看灌溉任务。

您可随时通过仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义"Smart Irrigation"仪表板。

## 设备

我们已创建多台设备并加载了演示数据。已创建设备及其凭据列表见解决方案<a href="https://thingsboard.io/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template">说明</a>。

### SI Water Meter
该配置文件在"battery"遥测值低于可配置阈值时触发告警。低于30时触发Warning告警。
设备还上报"pulseCounter"用于计算用水量。示例负载：

```json
{"battery": 99, "pulseCounter": 123000}
```
{: .copy-code}

### SI Soil Moisture Sensor
该配置文件在"battery"遥测值低于可配置阈值时触发告警。低于30时触发Warning告警。
设备还上报"moisture"液位。示例负载：
```json
{"battery": 99, "moisture": 57}
```
{: .copy-code}

### SI Smart Valve
该配置文件在"battery"遥测值低于可配置阈值时触发告警。低于30时触发Warning告警。示例负载：
```json
{"battery": 99}
```
{: .copy-code}

设备还接受用于开启或关闭水流的RPC命令。示例RPC命令：
```json
{"method": "TURN_ON", "params": {}}
```
{: .copy-code}

发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查找。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

## 告警
用户可通过"Smart Irrigation"仪表板开启/关闭告警并配置告警阈值。
