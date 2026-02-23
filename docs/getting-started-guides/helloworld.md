---
layout: docwithnav
assignees:
- ashvayka
title: ThingsBoard 快速入门
description: ThingsBoard 开源IoT平台快速入门及模拟 IoT 设备
redirect_from: "/docs/samples/"

step1:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-1-ce.png 
        title: '登录 ThingsBoard 并进入「实体」下的「设备」页面。'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-2-ce.png 
        title: '点击表格右上角的「+」图标，从下拉菜单中选择「添加新设备」。'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-3-ce.png 
        title: '输入设备名称（如「My New Device」），其他保持默认。点击「添加」。'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-4-ce.png
        title: '将打开设备连接检查窗口——我们暂时跳过此步，下一步再检查连接。'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-5-ce.png 
        title: '恭喜，您已添加第一个设备！后续添加的设备将出现在表格顶部，表格按创建时间自动排序，最新在最前。'

step11:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-6-ce.png 
        title: '添加设备后您会收到通知。点击右上角铃铛图标查看通知。'

step2:
    0:
        image: /images/helloworld/getting-started-ce/check-connectivity-device-1-ce.png
        title: '点击您的设备，在「设备详情」窗口中点击「检查连接」按钮。'
    1:
        image: /images/helloworld/getting-started-ce/check-connectivity-device-2-ce.png
        title: '在打开的窗口中选择消息协议和操作系统，安装所需客户端工具并复制提供的命令。'
    2:
        image: /images/helloworld/getting-started-ce/check-connectivity-device-3-ce.png
        title: '在终端中执行复制的命令。遥测数据（如温度读数）成功发布后，设备状态将从「非活动」变为「活动」，并显示数据。此时可关闭连接窗口。'

step21:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-3-ce.png
        title: '进入「最新遥测」标签页，应能看到之前发布的「temperature」读数。'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-2-1-connect-device-4-ce.png
        title: '关闭设备详情标签并刷新「设备」表格，设备状态应从「非活动」变为「活动」。'

step31:
    0:
        image: /images/helloworld/getting-started-ce/create-dashboard-1-ce.png
        title: '通过屏幕左侧主菜单进入「仪表盘」页面，点击右上角「+」并从下拉菜单选择「创建新仪表盘」。'
    1:
        image: /images/helloworld/getting-started-ce/create-dashboard-2-ce.png
        title: '在打开的对话框中输入仪表盘标题，描述可选。点击「添加」。'
    2:
        image: /images/helloworld/getting-started-ce/create-dashboard-3-ce.png
        title: '创建后仪表盘会自动打开，可立即添加部件。点击右上角「保存」按钮保存仪表盘。'
    3:
        image: /images/helloworld/getting-started-ce/create-dashboard-4-ce.png
        title: '首个仪表盘创建成功。新仪表盘将出现在列表顶部，默认按创建时间排序。'

step32:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-0-ce.png
        title: '进入仪表盘编辑模式，打开仪表盘并点击屏幕右上角「编辑模式」按钮；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-1-ce.png
        title: '点击屏幕顶部的「添加部件」按钮或中央的「添加新部件」大图标（若为仪表盘首个部件）；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-2-ce.png
        title: '找到「表格」部件组并点击；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-3-ce.png
        title: '选择「实体表格」部件；'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-4-ce.png
        title: '将出现「添加部件」窗口。在「设备」字段中指定之前创建设备「My New Device」作为数据源。「name」键已添加至「列」区域，用于显示设备名称。需再添加一列显示「temperature」键的值，点击「添加列」添加数据键字段；'
    5:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-5-ce.png
        title: '点击新出现的数据键输入框，将列出可用数据键，选择「temperature」；'
    6:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-6-ce.png
        title: '点击部件右下角「添加」按钮完成添加。'
    7:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-table-widget-7-ce.png
        title: '可拖拽部件右下角放大。调整满意后点击「保存」保存仪表盘更改。'

step33:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-chart-widget-1-ce.png
        title: '进入编辑模式，点击屏幕顶部「添加新部件」按钮；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-chart-widget-2-ce.png
        title: '找到「图表」部件组并点击；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-chart-widget-3-ce.png
        title: '选择「时间序列图表」部件；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-chart-widget-4-ce.png
        title: '在「设备」字段指定之前创建设备「My New Device」为数据源。在「系列」中指定数据键「temperature」以监控设备温度。然后点击「添加」；'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-chart-widget-5-ce.png
        title: '调整部件大小并应用更改。如步骤 2 多次发布不同遥测值。注意默认仅显示一分钟数据。点击「保存」应用更改；'

step33_2:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-3-1-add-chart-widget-6-ce.png
        title: '可调整部件数据展示时间间隔、聚合函数及分组间隔。打开时间窗口进行设置，点击「更新」按钮应用。'

step34:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-3-4-add-alarm-widget-1-ce.png
        title: '进入编辑模式，点击屏幕顶部「添加新部件」按钮；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-3-4-add-alarm-widget-2-ce.png
        title: '找到「告警部件」组并点击；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-3-4-add-alarm-widget-3-ce.png
        title: '选择「告警表格」部件；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-3-4-add-alarm-widget-4-ce.png
        title: '在「设备」字段指定「My New Device」为数据源。配置筛选器：所有告警有严重程度和状态，勾选要在部件中显示的。若不勾选则显示全部；'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-3-4-add-alarm-widget-5-ce.png
        title: '恭喜，已添加告警部件！默认新部件自上而下堆叠。拖拽「时间序列图表」部件到右上角，为「告警表格」腾出空间；'   
    5:
        image: /images/helloworld/getting-started-ce/hello-world-3-4-add-alarm-widget-6-ce.png
        title: '向下滚动找到「告警表格」部件，拖至空闲区域并调整大小。完成后点击「保存」。'

step4:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-1-ce.png
        title: '进入<b>实体</b>下的<b>设备</b>页面。<br>点击<b>My New Device</b>打开详情，进入<b>告警规则</b>标签。<br>点击「<b>+</b>」按钮，选择<b>创建新告警规则</b>。'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-2-ce.png
        title: '在<b>常规</b>区域指定<b>告警类型</b>——<i>High temperature</i>（或任意名称）——作为告警名称和唯一标识。'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-3-ce.png
        title: '添加参数——规则在评估条件时使用的数据源。'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-4-ce.png
        title: '点击<b>添加触发条件</b>。'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-5-ce.png
        title: '保持<b>严重</b>严重程度，点击<b>添加条件</b>。'
    5:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-6-ce.png
        title: '点击<b>添加参数筛选</b>。'
    6:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-7-ce.png
        title: '<b>常规：</b><b>参数：</b>temperature（之前添加的）；<b>值类型：</b>数值<br><b>筛选：</b>点击<b>添加</b>；<b>操作：</b>大于；<b>值来源：</b>静态；<b>值：</b>25。<br>点击<b>添加</b>。'
    7:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-8-ce.png
        title: '<b>类型：</b>简单。<br><b>保存</b>条件。'
    8:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-9-ce.png
        title: '最后点击<b>添加</b>。'
    9:
        image: /images/helloworld/getting-started-ce/hello-world-4-configure-alarm-rules-10-ce.png
        title: '新告警规则已创建并激活。'

step5:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-5-create-alarm-1-ce.png
        title: '当新<b>temperature</b>值超过阈值时，仪表盘将出现新的活动告警。'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-5-create-alarm-2-ce.png
        title: '可使用<b>告警表格</b>部件<b>确认</b>和<b>清除</b>告警。'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-5-create-alarm-3-ce.png
        title: '告警创建后，<b>通知中心</b>会收到通知。点击右上角铃铛图标查看最新通知。'

notification-center:
    0:
        image: /images/helloworld/getting-started-ce/notification-center-getting-started-1-ce.png
        title: 'ThingsBoard 通知中心可向最终用户发送个性化通知，包括设备活动、环境温度变化或 IoT 生态中检测到的其他事件。'

step71:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-1-ce.png
        title: '进入客户页面，点击「+」添加客户；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-2-ce.png
        title: '输入客户名称并点击「添加」。'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-3-ce.png
        title: '新客户已创建。'

step72:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-1-ce.png
        title: '打开「设备」页面，选择设备打开详情；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-2-ce.png
        title: '点击「分配至客户」按钮；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-3-ce.png
        title: '选择要分配设备的客户，点击「分配」；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-4-ce.png
        title: '设备归属已变更，在「客户」列可看到设备所有者；'

step72_1:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-5-ce.png
        title: '进入「客户」页面确认设备已分配。在客户列表中找到客户，点击「管理客户设备」图标；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-6-ce.png
        title: '设备已归属该客户。'

step72_2:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-8-ce.png
        title: '点击表格右上角「+」图标，从下拉菜单选择「添加新设备」；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-9-ce.png
        title: '输入设备名称（如「Thermostat」），在「分配至客户」字段选择客户，点击「添加」；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-10-ce.png
        title: '关闭连接检查窗口；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-device-to-customer-11-ce.png
        title: '设备已创建，并已归属所选客户。'

step73:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-dashboard-to-customer-3-ce.png
        title: '打开「仪表盘」页面，勾选仪表盘并点击「分配仪表盘」图标；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-dashboard-to-customer-4-ce.png
        title: '勾选「My New Customer」并点击「分配」；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-dashboard-to-customer-5-ce.png
        title: '进入「客户」页面，点击「My New Customer」的「管理客户仪表盘」图标；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-71-assign-dashboard-to-customer-6-ce.png
        title: '「My New Dashboard」已分配给您的客户。'

step74:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-user-1-ce.png
        title: '进入「客户」页面，在客户列表中找到客户，点击「管理客户用户」图标；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-user-2-ce.png
        title: '点击表格右上角「添加用户」图标；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-user-3-ce.png
        title: '输入用于客户用户登录的邮箱，点击「添加」；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-user-4-ce.png
        title: '复制激活链接并妥善保存，稍后用于设置密码。点击「确定」；'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-user-6-ce.png
        title: '点击已创建用户打开详情，点击「铅笔」图标进入编辑模式；'
    5:
        image: /images/helloworld/getting-started-ce/hello-world-7-create-customer-user-7-ce.png
        title: '将「My New Dashboard」设为默认仪表盘并勾选「始终全屏」。应用更改。'

step75:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-7-5-activate-customer-user-1-ce.png
        title: '将之前复制的链接粘贴到新浏览器标签页，按 Enter。输入两次密码并点击「创建密码」。'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-7-5-activate-customer-user-2-ce.png
        title: '您已以客户用户身份登录，可浏览数据并确认/清除告警。'

mqttWindows:
    0:
        image: /images/helloworld/hello-world-step-3-item-1.png
        title: '按下方截图创建新的 MQTT 客户端。' 
    1:
        image: /images/helloworld/hello-world-step-3-item-2.png
        title: '填写主题名称和 payload，确保 payload 为有效 JSON。点击「发布」按钮。' 

mosquitto-windows:
    0:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-1.png
        title: '按 Win + X，选择「系统」，然后点击「系统」页面；'
    1:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-2.png
        title: '进入「关于」区域，点击「高级系统设置」；'
    2:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-3.png
        title: '在「系统属性」弹窗中，点击「高级」标签下的「环境变量」；'
    3:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-4.png
        title: '在「环境变量」弹窗中选中「Path」，点击「编辑」；'
    4:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-5.png
        title: '在「编辑环境变量」弹窗中点击「新建」，添加包含 mosquitto_pub.exe 和 mosquitto_sub.exe 的目录路径（默认 C:\Program Files\mosquitto）。点击「确定」；'
    5:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-6.png
        title: '点击「确定」保存环境变量更改；'
    6:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-7.png
        title: '最后点击「确定」应用系统属性的所有更改。'

---

* TOC
{:toc}

{% include get-hosts-name.html %}

本指南演示 ThingsBoard 常用功能的基本用法。您将学习如何：

- 将设备连接至 ThingsBoard
- 从设备向 ThingsBoard 推送数据
- 构建实时仪表盘
- 创建客户并分配仪表盘
- 定义阈值并触发告警
- 设置通知

为简化说明，我们将以温度传感器数据为例进行可视化。

<hr>

## 前置条件

您需要一台运行中的 ThingsBoard 服务器：

* **ThingsBoard Cloud**：零配置快速开始。可选择[北美](/docs/paas/getting-started-guides/helloworld/)或[欧洲](/docs/paas/eu/getting-started-guides/helloworld/)区域（链接指向托管服务版快速入门）。
* **自托管安装**：可按 [Windows (Docker)](/docs/user-guide/install/docker-windows/){:target="_blank"} 或 [Linux 与 MacOS (Docker)](/docs/user-guide/install/docker/){:target="_blank"} 指南手动安装。

<hr>

## 步骤 1. 创建设备

添加一个向 ThingsBoard 发送温度数据的设备：

{% include images-gallery.html imageCollection="step1" showListImageTitles="true" %}

添加设备后您会收到通知，点击右上角铃铛图标查看。

{% include images-gallery.html imageCollection="step11" %}

[了解更多通知相关内容](#step-6-alarm-notifications)。

**其他创建设备方式**
- [批量 provisioning](/docs/user-guide/bulk-provisioning/){:target="_blank"}：通过 UI 以 CSV 批量导入设备。
- [设备 provisioning](/docs/user-guide/device-provisioning/){:target="_blank"}：配置设备自动自助注册。
- [REST API](/docs/api/){:target="_blank"} provisioning：通过 API 编程管理设备。

<hr>

## 步骤 2. 连接设备

验证设备与 ThingsBoard 的连接：

{% include images-gallery.html imageCollection="step2" showListImageTitles="true" %}

<br>
查看 [ThingsBoard API 参考](/docs/{{docsPrefix}}api){:target="_blank"}，了解更多设备连接支持协议详情。

<hr>

## 步骤 3. 创建仪表盘

ThingsBoard 中的仪表盘用于可视化和监控来自 IoT 设备的数据。

创建仪表盘并添加三个部件，展示实体列表及其最新值，以及指定实体的告警。

### 步骤 3.1 创建空仪表盘

按以下步骤创建新仪表盘：

{% include images-gallery.html imageCollection="step31" showListImageTitles="true" %}

### 步骤 3.2 添加实体表格部件

「实体表格」部件展示实体列表及其最新值，对应所选设备或其他实体，并支持全文搜索和分页。

从部件库选择表格部件。部件按部件组归类，每个部件有数据源，用于决定显示的数据。
要显示步骤 2 发送的「temperature」最新值，需配置数据源。

添加第一个部件：

{% include images-gallery.html imageCollection="step32" showListImageTitles="true" %}

恭喜，您已添加第一个部件。

「实体表格」部件有两列：第一列显示设备名称，第二列显示「temperature」键的值（设备遥测）。每列对应一个已添加的键。

现在可发送新的遥测读数（如[步骤 1](#step-1-provision-device)），会立即显示在表格中。

### 步骤 3.3 添加图表部件

图表部件用于以可定制折线图、柱状图展示时序数据。

从部件库选择图表部件。图表显示同一数据键（此处为「temperature」）的多个历史值。
使用图表部件时还需配置时间窗口。

{% include images-gallery.html imageCollection="step33" showListImageTitles="true" %}

恭喜，图表部件已添加。发送新遥测读数后，将立即显示在图表中。

也可调整部件数据展示时间间隔、聚合函数及分组间隔。
打开[时间窗口](/docs/user-guide/dashboards/#time-window){:target="_blank"}进行设置，点击「更新」按钮应用。

{% include images-gallery.html imageCollection="step33_2" %}

### 步骤 3.4 添加告警表格部件

告警表格部件在指定时间窗口内显示与指定实体相关的告警。
通过指定实体为告警源及对应告警字段来配置告警部件。

{% include images-gallery.html imageCollection="step34" showListImageTitles="true" %}

接下来配置告警规则并触发告警。

> **说明：**本文档以单一设备作为部件数据源。若要以动态实体（如某类型设备或某资产相关设备）为数据源，需使用 alias。Alias 是部件中使用的单个实体或实体组的引用。更多见[不同 alias 说明](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}。

<hr>

## 步骤 4. 配置告警规则

使用[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}功能定义温度超过 **25°C** 时触发的规则。
告警规则可在**设备**级别或目标设备所用的[设备 profile](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"} 级别配置。

> **建议：**若同一规则需应用于多台设备，请在 **Device profile** 级别创建，便于集中管理告警逻辑、简化维护并避免重复配置。

本例中，我们直接在设备「**My New Device**」上配置告警规则。

<br><b><font size="4">步骤 4.1 打开设备设置</font></b>
- 进入**实体**下的**设备**页面。
- 点击**My New Device**打开详情。
- 进入**告警规则**标签。
- 点击「**+**」按钮，选择**创建新告警规则**。

<b><font size="4">步骤 4.2 配置常规参数</font></b>

在**常规**区域指定**告警类型**——*High temperature*（或任意名称）——作为告警名称和唯一标识。

<b><font size="4">步骤 4.3 添加参数</font></b>

在定义告警触发条件前，需至少添加一个**参数**——规则使用的数据源。

在**参数**区域点击**添加参数**，填写：
- **实体类型：***当前实体*
- **参数类型：***最新遥测*
- **时序键：**<span class="code-light">temperature</span>
- **参数名称：**temperature
- 点击**添加**。

将创建用于告警条件的 <span class="code-light">temperature</span> 变量。

<b><font size="4">步骤 4.4 配置告警触发条件</font></b>

在**触发条件**区域点击**添加触发条件**。

- **严重程度：***严重*
- **条件**
  - 点击**添加条件**。
  - 在配置窗口中点击**添加参数筛选**并指定：
    - **常规**块：**参数：**temperature（之前添加的）；**值类型：***数值*
    - **筛选**块：点击**添加**；**操作：***大于*；**值来源：**静态；**值：**<span class="code-light">25</span>
    - 点击**添加**。
  - **类型：***简单*
  - 点击**保存**。

当温度超过 **25°C** 时，告警将立即触发。

<b><font size="4">保存规则</font></b>

点击**添加**按钮保存新告警规则。

规则保存后立即生效。

{% include images-gallery.html imageCollection="step4" %}

建议参阅[告警规则配置示例](/docs/{{docsPrefix}}user-guide/alarm-rules/#examples-of-alarm-rule-configurations/){:target="_blank"}

<hr>

## 步骤 5. 创建告警

告警规则已激活（见[步骤 4](#step-4-configure-alarm-rules)），需从设备发送新遥测（见[步骤 2](#step-2-connect-device)）以触发告警。

> **重要：**仅当温度超过告警创建条件中定义的 25°C 阈值时才会创建告警。

**发送遥测后发生的变化**

{% include images-gallery.html imageCollection="step5" showListImageTitles="true" %}

<hr>

## 步骤 6. 告警通知

ThingsBoard [通知中心](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}可向最终用户发送关于设备活动、环境变化或 IoT 生态中事件的个性化通知。
通知可通过邮件、短信或集成第三方系统送达。

{% include images-gallery.html imageCollection="notification-center" %}

此外，[ThingsBoard 移动应用](/docs/mobile/){:target="_blank"}可向手机推送即时通知，确保您随时掌握关键事件。

按[本指南](/docs/mobile/getting-started/){:target="_blank"}安装 ThingsBoard 移动应用并配置通知。

祝您探索愉快！

<hr>

## 步骤 7. 将设备和仪表盘分配至客户

ThingsBoard 的重要功能之一是将仪表盘分配至客户。
可将不同设备分配给不同客户，创建仪表盘并分配给多名客户。
每位客户用户只能看到自己的设备，无法查看其他客户的数据。

我们已创建设备（见[步骤 1](#step-1-provision-device)）和仪表盘（见[步骤 3](#step-3-create-dashboard)）。
接下来创建客户及客户用户，确保其能访问设备数据和仪表盘。

### 步骤 7.1 创建客户

创建标题为「My New Customer」的客户，操作如下：

{% include images-gallery.html imageCollection="step71" showListImageTitles="true" %}

### 步骤 7.2 将设备分配至客户

将设备分配至客户。客户用户可读写遥测并向设备发送命令。

{% include images-gallery.html imageCollection="step72" showListImageTitles="true" %}

确认设备已分配至客户。

{% include images-gallery.html imageCollection="step72_1" showListImageTitles="true" %}

可在创建设备时即指定客户为所有者，步骤如下：

{% include images-gallery.html imageCollection="step72_2" showListImageTitles="true" %}

### 步骤 7.3 将仪表盘分配至客户

将仪表盘分享给客户。客户用户对仪表盘仅具只读权限。

{% include images-gallery.html imageCollection="step73" showListImageTitles="true" %}

### 步骤 7.4 创建客户用户

创建归属于该客户、对仪表盘和设备具有`read-only`权限的用户。
可选择配置用户登录平台 Web UI 后直接显示该仪表盘。

{% include images-gallery.html imageCollection="step74" showListImageTitles="true" %}

### 步骤 7.5 激活客户用户

最后以客户用户身份登录 ThingsBoard。

{% include images-gallery.html imageCollection="step75" showListImageTitles="true" %}

<hr>

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/guides-banner.md %}

<hr>

## 您的反馈

欢迎在 [GitHub](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星以支持我们。
若有任何疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。