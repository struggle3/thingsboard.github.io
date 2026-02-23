---
layout: docwithnav-pe
title: Trendz 设置
description: ThingsBoard IoT 平台 Trendz 设置

trendz-settings:
  0:
    image: /images/user-guide/ui/trendz/trendz-settings.png
    title: 'Trendz设置页面。'

trendz-settings-sync-status:
  0:
    image: /images/user-guide/ui/trendz/trendz-settings-sync-status-1.png
    title: '若Trendz同步成功，您将看到：<b>Synchronization completed successfully</b>（同步已成功完成）。'
  1:
    image: /images/user-guide/ui/trendz/trendz-settings-sync-status-2.png
    title: '若有问题，将显示包含说明的错误消息。'

---

* TOC
{:toc}

在**Trendz设置**页面，您可以配置与[Trendz Analytics附加组件](/docs/trendz/what-is-trendz)的连接。

## 前提条件

* 需为要使用Trendz的ThingsBoard实例激活Trendz附加组件。激活方法请见[此处](/docs/trendz/activation/self-managed)。
* Trendz需已安装且可从ThingsBoard访问。安装方法请见[此处](/docs/trendz/install/installation-options)。

## 如何访问

* 以系统管理员身份登录ThingsBoard。
* 点击左侧菜单中的**Trendz settings**选项卡。

{% include images-gallery.html imageCollection="trendz-settings" %}

## Trendz配置

在此可设置**Trendz配置**：
* **Trendz Internal URL** - ThingsBoard用于与Trendz通信的URL。
* **ThingsBoard Internal URL** - Trendz用于与ThingsBoard通信的URL。

### 示例

不同安装类型的URL示例：

* **Ubuntu / Windows / CentOS / RHEL（Trendz和ThingsBoard安装在同一台机器）**：
  - Trendz Internal URL - `http://localhost:8888` 
  - ThingsBoard Internal URL - `http://localhost:8080`

* **Docker（Trendz和ThingsBoard在同一docker compose文件中）**：
  - Trendz Internal URL - `http://trendz:8888`
  - ThingsBoard Internal URL - `http://thingsboard-pe:8080`

* **Kubernetes（ThingsBoard和Trendz在同一集群中）**：
  - Trendz Internal URL - `http://trendz-app:8888`
  - ThingsBoard Internal URL - `http://tb-node:8080`

若Trendz和ThingsBoard在私有网络中无法相互访问，可使用公共URL。例如，若ThingsBoard和Trendz在同一域**mydomain**下：
  - Trendz Internal URL - `https://mydomain`
  - ThingsBoard Internal URL - `https://mydomain`

## 操作

在此页面可执行以下**操作**：

* **Save Configuration** - 保存Trendz和ThingsBoard的URL配置。
* **Retry Discovery** - 使用**已保存的配置**启动与Trendz的同步。
* **Retry Healthcheck** - （仅当Trendz已与ThingsBoard同步时可见）检查Trendz同步当前是否存在错误。

您可在页面标题处查看同步结果：
* 若Trendz同步成功，将显示：**Synchronization completed successfully**。
* 若有问题，将显示包含说明的错误消息。

{% include images-gallery.html imageCollection="trendz-settings-sync-status" %}
