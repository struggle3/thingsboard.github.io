---
layout: docwithnav
title: ROLTEK
description: ROLTEK 集成指南

---

* TOC
{:toc}

## 简介

本文介绍如何配置 ThingsBoard 物联网平台并连接 Roltek DC620 设备。
[ThingsBoard IoT](https://thingsboard.io/) 平台是开源物联网平台，用于数据采集、处理、可视化和设备管理。
支持通过行业标准物联网协议（MQTT、CoAP 和 HTTP）实现设备连接，并支持云端和本地部署。
ThingsBoard 兼具可扩展性、容错能力和性能，确保您的数据不会丢失。

## 在 ThingsBoard 中创建设备

Login to your ThingsBoard platform and ppen "**Devices**" page.

![image](/images/samples/roltek/tb1.png)

<br>
Click "**plus**" button then click "**Add new device**" button to add new device.
**Enter name** for your device. Then click "**Next: Credentials**" button;

![image](/images/samples/roltek/tb3.png)

<br>
Enable "**Add credentials**" option. Enter the desirable **Access Token** and click "**Add**" button to save changes.

![image](/images/samples/roltek/tb4.png)

## 配置 Roltek DC620

First connect your device to the Internet via WiFi or Ethernet as described in the user manual.

On the "**MQTT Settings**" page: 
 - Set "**MQTT Mode**" to **enable**;
 - Enter your Thingsboard Server hostname or IP to "**MQTT Broker URI**";
 - Enter your **Access Token** to "**MQTT Broker Username**";
 - Click **Save** button.

![image](/images/samples/roltek/tb5.png)

<br>
Users can add **Nodes** and **Tags** as described in the user manual. In this demo we will work with device’s default node and tags.

On the **Rules** page navigate to the **MQTT Payloads** tab and click Add **MQTT Payload** button.

![image](/images/samples/roltek/tb6.png)

<br>
In new window enter values:
 - Select **Payload Type** - **JSON**;
 - Enter "**{**" to **Header**;
 - Enter **"$V":#V** to **Pattern**;
 - Enter "**,**" to **Seperator**;
 - Enter "**}**" to **Ending**;
 - Click **Save** button.

![image](/images/samples/roltek/tb7.png)

<br>
On the **Rules** page navigate to the **MQTT Publishers** tab and click **Add MQTT Publisher** button.

![image](/images/samples/roltek/tb8.png)

<br>
In new window enter values:
 - Enter publish period you want to **Period**;
 - Choose **QoS** option you want;
 - Choose **Retain** value you want;
 - Enter **"v1/devices/me/telemetry"** to **Topic**;
 - Choose **Payload** we previously added. (**1** in this case);
 - Select **tag** or **tags** you want to publish;
 - Click **Save** button.

![image](/images/samples/roltek/tb9.png)

## 在仪表板中添加部件

采集的数据可通过多种部件显示。要创建部件，需能在「最新遥测」部分查看已采集数据。

To access it you should follow these steps:
 - Go to the **Devices** on the left menu;
 - Select previously configure device;
 - Navigate to the **Latest Telemetry** tab;
 - Click on the gathered data row;
 - Press **Show on widget** button.

![image](/images/samples/roltek/tb10.png)

<br>
Choose widget bundle accordingly to your data. Choose suitable chart for your data visualization. Click "**Add to dashboard**" button.

![image](/images/samples/roltek/tb11.png)

<br>
Now select "**Create new dashboard**". Mark "**Open dashboard**" (with this option enabled after addition you will be redirected to newly created dashboard) and click "**Add**" to create new dashboard.

![image](/images/samples/roltek/tb12.png)

<br>
![image](/images/samples/roltek/tb13.png)

## Next steps

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
