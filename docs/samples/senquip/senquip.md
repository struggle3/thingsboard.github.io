---
layout: docwithnav
title: 将 Senquip 遥测设备连接到 ThingsBoard
description: 配置 Senquip 遥测设备，使其能够将遥测数据发送到 ThingsBoard。

---

* TOC 
{:toc}

## 简介

ThingsBoard 是面向物联网解决方案的服务管理、数据采集、处理和可视化平台。若您首次使用平台，建议先阅读 [什么是 ThingsBoard](/docs/getting-started-guides/what-is-thingsboard/) 和 [快速入门](/docs/getting-started-guides/helloworld/) 指南。

Senquip 生产可编程遥测设备，如 [ORB-C1](https://www.senquip.com)，可连接任意工业传感器或系统。Senquip 设备可同时保持与第三方端点（通过 UDP、HTTP 和 MQTT）以及 [Senquip Portal](https://portal.senquip.com) 的连接。因此可在 [Senquip Portal](https://portal.senquip.com) 进行配置更改和固件更新，同时将测量数据发送到 ThingsBoard。

Senquip 设备可连接 MODBUS、CAN 总线、电流、电压、频率等多种传感器类型。本示例中，位置、温度和 CAN 总线数据将通过 MQTT 从 Senquip ORB-C1 发送到 ThingsBoard。

Here is an image of a real life install using this data.

![image](/images/samples/senquip/digger.jpg)

Once you complete, the data will be shown on the following dashboard.

![image](/images/samples/senquip/dash.jpg)

A similar guide is also available as an [application note](https://docs.senquip.com/app_notes/APN0015%20Rev%201.0%20-%20Connecting%20Senquip%20Devices%20to%20the%20ThingsBoard.pdf) from the Senquip website.


## List of hardware and pinouts

ORB-C1-G
![image](/images/samples/senquip/orb-x1-open.jpg)


Pin number		|Name							|Terminal block marking		 |Application
----------------|-------------------------------|----------------------------|---------------------------------------------------------------------------------------
1               |Positive voltage in            |PWR+                        |Positive system power; either permanent or intermittent such as from a solar panel
2               |Negative voltage in (ground)   |GND                         |Negative system power or ground
3               |Source 1                       |SRC1                        |Switchable output with current measurement for powering sensors such as 4-20mA devices
4               |Ground                         |GND                         |Spare ground for sensor connection
5               |Source 2                       |SRC2                        |Switchable output with current measurement for powering sensors such as 4-20mA devices
6               |Serial in                      |B / RX                      |RS485B in RS485 mode and receive in RS232 mode
7               |Serial out                     |A / TX                      |RS485A in RS485 mode and transmit in RS232 mode
8               |Input 1                        |IN1                         |Analog or digital input with edge detect capability
9               |Input 2                        |IN2                         |Analog or digital input
10              |Output                         |OUT1                        |Open collector output
11              |CAN Bus High                   |CAN H                       |CAN bus high connection
12              |CANBus Low                     |CAN L                       |CAN bus high connection


## Senquip device configuration

In this guide, it will be assumed that the user has an account on the [Senquip Portal](https://portal.senquip.com), and that they have added a device to that account.  It is also assumed that the device network is configured to operate over Wi-Fi or cellular.  All device configuration described in the steps below will be performed on the [Senquip Portal](https://portal.senquip.com).

### General device setup

* [Step 1] Give the Senquip device a meaningful name (Setup/General/Name = "Demo Senquip Device").
* [Step 2] Configure the interval at which the Senquip device takes measurements and transmits as 5 seconds (Setup/General/Base Interval = 5).
* [Step 3] Turn on the GPS peripheral and set it to measure on every base interval (Setup/Internal/GPS/Interval = 1).
* [Step 4] Turn on the CAN peripheral and set it to measure on every base interval (Setup/External/CAN/Interval = 1).  If this is the only CAN device on the network, select "Tx Enable" so that the Senquip device acknowledges the CAN messages.
* [Step 5] Save your configuration by pressing the save button.

The General settings should now look like this.

![image](/images/samples/senquip/general.jpg)

### Configuring the ThingsBoard endpoint

Senquip devices can send to the Senquip Portal and a second endpoint at the same time.  In this example, the ThingsBoard will be confirgured as the second endpoint, using MQTT as the transport.

* [Step 1] Enable the MQTT endpoint (Setup/Endpoint/MQTT = Enabled).
* [Step 2] Set the broker address (Setup/Endpoint/MQTT/Broker Address = "thingsboard.cloud:1883").
* [Step 3] Set the client address, we will use the unique device ID "AYCAN24V1" (Setup/Endpoint/MQTT/Client ID = "AYCAN24V1").
* [Step 4] Set the data topic (Setup/Endpoint/MQTT/Data Topic = "v1/devices/me/telemetry").
* [Step 5] Select a username to be used on the ThingsBoard, we have chosen "Senquip" (Setup/Endpoint/MQTT/Username = "Senquip").
* [Step 6] Select a password to be associated with the username, we have chosen "SenquipPassword", we suggest you choose smething more secure (Setup/Endpoint/MQTT/Password = "SenquipPassword").

The Endpoint settings should now look like this.

![image](/images/samples/senquip/mqtt.jpg)

## Thingsboard configuration

It will be assumed that the user has an account on the [ThingsBoard Cloud](https://thingsboard.cloud/).  All device configuration described in the steps below will be performed using the [ThingsBoard Cloud](https://thingsboard.cloud/).

### Create a new device

* [Step 1] Select the Device Group to which you would like to add the Senquip device.  Open the group and use the "+" button to add a new device.
* [Step 2] Give the new device a meaningful name, we are using the same name as chosen in step 1.1.
* [Step 3] Give the device a short label that will be used on widgets such as maps, we have chosen "SQ1".
* [Step 4] Select MQTT as the transport type.
* [Step 5] Press "Next:Credentials" to continue.

The new device settings should now look like this.

![image](/images/samples/senquip/add.jpg)

### Set the credentials

* [Step 1] Select "MQTT Basic" as the Credentials type.
* [Step 2] Insert the Client ID, User Name, and Password the same as in steps 2.3, 2.5, and 2.6.
* [Step 3] Press "Add" to add the configured device.

The credentials should now look like this.

![image](/images/samples/senquip/credentials.jpg)

## Telemetry data

Senquip devices send data in [JSON](https://en.wikipedia.org/wiki/JSON) format as shown in the image below.

![image](/images/samples/senquip/raw.jpg)


Each measurement in the JSON packet has a key and a value.  For instance, GPS latitude has the key "gps_lat" and a value of "-32.70245".  In this example, 5 CAN messages are being received, each with an identifier and value and so the CAN data in the JSON packet is nested with 5 individual CAN identifiers and values.

By selecting the device that we have just added to the ThingsBoard and pressing "Latest Telemetry", we can see the telemetry arriving on the ThingsBoard.  Notice how the ThingsBoard has automatically recognised the data in the JSON packet and has converted it into a table of keys and values.  Notice also how the CAN data has been inserted as 5 rows of CAN identifiers and values.

![image](/images/samples/senquip/telemetry.jpg)


## Viewing the data on a dashboard

We will now add the telemetry data to widegets on a dashboard.

* [Step 1] Select a key from the latest telemetry and press "Show on widget".

![image](/images/samples/senquip/widget.jpg)

* [Step 2] Select a bundle of widgets from those available.  For temperature, we will choose analog gauges.
* [Step 3] Press "Add to dashboard" and select an available dashboard or create a new one.  We will create a new one and call it "Senquip Demo".

![image](/images/samples/senquip/add-widget.jpg)

* [Step 4] Select additional keys from the telmetry data and associate them with widgets, each time adding them to the dashboard.
* [Step 5] For some widgets such as the map widgets, multiple key values (gps_lat and gps_lon) will be required.  Under the advanced settings, the Latitude and Longitude for the widget can be associated with the gps_lat and gps_lon keys.
* [Step 6] The dashboard and widgets can be customised by changing colours, sizes, locations of widgets, the fonts of text and much more.

This is how the dashboard now looks.

![image](/images/samples/senquip/dash.jpg)


## Next steps

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
