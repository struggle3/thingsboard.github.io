{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
{% assign deviceName = page.title | remove: "How to install ThingsBoard Edge on " | remove: "?" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client library](https://pypi.org/project/tb-mqtt-client/){:target='_blank' rel='noopener'}
- [python ≥ 3.7](https://www.python.org/){:target='_blank' rel='noopener'}
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/){:target='_blank' rel='noopener'} "
  %}
{% else %}  
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [tb-mqtt-client library](https://pypi.org/project/tb-mqtt-client/){:target='_blank' rel='noopener'}
- [python ≥ 3.7](https://www.python.org/){:target='_blank' rel='noopener'}
- [Adafruit-Blinka](https://pypi.org/project/Adafruit-Blinka/){:target='_blank' rel='noopener'} "
 %}
{% endif %}

## 概述

NVIDIA Jetson Xavier NX Developer Kit 是一款紧凑型高性能 AI 计算机，在小尺寸下提供最高 21 TOPS 加速算力。
面向自主机器、工业机器人及需边缘高性能 AI 的嵌入式系统。

{% include /docs/device-library/blocks/basic/introduction-block.md %}

{% if page.docsPrefix == "pe/edge/" or page.docsPrefix == "edge/" %}
## 在 {{deviceName}} 上启动 Edge {#starting-edge-on-device}
{% assign userName = "nvidia" %}
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
{% assign hostName = "NVIDIA_JETSON_XAVIER_NX_IP_ADDRESS" %}
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
