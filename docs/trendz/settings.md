---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: Trendz 设置
description: Trendz 设置说明
---

* TOC
{:toc}

点击屏幕左下角**"Settings"**按钮进入**Settings**页面。

![Settings Navigation](/images/trendz/signing-key-1.png)

## System

### Import / Export

将数据从一个Trendz实例迁移到另一个时，使用内置**Import/Export**机制。

可导出和导入：

- Business Entities及其Fields
- View Configurations和View Collections
- Calculation Fields
- Prediction Models
- Anomaly Models和Anomalies
- AI Assistant Chats和Messages
- Prompts
- Tasks
 
**Exporting**

点击**Export**按钮即可，无需其他步骤。
文件将自动下载。

**Importing**

点击**Import**按钮，选择此前导出的文件，并配置**Skip duplicates**选项：
- **True** – 导入文件中的重复项将被忽略。
- **False** – 重复项将导致导入错误。

配置完成后点击**Import Configuration**。成功后会显示确认消息。

**Limitations**
- 不支持**不同Trendz版本**间的迁移。
- 不支持**不同tenant**间的迁移。

### Cache Management

本区域用于管理Trendz中使用的各类cache，如清除local cache或telemetry cache。
详见[Cache Settings文档](/docs/trendz/cache-settings)。

### External Data Source

在此配置和管理外部SQL数据源，并与Trendz视图集成。
详见[外部数据源指南](/docs/trendz/mix-sql-datasource)。

## AI Settings

此处可配置以下功能的AI Model：

* [Metric Explorer](/docs/trendz/metric/overview)
* [View AI Assistant](/docs/trendz/ai-assistance-overview)
* [AI Widget Summary](/docs/trendz/ai-widget-summary)

AI Setting配置方法[见](/docs/trendz/custom-ai-model-configuration/)。

## White Labeling

可将Trendz用户界面（logo、颜色、标签）customize为您的品牌。
完整配置选项见[White Labeling文档](/docs/trendz/white-labeling)。

## General (Deprecated)

仅在Trendz连接ThingsBoard 4.2.1或更早版本时显示此选项卡。

### Signing Key

为使应用正常运行，需代表用户向ThingsBoard进行身份验证。后台操作需要此验证，例如：

- 发送生成的telemetry
- 持续 prediction model fitting 和 forecasting 时拉取数据

在应用内存中存储用户凭证不安全。Trendz支持使用**JWT signing key**的安全机制，应存储在配置文件中。Trendz应安装在安全服务器上（与ThingsBoard及类似系统相同）。

也可在Trendz数据库中自动存储signing key，但出于安全考虑**不推荐**。

设置中的指示器显示signing key是否已设置且有效。

**如何检查Signing Key**

滚动至**Settings**页面底部找到**Signing Key**面板。将看到以下两种之一：

- **The signing key is not valid (not set or expired)**  
  ![Signing Key Invalid](/images/trendz/signing-key-2.png)

- **The signing key is valid**  
  ![Signing Key Valid](/images/trendz/signing-key-3.png)

**Setting the Signing Key**

按以下步骤配置signing key：

1. **以System Administrator身份登录ThingsBoard**  
   ![Login](/images/trendz/signing-key-4.png)

2. 进入**Security → General**  
   ![Security General Page](/images/trendz/signing-key-5.png)

3. 滚动至**JWT Security Settings**区域  
   ![JWT Security](/images/trendz/signing-key-6.png)

4. 复制**Signing key**字段的值。

**安装方式相关说明**
- *Ubuntu Installation*

    1. SSH到运行Trendz的服务器。

    2. 打开Trendz配置文件：

       ```bash
       sudo nano /etc/trendz/conf/trendz.conf
       ```
       {: .copy-code}

    3. 在文件末尾添加signing key：

       ```bash
       export JWT_TOKEN_SIGNING_KEY=<signing-key>
       ```
       {: .copy-code}
       ![Ubuntu Signing Key](/images/trendz/signing-key-7.png)

    4. 保存文件并重启Trendz服务。


- *Docker Compose Installation*
    1. 打开`docker-compose.yml`文件。

    2. 在Trendz服务下添加新的environment变量：

       ```yaml
       environment:
         - JWT_TOKEN_SIGNING_KEY=<signing-key>
       ```
       {: .copy-code}
       ![Docker Signing Key](/images/trendz/signing-key-8.png)

    3. 保存文件并重启Trendz容器。

### Trendz Widget Bundle

上传Trendz Widget Bundle是启用从Trendz向ThingsBoard dashboards共享视图所**必须**的。
*（安装后如何使用部件[见](/docs/trendz/embed-visuals)）*

在**Trendz Widget Bundle**区域将看到以下状态之一：

- **Not installed** – Bundle未安装。
- **Update required** – 有更新版本。
- **Latest version installed** – 已安装最新版。
- **Bundle is invalid** – 当前bundle损坏或不完整。

**操作步骤：**

- 若状态为**Latest version installed** – 无需操作。
- 其他状态时，点击**Upload bundle**按钮：
    - 未安装时——上传bundle。
    - 版本过时时——更新到最新版。

### Trendz JS Summary Module

上传Trendz JS Summary Module**推荐**用于在ThingsBoard部件间配置AI Widget Summaries。
*（如何配置AI Widget Summaries[见](/docs/trendz/ai-widget-summary)）*

在**Trendz JS Summary Module**区域查看状态：

- **Not installed** – 未安装。
- **Update required** – 有更新版本。
- **Latest version installed** – 无需操作。

**操作步骤：**

- 若状态为**Latest version installed** – 已完成。
- 否则点击**Upload Module**按钮：
    - 未安装时——上传模块。
    - 版本过时时——更新。
