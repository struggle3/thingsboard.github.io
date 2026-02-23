---
layout: docwithnav
title: 4G LTE 工业路由器与 ThingsBoard
description: 4G LTE 工业路由器与 ThingsBoard PE 平台
hidetoc: "true"
---

* TOC
{:toc}

## 简介

本文介绍如何配置 ThingsBoard PE 平台并连接 KERNEL 设备。ThingsBoard PE 平台是一款开源IoT平台，用于数据采集、处理、可视化及设备管理。支持通过业界标准 MQTT 协议实现设备连接。ThingsBoard 兼具可扩展性、容错与高性能，确保数据不丢失。

## 集成流程：

### 步骤 1 ThingsBoard：设备配置

* [步骤 1.1] 登录 ThingsBoard 实例，打开「Device Groups」页面。
<br>
<img src="/images/samples/kingpigeon/home.png" width="1000" alt="home">
<br>

* [步骤 1.2] 进入默认设备组「All」。
<br>
<img src="/images/samples/kingpigeon/device.png" width="1000" alt="device">
<br>1.在 Device groups 概览页面点击红框任一按钮。此页面还可添加额外设备组以区分不同数据流的设备。
<br>2.点击标出的「+」按钮向组内添加新设备。
<br>

* [步骤 1.3] 输入设备名称，例如「R40」。此时无需其他修改。点击「Next:Credentials」配置凭证。
<br>
<img src="/images/samples/kingpigeon/device_new.png" width="1000" alt="device new">
<br>

* [步骤 1.4] 凭证类型：MQTT Basic
<br>
<img src="/images/samples/kingpigeon/mqtt_basic.png" width="1000" alt="mqtt basic">
<br>1.选择凭证类型：MQTT Basic。
<br>2.设置 Client ID，例如「R40」。
<br>3.设置用于 MQTT 鉴权的用户名。
<br>4.设置用于 MQTT 鉴权的密码。
<br>

### 步骤 2 工业路由器配置

* [步骤 2.1] 登录路由器。默认用户名为「admin」，无密码。
<br>
<img src="/images/samples/kingpigeon/r4000.png" width="800" alt="step 1">
<br>

* [步骤 2.2] 点击菜单「Cloud platform」->「Custom cloud」->「Add」添加云配置。
<br>
<img src="/images/samples/kingpigeon/r4001.png" width="800" alt="step 2">
<br>

* [步骤 2.3] 点击「Edit」编辑配置。
<br>
<img src="/images/samples/kingpigeon/r4002.png" width="800" alt="step 3">
<br>

* [步骤 2.4] 编辑 ThingsBoard 配置。
<br>
<img src="/images/samples/kingpigeon/r4003.png" width="800" alt="step 4">
<br>1.选择 ThingsBoard 平台。
<br>2.设置 MQTT ID，见「步骤 1.4」。
<br>3.设置用户名，见「步骤 1.4」。
<br>4.设置密码，见「步骤 1.4」。
<br>5.设置发布周期。
<br>6.点击「Save」保存配置，「Back to Overview」返回概览。
<br>

* [步骤 2.5] 勾选「Enable setting」，点击「Save&Apply」应用配置。
<br>
<img src="/images/samples/kingpigeon/r4004.png" width="800" alt="step 5">
<br>

### 步骤 3 向仪表板添加部件
* [步骤 3.1] 采集的数据可通过多种部件展示。要创建部件，需能在 Latest telemetry 中看到采集数据。按以下步骤访问：
<br>
<img src="/images/samples/kingpigeon/telemetry.png" width="1000" alt="telemetry">
<br>1.点击已配置的设备。
<br>2.从弹出菜单选择 Latest telemetry。应能看到采集数据。
<br>

* [步骤 3.2] 要在部件中展示数据，应：
<br>
<img src="/images/samples/kingpigeon/telemetry02.png" width="1000" alt="telemetry 2">
<br>1.点击采集数据行。
<br>2.点击 Show on widget 按钮。
<br>
<img src="/images/samples/kingpigeon/chart.png" width="1000" alt="chart 1">
<br>1.根据数据选择 bundle。
<br>2.选择适合数据可视化的图表。
<br>3.将部件添加到仪表板。
<br>
<img src="/images/samples/kingpigeon/chart02.png" width="400" alt="chart 2">
<br>1.创建新仪表板。
<br>2.启用此选项后，添加后会跳转到新创建的仪表板
<br>3.将部件添加到仪表板。
<br>
<img src="/images/samples/kingpigeon/chart03.png" width="400" alt="chart 3">
<br>

可参考以下 ThingsBoard 主要功能指南：

 - [Create Dashboard](/docs/getting-started-guides/helloworld/#step-3-create-dashboard) - 如何创建新仪表板
 - [Working with IoT dashboards](/docs/user-guide/dashboards/) - 如何使用仪表板
<br>

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
