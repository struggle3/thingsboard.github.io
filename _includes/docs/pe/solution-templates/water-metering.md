
* TOC 
{:toc}

{% include templates/solution-templates.md %}

Water Metering模板代表通用水表计量解决方案。
使用该模板可获得交互式仪表板，使管理员与最终用户可浏览水表状态及聚合用水统计。
用户可定义阈值并开启告警及SMS或邮件通知。

## 仪表板

本解决方案中创建了"Water Metering Tenant Dashboard"，用于管理水表设备、用户与告警：

* 在地图上观察水表的位置与状态。标记可聚类以同时展示数千台水表；
* 使用"Analytics"视图比较当前月与上月的用量；
* 使用"Devices"视图获取所有水表设备列表，支持
    * 创建新设备并分配给customer；
    * 更改设备位置；
    * 为该设备配置告警阈值；
    * 点击设备行导航至"Device"视图；
* 使用"Device"视图可：
    * 浏览特定水表设备的用水历史；
    * 浏览特定水表设备的活跃告警；
    * 更改水表位置信息
    * 上传水表照片；
    * 更改设备位置；
* 使用"Customers"视图管理customers；
* 使用"Users"视图添加更多将接收告警通知的租户管理员；
* 使用"Alarms"视图浏览并清除水表告警；
* 使用"Settings"视图可：
    * 开启/关闭系统告警；
    * 定义系统告警阈值；
    * 开启/关闭SMS与邮件通知；

{% include images-gallery.html imageCollection="solution-highlights" %}

我们还为最终用户创建了"Water Metering User Dashboard"。该仪表板会自动分配给新customers。最终用户仪表板允许customers：

* 在地图上观察水表的位置与状态。标记可聚类以同时展示数千台水表；
* 浏览活跃告警及按日、按周的用水量；
* 使用与主仪表板类似的"Analytics"、"Devices"、"Alarms"视图；
* 使用"Settings"视图为特定customer定义告警阈值。生成的告警默认对Tenant Administrator不可见；

您可随时通过仪表板开发[指南](/docs/{{docsPrefix}}user-guide/dashboards/)自定义"Water Metering"仪表板。


## 设备

我们已创建三台水表设备并加载了演示数据。
已创建设备及其凭据列表见解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。

解决方案要求水表设备上报"pulseCounter"、"temperature"、"battery"和"leakage"值。
最简JSON负载示例：

```json
{"temperature":  42, "humidity":  73}
```
{: .copy-code}

发送数据的具体命令可在解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)中查找。
多数水表使用LoRaWAN、Sigfox或NB IoT技术。
连接真实设备的多种选项参见[连接设备](/docs/{{docsPrefix}}getting-started-guides/connectivity/)。

## 告警

告警由"Water Meter" [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)中的九条告警规则生成。
告警通知根据仪表板中定义的阈值与设置，通过SMS或邮件发送给Tenant Administrators和Customer Users。

{% include images-gallery.html imageCollection="solution-alarms" %}

## 规则链

"Water Metering Solution Main"规则链处理来自水表设备的所有入站消息。
该规则链负责按日、按周对设备、customer与租户级别进行入站数据聚合。
聚合数据同样存储为遥测。聚合默认使用UTC时区。
可在"aggregate stream"规则节点中更改时区。也可在不同时区进行聚合。

另有两套规则链："Water Metering Solution Tenant Alarm Routing"和"Water Metering Solution Customer Alarm Routing"。
它们分别负责将入站消息路由至租户管理员与customer用户。

{% include images-gallery.html imageCollection="rule-chains" %}

## Customers

水表"WM0000123"和"WM0000124"已分配给新创建的customer"Water Metering Customer A"。
您可注意到"Water Metering Customer A"有一名用户，且"Water Metering User Dashboard"仪表板默认分配给该用户。
可通过管理界面创建更多[Customers](/docs/{{docsPrefix}}user-guide/ui/customers/)和[Users](/docs/{{docsPrefix}}user-guide/ui/users/)。

## 基于角色的访问控制（RBAC）

我们已为customers"Water Metering Customer A"和"Water Metering Customer B"创建了独立用户。已创建用户及其密码列表见解决方案[说明](/docs/{{docsPrefix}}solution-templates/overview/#install-solution-template)。

这些用户为"Customer User"组的成员。因此，他们对Customer的所有实体具有只读权限。
我们还创建了"Water Metering User"通用角色，允许这些用户对告警、customer属性和设备属性具有写权限。使用户可设置特定告警与通知。

思路是为多customers的所有用户提供一个"Water Metering User Dashboard"仪表板。Customer用户应能浏览但无权编辑仪表板。
为实现此目的，我们创建"Water Metering Shared"组，通过"Water Metering Read Only"角色与customer用户共享。该组包含"Water Metering User Dashboard"仪表板。
如需与相同用户共享更多仪表板，可将其他仪表板加入该组。更多说明请参见[IoT高级RBAC](/docs/{{docsPrefix}}user-guide/rbac/)。
