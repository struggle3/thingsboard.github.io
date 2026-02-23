---
layout: docwithnav-gw
title: 如何在 ThingsBoard IoT Gateway 上启用远程日志功能
description: 如何在 ThingsBoard IoT Gateway 上启用远程日志功能

---

* TOC
{:toc}

本指南将帮助您在 ThingsBoard 平台实例上启用远程日志功能并读取 ThingsBoard IoT Gateway 的日志。  

本指南将使用以下环境：
1. 本地安装的 ThingsBoard 平台实例（安装方法见 [此处](/docs/user-guide/install/installation-options/)）。
2. ThingsBoard IoT Gateway（安装方法见 [此处](/docs/iot-gateway/installation/)）。

## 步骤 1：启用远程日志并设置日志级别

要启用并设置日志级别，请按以下步骤操作：  
   
 - 在 Web 界面中打开网关设备详情。  
 - 进入「**属性**」标签页。  
 - 在**实体属性**范围列表中选择**共享属性**。  
 - 点击「**+**」按钮（添加新属性）。  
 <br>
  ![](/images/gateway/add-shared-attributes-gateway.png)
 - In "Add attribute" window fill fields with the following values: 
    - The **name** field must be **RemoteLoggingLevel**
    - The **value** field sets the logging level, the values can be as follows:
 ```
 DEBUG
 INFO
 WARNING
 ERROR
 CRITICAL
 NONE
```
  
  ![](/images/gateway/add-remote-logging-level-attribute-1.png)
 - Click **Add**
  ![](/images/gateway/add-remote-logging-level-attribute-2.png)
 - Launch your gateway in case it is not running **[Optional]**.  
 - Open the **Latest telemetry** tab of your gateway device, and you will see the new telemetry key -- **LOGS**.  
  <br><br>
  ![](/images/gateway/logs-telemetry.png)
  <br>
  <br>
  
## Step 2. Display logs on a dashboard

It may be not convenient to review logs in the Device details window. We should show them on a dashboard.  
So we will be able to investigate all logs, not only the latest one.  
To do this we use following steps:

  - Check **LOGS** key and click "**Show on widget**" button:
  ![](/images/gateway/show-logs-on-widget.png)

  - We will use the default **Cards** widget:
  ![](/images/gateway/add-logs-to-dashboard.png)

  - Choose **Timeseries table** Card widget and add it to the Dashboard. It can be either the new one or the existing dashboard.
  ![](/images/gateway/create-new-dashboard-for-logs.png)

  - As a result now we can monitor the status of the gateway device from ThingsBoard environment.
  ![](/images/gateway/logs-dashboard.png) 

## Next steps

Explore guides related to main ThingsBoard features:

 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.
 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
