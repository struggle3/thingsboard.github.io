---
layout: docwithnav-edge
title: 在 Windows 上安装 ThingsBoard Edge
description: 在 Windows 上安装 ThingsBoard Edge
---

* TOC
{:toc}

{% include templates/edge/install/compatibility-warning-general.md %}

{% assign docsPrefix = "edge/" %}

{% include templates/install/windows-warning-note.md %}

本指南介绍在 **Windows** 上安装 **ThingsBoard Edge** 的步骤。

以下步骤适用于：
* 32 位或 64 位系统
* Windows 11/10

{% include templates/edge/install/prerequisites.md %}

## 安装与配置

### 步骤 1：安装 Java 17（OpenJDK） 

{% include templates/install/windows-java-install.md %}

### 步骤 2：配置 PostgreSQL

{% include templates/edge/install/windows-db-postgresql.md %}

### 步骤 3：安装 ThingsBoard Edge 服务

下载并解压安装包。

```bash
https://github.com/thingsboard/thingsboard-edge/releases/download/{{ site.release.edge_tag }}/tb-edge-windows-{{ site.release.edge_ver }}.zip
```
{: .copy-code}

**注意：** 假设已将安装包解压到默认路径：*C:\Program Files (x86)\tb-edge*

### 步骤 4：配置 ThingsBoard Edge

{% include templates/edge/install/windows-configure-edge.md %}

### 步骤 5：运行安装脚本

{% include templates/edge/install/run-edge-install-windows.md %} 

### 步骤 6：启动 ThingsBoard Edge 服务

{% include templates/edge/install/windows-start-service.md %}

### 步骤 7：打开 ThingsBoard Edge UI

{% include templates/edge/install/open-edge-ui.md %} 

## 故障排除

日志文件位于 **logs** 目录（本示例中为 "C:\Program Files (x86)\tb-edge\logs"）。

**tb-edge.log** 文件中应包含以下行：

```text
YYYY-MM-DD HH:mm:ss,sss [main] INFO  o.t.server.TbEdgeApplication - Started TbEdgeApplication in x.xxx seconds (JVM running for x.xxx)
```

如有不明错误，请参阅通用 [故障排除指南](/docs/user-guide/troubleshooting/#getting-help) 或 [联系我们](/docs/contact-us/)。

## Windows 防火墙设置

若需从外部访问 ThingsBoard Web UI 及设备连接（HTTP、MQTT、CoAP），需在 Windows 防火墙高级安全中新建入站规则。
 
- 从「控制面板」打开「Windows 防火墙」：

![image](/images/user-guide/install/windows/windows7-firewall-1.png)

- 在左侧面板中点击「高级设置」：

![image](/images/user-guide/install/windows/windows7-firewall-2.png)

- 在左侧选择「入站规则」，然后在右侧「操作」面板中点击「新建规则...」：

![image](/images/user-guide/install/windows/windows7-firewall-3.png)

- 将打开「新建入站规则向导」窗口。在第一步「规则类型」中选择「端口」： 

![image](/images/user-guide/install/windows/windows7-firewall-4.png)

- 在「协议和端口」步骤中，选择「TCP」协议，并在「特定本地端口」中输入 **8080, 1883, 5683**：

![image](/images/user-guide/install/windows/windows7-firewall-5.png)

- 在「操作」步骤中保持选择「允许连接」：

![image](/images/user-guide/install/windows/windows7-firewall-6.png)

- 在「配置文件」步骤中选择该规则适用的 Windows 网络配置文件：

![image](/images/user-guide/install/windows/windows7-firewall-7.png)

- 最后，为规则命名（例如「ThingsBoard Service Networking」）并点击「完成」。

![image](/images/user-guide/install/windows/windows7-firewall-8.png)


## 下一步

{% include templates/edge/install/next-steps.md %}
