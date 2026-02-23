---
layout: docwithnav
assignees:
- ddiachenko
title: 使用 Cricket 与 ThingsBoard 打造电池供电的 Wi-Fi 传感器
description: 使用 Cricket 制造的超低功耗 Wi-Fi 温度传感器示例，无需编写代码即可集成到 ThingsBoard
hidetoc: "true"

---

* TOC
{:toc}

## 简介
本指南分步介绍如何将 Things On Edge 的 Cricket Wi-Fi 模块集成到 ThingsBoard。通过几个步骤，我们即可制作一个 Wi-Fi 电池供电传感器，并在 ThingsBoard 中可视化其数据，而无需编写代码。可以是任何类型的传感器，本示例中我们制作温度传感器。

我们将完成以下步骤：
<br>
1) 制作电池供电的 Wi-Fi 传感器
<br>
2) 将传感器连接到 Wi-Fi 网络
<br>
3) 配置传感器将数据发送到 ThingsBoard
<br>

### Things On Edge
Things On Edge 设计易于使用、超低功耗的 Cricket Wi-Fi 模块。其设计目标是快速、简便地制造 IoT 终端节点（如传感器、按钮、开关等）；直接用电池长时间供电；并集成到庞大的软件与互联网服务生态中。所有这些均无需编写任何代码。
<br>
<img src="/images/samples/cricket-wifi/cricket.png" width="50%" alt="Cricket plate">
<br>
![image](/images/samples/cricket-wifi/TB-graph.png)

## 前置条件

### 硬件
* Things On Edge - Cricket Wi-Fi 模块
* 2xAAA 电池座
* 2xAAA 电池

### 制作电池供电的 Wi-Fi 传感器
Cricket Wi-Fi 模块内置温度传感器。本示例中不需要其他硬件外设。但为了获得更准确的温度读数，强烈建议使用外部传感器，如 DS18B20/+

本示例中我们只需将电池连接到 Cricket Wi-Fi 模块即可使用。注意：请使用全新且质量良好的电池，如 Duracel、Energizer。

<img src="/images/samples/cricket-wifi/asm.png" width="50%" alt="Asm plate connection">


### 将 Cricket 连接到 Wi-Fi 网络

<img src="/images/samples/cricket-wifi/TOE-01.png" width="50%" alt="step 1 - press button on TOE">

<img src="/images/samples/cricket-wifi/TOE-02.png" width="50%" alt="step 2 - connect device to TOE">

<img src="/images/samples/cricket-wifi/TOE-03.png" width="50%" alt="step 3 - connect device to WiFi">

<img src="/images/samples/cricket-wifi/TOE-04.png" width="50%" alt="step 4 - connect TOE to WiFi by device">



### 配置 Cricket 向 ThingsBoard 发送数据
现在可以配置 Cricket 将温度读数发送到 ThingsBoard。
<br>

Cricket 支持 MQTT 和 HTTP 协议，我们将使用 HTTP 协议进行集成。需要确保已获取 ThingsBoard 的 Access Token，如下所示：
![image](/images/samples/cricket-wifi/TB-01.png)
<br>

现在可以返回 Cricket 的配置面板完成配置。
<br>
用于向 ThingsBoard 发送数据的完整 URL 应如下所示：
<br>
**https://thingsboard.cloud/api/v1/**ADD YOUR TOKEN HERE**/telemetry**
<br>
<br>
我们还定义以下有效载荷格式：
<br>
{"temperature":#temp}
<br>
其中 #temp 标签会在发送到 ThingsBoard 之前自动替换为温度值。

完整的 Cricket 配置示例如下：
![image](/images/samples/cricket-wifi/TB-02.png)
<br>


配置完成后，必须按如下图所示的右上角重置按钮退出配置面板。
<br>
<img src="/images/samples/cricket-wifi/TOE-last.png" width="50%" alt="Disconnect from TOE">
<br>


若按上述方式配置，设备将每 10 分钟向 ThingsBoard 发送一次数据。数据将如下所示显示在图表中：
![image](/images/samples/cricket-wifi/TB-03.png)

<br>
<br>


### 更多信息

[Cricket Wi-Fi module - Documentation](https://thingsonedge.com/documentation)


{% include templates/feedback.md %}

{% include socials.html %}

## 下一步

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
