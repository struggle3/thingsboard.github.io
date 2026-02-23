
{% assign boardLedCount = 1 %}
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign arduinoBoardPath="**ESP8266** > **NodeMCU 1.0 (ESP-12E Module)**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 概述


NodeMCU 是一款广受欢迎的开发板，在物联网领域应用广泛。
它基于 ESP-12E Wi-Fi 模块，将 Arduino IDE 的简易编程与 Wi-Fi 能力相结合。
借助板载编程器和 CP2102 USB 转串口芯片，可轻松烧录 ESP8266 并在 PC 上查看串口输出，便于原型开发。
NodeMCU 开发板集成 ESP8266，该芯片专为互联世界需求设计。
板载芯片既可托管应用，也可将 Wi-Fi 网络功能从主处理器卸载，灵活部署。

{% include /docs/device-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需库和工具 {#install-required-libraries-and-tools}

{% include /docs/device-library/blocks/microcontrollers/esp8266-arduino-library-install-block.md %}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/device-library/blocks/microcontrollers/general-code-to-program-block.md %}

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
