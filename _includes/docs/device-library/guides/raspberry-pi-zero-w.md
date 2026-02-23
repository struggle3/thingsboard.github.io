
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client library](https://pypi.org/project/tb-mqtt-client/)
- [python ≥ 3.7](https://www.python.org/)
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/) "
 %}

## 概述

Raspberry Pi Zero W 是一款小巧、低成本、功能强大的单板计算机，面向 DIY 爱好者、创客和极客。
它是广受欢迎的 Raspberry Pi Zero 的衍生型号，以微型尺寸和高性价比著称。
型号中的「W」代表「wireless」（无线），板子配备 Wi-Fi 与 Bluetooth 连接。
可轻松连接互联网、其他设备及各类传感器和外设。
尽管尺寸仅 65 mm × 30 mm × 5 mm，Raspberry Pi Zero W 仍具备丰富功能：博通 BCM2835 处理器（1 GHz）、512 MB RAM、mini-HDMI、用于供电与数据的 micro-USB、CSI 摄像头接口以及 40 针 GPIO 扩展。
板子运行基于 Linux 的 Raspbian 系统，兼容多种软件、工具和编程语言。
适合学习、原型设计及构建各类项目，如智能家居、机器人、媒体中心等。

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
