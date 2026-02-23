{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
{% assign deviceName = page.title | remove: "How to install ThingsBoard Edge on " | remove: "?" %}
{% assign prerequisites = "
- [" | append: deviceName | append: "](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/){:target='_blank' rel='noopener'}
- [tb-mqtt-client library](https://pypi.org/project/tb-mqtt-client/){:target='_blank' rel='noopener'}
- [python ≥ 3.7](https://www.python.org/){:target='_blank' rel='noopener'}
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/){:target='_blank' rel='noopener'} "
 %}
{% else %}  
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign prerequisites = "
- [" | append: deviceName | append: "](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/){:target='_blank' rel='noopener'}
- [tb-mqtt-client library](https://pypi.org/project/tb-mqtt-client/){:target='_blank' rel='noopener'}
- [python ≥ 3.7](https://www.python.org/){:target='_blank' rel='noopener'}
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/){:target='_blank' rel='noopener'} "
 %}
{% endif %}

## 概述
Raspberry Pi 一直是低成本单板计算机的标杆，广泛应用于机器人、智能家居设备、数字终端等。
2019 年推出的 Raspberry Pi 4 将 Pi 系列提升到新高度，性能足以应付日常桌面 PC 使用，支持 60 Hz 的 4K 视频输出或双显示器。
近期推出的 Raspberry Pi 4（8GB）型号提供足够内存，可用于桌面计算、办公及数据库托管。

{% include /docs/device-library/blocks/basic/introduction-block.md %}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
## 在 {{deviceName}} 上启动 Edge {#starting-edge-on-device}
{% assign userName = "pi" %}
{% include /templates/edge/devices-library/install-edge-gw.md %}
{% endif %}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
## 在 ThingsBoard Edge 中创建设备 {#create-device-on-thingsboard-edge}
{% else %}
## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}
{% endif %}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需库和工具 {#install-required-libraries-and-tools}

{% include /docs/device-library/blocks/single-board-computers/install-required-libraries-and-tools-block.md %}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
{% assign hostName = "RPi_4_IP_ADDRESS" %}
## 连接设备到 ThingsBoard Edge {#connect-device-to-thingsboard-edge}
{% else %}
## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% endif %}

{% include /docs/device-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/device-library/blocks/single-board-computers/general-code-to-program-block.md %}

## 使用客户端和共享属性请求同步设备状态 {#synchronize-device-state-using-client-and-shared-attribute-requests}

{% include /docs/device-library/blocks/single-board-computers/thingsboard-synchronize-device-state-using-attribute-requests-block.md %}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
## 在 ThingsBoard Edge 上查看数据 {#check-data-on-thingsboard-edge}
{% else %}
## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
{% endif %}

{% include /docs/device-library/blocks/single-board-computers/check-data-on-thingsboard-block.md %}

## 使用共享属性控制设备 {#control-device-using-shared-attributes}

{% include /docs/device-library/blocks/single-board-computers/update-shared-attributes-block.md %}

## 使用 RPC 控制设备 {#control-device-using-rpc}

{% include /docs/device-library/blocks/single-board-computers/using-rpc-block.md %}

## 总结

{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}
