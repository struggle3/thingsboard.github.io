---
layout: docwithnav-gw
title: 什么是 ThingsBoard IoT Gateway？
description: ThingsBoard IoT Gateway 的功能与优势

---

ThingsBoard **IoT Gateway** 是开源解决方案，可将接入传统与第三方系统的设备与 ThingsBoard 集成。  

ThingsBoard 是用于数据采集、处理、可视化和设备管理的开源物联网平台。若是新用户，请参阅 [**ThingsBoard是什么**](/docs/getting-started-guides/what-is-thingsboard/)。

<object width="95%" data="/images/gateway/python-gateway-animd-ff.svg"></object>

## 网关功能

ThingsBoard IoT Gateway 提供以下功能：

 - [**MQTT** connector](/docs/iot-gateway/config/mqtt/)：控制、配置并采集接入外部 MQTT broker 的 IoT 设备数据。
 - [**OPC-UA** connector](/docs/iot-gateway/config/opc-ua/)：采集接入 OPC-UA 服务器的 IoT 设备数据。
 - [**Modbus** connector](/docs/iot-gateway/config/modbus/)：采集通过 Modbus 协议接入的 IoT 设备数据。
 - [**BLE** connector](/docs/iot-gateway/config/ble/)：采集通过 Bluetooth Low Energy 连接的 IoT 设备数据。
 - [**Request** connector](/docs/iot-gateway/config/request/)：采集具备 HTTP(S) API 端点的 IoT 设备数据。
 - [**CAN** connector](/docs/iot-gateway/config/can/)：采集通过 CAN 协议连接的 IoT 设备数据。
 - [**BACnet** connector](/docs/iot-gateway/config/bacnet/)：采集通过 BACnet 协议连接的 IoT 设备数据。
 - [**ODBC** connector](/docs/iot-gateway/config/odbc/)：从 ODBC 数据库采集数据。
 - [**REST** connector](/docs/iot-gateway/config/rest/)：创建端点并采集来自 HTTP 请求的数据。
 - [**SNMP** connector](/docs/iot-gateway/config/snmp/)：从 SNMP 管理器采集数据。
 - [**FTP** connector](/docs/iot-gateway/config/ftp/)：从 FTP 服务器采集数据。
 - [**Socket** connector](/docs/iot-gateway/config/socket/)：采集通过 TCP/UDP 协议连接的 IoT 设备数据。
 - [**XMPP** connector](/docs/iot-gateway/config/xmpp/)：采集通过 XMPP 协议连接的 IoT 设备数据。
 - [**OCPP** connector](/docs/iot-gateway/config/ocpp/)：在充电桩与中央系统间通信。
 - [**KNX** connector](/docs/iot-gateway/config/knx/)：采集通过 KNX 协议连接的 IoT 设备数据。
 - [**Custom** connector](/docs/iot-gateway/custom/)：采集通过其它协议连接的 IoT 设备数据（可为所需协议自建 connector）。
 - **持久化**采集数据，在网络或硬件故障时保证投递。
 - **自动重连** ThingsBoard 集群。
 - 简单且强大的**数据与消息映射**为**统一格式**。


## 架构

IoT Gateway 是软件组件，设计为在支持 **Python 3.7+** 的 Linux 微机上运行。
ThingsBoard IoT Gateway 主要组件如下。

**Connector**

该组件负责连接外部系统（如 MQTT broker、OPC-UA 服务器）或直接连接设备（如 Modbus、BLE、CAN）。
连接后，connector 通过轮询或订阅从这些系统获取数据，取决于协议能力。
例如，MQTT connector 采用订阅模型，Modbus 和 CAN 采用轮询。
Connector 可直接或通过外部系统向设备推送更新。

可参考 [自定义指南](/docs/iot-gateway/custom/) 定义自己的 connector。

**Converter**   
 
Converter 负责将协议特定格式与 ThingsBoard 格式相互转换。
Converter 由 Connector 调用，通常与 Connector 支持的协议绑定。
分为上行与下行 converter。上行 converter 将协议数据转为 ThingsBoard 格式。
下行 converter 将 ThingsBoard 消息转为协议格式。

可参考 [自定义指南](/docs/iot-gateway/custom/#step-4-define-converter-implementation/) 定义自己的 converter。

**Event Storage**

Event Storage 用于临时存储 Connector 产生的遥测等事件，直至投递到 ThingsBoard。
支持两种实现：内存队列和持久化文件存储。
两种实现均可保障在网络中断时最终投递设备数据。
内存队列减少 IO 操作，但网关进程重启可能丢失消息。
持久化文件存储可 survive 进程重启，但需要对文件系统执行 IO。

**ThingsBoard Client**

网关通过 MQTT 协议与 ThingsBoard 通信，使用 [此处](/docs/reference/gateway-mqtt-api/) 描述的 API。
ThingsBoard Client 是独立线程，轮询 Event Storage 并在与 ThingsBoard 连接可用时投递消息。
支持连接监控、事件批处理优化以及多项其它功能。

**Gateway Service**

Gateway Service 负责启动 Connector、Event Storage 与 ThingsBoard Client。
该服务采集并定期向 ThingsBoard 上报消息量与设备连接统计。
会持久化已连接设备列表，以便在网关重启后重新订阅设备配置更新。

## 项目路线图

<p><a id="Products_IoTGateway_GRoadmap" href="/docs/iot-gateway/roadmap/" class="button gtm_button">Gateway 路线图</a></p>

## 下一步

<p><a id="Products_IoTGateway_GSGuide" href="/docs/iot-gateway/getting-started/" class="button gtm_button">快速入门指南</a></p>
