
{% assign boardLedCount = 3 %}
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign arduinoBoardPath="**Arduino Mbed OS Nano Boards** > **Arduino Nano RP2040 Connect**" %}
{% assign prerequisites = "
- " | append: deviceName | append: "
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 概述


Arduino Nano RP2040 Connect 将树莓派 RP2040 微控制器带入 Nano 尺寸，功能丰富。  
借助 U-blox Nina W102 模块提供的 Bluetooth 与 Wi-Fi 连接，可利用双核 32 位 Arm® Cortex®-M0+ 开发物联网项目。  
板载加速度计、陀螺仪、RGB LED 和麦克风，可直接投入实际项目。  
使用 Arduino Nano RP2040 Connect 可轻松开发嵌入式 AI 应用。

{% include /docs/device-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需库和工具 {#install-required-libraries-and-tools}

{% include /docs/device-library/blocks/microcontrollers/nano-connect-arduino-library-install-block.md %}

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
