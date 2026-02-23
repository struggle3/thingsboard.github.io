---
layout: docwithnav
assignees:
  - samson0v
title: 如何将 Modbus 设备连接至 ThingsBoard CE？
description: 了解如何使用 ThingsBoard IoT Gateway 将 Modbus 设备连接至 ThingsBoard

---

* TOC
{:toc}

## 概述

本指南将介绍如何使用 ThingsBoard IoT Gateway 将 Modbus 设备连接至 ThingsBoard CE。
无论您是刚接触 Modbus 协议，还是希望优化现有配置，本指南都将帮助您快速上手。

**什么是 ThingsBoard IoT Gateway？**

ThingsBoard IoT Gateway 是一款开源方案，在接入既有或第三方系统的物联网设备与 ThingsBoard 平台之间架起桥梁。它让无法直接与 ThingsBoard 通信的设备得以无缝集成，确保数据可实时采集、处理与展示。借助 IoT Gateway，您可以连接多台设备、聚合遥测数据并集中管理配置。它支持灵活的部署场景，尤其适用于 Modbus 广泛使用的工业自动化、监控和智能能源系统。

**什么是 Modbus？**

Modbus 支持多种通信模式，包括串口（Modbus RTU 和 ASCII）与网络（Modbus TCP/IP），可适应多种工业环境。其简洁性与开放标准促成了广泛采用，使不同厂商的设备可以互通。尽管已问世数十年，Modbus 凭借可靠、易实现及与现代工业系统的兼容性，至今仍在使用。此外，它常作为数据采集、过程监控及控制的主干协议，用于从工厂到楼宇自动化等场景。

**您将学到什么？**

本指南将分步骤说明如何使用 ThingsBoard IoT Gateway 将 Modbus 设备连接至 ThingsBoard CE。您将学会如何配置网关、设置 Modbus 连接器、映射数据点并发送至 ThingsBoard。完成本指南后，您将掌握利用 ThingsBoard IoT Gateway 将 Modbus 设备纳入物联网生态的方法，并建立起可在 ThingsBoard CE 中无缝监控与分析 Modbus 设备数据的运行环境。

## 前提条件

- 在配置网关前，请确保 ThingsBoard 服务已运行。您可参考
  [安装指南](/docs/user-guide/install/installation-options/) 手动安装 ThingsBoard CE。
- 继续前请确保本机已安装并正确配置 Docker。若尚未安装，可从 [Docker 官网](https://docs.docker.com/engine/install/) 下载并按您所用系统的安装指南完成安装。

## Modbus Device Structure Overview

For this guide, we will use a ThingsBoard Modbus Demo Device, which simulates a Modbus device and provides a
convenient way to test and demonstrate Modbus communication with ThingsBoard. The demo device is pre-configured with a
set of registers and data points that mimic the behavior of a real Modbus device. It allows users to interact with the
device, read and write data, and observe how the data is processed and visualized in ThingsBoard.

The ThingsBoard Modbus Demo Device is designed to help users understand the Modbus protocol and how to integrate
Modbus devices into their IoT solutions using ThingsBoard. It provides a practical and hands-on way to explore
the capabilities of ThingsBoard in the context of Modbus communication.

The Modbus Demo Device has the following structure:

| Variable Name  | Register Type   | Data Type  | Address    |
|:---------------|:----------------|------------|:-----------|
| Temperature    | Holding         | 16int      | 0          |
| Humidity       | Holding         | 16int      | 1          |
| Power          | Holding         | 16int      | 2          |
| Pressure       | Holding         | 16int      | 3          |
| Relay          | Coil            | bits       | 1          |
| -------------- | --------------- | ---------- | ---------- |

To up and run the Modbus Demo Device, you can use Docker and the following command:

```bash
docker run -it -p 5021:5021 thingsboard/tb-gw-modbus-server:latest
```
{:.copy-code}

The server will be available at `0.0.0.0:5021`.

{% capture difference %}
We will use `host.docker.internal` instead of `0.0.0.0` in our Gateway connector configuration to allow the Docker 
container to access another Docker container.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

By working with the Demo Device and its registers, you'll see how to extract real-time telemetry data and then forward
it to ThingsBoard for monitoring and analysis.

## Step 1. Create a new gateway device on ThingsBoard

First, add a gateway device to your ThingsBoard instance by following these steps:

{% assign createNewGatewayDevice = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-1-ce.png,
        title: Go to "**Entities**" > "**Gateways**" tab.
    ===
        image: /images/gateway/dashboard/gateway-getting-started-2-ce.png,
        title: Click the "**+**" button, enter the gateway device name (e.g., "My Gateway"), and select the device profile. Click on "**Create**" button.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=createNewGatewayDevice %} 

To launch the gateway, use the following steps:

{% assign remoteCreateGatewayDocker = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-3-ce.png,
        title: Select and click on newly created gateway, click on **"Launch command"** button in the top right corner.
    ===
        image: /images/gateway/dashboard/gateway-getting-started-4-ce.png,
        title: Click to download `docker-compose.yml` file to your PC, copy command and execute it in your terminal.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=remoteCreateGatewayDocker %}

After running gateway docker image, you can see the following logs in your terminal:

![](/images/gateway/dashboard/launch-gateway-docker.png)

## Step 2. Add new Modbus connector

Let’s add a Modbus connector, which will read described before data from a simulated Modbus device to the 
created gateway. To create a connector, follow these steps:

{% assign addNewConnector = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-7-ce.png,
        title: Click on "**Connectors configuration**" button on the right panel;
    ===
        image: /images/gateway/dashboard/gateway-getting-started-8-ce.png,
        title: Click the "**+ Add connector**" button;
    ===
        image: /images/gateway/dashboard/gateway-getting-started-modbus-9-ce.png,
        title: Choose "**Modbus**" connector type from the dropdown, fill in "**Name**" field, choose "**Logging level**" to "**INFO**", turn off the "**Fill configuration with default values**" option and click on "**Add**" button;
    ===
        image: /images/gateway/modbus-connector/guides/connector-configuration.png,
        title: Choose “**Advanced**” configuration mode, click on “**Configuration**” tab and paste connector configuration (_you can find it under these steps_).
    ===
        image: /images/gateway/modbus-connector/guides/connector-configuration-save.png,
        title: Click on “**Save**” button to apply changes.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewConnector %} 

**Modbus connector configuration:**

```json
{
  "master": {
    "slaves": [
      {
        "host": "host.docker.internal",
        "port": 5021,
        "type": "tcp",
        "method": "socket",
        "timeout": 35,
        "byteOrder": "BIG",
        "wordOrder": "LITTLE",
        "retries": true,
        "retryOnEmpty": true,
        "retryOnInvalid": true,
        "pollPeriod": 1000,
        "unitId": 1,
        "deviceName": "Modbus PLC",
        "deviceType": "default",
        "connectAttemptTimeMs": 5000,
        "connectAttemptCount": 5,
        "waitAfterFailedAttemptsMs": 300000,
        "attributes": [
          {
            "tag": "power",
            "type": "16int",
            "functionCode": 3,
            "objectsCount": 1,
            "address": 2,
            "divider": 10
          }
        ],
        "timeseries": [
          {
            "tag": "temperature",
            "type": "16int",
            "functionCode": 3,
            "objectsCount": 1,
            "address": 0,
            "divider": 10
          },
          {
            "tag": "humidity",
            "type": "16int",
            "functionCode": 3,
            "objectsCount": 1,
            "address": 1,
            "divider": 10
          },
          {
            "tag": "pressure",
            "type": "16int",
            "functionCode": 3,
            "objectsCount": 1,
            "address": 3,
            "divider": 10
          },
          {
            "tag": "relay",
            "type": "bits",
            "functionCode": 1,
            "objectsCount": 1,
            "address": 1
          }
        ],
        "attributeUpdates": [],
        "rpc": []
      }
    ]
  }
}
```
{:.copy-code.expandable-10}

Let’s break our connector configuration into smaller pieces and provide an explanation:

- `master.slaves` - a list of Modbus “devices” the gateway will talk to. We have just one.
- `host: "host.docker.internal"` – the IP/hostname of the Modbus server. This value makes a Dockerized gateway reach your host machine.
- `pollPeriod: 1000` – poll the device every 1000 ms (1 second).
- `unitId: 1` – the Modbus unit/slave ID on the target (for TCP, this is still used by many gateways).
- `deviceName: "Modbus PLC"` – the ThingsBoard device name that will receive the data.
- `attributes` - a list of Modbus registers that will be read as device attributes in ThingsBoard.
- `timeseries` - a list of Modbus registers that will be read as device telemetry in ThingsBoard.
- `tag` - the key name that appears in ThingsBoard.
- `type` - how to decode the raw data (e.g., 16int is a signed 16-bit integer; bits is a coil/bitfield).
- `functionCode` - the Modbus function code to use when reading the data (e.g., 3 is for holding registers, 1 is for coils).
- `address` - the Modbus address to read from (e.g., 0 for temperature, 1 for humidity, etc.).
- `divider` - a modifier that divides the read value by 10 to get the actual value.

{% capture difference %}
Additional information about the Modbus connector can be found [here](/docs/iot-gateway/config/modbus){:target="_blank"}.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## Step 3. Check device data

To review the data uploaded from your gateway, use the following step:

{% assign checkDeviceData = '
    ===
        image: /images/gateway/modbus-connector/guides/review-device-data.png,
        title: Navigate to the **Entities** > **Devices** page and click on the created device "**Modbus PLC**" as we named it in the “**deviceName**” field . This will open the device details page. From there, switch to the **"Latest telemetry"** tab to view the real-time data that were configured in the connector.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkDeviceData %}

## Conclusion

In this guide, we have walked you through the process of connecting a Modbus device to ThingsBoard CE using the
ThingsBoard IoT Gateway. By following the steps outlined in this guide, you have successfully set up the gateway,
configured the Modbus connector, and mapped data points to send telemetry and attributes to ThingsBoard. You have also
learned how to monitor and visualize the data from your Modbus device in ThingsBoard CE.
With the ThingsBoard IoT Gateway acting as a bridge between your Modbus device and ThingsBoard, you can now leverage
the powerful features of ThingsBoard to analyze and manage your device data effectively. Whether you are monitoring
environmental conditions, tracking energy consumption, or managing industrial processes, the integration of Modbus
devices with ThingsBoard opens up new possibilities for data-driven decision-making and automation.

As you continue to explore the capabilities of ThingsBoard and the ThingsBoard IoT Gateway, you can further enhance your
IoT solutions by adding more devices, implementing advanced data processing, and creating custom dashboards to visualize
your data. The flexibility and scalability of ThingsBoard make it an ideal platform for building robust IoT
applications.

We encourage you to experiment with different configurations, explore additional features of ThingsBoard IoT Gateway,
and leverage the power of Modbus devices in your IoT projects. With the knowledge gained from this guide, you are
well-equipped to take your IoT initiatives to the next level.

## Next steps

Explore guides related to main ThingsBoard features:
 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.
 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
