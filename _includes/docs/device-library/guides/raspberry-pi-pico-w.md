
{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign arduinoBoardPath="**Raspberry Pi Pico/RP2040** > **Raspberry Pi Pico W**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 概述


继广受欢迎的 Raspberry Pi Pico 之后，Raspberry Pi Pico W 成为基于 RP2040 的无线版本，新增 2.4 GHz 802.11n Wi-Fi 连接。  
无线功能使 Pico W 适用于更多项目场景，如远程传感器读数、遥控、智能家居、迷你 Web 服务器、无线 GPIO 控制等。  
Pico W 核心为 RP2040，与初代 Raspberry Pi Pico 相同，双核 ARM Cortex-M0+，主频 133 MHz，256 KB RAM，30 个 GPIO 引脚，以及丰富的接口选项，搭配 2 MB 板载 QSPI Flash 存储程序与数据。  
Wi-Fi 由英飞凌 CYW43439 无线芯片实现。

{% include /docs/device-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需库和工具 {#install-required-libraries-and-tools}

{% include /docs/device-library/blocks/microcontrollers/raspberry-pi-pico-arduino-library-install-block.md %}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/device-library/blocks/microcontrollers/rp2040-general-code-to-program-block.md %}

## 在 ThingsBoard 上查看数据 {#check-data-on-thingsboard}
{% include /docs/device-library/blocks/basic/thingsboard-upload-example-dashboard.md %}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-check-example-data-block.md %}

## 使用客户端和共享属性请求同步设备状态 {#synchronize-device-state-using-client-and-shared-attribute-requests}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-synchronize-device-state-using-attribute-requests-block.md %}

## 使用共享属性控制设备 {#control-device-using-shared-attributes}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-update-shared-attributes-device-block.md %}

## 使用 RPC 控制设备 {#control-device-using-rpc}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-send-rpc-to-device-block.md %}

## 总结
{% include /docs/device-library/blocks/basic/conclusion-block.md %}
{% include add-device-banner.liquid %}
