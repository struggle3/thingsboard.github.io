---
layout: docwithnav-trendz
assignees:
- ashvayka
title: 在 Windows 上安装 ThingsBoard Trendz Analytics
description: 在 Windows 上安装 ThingsBoard Trendz Analytics

trendz-settings:
  0:
    image: /images/trendz/install/sync/trendz-settings-1.png
    title: "Log in to <b>ThingsBoard</b> as a <b>Sysadmin</b>."
  1:
    image: /images/trendz/install/sync/trendz-settings-2.png
    title: "Open the <b>Trendz Settings</b> page."
  2:
    image: /images/trendz/install/sync/trendz-settings-3.png
    title: "If you see the message <b>\"Synchronization completed successfully\"</b>, the synchronization has been completed automatically and no further action is required."
trendz-sync:
  0:
    image: /images/trendz/install/sync/trendz-sync-1.png
    title: "If you see an error message, follow these steps."
  1:
    image: /images/trendz/install/sync/trendz-sync-2.png
    title: "Enter the correct <b>Trendz internal URL</b> and <b>ThingsBoard internal URL</b>."
  2:
    image: /images/trendz/install/sync/trendz-sync-3.png
    title: "Click <b>Save configuration</b>."
  3:
    image: /images/trendz/install/sync/trendz-sync-4.png
    title: "Click <b>Retry discovery</b>."
  4:
    image: /images/trendz/install/sync/trendz-sync-5.png
    title: "Once the message <b>\"Synchronization completed successfully\"</b> appears, the synchronization is complete."

---

* TOC
{:toc}

本指南说明如何在**Windows 10或11**（32位/64位）上安装**Trendz Analytics**。

**Windows安装前重要说明**

Trendz Analytics的部分功能（如**predictions**、**metric explorations**和**Python calculation fields**）依赖Python executor。

Python executor**仅能通过Docker运行**。即使在Windows上，也要使用Docker才能完整使用Trendz。
建议遵循[Docker (Windows) 安装指南](/docs/trendz/install/docker-windows)，采用Docker安装而非Windows。

**仅**在有充分理由使用Windows + Docker组合方案时再继续阅读本文。

## Prerequisites

### Hardware Requirements

{% include templates/trendz/install/hardware-requirements.md %}

### Software Requirements

{% include templates/trendz/install/docker-requirements-linux.md %}
{% include templates/trendz/install/thingsboard-requirements.md %}

## Installation Steps

### Step 1. Install Java 17 (OpenJDK) 

{% include templates/install/windows-java-install.md %}

### Step 2. Trendz Analytics service installation

下载并解压安装包。

```bash
https://dist.thingsboard.io/trendz-windows-{{ site.release.trendz_ver }}.zip
```
{: .copy-code}

**注意：** 假设Trendz解压到默认路径：*C:\Program Files (x86)\trendz*

### Step 3. Configure Trendz database

Trendz使用PostgreSQL作为数据库。可在同一服务器为Trendz安装PostgreSQL，或使用云商的托管PostgreSQL服务。

* **PostgreSQL Installation**

在[此处](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)下载安装文件（PostgreSQL 12.17或更新版本）并按照说明安装。

安装PostgreSQL时会提示设置superuser（postgres）密码。
请记住该密码，后续将使用。为简化说明，下例以"postgres"代替。

* **Create Database for Trendz**

安装完成后，启动"pgAdmin"并以superuser（postgres）登录。
打开服务器并创建owner为"postgres"的"trendz"数据库。

* **Configure database connection for Trendz**

以管理员身份打开记事本或其他编辑器（右键应用图标选择"以管理员身份运行"）。
打开并编辑以下文件（在文件选择对话框中选"所有文件"而非"文本文档"，编码为UTF-8）：

```text 
C:\Program Files (x86)\trendz\conf\trendz.yml
``` 
{: .copy-code}

定位到"datasource"块。将SPRING_DATASOURCE_URL、SPRING_DATASOURCE_USERNAME和SPRING_DATASOURCE_PASSWORD
替换为有效值。勿忘将"postgres"替换为真实的postgres密码：

```yml
datasource:
    driverClassName: "${SPRING_DRIVER_CLASS_NAME:org.postgresql.Driver}"
    url: "${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/trendz}"
    username: "${SPRING_DATASOURCE_USERNAME:postgres}"
    password: "${SPRING_DATASOURCE_PASSWORD:postgres}"
    hikari:
      maximumPoolSize: "${SPRING_DATASOURCE_MAXIMUM_POOL_SIZE:5}"
``` 
{: .copy-code}

### Step 4. Run installation script

以管理员身份打开Windows shell（命令提示符）。切换到Trendz安装目录。

执行**install.bat**脚本，将Trendz安装为Windows服务。
即系统启动时自动运行。
同理，**uninstall.bat**可从Windows服务中移除Trendz。
输出应类似：

  ```text
C:\Program Files (x86)\trendz>install.bat
Detecting Java version installed.
CurrentVersion 11
Java 11 found!
Installing Trendz Analytics...
...
Trendz Analytics installed successfully!
```

### Step 5. Start Trendz service

启动Trendz服务。
以管理员身份打开命令提示符，执行：

```shell
net start trendz
```
{: .copy-code}

预期输出：

```text
The Trendz Analytics service is starting.
The Trendz Analytics service was started successfully.
```

重启Trendz服务可执行：

```shell
net stop trendz
net start trendz
```

### Step 6. Sync ThingsBoard With Trendz

{% include templates/trendz/install/sync-with-tb.md %}

### Step 7. Install Trendz Python Executor

要使用Trendz Python Calculation Fields或Prediction Models等全部Trendz能力，
需安装Trendz Python Executor——该服务可安全运行Python代码。

安装方法[见](/docs/trendz/install/python-executor-configuration)。

## Authentication

{% include templates/trendz/install/authentication.md %}

## Troubleshooting

日志文件位于**logs**文件夹（本例为"C:\Program Files (x86)\trendz\logs"）。

**trendz.log**中应包含：

```text
YYYY-MM-DD HH:mm:ss,sss [main] INFO  o.t.t.TrendzApplication - Started TrendzApplication in x.xxx seconds (JVM running for x.xxx)
```

如有不明错误，可参考通用[troubleshooting指南](/docs/user-guide/troubleshooting/#getting-help)或[联系我们](/docs/contact-us/)。

## Windows firewall settings

若需从外部访问Trendz Web UI，
需在Windows Firewall with Advanced Security中创建新的入站规则。
 
- 从"控制面板"打开"Windows Firewall"：

![image](/images/user-guide/install/windows/windows7-firewall-1.png)

- 点击左侧"Advanced settings"：

![image](/images/user-guide/install/windows/windows7-firewall-2.png)

- 在左侧选择"Inbound Rules"，然后点击右侧"Actions"面板的"New Rule..."：

![image](/images/user-guide/install/windows/windows7-firewall-3.png)

- 打开"New Inbound Rule Wizard"。第一步"Rule Type"选择"Port"： 

![image](/images/user-guide/install/windows/windows7-firewall-4.png)

- 在"Protocol and Ports"步骤选择"TCP"协议，在"Specific local ports"中输入端口**8888**：

![image](/images/user-guide/install/windows/windows7-firewall-5.png)

- 在"Action"步骤保持"Allow the connection"：

![image](/images/user-guide/install/windows/windows7-firewall-6.png)

- 在"Profile"步骤选择应用此规则的Windows网络配置文件：

![image](/images/user-guide/install/windows/windows7-firewall-7.png)

- 最后为规则命名（如"Trendz Service Networking"）并点击"Finish"。

![image](/images/user-guide/install/windows/windows7-firewall-8.png)

## Next steps

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}
