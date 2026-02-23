---
layout: docwithnav
assignees:
- ikulikov
title: 在 Windows 上安装 ThingsBoard
description: 在 Windows 上安装 ThingsBoard

---

{% include templates/live-demo-banner.md %}

* TOC
{:toc}

{% include templates/install/windows-warning-note.md %}

## 前置条件

本指南介绍如何在 Windows 机器上安装 ThingsBoard。
以下说明适用于 Windows 11/10。
硬件要求取决于所选数据库及连接系统的设备数量。
在同一台机器上运行 ThingsBoard 和 PostgreSQL 至少需要 4GB 内存。
在同一台机器上运行 ThingsBoard 和 Cassandra 至少需要 8GB 内存。

## 步骤 1. 安装 Java 17 (OpenJDK) 

{% include templates/install/windows-java-install.md %}

## 步骤 2. ThingsBoard 服务安装

下载并解压安装包。

```bash
https://github.com/thingsboard/thingsboard/releases/download/{{ site.release.ce_tag }}/thingsboard-windows-{{ site.release.ce_ver }}.zip
```
{: .copy-code}

**注意：** 我们假定您已将 ThingsBoard 安装包解压到默认位置：*C:\Program Files (x86)\thingsboard*

## 步骤 3. 配置 ThingsBoard 数据库

{% include templates/install/install-db.md %}

{% capture contenttogglespec %}
PostgreSQL <small>(recommended for < 5K msg/sec)</small>%,%postgresql%,%templates/install/windows-db-postgresql.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="ubuntuThingsboardDatabase" toggle-spec=contenttogglespec %} 

## 步骤 4. 选择 ThingsBoard queue 服务

{% include templates/install/install-queue.md %}

{% capture contenttogglespecqueue %}
In Memory <small>(built-in and default)</small> %,%inmemory%,%templates/install/queue-in-memory.md%br%
Kafka <small>(recommended for on-prem, production installations)</small> %,%kafka%,%templates/install/windows-queue-kafka.md%br%
Confluent Cloud <small>(Event Streaming Platform based on Kafka)</small>%,%confluent-cloud%,%templates/install/windows-queue-confluent-cloud.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="windowsThingsboardQueue" toggle-spec=contenttogglespecqueue %} 

## 步骤 5. [可选] 低配机器内存更新（4GB 内存） 

{% include templates/install/windows-memory-on-slow-machines.md %} 

## 步骤 6. 运行安装脚本

以管理员身份启动 Windows shell（命令提示符）。切换至 ThingsBoard 安装目录。

执行 **install.bat** 脚本，将 ThingsBoard 安装为 Windows 服务（或运行 **".\install.bat --loadDemo"** 安装并添加演示数据）。
安装后将在系统启动时自动运行。
类似地，**uninstall.bat** 可从 Windows 服务中移除 ThingsBoard。
输出应类似如下：
  
  ```text
C:\Program Files (x86)\thingsboard>.\install.bat --loadDemo
Detecting Java version installed.
CurrentVersion 170
Java 17 found!
Installing thingsboard ...
...
ThingsBoard installed successfully!
```

## 步骤 7. 启动 ThingsBoard 服务

{% include templates/windows-start-service.md %}

{% capture 90-sec-ui %}
Web UI 启动最多可能需要 90 秒。{% endcapture %}
{% include templates/info-banner.md content=90-sec-ui %}

## 安装后步骤

### 升级到新版本 ThingsBoard

{% include templates/install/upgrade-thingsboard.md %}

## 故障排查

日志文件位于 **logs** 文件夹（本文示例为 "C:\Program Files (x86)\thingsboard\logs"）。

**thingsboard.log** 文件应包含如下行：

```text
YYYY-MM-DD HH:mm:ss,sss [main] INFO  o.t.s.ThingsboardServerApplication - Started ThingsboardServerApplication in x.xxx seconds (JVM running for x.xxx)
```

如遇不明错误，请参考通用 [故障排查指南](/docs/user-guide/troubleshooting/#getting-help) 或 [联系我们](/docs/contact-us/)。

## Windows 防火墙设置

为允许外部访问 ThingsBoard Web UI 及设备连接（HTTP、MQTT、CoAP），
需在 Windows 高级安全防火墙中新建入站规则。
 
- 从「控制面板」打开 "Windows Firewall"：

![image](/images/user-guide/install/windows/windows7-firewall-1.png)

- 在左侧面板点击 "Advanced settings"：

![image](/images/user-guide/install/windows/windows7-firewall-2.png)

- 在左侧面板选择 "Inbound Rules"，在右侧 "Actions" 面板点击 "New Rule..."：

![image](/images/user-guide/install/windows/windows7-firewall-3.png)

- 将打开 "New Inbound Rule Wizard" 窗口。在第一步 "Rule Type" 选择 "Port" 选项：

![image](/images/user-guide/install/windows/windows7-firewall-4.png)

- 在 "Protocol and Ports" 步骤选择 "TCP" 协议，在 "Specific local ports" 字段输入端口列表 **8080, 1883, 5683**：

![image](/images/user-guide/install/windows/windows7-firewall-5.png)

- 在 "Action" 步骤保持 "Allow the connection" 选项为选中状态：

![image](/images/user-guide/install/windows/windows7-firewall-6.png)

- 在 "Profile" 步骤选择应用此规则的 Windows 网络配置文件：

![image](/images/user-guide/install/windows/windows7-firewall-7.png)

- 最后，为此规则命名（例如 "ThingsBoard Service Networking"）并点击 "Finish"。

![image](/images/user-guide/install/windows/windows7-firewall-8.png)



## 下一步

{% assign currentGuide = "InstallationGuides" %}{% include templates/guides-banner.md %}
