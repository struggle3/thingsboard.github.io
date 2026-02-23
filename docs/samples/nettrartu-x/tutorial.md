---
layout: docwithnav
title: 使用 Nettra RTU 通过 MQTT 上传温度
description: ThingsBoard 物联网平台示例：使用 Nettra RTU 通过 MQTT 上传温度
hidetoc: "true"
---

## 目录
1. [简介](#introduction)
2. [前置条件](#prerequisites)
3. [连接示意图](#connection_diagram)
4. [ThingsBoard 配置](#tb_configuration)
5. [将 RTU-X 连接到 PC](#connection_pc)
6. [RTU-X 配置](#rtu_configuration)
7. [数据可视化](#data_visualization)

## 简介

本指南包含分步说明，介绍如何通过 Wi-Fi 使用 TCP/IP 将 Nettra RTU 设备连接到 ThingsBoard 社区版，并以 Nettra RTU 众多应用之一为例。完成本指南后，您将能够使用 ThingsBoard Web UI 监控并显示数据。

### Nettra RTU
[Nettra RTU](https://nettra.tech) 又称 **RTU-X**，是一款功能强大的物联网电子设备，具有数字和模拟输入输出，以及多种集成通信接口（调制解调器、以太网、蓝牙、802.15.4、RS485、RS232 和 GPS）。它是实现分布式数据网络上监控、数据采集和控制应用的理想产品。

RTU-X 可通过 [RTU-X 配置界面](http://wiki.nettra.tech/en/downloads) 轻松配置。为适应各应用场景，RTU-X 运行完全可自定义的脚本，可从配置界面访问和编辑。本指南将提供一个简单易懂的示例。

完成本示例/教程后，您将在仪表板中看到传感器数据，如下图所示。
<br><br>

![rtu_x](https://user-images.githubusercontent.com/61634031/133831823-b6e2420e-5669-433a-a3fa-54b506ab24b9.png) ![dash2](https://user-images.githubusercontent.com/61634031/134074200-5063cd05-6091-4f36-90a3-91771373bd65.png)


## 前置条件

### 硬件

 - 1x [RTU-X](https://nettra.tech)
 - 1x 12V 直流电源

### 软件
 - [RTU-X 配置界面](http://wiki.nettra.tech/en/downloads)
 - 需要运行 ThingsBoard 服务器。可使用 [ThingsBoard Cloud](https://thingsboard.io/installations/){:target="_blank"} 或参考 [安装指南](https://thingsboard.io/docs/user-guide/install/ubuntu/) 安装 ThingsBoard

## 连接示意图

下图展示了本简单项目的连接方式：
<br><br>
![copy_941957077](https://user-images.githubusercontent.com/61634031/133837072-8340491f-ea35-4204-91e1-7d513641d7bb.png)

## ThingsBoard 配置

本步骤包含将设备连接到 ThingsBoard 所需的说明。

有关获取账号的详细信息，请参阅 [ThingsBoard Cloud](https://thingsboard.io/installations/) 页面。

### 设备

1. 进入「**Devices**」部分
2. 点击「**+**」按钮，创建名为 **RTU-X** 的设备。将「**Device type**」设置为 **default**
<br><br>
![add_opt (1)](https://user-images.githubusercontent.com/61634031/133840783-8b605dfd-3a50-430b-bb63-a8244a53cad9.png)
<br><br>
3. 设备创建后，打开其详情并点击「**Copy access token**」。请保存此设备令牌，后文将引用为 **$RTU_DEMO_TOKEN**。
<br><br>
![access_opt (3)](https://user-images.githubusercontent.com/61634031/133840798-1ea7dc07-c157-4fda-ab1c-9ecb0bba1bb8.png)

### 仪表板

使用此 [链接](/docs/samples/nettrartu-x/resources/rtu_x_dashboard.json) 下载仪表板文件 (.json)。
按 [导入/导出说明](https://thingsboard.io/docs/user-guide/dashboards/#import-dashboard) 将仪表板导入 ThingsBoard 实例。

## 将 RTU-X 连接到 PC

 - Download and install the latest version of [RTU-X Configuration Interface](http://wiki.nettra.tech/en/downloads).

 - Turn on the RTU-X.

 - Check your wifi network and connect to "RTU-X-******".

 - Open the RTU-X Configuration Interface. 

   1. Go to *"Home"*.
   2. Click on *"TCP/IP"*.
   4. Specify the *"IP*" address **"192.168.4.1"**, *"Port":* **"502"** (by default).
   5. Click on *"Connect"*.

   ![rtu1_step1](https://user-images.githubusercontent.com/61634031/134022796-78e22a93-5f03-4c9f-80bb-c129814b349a.png)

 - Once you are connected you should see the following:

   ![rtu2_step](https://user-images.githubusercontent.com/61634031/133849616-2b64bd94-8b5e-49d8-b9fc-a909b8d0cf3e.png)
  
 - Then:
   1. Go to *"Communications"*.
   2. Go to *"Wifi, Serial, Modbus"*.
   3. Click *"Station"* and register the data for the WiFi network.
   4. *"Apply Changes"*
   
   ![rtu3_step3](https://user-images.githubusercontent.com/61634031/134022912-8dcbe19c-986f-4fa7-8231-823564262343.png)
   
 - Finally:
   1. Go back to *"Home"*.
   2. Copy the *"IP"* address on *"WiFi STA information"*.
   3. Disconnect from the RTU-X.
   4. Change the *"IP"* address and reconnect.

   ![rtu4_step4](https://user-images.githubusercontent.com/61634031/134022869-f1ec2a5b-dfee-4571-96a4-7fd1fcd81778.png)

## RTU-X 配置

RTU-X 连接到 PC 后，即可进行配置。

### MQTT

1. 进入「**Communications**」
2. 点击「**MQTT**」
3. On *"Interface"* select *"Modem"*. On *"Format"* select *"Thingsboard"*. On *"URI"* paste *"mqtt://thingsboard.cloud:1883"*. On *"Password"* paste the Device Acces Token from *"Device"* step.
4. Click on *"Apply Changes"*.

![rtu5_step5](https://user-images.githubusercontent.com/61634031/134028854-17b5d9c8-c807-4b3b-a557-00ea5b25d7ac.png)

### Script

 - Download this [***script***](/docs/samples/nettrartu-x/resources/rtu_x_script.json).

```c
/*
 * DESCRIPTION :
 *	- Sending a variable to a Thingsboard Dashboard
*/
// VARIABLES DEFINITION ------------------------------------------
// Attributes
shared uint tLog = 10;

// Loggable
telemetry float variable;

// SCRIPT -----------------------------------------------------------
while (1)
{
    variable = 15;
	
    delay_loop(tLog*1000); // 10 seconds
    log(variable);
}
```

1. Go to *"User Interface"* 
2. Import the script clicking *"Load"*. If you want to make your own script, you can see the [Nettra script user manual](http://wiki.nettra.tech/en/script).
3. Compile and save the script in the RTU-X by clicking *"Compila & Apply"*.

![rtu6_step6](https://user-images.githubusercontent.com/61634031/134028433-e7412285-9f4e-4d67-9f3c-80879f99191f.png)

## 数据可视化

最后，使用与「ThingsBoard 配置」部分相同的用户名和密码打开 ThingsBoard Web UI。

进入「**Devices**」部分，找到「**RTU-X Device**」，打开设备详情并切换到「**Latest telemetry**」标签。
若配置正确，您应在表格中看到「**variable**」的最新值。<br><br>

![dev](https://user-images.githubusercontent.com/61634031/134029353-d4d80304-0396-4a10-b313-02a249300280.png)

然后打开「**Dashboards**」部分，找到并打开「**RTU-X**」仪表板。
结果将显示一个模拟表盘（与简介中的仪表板图片类似）。<br><br>

![dash](https://user-images.githubusercontent.com/61634031/134030076-19fd80de-38fd-4114-b1f1-221f61756782.png)

## 另请参阅

浏览其他 [示例](https://thingsboard.io/docs/samples/) 或查看 ThingsBoard 主要功能相关指南：

 - [设备属性](https://thingsboard.io/docs/user-guide/attributes/) - 如何使用设备属性
 - [数据可视化](https://thingsboard.io/docs/guides/#AnchorIDDataVisualization) - 如何可视化采集的数据
 - [数据分析](https://thingsboard.io/docs/guides/#AnchorIDDataAnalytics) - 如何采集遥测数据
 - [规则引擎](https://thingsboard.io/docs/user-guide/rule-engine-2-0/re-getting-started/) - 如何使用规则引擎分析设备数据
 - [使用 RPC 功能](https://thingsboard.io/docs/user-guide/rule-engine-2-0/tutorials/rpc-request-tutorial/) - 如何向/从设备发送命令

