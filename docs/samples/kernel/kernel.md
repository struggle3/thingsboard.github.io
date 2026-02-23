---
layout: docwithnav
title: PLC KERNEL 与 ThingsBoard
description: 使用 ThingsBoard PE 平台监测 PLC KERNEL
hidetoc: "true"
---

* TOC
{:toc}

## 简介 / 概要

本文介绍如何配置 ThingsBoard PE 平台并连接 KERNEL 设备。ThingsBoard PE 平台是一款开源IoT平台，用于数据采集、处理、可视化及设备管理。支持通过业界标准 MQTT 协议实现设备连接。ThingsBoard 兼具可扩展性、容错与高性能，确保数据不丢失。

## 说明

本流程适用于所有配备带以太网口的 ARM 微处理器的 KERNEL PLC。

## 集成流程：

### 步骤 1 ThingsBoard：设备配置

* [步骤 1.1] 登录 ThingsBoard 实例。
<br>
<img src="/images/samples/kernel/Thingsboard 000.png" width="400" alt="Thingsboard 1">
<br>
<br>

* [步骤 1.2] 打开「Device Groups」页面。
<br>
<img src="/images/samples/kernel/Thingsboard 002.png" width="1000" alt="Thingsboard 2">
<br>
<br>

* [步骤 1.3] 进入默认设备组「ALL」。
<br>
<img src="/images/samples/kernel/Thingsboard 003.png" width="1000" alt="Thingsboard 3">
<br>
<br>

* [步骤 1.4] 点击表格右上角「+」图标，选择「Add Device」。
<br>
<img src="/images/samples/kernel/Thingsboard 004.png" width="1000" alt="Thingsboard 4">
<br>
<br>

* [步骤 1.4a] 输入设备名称，例如「PLC KERNEL Device」。此时无需其他修改。点击「Add」添加设备。
<br>
<br>

* [步骤 1.5] 此时设备应排在列表最前，因表格默认按创建时间排序。
<br>
<img src="/images/samples/kernel/Thingsboard 005.png" width="1000" alt="Thingsboard ">
<br>
<br>


### 步骤 2 LogiPaint 配置

连接 PLC KERNEL 设备前需先获取设备凭证。ThingsBoard 支持多种设备凭证。本指南推荐使用默认自动生成的 access token。

* [步骤 2.1] 点击表格中的设备行打开设备详情。
<br>
<img src="/images/samples/kernel/Thingsboard 006.png" width="1000" alt="Thingsboard 6">
<br>
<br>

* [步骤 2.2] 点击「Copy access token」。Token 将复制到剪贴板。请妥善保存。
<br>
<img src="/images/samples/kernel/Thingsboard 007.png" width="1000" alt="Thingsboard 7">
<br>
<br>

* [步骤 2.3] 打开「LogicPaint」。
<br>
<img src="/images/samples/kernel/LogicPaint 000.jpg" width="1000" alt="LogicPaint 0">
<br>
<br>

* [步骤 2.4] 通过串口将 PLC KERNEL 连接到 PC。
<br>
<br>

* [步骤 2.5] 打开菜单「File」>>「Show Ethernet Port Configuration」。
<br>
<img src="/images/samples/kernel/LogicPaint 001.png" width="1000" alt="LogicPaint 1">
<br>
<br>

* [步骤 2.6] 点击「MQTT Configuration」按钮：
<br>
<img src="/images/samples/kernel/LogicPaint 002.png" width="1000" alt="LogicPaint 2">
<br>
<br>

* [步骤 2.7] 将复制的 access token 粘贴到指定框：
<br>
<img src="/images/samples/kernel/LogicPaint 003.png" width="1000" alt="LogicPaint 3">
<br>
<br>

* [步骤 2.8] 填写以下字段：
<br>
<img src="/images/samples/kernel/Table 000.png" width="1000" alt="Table 0">
<br>
<br>

* [步骤 2.9] 为每个需要监测的数值添加 slot：
<br>
<img src="/images/samples/kernel/Table 001.png" width="1000" alt="Table 1">
<br>
<br>

* [步骤 2.10] 使用 CLOSE 按钮关闭两个打开的窗口。
<br>
<br>

* [步骤 2.11] 最后使用「Compile + Send Application」按钮编译并将应用发送到 KERNEL PLC。
<br>
<br>

* [步骤 2.12] 成功发布「temperature」读数后，应能立即在设备遥测选项卡中看到。点击表格中的设备行打开设备详情：
<br>
<img src="/images/samples/kernel/Thingsboard 006.png" width="1000" alt="Thingsboard 6">
<br>
<br>

* [步骤 2.13] 进入「Latest telemetry」选项卡：
<br>
<img src="/images/samples/kernel/Thingsboard 008.png" width="1000" alt="Thingsboard 8">
<br>
<br>

### 步骤 3 创建仪表板

最后一步是根据需要创建仪表板。
仪表板用于收集和展示数据集。可通过丰富的部件实现数据可视化。
可参考以下 ThingsBoard 主要功能指南：

 - [Create Dashboard](/docs/getting-started-guides/helloworld/#step-3-create-dashboard) - 如何创建新仪表板
 - [Working with IoT dashboards](/docs/user-guide/dashboards/) - 如何使用仪表板
<br>
<br>

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
