---
layout: docwithnav-pe
assignees:
- ashvayka
title: 空中固件与软件更新
description: IoT 设备固件更新
 
createFirmware:
    0:
        image: /images/user-guide/firmware/add-firmware-pe.png  
        title: '需输入标题和版本；选择类型和设备档案（该字段定义此固件适用于哪些类型的设备）；选择包含固件的文件。可选：添加校验和算法和校验和。'

listFirmware:
    0:
        image: /images/user-guide/firmware/list-firmware-pe.png
        title: ''
    1:
        image: /images/user-guide/firmware/list-firmware-1-pe.png
        title: ''
    2:
        image: /images/user-guide/firmware/list-firmware-2-pe.png
        title: ''
    3:
        image: /images/user-guide/firmware/list-firmware-3-pe.png
        title: ''     


fw-deviceprofile:
    0:
        image: /images/user-guide/firmware/fw-deviceprofile-pe.png
        title: '.'
    1:
        image: /images/user-guide/firmware/fw-deviceprofile-1-pe.png
        title: '.'
    2:
        image: /images/user-guide/firmware/fw-deviceprofile-2-pe.png
        title: '.'
    3:
        image: /images/user-guide/firmware/fw-deviceprofile-3-pe.png
        title: '.'

deviceFirmware:
    0:
        image: /images/user-guide/firmware/device-firmware-pe.png
        title: '进入设备页面，打开目标设备详情以编辑其信息。'
    1:
        image: /images/user-guide/firmware/device-firmware-1-pe.png
        title: '从下拉菜单中选择要分配给该设备的固件。'
    3:
        image: /images/user-guide/firmware/device-firmware-2-pe.png
        title: '选择固件后，点击页面右侧的橙色对勾应用更改。'
    4:
        image: /images/user-guide/firmware/device-firmware-3-pe.png
        title: '.'

fw-attributes:
    0:
        image: /images/user-guide/firmware/fw-attributes-pe.png
        title: ''

fw-dashboard:
    0:
        image: /images/user-guide/firmware/fw-dashboard-pe.png
        title: '在固件仪表板中监控和跟踪设备的固件状态。'
    1:
        image: /images/user-guide/firmware/fw-dashboard-1-pe.png
        title: '点击设备名称旁的按钮可查看特定设备的固件状态详情。'

fw-status:
    0:
        image: /images/user-guide/firmware/fw-status-pe.png
        title: ''
    1:
        image: /images/user-guide/firmware/fw-status-1-pe.png
        title: ''

sw-dashboard:
    0:
        image: /images/user-guide/firmware/sw-dashboard-1-pe.png
        title: '在软件仪表板中监控和跟踪设备的软件状态。'
    1:
        image: /images/user-guide/firmware/sw-dashboard-2-pe.png
        title: '点击设备名称旁的按钮可查看特定设备的软件状态详情。'

fw-http-updated:
    0:
        image: /images/user-guide/firmware/fw-http-updated.png
        title: ''

fw-mqtt-updated:
    0:
        image: /images/user-guide/firmware/fw-mqtt-updated.png
        title: ''

fw-coap-updated:
    0:
        image: /images/user-guide/firmware/fw-coap-updated.png
        title: ''

fw-devicegroup:
    0:
        image: /images/user-guide/firmware/fw-devicegroup-pe.png
        title: '进入设备档案页面，打开目标设备档案详情以编辑其信息。'
    1:
        image: /images/user-guide/firmware/fw-devicegroup-1-pe.png
        title: '从下拉菜单中选择要分配给该设备档案的固件。'
    2:
        image: /images/user-guide/firmware/fw-devicegroup-2-pe.png
        title: '选择固件后，点击页面右侧的橙色对勾应用更改。'
    3:
        image: /images/user-guide/firmware/fw-devicegroup-3-pe.png
        title: ''

fw-scheduler:
    0:
        image: /images/user-guide/firmware/fw-scheduler-pe.png
    1:
        image: /images/user-guide/firmware/fw-scheduler-1-pe.png
    2:
        image: /images/user-guide/firmware/fw-scheduler-2-pe.png

fw-calendar:
    0:
        image: /images/user-guide/firmware/fw-scheduler-3-pe.png


---

{% assign docsPrefix = "pe/" %}
{% include get-hosts-name.html docsPrefix=docsPrefix %}
{% include docs/user-guide/ota-updates.md %}

## 将 OTA 包分配给设备组

专业版允许您将固件/软件分配给特定设备组，以自动分发到该组内的所有设备。参见下方截图。

{% include images-gallery.html imageCollection="fw-devicegroup" %}

设备组详情中仅可选择兼容的 OTA 更新包（详见[预配置](/docs/{{docsPrefix}}user-guide/ota-updates/#provision-ota-package-to-thingsboard-repository)）。固件/软件的分配会触发[更新流程](/docs/{{docsPrefix}}user-guide/ota-updates/#update-process)。

单独分配给设备的固件版本将自动覆盖分配给设备组的固件版本。

例如，假设设备 A1、A2 和 A3 位于同一设备组，但使用不同的设备档案。

* 设备 A1 和 A2 具有兼容的设备档案，设备 A3 不兼容。将此包分配给该设备组时，固件/软件仅会更新设备 A1 和 A2。
* 若仅对设备 A2 更新包，设备 A1 将保持未更新状态。

## 调度器

调度器可设置 OTA 包更新的确切日期和时间。您可以以列表形式查看调度事件，或在日历视图中查看即将发生的事件。
1. 要安排更新，请点击屏幕右上角的加号打开对话框。

2. 在打开对话框的**配置**选项卡中，输入事件名称，从下拉菜单选择事件类型（软件/固件更新）并选择更新目标：
* 若需为设备、设备档案或设备组安排更新，请从下拉菜单中选择实体和所需 OTA 包。
* 若需为设备组所有者安排更新，请从下拉菜单中选择组所有者、该所有者下的特定实体组以及要更新的包。
  
3. 在**计划**选项卡中，选择时区，设置希望实体更新的日期和时间。若需重复执行，请勾选「重复」框。在出现的下拉菜单中选择更新频率。
选择「每周」更新时，应勾选希望更新的星期。基于计时器的更新可设置频率：小时、分钟或秒，以及数值。还需设置重复结束时间。

4. 配置参数和计划时间后，点击「创建」按钮。可通过名称旁的对应按钮编辑或删除已创建的调度事件。在编辑调度事件对话框中可配置 Method 和 Params。
  
{% include images-gallery.html imageCollection="fw-scheduler" %}

在日历中，可通过下拉菜单选择首选视图类型。点击调度事件可编辑或删除。

{% include images-gallery.html imageCollection="fw-calendar" %}
