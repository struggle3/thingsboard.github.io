---
layout: docwithnav-gw
title: 服务 RPC 方法
description: 服务 RPC 方法

---


* TOC
{:toc}


本指南说明如何在 ThingsBoard IoT Gateway 中使用 RPC API。  

本教程需要：  
1. 本地安装的 ThingsBoard 平台实例（若为新用户请参考 [安装文档](/docs/user-guide/install/installation-options/)）。
2. 已 [安装](/docs/iot-gateway/installation/) 并 [配置](/docs/iot-gateway/configuration/) ThingsBoard IoT Gateway。 

## 步骤 1：创建用于 ThingsBoard IoT Gateway RPC API 的仪表板

要使用调试终端，需从**控制部件**包添加 **RPC 调试终端** 部件。<br>
按以下步骤操作：

  - 打开 **仪表板** 标签页；
  <br><br>
  ![](/images/gateway/service-rpc-methods-1.png)

  - Add a new dashboard;
  <br><br>
  ![](/images/gateway/service-rpc-methods-2.png)

  - Open created dashboard, enter edit mode by clicking **pencil** button in the bottom right corner and click "**Add new widget**" button;
  <br><br>
  ![](/images/gateway/service-rpc-methods-3.png)

  - Select widget bundle - "**Control widgets**";
  <br><br>
  ![](/images/gateway/service-rpc-methods-4.png)

  - Scroll down and select **RPC debug terminal** widget;
  <br><br>
  ![](/images/gateway/service-rpc-methods-5.png)

  - We haven't specify the entity type for the widget so we will **create a new one**;
  <br><br>
  ![](/images/gateway/service-rpc-methods-6.png)

  - Fill in required fields and same the entity. **Gateway** - is our gateway device;
  <br><br>
  ![](/images/gateway/service-rpc-methods-7.png)

  - Apply all changes;
  <br><br>
  ![](/images/gateway/service-rpc-methods-8.png)

  - The connected widget looks like (Connection setups automatically).<br>
  Now you can use Debug Terminal to send RPC requests to the gateway.
  <br><br>
  ![](/images/gateway/service-rpc-methods-9.png)

## Step 2. Gateway RPC methods 

To send RPC requests to the gateway the one should use **RPC Debug Terminal** from **Control widgets** bundle.  
ThingsBoard IoT gateway has several RPC methods, which called from WEB UI, available by default.  
The list of OOTB methods will be extended within upcoming releases.

### gateway_ping RPC method

**gateway_ping RPC method** is used to check connection to the gateway and RPC processing status.
Every command with prefix "**gateway_**" will be interpreted as a command to general gateway service and not as an RPC request to the connector or device.
Command:  

```bash
gateway_ping
```
{: .copy-code}

The response is:  

```json
{
  "code": 200,
  "resp": "pong"
}
```

![Gateway RPC ping method](/images/gateway/gateway-rpc-ping.png)

### gateway_devices RPC method

**gateway_devices RPC method** is used to list devices connected through the gateway with info about the type of connector used.
This method returns object in “resp” with **key-value** parameters, where:
key — is a device name
value — identifies the connector

Command:

```bash
gateway_devices
```
{: .copy-code}

Returns object like:

```json
{
  "code": 200,
  "resp": {
    "Device Number One": "OPC-UA Connector"
  }
}
```

![Gateway RPC devices method](/images/gateway/gateway-rpc-devices.png)


### gateway_restart RPC method

**gateway_restart RPC method** is used to schedule restart action, e.g. ```bash gateway_restart 60``` set up the restart of the gateway service in 60 seconds.
This method uses seconds as measuring unit.

**Note:** The response will be returned after adding the task to the gateway scheduler.

Command:  

```bash
gateway_restart 60
```
{: .copy-code}

The response is:  

```json
{"success": true}
```

![Gateway RPC restart method](/images/gateway/gateway-rpc-restart.png)

### gateway_reboot RPC method

**gateway_reboot RPC method** is used to schedule rebooting of the gateway device (hardware?), e. g. ```bash gateway_reboot 60``` set up the reboot of the gateway device in one minute.
**Take into account: this method available if you start the gateway service as a python module instead of daemon approach and the user that is running the gateway has reboot permissions.** 
Command:  

```bash
gateway_reboot 60
```
{: .copy-code}

The response is:  

```json
{"success": true}
```

**Notate:** The response will be returned after adding the task to the gateway scheduler.  

![Gateway RPC reboot method](/images/gateway/gateway-rpc-reboot.png)

### remove_provisioned_credentials RPC method

The **gateway_remove_provisioned_credentials RPC method** removes the device credentials from the config folder. 
If [device provisioning](/docs/iot-gateway/features-overview/provisioning/) is enabled for the gateway instance, the gateway will automatically re-provision itself on the next startup.  

Command:  

```bash
gateway_remove_provisioned_credentials
```
{: .copy-code}

The response is:  

```json
{"code": 200, "resp": "Provisioned credentials file removed successfully."}
```

## Next steps

Explore guides related to main ThingsBoard features:

 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.
 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
