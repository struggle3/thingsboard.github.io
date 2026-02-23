
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client library](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 概述

NVIDIA Jetson Nano Developer Kit 是一款小巧且性能强劲的计算机，可并行运行多组神经网络，适用于图像分类、目标检测、语音处理等应用。
适合创客与开发者构建边缘智能设备。


{% include /docs/device-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需库和工具 {#install-required-libraries-and-tools}

{% include /docs/device-library/blocks/single-board-computers/install-required-libraries-and-tools-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/device-library/blocks/single-board-computers/general-code-to-program-block.md %}

## 使用客户端和共享属性请求同步设备状态 {#synchronize-device-state-using-client-and-shared-attribute-requests}
{% include /docs/device-library/blocks/single-board-computers/thingsboard-synchronize-device-state-using-attribute-requests-block.md %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
{% include /docs/device-library/blocks/single-board-computers/check-data-on-thingsboard-block.md %}

## 使用共享属性控制设备 {#control-device-using-shared-attributes}

{% include /docs/device-library/blocks/single-board-computers/update-shared-attributes-block.md %}

## 使用 RPC 控制设备 {#control-device-using-rpc}

{% include /docs/device-library/blocks/single-board-computers/using-rpc-block.md %}

## 总结

{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}
