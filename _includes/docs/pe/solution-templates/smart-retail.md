
* TOC 
{:toc}

{% include templates/solution-templates.md %}

Smart retail解决方案代表作为解决方案提供商的通用智能零售方案，您可配置多个Customers并为每位客户分配一批IoT设备。

{% include images-gallery.html imageCollection="solution-highlights" %}

## 仪表板
本解决方案创建了2个展示多传感器数据的仪表板：**Smart Supermarkets Dashboard**和**Administration Dashboard**。

### Smart Supermarkets Dashboard

**Supermarkets Dashboard**具有多种状态：
- **Main**状态包含超市地图与告警列表。告警从设备传播至对应超市，平台根据传播告警的最高严重级别计算各超市状态。作为用户，您可按超市状态在地图上过滤超市。
- **Floor** plan状态包含带超市平面图的室内地图与设备标记。除地图外，该状态还包含两个过滤器：按设备类型与设备状态。过滤设置保存在用户级别。
    - State filter使您可按告警最高严重级别过滤设备，例如仅显示至少有一个critical告警的设备。
    - Device type filter使您可按设备类型显示或隐藏特定设备，例如仅显示Freezers和Chillers并隐藏其他设备。
    - 点击特定设备标记可在仪表板右侧面板显示设备详情状态。设备详情内容依设备类型而定，例如freezer设备有温度读数的折线图，smart bin有满度水平的柱状图。设备详情的通用元素包括标题与告警列表。标题包含设备当前状态及其电池电量（若为电池供电）。标题还支持导航至该设备的设置，用于配置告警阈值。

因演示仪表板为公开访问，部分功能（如删除设备）已被禁用。

<br>
安装解决方案模板后，您还将获得“Smart Supermarket Administration”的访问权限，用于配置customers、其用户、超市与设备。

### Smart Supermarket Administration Dashboard

**Smart Supermarkets Administration Dashboard**具有多种状态：
- **Main**状态用于列出零售公司（customers）。我们假设customer为拥有一家或多家人超市的零售公司。为演示已预配置两家“假”零售公司及其若干超市。
- **Device management**状态用于在零售公司（customer）范围内管理设备。您可配置新设备或删除现有设备。该状态显示分配给该零售公司的所有设备表格，Tenant或Supermarket Administrator可使用这些设备将其部署到超市。可将该列表视为Customer超市中可安装的设备池。
- **Supermarket management**状态用于在零售公司（customer）范围内管理超市。该仪表板状态在地图上显示超市并在表格中列出超市。
  超市为可包含多台设备及若干属性（平面图、地址）的资产。
  
- **Supermarket devices**状态显示带超市平面图与设备标记的室内地图。您可拖放设备标记以定义设备在超市中的精确位置。

您可随时通过仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义"Smart Retail"仪表板。

## 设备

我们已创建多台传感器并加载了演示数据。已创建设备及其凭据列表见解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。


### Smart Shelf

该配置文件在"weight"遥测值低于阈值时触发告警。低于20单位（kg或lbs取决于设备上报）触发Major告警，低于10单位触发Critical告警。
示例负载：

```json
{"weight": 42}
```
{: .copy-code}

### Smart Shelf

该配置文件在"temperature"遥测值高于或低于特定阈值时触发告警。高于-2度或低于-25时触发Major告警，高于-1度或低于-30时触发Critical告警。
示例负载：

```json
{"temperature": -5.4}
```
{: .copy-code}

### Chiller

Chiller配置文件与Freezer类似，但默认阈值不同。
示例负载：

```json
{"temperature": 6.2}
```
{: .copy-code}

### Door sensor

该配置文件在门开启超过30分钟时触发major告警，超过1小时触发critical告警。若门在非工作时间开启，则触发critical告警。非工作时间可在设备配置文件的告警规则中配置。
因门传感器通常为电池供电，电量低于30（major）或10（critical）时触发对应告警。若传感器非电池供电，可忽略该告警规则。
示例负载：

```json
{"open": true, "batteryLevel":  99}
```
{: .copy-code}


### Motion sensor

与Door sensor类似，motion sensor在非工作时间检测到运动时触发critical告警。非工作时间可在设备配置文件的告警规则中配置。

```json
{"motion": true, "batteryLevel":  99}
```
{: .copy-code}

### Smoke sensor

检测到烟雾时，Smoke sensor将触发critical告警。因烟雾传感器通常为电池供电，电量低于30（major）或10（critical）时触发对应告警。若传感器非电池供电，可忽略该告警规则。
```json
{"alarm": false, "batteryLevel":  99}
```
{: .copy-code}

### Smart Bin
该配置文件在满度水平高于特定阈值时触发告警。高于70%触发Major告警，高于90%触发Critical告警。
Smart bin传感器通常为电池供电，电量低于30（major）或10（critical）时触发对应告警。若传感器非电池供电，可忽略该告警规则。
示例负载：

```json
{"level": 35, "batteryLevel":  89}
```
{: .copy-code}


### Liquid Level Sensor
该配置文件在液位低于特定阈值时触发告警。低于30%触发Major告警，低于10%触发Critical告警。
Liquid Level传感器通常为电池供电，电量低于30（major）或10（critical）时触发对应告警。若传感器非电池供电，可忽略该告警规则。
示例负载：

```json
{"level": 85, "batteryLevel":  99}
```
{: .copy-code}

### Occupancy sensor
该配置文件在房间被占用超过30分钟时触发major告警，超过1小时触发critical告警。
因occupancy传感器可能为电池供电，电量低于30（major）或10（critical）时触发对应告警。若传感器非电池供电，可忽略该告警规则。

```json
{"occupied": true, "batteryLevel":  99}
```
{: .copy-code}




发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查找。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

## 告警
用户可通过<a href="https://thingsboard.io/docs/{{docsPrefix}}user-guide/device-profiles/#alarm-rules" target="_blank">"Smart Retail"</a>仪表板开启/关闭告警并配置告警阈值。
