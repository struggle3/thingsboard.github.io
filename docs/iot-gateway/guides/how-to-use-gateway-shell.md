---
layout: docwithnav-gw
title: 如何使用 Gateway Shell
description: 如何使用 Gateway Shell

---

* TOC
{:toc}


本指南说明如何使用 Gateway Shell，并提供其中各命令的使用示例。
Gateway Shell 功能允许用户通过命令行与网关交互。
借助提供的命令及对应参数，用户可执行指定操作并从网关获取信息。
请参考本指南中的用法示例以有效利用 Gateway Shell 功能。

本教程需要：  
1. 本地安装的 ThingsBoard 平台实例（若为新用户请参考 [安装文档](/docs/user-guide/install/installation-options/)）。
2. 已 [安装](/docs/iot-gateway/installation/) 并 [配置](/docs/iot-gateway/configuration/) ThingsBoard IoT Gateway。

### Storage 命令
`storage` 命令提供与存储操作相关的功能。

#### 获取存储名称
要获取存储名称，请使用以下命令：

```bash
tb-gateway-shell storage -n
```
{: .copy-code}

#### 获取存储事件数量
要获取存储事件数量，请使用以下命令：

```bash
tb-gateway-shell storage -c
```
{: .copy-code}

### Connector 命令
`connector` 命令提供与连接器相关的操作。

#### 获取可用连接器
要列出可用连接器，请使用以下命令：

```bash
tb-gateway-shell connector -l
```
{: .copy-code}

#### 获取连接器状态
要获取指定连接器的状态，请按如下方式传入连接器名称：

```bash
tb-gateway-shell connector -s <name>
```
{: .copy-code}

#### 获取连接器配置
要获取指定连接器的配置，请按如下方式传入连接器名称：

```bash
tb-gateway-shell connector -c <name>
```
{: .copy-code}

### Gateway 命令
`gateway` 命令提供与网关本身相关的操作。

#### 获取网关状态
要获取网关状态，请使用以下命令：

```bash
tb-gateway-shell gateway -s
```
{: .copy-code}

## Next steps

Explore guides related to main ThingsBoard features:

 - [Data Visualization](/docs/user-guide/visualization/) - how to visualize collected data.
 - [Device attributes](/docs/user-guide/attributes/) - how to use device attributes.
 - [Telemetry data collection](/docs/user-guide/telemetry/) - how to collect telemetry data.
 - [Using RPC capabilities](/docs/user-guide/rpc/) - how to send commands to/from devices.
 - [Rule Engine](/docs/user-guide/rule-engine/) - how to use rule engine to analyze data from devices.
