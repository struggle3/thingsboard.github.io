---
layout: docwithnav-gw
title: 如何使用远程转换器更新
description: 如何使用远程转换器更新

---

* TOC
{:toc}

「远程转换器更新」（Remote converter update）允许通过共享属性远程更新转换器配置。
本指南将帮助您使用此功能远程更新转换器配置。

本教程需要：  
1. 本地安装的 ThingsBoard 平台实例（若为新用户请参考 [安装文档](/docs/user-guide/install/installation-options/)）。
2. 已 [安装](/docs/iot-gateway/installation/) 并 [配置](/docs/iot-gateway/configuration/) ThingsBoard IoT Gateway。 

## 步骤 1：在网关设备上创建共享属性

您需在网关设备上创建共享属性，键使用格式 `<连接器名称>:<转换器类名>`，值写入转换器配置。

例如：
![](/images/gateway/remote-converter-update-create-shared-attr.png)

上图为远程更新 MQTT 默认 JSON 转换器配置而创建的共享属性。

## 步骤 2：更新已提供的共享属性

要获取新的转换器配置更新，需提供包含新配置的共享属性。
For example:
![](/images/gateway/remote-converter-update-shared-attr.png)

## 步骤 3：日志

若上述步骤均正确完成，您将看到如下网关日志：
![](/images/gateway/remote-converter-update-logs.png)

## 下一步

探索 ThingsBoard 主要功能相关指南：

 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据
 - [使用 RPC 能力](/docs/user-guide/rpc/) - 如何向设备发送命令
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据
