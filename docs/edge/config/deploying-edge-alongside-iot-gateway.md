---
layout: docwithnav-edge
title: 将ThingsBoard Edge与ThingsBoard IoT Gateway一并部署
description: 将ThingsBoard Edge与ThingsBoard IoT Gateway一并部署

startEdge:
  0:
    image: /images/devices-library/edge/recomputer-r1000/installation-add-edge-item-1.webp
    title: '登录您的<b>云账户</b>，进入<b>Edge管理 > 实例</b>区域。点击<b>"+"</b>按钮并选择<b>"添加新Edge"</b>选项。'
  1:
    image: /images/devices-library/edge/recomputer-r1000/installation-add-edge-item-2.webp
    title: '在<b>"添加Edge"</b>弹出窗口中，在<b>"名称"</b>框中输入Edge名称，点击<b>"添加"</b>按钮。'
  2:
    image: /images/devices-library/edge/recomputer-r1000/installation-add-edge-item-3.webp
    title: '<b>Edge实例</b>将显示在列表顶部，因为条目默认按创建时间排序。'

copyYml:
    0:
        image: /images/devices-library/edge/recomputer-r1000/1.2-instrucrions-button.webp
        title: '进入<b>Edge管理 > 实例</b>区域，点击<b>Edge实例</b>。在<b>Edge详情</b>页面，点击<b>"安装与连接说明"</b>按钮。'
    1:
        image: /images/devices-library/edge/recomputer-r1000/1.3-docker.webp
        title: '在<b>"安装与连接说明"</b>弹出窗口中，选择<b>"Docker"</b>选项卡并复制配置行。'
    2:
        image: /images/edge/config/paste-yml-terminal.webp
        title: '将复制的行粘贴到终端的<b>docker-compose.yml</b>文件中并保存。按<b>CTRL+X</b>关闭文件。'

provisionGW:
    0:
        image: /images/devices-library/edge/recomputer-r1000/1-instances-section.webp
        title: '登录云平台，进入<b>Edge管理 > 实例</b>区域，点击<b>"管理仪表板"</b>按钮。'
    1:
        image: /images/devices-library/edge/recomputer-r1000/2-assign-dashboard.webp
        title: '点击<b>"+"</b>按钮。在弹出窗口的下拉菜单中选择<b>"ThingsBoard IoT Gateways"</b>仪表板。点击<b>"分配"</b>按钮将其分配给<b>Edge实例</b>。<b>"ThingsBoard IoT Gateways"</b>仪表板为预置的开箱即用仪表板之一。'
    2:
        image: /images/devices-library/edge/recomputer-r1000/3-login-to-edge.webp
        title: '使用 <a href="http://127.0.0.1:8080" target="_blank">http://127.0.0.1:8080</a> 打开<b>Edge实例</b>，使用您的凭据登录，进入<b>仪表板</b>区域打开<b>"ThingsBoard IoT Gateways"</b>仪表板。'
    3:
        image: /images/devices-library/edge/recomputer-r1000/4-add-gw.webp
        title: '点击<b>"+"</b>按钮添加新的<b>IoT Gateway</b>设备。在<b>"名称"</b>框中输入网关名称，选择<b>"default"</b>设备配置。点击<b>"创建"</b>按钮。'
    4:
        image: /images/edge/config/launch-command.webp
        title: '从<b>"启动命令"</b>弹出窗口为您的IoT Gateway设备下载<b>docker-compose.yml</b>文件。'

copyPasteYml:
    0:
        image: /images/devices-library/edge/recomputer-r1000/10-copy-paste-configs.webp
---

{% assign docsPrefix = "edge/" %}
{% include docs/edge/user-guide/config/deploying-edge-alongside-iot-gateway.md %}