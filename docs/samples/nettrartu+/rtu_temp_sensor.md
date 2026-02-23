---
layout: docwithnav
title: 使用 Nettra RTU 通过 MQTT 上传温度
description: ThingsBoard 物联网平台示例：使用 Nettra RTU 通过 MQTT 上传温度
hidetoc: "true"
---

* TOC
{:toc}

## 简介

本指南包含分步说明，介绍如何通过以太网将 Nettra RTU 设备连接到 ThingsBoard 社区版，并以 Nettra RTU 众多应用之一为例。本示例应用将允许您使用 ThingsBoard Web UI 监控并显示来自传感器的温度数据。

### Nettra RTU
[Nettra RTU](https://nettra.tech) 又称 **RTU+**，是一款功能强大的物联网电子设备，具有数字和模拟输入输出，以及多种集成通信接口（调制解调器、以太网、802.15.4、RS485、RS232 和 GPS）。它是实现分布式数据网络上监控、采集和控制应用的理想产品。

RTU+ 可通过 [RTU+ 配置界面](https://nettra.tech) 轻松配置。为适应各应用场景，RTU+ 运行完全可自定义的脚本，可从配置界面访问和编辑。本指南将提供一个简单易懂的示例。

完成本示例/教程后，您将在仪表板中看到传感器数据，如下图所示。
<br><br>
![image](/images/samples/nettrartu+/nettrartu+.png)   ![image](/images/samples/nettrartu+/rtu_temp_sensor/dashboard.png)

## Prerequisites

### Hardware

 - 1x [RTU+](https://nettra.tech)
 - 1x Temperature sensor (Operation range: 4-20mA or 0-20V)
 - 1x 12VDC supply voltage
 - 1x USB to Serial cable
 - 1x Ethernet cable

### Software
 - [RTU+ Configuration Interface](https://nettra.tech).
 - You will need to have ThingsBoard server up and running. Use either [ThingsBoard Cloud](https://thingsboard.io/installations/) or [Installation Guide](/docs/user-guide/install/installation-options/) to install ThingsBoard.

## Connection diagram

The following picture summarizes the connections for this simple project:
<br><br>

![image](/images/samples/nettrartu+/rtu_temp_sensor/connection_diagram.png)

## ThingsBoard configuration

This step contains instructions that are necessary to connect your device to ThingsBoard.

Sign in to your ThingsBoard server Web UI.

### Device

1. Go to *"Devices"* section. 
2. Click *"+"* button and create a device with the name **"RTU+"**. Set *"Device type"* to **"default"**.
<br><br>
![image](/images/samples/nettrartu+/device.png)
<br><br>
3. Once device created, open its details and click *"Manage credentials"*.
4. Copy auto-generated access token from the *"Access token"* field. Please save this device token. It will be referred to later as **$RTU_DEMO_TOKEN**.
<br><br>
 ![image](/images/samples/nettrartu+/credentials.png)

### Dashboard

Download the dashboard file (.json) using this [link](/docs/samples/nettrartu+/resources/rtu_.json).
Use import/export [instructions](/docs/user-guide/ui/dashboards/#iot-dashboard-importexport) to import the dashboard to your ThingsBoard instance.

## Connect RTU+ to PC

 - Download and install last version of [RTU+ Configuration Interface](https://nettra.tech).

 - Once you have the RTU+ connected to the temperature sensor and the 12VDC power supply as shown in *Connection Diagram* section, connect the RTU+ to the PC using the USB-Serial cable (make sure you have all the necessary drivers installed for that).

 - Open the RTU+ Configuration Interface. 

   1. Go to *"Inicio"*.
   2. Click *"Serial"*.
   3. Select the USB port *"Puerto"* you have connected the RTU+, *"Baud rate":* **"9600"** (by default), and *"Paridad":* **"Sin paridad"**. 
   4. Click *"Connect"*.

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/serial_connection.png)

   Once you are connected you should see this icon :

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/connected.png)

## RTU+ configuration

Once you have your RTU+ connected to the PC, we can proceed with its configuration.  

### Ethernet

1. Go to *"Comunicaciones"*.
2. Click *"Serial y Ethernet"*. 
3. Tick the box **"DHCP"** as shown in next image. 
4. Save clicking *"Aplicar cambios"*.

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/ethernet_conf.png)

### MQTT

1. Go to *"Comunicaciones"*.
2. Click *"MQTT y Hora"*.
3. Fill the ***MQTT*** boxes as follow:
   <br><br>
   **Interfaz** : Ethernet &nbsp;&nbsp; **Puerto** : 1883<br>
   **Servidor** : ThingsBoard HOST/IP address that is accessible within your local network. Specify `mqtt.thingsboard.cloud` if you are using [ThingsBoard Cloud](https://thingsboard.cloud/) server.<br>
   **Usuario** : $RTU_DEMO_TOKEN (provided in *Device* subsection)<br>
   **Contraseña** : Leave empty<br>
   **Client ID** : RTU+<br>
   **Telemetry Topic** : v1/devices/me/telemetry<br>
   **Attributes Topic** : v1/devices/me/attributes<br>
   **Formato** : Telemetry+<br>
4. Fill the ***Time Synchronization*** boxes as follow:
   <br><br>
   **Interfaz** : NTP Ethernet<br>
   **Servidor** : ThingsBoard HOST/IP address that is accessible within your local network. Specify `thingsboard.cloud` if you are using [ThingsBoard Cloud](https://thingsboard.cloud/) server.<br>
   **Frecuencia** : 10<br>
   **Huso** : Write your time zone<br>

5. Click *"Aplicar cambios"* to save.

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/mqtt_conf.png)

   You should see in *"Estado"*: *"Conectado"* (MQTT status: Connected)
   (It could take some minutes the first time)

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/status.png)

### Time

1. Go to *"Inicio"*

2. Click *"Configurar Hora"*.

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/configure_time.png)

### Analog input

1. Go to *"Escalado de Entradas Analógicas"*.

2. Here we have two possibles configurations, depending on your temperature sensor.

   If your temperature sensor output range is between **4-20mA** :<br>
   Select *"Corriente"* in *"Entrada Analógica 0: "*. Fill *"X0"* with **"819"** and *"X1"* with **"4096"**. Fill *"Y0"* with minimum sensor temperature and *"Y1"* with maximum sensor temperature.<br>
   Example: Sensor Range: -10°C to 100°C. *"X0" = 819*, *"Y0" = -10*, *"X1" = 4096* and *"Y1" = 100*

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/current_input.png)

   If your temperature sensor output range is between **0-20V** :<br>
   Select *"Tensión"* in *"Entrada Analógica 0: "*. Fill *"X0"* with **"0"** and *"X1"* with **"4096"**. Fill *"Y0"* with minimum sensor temperature and *"Y1"* with maximum sensor temperature.<br>
   Example: Sensor Range: -10°C to 100°C. *"X0" = 0*, *"Y0" = -10*, *"X1" = 4096* and *"Y1" = 100*

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/voltage_input.png)

3. Click *"Aplicar cambios"* to save.

### Script

 - Download this [***script***](/docs/samples/nettrartu+/resources/rtu_temp_script.nbs).

```c
/*
 * DESCRIPTION :
 * - Monitor temperature each 20 seconds.
 * 
 * INPUTS:
 * - Temperature sensor : Analog Input 0 
 */

// Constants
const TLOG = 20000;  // [Miliseconds]
 
// Variables definition
loggable float temperature;   // [ºC]
ulong logTimer;
<span style="color: green"> Some green text </span>
// Alias
alias sensorTemperature as AInEscalado[0];

// Variables initialization
logTimer = ConfigurarTimeout(0); 

// Code
while(1)
{
   if (Timeout(logTimer))
   {
      logTimer = ConfigurarTimeout(TLOG);
      temperature = sensorTemperature;
      Log(temperature);
   }
}
```

1. Go to *"Nettra-C"* 
2. Import the script clicking *"Cargar"*. If you want to make your own script, you can see the [Nettra C](https://nettra.tech) user manual.

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/import_script.png)

3. Compile and save the script in the RTU+ by clicking *"Compilar y Aplicar"*.

   ![image](/images/samples/nettrartu+/rtu_temp_sensor/script_running.png)

## Data visualization

Finally, open ThingsBoard Web UI with same user and password as *ThingsBoard configuration* section.

Go to *"Devices"* section and locate *"RTU+ Device"*, open device details and switch to *"Latest telemetry"* tab.
If all is configured correctly you should be able to see latest values of *"temperature"* in the table.<br><br>

![image](/images/samples/nettrartu+/rtu_temp_sensor/telemetry_table.png)

After, open *"Dashboards"* section then locate and open *"RTU+"* dashboard.
As a result, you will see a time-series chart displaying temperature level (similar to dashboard image in the introduction).<br><br>

![image](/images/samples/nettrartu+/rtu_temp_sensor/dashboard.png)

## See also

Browse other [samples](/docs/samples) or explore guides related to main ThingsBoard features:

 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.

{% include templates/feedback.md %}

{% include socials.html %}

## Next steps

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}
