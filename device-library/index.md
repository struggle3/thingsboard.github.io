---
layout: page-with-filter
title: ThingsBoard设备库
description: 设备库与连接指南
containerId: "devices-card-collection"
filterSelector: ".pagination-render-trigger"
itemsSelector: ".card"
itemsPerPage: "18"
searchControl: "#searchCompanyInput"
customTitle: "true"
not-found: "未找到设备..."

filterCollection:
  - label: Platfrom
    selectPlatfrom: true
    filters:
      - label: 社区版
        platform: ce
      - label: 专业版
        platform: pe
      - label: 云服务(North America)
        platform: paas
      - label: 云服务(Europe)
        platform: paas-eu
      - label: Edge
        platform: edge
      - label: Edge专业版
        platform: pe-edge
  - label: Hardware types
    filters:
      - Microcontrollers
      - Single-board computers
      - Gateways
      - Sensors
      - Trackers
      - Other devices
  - label: Connectivity
    filters:
      - HTTP
      - MQTT
      - WIFI
      - Bluetooth
      - BLE
      - Ethernet
      - GSM
      - GPRS
      - GPS
      - LoRaWAN
      - 4G
      - LTE
      - Zigbee
      - LAN
      - WAN
      - SIGFOX
      - 5G
      - KNX
      - NB-IoT
      - LTE-M
      - DigiMesh
      - BACnet
      - RS-485
      - UDP
      - 3G
      - CoAP
      - MODBUS TCP
      - HTTPS
  - label: Industry
    filters:
      - Industrial Manufacturing
      - Security
      - Smart Buildings
      - Environmental Monitoring
      - Smart Cities
      - Transportation & Logistics
      - Retail
      - Healthcare
      - Energy Management
      - Agriculture
  - label: Use cases
    filters:
      - Smart energy
      - Environment Monitoring
      - Smart Office
      - Smart Retail
      - Smart Farming
      - Fleet Tracking
      - Health Care
      - Air Quality Monitoring
      - Waste Management
      - Tank Level Monitoring
      - Smart Metering
      - Smart Irrigation
      - Water Metering
---


<div class="devices-hero">
    <div class="devices-wrapper">
        <div class="devices-hero-text">
            <h1>欢迎使用ThingsBoard设备库</h1>
            <p>设备库汇集了各类指南与代码示例说明如何将常见IoT开发板接入ThingsBoard平台；我们重点提供可编程设备的代码示例，以提升固件工程师的开发效率并持续扩展设备库。<a href="/device-library/guidelines/">参与贡献</a>。</p>
        </div>
        <div class="devices-hero-banner">
            <p>传感器接入</p>
            <a href="/docs/getting-started-guides/connectivity/">查看说明</a>
            <img src="/images/devices-library-icon.svg" width="210" height="210" alt="合作伙伴图标">
        </div>
    </div>
</div>