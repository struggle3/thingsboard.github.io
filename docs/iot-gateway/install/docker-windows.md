---
layout: docwithnav-gw
title: 在 Windows 上使用 Docker 安装 ThingsBoard IoT Gateway
description: 在 Windows 上使用 Docker 安装并启动 ThingsBoard Gateway
redirect_from: 
 - "/docs/iot-gateway/install/windows/"
---

* TOC
{:toc}

本指南介绍如何在 Windows 上使用 Docker 安装并启动 ThingsBoard Gateway。

## 前置条件

- [安装 Docker Compose for Windows](https://docs.docker.com/desktop/setup/install/windows-install/){:target="_blank"}；
- 需要能访问 ThingsBoard。最简单的方式是使用 [ThingsBoard Cloud](https://thingsboard.io/installations/){:target="_blank"}。
也可按[安装指南](https://thingsboard.io/docs/user-guide/install/installation-options/){:target="_blank"}在本地安装 ThingsBoard。

## 下载 docker-compose 文件

{% assign downloadGatewayConfigurationFile = '
   ===
      image: /images/gateway/install/gateway-download-configuration-file-1-ce.png,
      title: 进入「**实体**」>「**网关**」页面，点击右上角「**加号**」图标添加新网关。
   ===
      image: /images/gateway/install/gateway-download-configuration-file-2-ce.png,
      title: 在弹出窗口中输入网关名称，选择「**default**」设备配置文件，点击「**创建**」。
   ===
      image: /images/gateway/install/gateway-download-configuration-file-3-ce.png,
      title: 将打开「**启动命令**」窗口。点击「**下载**」按钮下载网关的 docker-compose 文件。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=downloadGatewayConfigurationFile %}

## 运行

点击 **Docker QuickStart** 图标启动预配置的 **Docker Toolbox** 终端。

确保已[登录](https://docs.docker.com/engine/reference/commandline/login/){:target="_blank"} Docker Hub。
以管理员身份在包含 **docker-compose.yml** 文件的目录下执行以下命令启动网关：

```
docker compose up
```
{: .copy-code}

{% assign startGatewayWindows = '
    ===
        image: /images/gateway/install/start-gateway-windows-1-ce.png,
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=startGatewayWindows %}

## 后台运行命令

从会话中分离（容器将在后台继续运行），执行以下命令：

```
docker compose up -d
```
{: .copy-code}

重新附加到命令行（查看网关日志）时执行以下命令：

```
docker attach tb-gateway
```
{: .copy-code}

## 升级

更新到最新镜像，执行以下命令：

```
docker compose down
docker pull thingsboard/tb-gateway
docker compose up
```
{: .copy-code}

## 下一步

查阅 ThingsBoard 主要功能的相关指南：

 - [快速入门](/docs/iot-gateway/getting-started/) - ThingsBoard IoT Gateway 入门。
 - [数据可视化](/docs/user-guide/visualization/) - 如何可视化采集的数据。
 - [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
 - [遥测数据采集](/docs/user-guide/telemetry/) - 如何采集遥测数据。
 - [RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送及从设备接收命令。
 - [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析设备数据。
