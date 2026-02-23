---
layout: docwithnav-gw
title: 如何将 OPC-UA 设备连接至 ThingsBoard CE？
description: 了解如何使用 ThingsBoard IoT Gateway 将 OPC-UA 设备连接至 ThingsBoard CE
redirect_from: "/docs/iot-gateway/guides/how-to-connect-opcua-server/"

---

* TOC
{:toc}

## 概述

本指南将介绍如何使用 ThingsBoard IoT Gateway 将 OPC-UA 设备连接至 ThingsBoard CE。 
无论您是刚接触 OPC-UA 集成，还是希望优化现有配置，本指南都将帮助您快速上手。

**什么是 ThingsBoard IoT Gateway？**

ThingsBoard IoT Gateway 是一款开源方案，在接入既有或第三方系统的物联网设备与 ThingsBoard 平台之间架起桥梁。它让无法直接与 ThingsBoard 通信的设备得以无缝集成，确保数据可实时采集、处理与展示。借助 IoT Gateway，您可以连接多台设备、聚合遥测数据并集中管理配置。它支持灵活的部署场景，尤其适用于 OPC-UA 广泛使用的工业自动化、监控和智能能源系统。

**什么是 OPC-UA？**

OPC 统一架构（OPC-UA）是工业自动化中广泛采用的机器对机器通信协议。它提供与平台无关、安全可靠的框架，用于设备、服务器与应用之间的数据交换。与旧版 OPC 标准不同，OPC-UA 支持现代技术、允许结构化数据建模，并为跨平台与跨网络的可扩展性设计。其稳定性与互操作性使其成为需要一致、实时、厂商中立通信的工业首选。

**您将学到什么？**

本指南将分步骤说明如何将 OPC-UA 设备集成至 ThingsBoard CE。您将学会如何安装与配置 ThingsBoard IoT Gateway、设置 OPC-UA 连接器并建立与 OPC-UA 服务器的连接。我们还将演示如何映射数据点、向 ThingsBoard 发送遥测。完成本指南后，您将建立起可在 ThingsBoard CE 中无缝监控与分析 OPC-UA 设备数据的运行环境。

## 前提条件

- 在配置网关前，请确保 ThingsBoard 服务已运行。您可参考
  [安装指南](/docs/user-guide/install/installation-options/) 手动安装 ThingsBoard CE。
- 继续前请确保本机已安装并正确配置 Docker。若尚未安装，可从 [Docker 官网](https://docs.docker.com/engine/install/) 下载并按您所用系统的安装指南完成安装。

## OPC-UA Server Structure Overview

For this guide, we’ll use the Prosys OPC-UA Simulation Server as our example OPC-UA device. It’s available at:

```bash
opc.tcp://0.0.0.0:53530/OPCUA/SimulationServer
```

{% capture difference %}
We will use `host.docker.internal` instead of `0.0.0.0` in our Gateway connector configuration to allow the Docker 
container to access the host machine's network.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

This simulation server provides a predefined set of nodes that we can use to mimic a real industrial device. 
Its structure looks like this:

![image](/images/gateway/opc-ua-connector/guides/opc-ua-server-structure-overview.png)

In our example, we’ll focus on the following nodes:

- `Root.Objects.OPC-UA_PLC` - the parent device node that contains all related data points:
    - Root.Objects.OPC-UA_PLC.`Humidity` - represents humidity value. We’ll map this node to ThingsBoard CE as a
      time-series value.
    - Root.Objects.OPC-UA_PLC.`Temperature` - represents temperature value. We’ll also send this value to ThingsBoard CE
      as a time-series value.
    - Root.Objects.OPC-UA_PLC.`Pressure` - represents pressure measurements, which will be stored in ThingsBoard CE as a
      time-series value.
    - Root.Objects.OPC-UA_PLC.`FirmwareInformation` - a child node that holds metadata about the device firmware:
      - Root.Objects.OPC-UA_PLC.FirmwareInformation.`Version` - the firmware version number. We’ll map this to ThingsBoard
        CE as a device attribute.
      - Root.Objects.OPC-UA_PLC.FirmwareInformation.`UpdatedDate` - the last time the firmware was updated. This will also
        be sent to ThingsBoard CE as a device attribute.

By working with these nodes, you’ll see how to extract both real-time telemetry data (Humidity, Temperature, Pressure)
and static attributes (firmware details) from an OPC-UA device, and then forward them into ThingsBoard CE for 
monitoring and visualization.

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

## Step 2. Add new OPC-UA connector

Let’s add an OPC-UA connector, which will read described before data from a simulated OPC-UA device to the 
created gateway. To create a connector, follow these steps:

{% assign addNewConnector = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-7-ce.png,
        title: Click on "**Connectors configuration**" button on the right panel;
    ===
        image: /images/gateway/dashboard/gateway-getting-started-8-ce.png,
        title: Click the "**+ Add connector**" button;
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-9-ce.png,
        title: Choose "**OPCUA**" connector type from the dropdown, fill in "**Name**" field, choose "**Logging level**" to "**INFO**", turn off the "**Fill configuration with default values**" option and click on "**Add**" button;
    ===
        image: /images/gateway/opc-ua-connector/guides/connector-configuration.png,
        title: Choose “**Advanced**” configuration mode, click on “**Configuration**” tab and paste connector configuration (_you can find it under these steps_).
    ===
        image: /images/gateway/opc-ua-connector/guides/connector-configuration-save.png,
        title: Click on “**Save**” button to apply changes.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewConnector %} 

**OPC-UA configuration:**

```json
{
  "server": {
    "url": "opc.tcp://host.docker.internal:53530/OPCUA/SimulationServer",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 3600000,
    "pollPeriodInMillis": 5000,
    "enableSubscriptions": false,
    "subCheckPeriodInMillis": 100,
    "showMap": false,
    "security": "Basic128Rsa15",
    "identity": {
      "type": "anonymous"
    }
  },
  "mapping": [
    {
      "deviceNodeSource": "path",
      "deviceNodePattern": "Root\\.Objects\\.OPC-UA_PLC",
      "deviceInfo": {
        "deviceNameExpression": "OPC-UA PLC",
        "deviceNameExpressionSource": "constant",
        "deviceProfileExpressionSource": "constant",
        "deviceProfileExpression": "default"
      },
      "attributes": [
        {
          "key": "Firmware Version",
          "type": "path",
          "value": "${FirmwareInformation\\.Version}"
        },
        {
          "key": "Updated",
          "type": "path",
          "value": "${FirmwareInformation\\.UpdatedDate}"
        }
      ],
      "timeseries": [
        {
          "key": "Humidity",
          "type": "path",
          "value": "${Humidity}"
        },
        {
          "key": "Temperature",
          "type": "path",
          "value": "${Temperature}"
        },
        {
          "key": "Pressure",
          "type": "path",
          "value": "${Pressure}"
        }
      ],
      "rpc_methods": [],
      "attributes_updates": []
    }
  ]
}
```
{:.copy-code.expandable-10}

Let’s break our connector configuration into smaller pieces and provide an explanation:

**Server** - defines how the gateway connects and interacts with your OPC-UA server. From all parameters for us 
the following is important:
- **`url`** - specifies the server’s TCP endpoint. In this case, it's pointing to a local Prosys simulation at `opc.tcp://host.docker.internal:53530/OPCUA/SimulationServer`.
- **`pollPeriodInMillis`** - sets the interval for polling node values when subscriptions aren't used (every 5 seconds in our example).
- **`security`** - sets the OPC-UA security policy. Options include `Basic128Rsa15`, `Basic256`, and `Basic256Sha256`. Depends on your OPC-UA server settings.
- **`identity`** - defines how the gateway authenticates to the server: here, anonymous for simplicity.

**Mapping** - defines how node data from the OPC-UA server maps to ThingsBoard devices:
- **`deviceNodeSource`** & **`deviceNodePattern`** - the source type is path, and the pattern matches the root node (`Root.Objects.OPC-UA_PLC`) that represents our device.
- **`deviceInfo`** - define ThingsBoard device name and device profile. In our example, we use constant values for this purpose.
- **`attributes`** - these values are pushed to ThingsBoard attributes and are typically static or change infrequently. We use a relative path for configuring attributes data mapping.
- **`timeseries`** -  these gauge readings will appear under the "**Latest Telemetry**" tab in the device's page. We use a relative path for configuring time series data mapping too.

{% capture difference %}
Additional information about the OPC-UA connector can be found [here](/docs/iot-gateway/config/opc-ua){:target="_blank"}.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## Step 3. Check device data

To review the data uploaded from your gateway, use the following steps:

{% assign checkDeviceData = '
    ===
        image: /images/gateway/opc-ua-connector/guides/review-device-data-1.png,
        title: Navigate to the **Entities** > **Devices** page and click on the created device "**OPC-UA PLC**" as we named it in the “**deviceNameExpression**” field . This will open the device details page. From there, switch to the **"Attributes"** tab to view the attributes that were configured in the connector.
    ===
        image: /images/gateway/opc-ua-connector/guides/review-device-data-2.png,
        title: To view real-time telemetry data from the device, navigate to the “**Latest Telemetry**” tab. Here, you will find the telemetry data being sent by the device, including metrics like “**humidity**”, “**temperature**” and “**pressure**”. This tab provides real-time device telemetry updates.
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkDeviceData %}

## Conclusion

In this guide, we demonstrated how to connect an OPC-UA device to ThingsBoard CE using the ThingsBoard IoT Gateway. 
By configuring the gateway, setting up the OPC-UA connector, and mapping both telemetry data (such as humidity, 
temperature, and pressure) and device attributes (like firmware version and update date), we established a complete 
data flow from the OPC-UA server into ThingsBoard.

With this setup, you can now monitor your device data in real time, visualize it on dashboards, and use 
ThingsBoard’s powerful features—such as alarms, rule chains—to build advanced IoT solutions. The same approach 
can be extended to real industrial OPC-UA devices, enabling seamless integration of systems into modern IoT platforms.

This example using the Prosys Simulation Server is just the beginning. You can now adapt the configuration to 
your own devices, scale up to multiple servers, and customize data mappings based on your project’s needs.

## Next steps

Explore guides related to main ThingsBoard features:
 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.
 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
