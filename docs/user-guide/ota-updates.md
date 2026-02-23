---
layout: docwithnav
assignees:
- ashvayka
title: OTA 固件与软件更新
description: IoT 设备固件与软件更新
 
createFirmware:
    0:
        image: /images/user-guide/firmware/add-firmware-ce.png  
        title: '需输入 title 和 version；选择 type 和 device profile（该字段定义此固件适用于何类设备）；选择包含固件的文件。可选添加 checksum algorithm 和 checksum。'

listFirmware:
    0:
        image: /images/user-guide/firmware/list-firmware-ce.png
        title: ''
    1:
        image: /images/user-guide/firmware/list-firmware-1-ce.png
        title: ''
    2:
        image: /images/user-guide/firmware/list-firmware-2-ce.png
        title: ''
    3:
        image: /images/user-guide/firmware/list-firmware-3-ce.png
        title: ''

deviceFirmware:
    0:
        image: /images/user-guide/firmware/device-firmware-ce.png
        title: '进入 Device 页面，打开需编辑的设备详情。'
    1:
        image: /images/user-guide/firmware/device-firmware-1-ce.png
        title: '在下拉菜单中选择要分配给该设备的固件。'
    3:
        image: /images/user-guide/firmware/device-firmware-2-ce.png
        title: '选择固件后，点击页面右侧的橙色对勾应用更改。'
    4:
        image: /images/user-guide/firmware/device-firmware-3-ce.png
        title: '。'

fw-deviceprofile:
    0:
        image: /images/user-guide/firmware/fw-deviceprofile-ce.png
        title: '进入 Device profile 页面，打开需编辑的 device profile 详情。'
    1:
        image: /images/user-guide/firmware/fw-deviceprofile-1-ce.png
        title: '在下拉菜单中选择要分配给此 device profile 的固件。'
    2:
        image: /images/user-guide/firmware/fw-deviceprofile-2-ce.png
        title: '选择固件后，点击页面右侧的橙色对勾应用更改。'

fw-attributes:
    0:
        image: /images/user-guide/firmware/fw-attributes-ce.png
        title: ''

fw-dashboard:
    0:
        image: /images/user-guide/firmware/fw-dashboard-ce.png
        title: '在 Firmware dashboard 中监控设备固件状态。可查看所有设备的固件信息列表，使用页面右侧选项卡查看更详细的状态。'
    1:
        image: /images/user-guide/firmware/fw-dashboard-2-ce.png
        title: '点击设备名称旁的按钮可查看具体设备的固件状态。'

fw-status:
    0:
        image: /images/user-guide/firmware/fw-status-ce.png
        title: ''
    1:
        image: /images/user-guide/firmware/fw-status-1-ce.png
        title: ''

sw-dashboard:
    0:
        image: /images/user-guide/firmware/sw-dashboard-1-ce.png
        title: '在 Software dashboard 中监控设备软件状态。'
    1:
        image: /images/user-guide/firmware/sw-dashboard-2-ce.png
        title: '点击设备名称旁的按钮可查看具体设备的软件状态。'

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
        title: '进入 Device group 页面，打开要编辑的 device group 详情。'
    1:
        image: /images/user-guide/firmware/fw-devicegroup-1-pe.png
        title: '在下拉菜单中选择要分配给该设备的 OTA 包。'
    3:
        image: /images/user-guide/firmware/fw-devicegroup-2-pe.png
        title: '选择固件后，点击页面右侧的橙色对勾应用更改。'
    4:
        image: /images/user-guide/firmware/fw-devicegroup-3-pe.png
        title: '。'

---

{% include get-hosts-name.html %}
{% include docs/user-guide/ota-updates.md %}