{% assign boardLedCount = 1 %}
{% assign hasCamera = "true" %}
{% assign deviceName = page.title | remove: "如何将 " | remove: " 连接至 ThingsBoard？" | remove: "How to connect " | remove: "to ThingsBoard?" %}
{% assign arduinoBoardPath = "**M5Stack** > **M5TimerCAM** (Or M5Stack-Timer-CAM in older ESP-IDF versions)" %}
{% assign prerequisites = "
- [" | append: deviceName | append: "](https://shop.m5stack.com/collections/m5-cameras/products/esp32-psram-timer-camera-fisheye-ov3660)
- [Arduino IDE](https://www.arduino.cc/en/software)"
 %}

## 概述

[M5Stack Timer Camera F](https://shop.m5stack.com/collections/m5-cameras/products/esp32-psram-timer-camera-fisheye-ov3660) 是基于 ESP32-D0WDQ6-V3 的鱼眼摄像头模块，板载 8 MB PSRAM 与 4 MB Flash。  
OV3660 传感器 300 万像素，DFOV 120°，最高分辨率 2048×1536。  
采用超低功耗设计，板载 RTC（BM8563）可输出 IRQ 信号，用于睡眠与定时唤醒（睡眠电流低至 2 µA）。  
内置 270 mAh 电池，定时拍照（每小时一张）可续航超过一个月。  
支持 Wi-Fi 图像传输与 USB 口调试，底部 HY2.0-4P 可扩展其他外设。  
板载 LED 状态指示与复位键，便于程序开发与调试。  

{% include /docs/device-library/blocks/basic/introduction-block.md %}

## 在 ThingsBoard 中创建设备 {#create-device-on-thingsboard}

{% include /docs/device-library/blocks/basic/thingsboard-create-device-block.md %}

## 安装所需库和工具 {#install-required-libraries-and-tools}

{% include /docs/device-library/blocks/microcontrollers/m5stack-arduino-library-install-block.md %}

{% include /docs/device-library/blocks/microcontrollers/thingsboard-arduino-library-install-block.md %}

## 连接设备到 ThingsBoard {#connect-device-to-thingsboard}
{% include /docs/device-library/blocks/basic/thingsboard-provide-device-access-token-block.md %}

{% include /docs/device-library/blocks/microcontrollers/camera-code-to-program-block.md %}

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