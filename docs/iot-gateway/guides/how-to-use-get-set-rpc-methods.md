---
layout: docwithnav-gw
title: 如何使用内置 GET/SET RPC 方法
description: 如何使用内置 GET/SET RPC 方法

---

* TOC
{:toc}

内置 GET/SET RPC 方法可在无需额外配置的情况下读写遥测与属性参数值。以下连接器支持内置 GET/SET RPC 方法：

{% capture getSetConnectorRPCType %}
OPC-UA<small></small>%,%opcua%,%templates/iot-gateway/get-set-connector-rpc/opcua.md%br%
Modbus<small></small>%,%modbus%,%templates/iot-gateway/get-set-connector-rpc/modbus.md%br%
MQTT<small></small>%,%mqtt%,%templates/iot-gateway/get-set-connector-rpc/mqtt.md%br%
BACnet<small></small>%,%bacnet%,%templates/iot-gateway/get-set-connector-rpc/bacnet.md%br%
REST<small></small>%,%rest%,%templates/iot-gateway/get-set-connector-rpc/rest.md%br%
Request<small></small>%,%request%,%templates/iot-gateway/get-set-connector-rpc/request.md%br%
FTP<small></small>%,%ftp%,%templates/iot-gateway/get-set-connector-rpc/ftp.md%br%
Socket<small></small>%,%socket%,%templates/iot-gateway/get-set-connector-rpc/socket.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="getSetConnectorRPC" toggle-spec=getSetConnectorRPCType %}

## 下一步

探索 ThingsBoard 主要功能相关指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据
 - [使用 RPC 能力](/docs/user-guide/rpc/) - 如何向设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据