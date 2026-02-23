* TOC
{:toc}

本指南演示 ThingsBoard 常用功能的基本用法。您将学习如何：

- 将设备连接至 ThingsBoard
- 从设备向 ThingsBoard 推送数据
- 构建实时仪表板
- 创建客户并与他们共享仪表板
- 定义阈值并触发告警
- 通过邮件、SMS、移动应用或第三方服务配置通知

为简化说明，我们将以温度传感器数据为例进行可视化。

更偏好视频学习？可观看分步[视频教程](https://www.youtube.com/watch?v=iIuyG1KL-bw){:target="_blank"}。

<hr>

{% include templates/prerequisites-pe.md %}

<hr>

## 步骤 1. 配置设备

示例：添加一台向 ThingsBoard 平台发送以下数据的设备：设备名称及温度遥测读数。

按以下步骤添加新设备：
 
{% include images-gallery.html imageCollection="step1" showListImageTitles="true" %} 

添加设备时您也会收到通知。点击右上角 **铃铛图标** 可查看通知。

{% include images-gallery.html imageCollection="step11" %}

[在此了解通知相关说明](#step-6-alarm-notifications)。

**其他配置方式**
- [批量配置](/docs/{{docsPrefix}}user-guide/bulk-provisioning/){:target="_blank"}：通过界面 CSV 导入多个设备。
- [设备配置](/docs/{{docsPrefix}}user-guide/device-provisioning/){:target="_blank"}：配置设备自动注册。
- [REST API](/docs/{{docsPrefix}}api/){:target="_blank"} 配置：通过 API 编程管理设备。

<hr>

## 步骤 2. 连接设备

验证设备与 ThingsBoard 的连接：

{% include images-gallery.html imageCollection="step2" showListImageTitles="true" %}

<br>
查看 [ThingsBoard API 参考](/docs/{{docsPrefix}}api){:target="_blank"}，获取设备连接所支持协议的更详细说明。

<hr>

## 步骤 3. 创建仪表板

ThingsBoard 中的仪表板用于可视化和监控从 IoT 设备采集的数据。

创建仪表板并添加三个部件，用于展示实体列表及其最新值，以及指定实体的告警信息。

### 步骤 3.1 创建空仪表板

按以下步骤创建新仪表板：

{% include images-gallery.html imageCollection="step31" showListImageTitles="true" %}

### 步骤 3.2 添加实体表部件

「实体表」部件展示实体列表及其最新值。
实体列表对应所选设备或其他实体，支持全文搜索和分页过滤。

添加表格部件时需从部件库中选择。部件按部件包分组。
每个部件有数据源，用于确定要展示的数据。
为查看步骤 2 中发送的「temperature」数据最新值，需配置数据源。

添加第一个部件：

{% include images-gallery.html imageCollection="step32" showListImageTitles="true" %}

恭喜！您已添加第一个部件。

「实体表」部件包含两列。
第一列显示设备名称，第二列显示「temperature」键（设备遥测）的值。
每列对应一个添加的键。

现在可发送新的遥测读数（同[步骤 1](#step-1-provision-device)），它会立即显示在表格中。

### 步骤 3.3 添加图表部件

图表部件用于展示时序数据，支持可定制的折线图和柱状图。

添加图表部件时需从部件库中选择。
图表部件显示同一数据键的多个历史值（本例为「temperature」）。
还需配置时间窗口以使用图表部件。

{% include images-gallery.html imageCollection="step33" showListImageTitles="true" %}

恭喜！您已添加图表部件。现在可发送新的遥测读数，它会立即显示在图表中。

还可调整部件中数据展示的时间间隔、修改聚合函数、指定分组间隔。
打开[时间窗口](/docs/{{docsPrefix}}user-guide/dashboards/#time-window){:target="_blank"}并进行设置，然后点击「更新」按钮应用时间窗口配置。

{% include images-gallery.html imageCollection="step33_2" %}

### 步骤 3.4 添加告警表部件

告警表部件在指定时间窗口内显示与指定实体相关的告警。
通过指定实体为告警源并配置对应告警字段来配置告警部件。

{% include images-gallery.html imageCollection="step34" showListImageTitles="true" %}

接下来配置告警规则并触发告警。

> **说明**：本文档以单个设备作为部件数据源。
若要以动态实体（如某类设备或某资产下的设备）为数据源，需使用 alias。
Alias 是部件中使用的单个实体或实体组的引用。
可在此[了解不同类型 alias](/docs/{{docsPrefix}}user-guide/ui/aliases/){:target="_blank"}。

<hr>

## 步骤 4. 配置告警规则

使用[告警规则](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}功能定义：当温度超过 **25°C** 时触发。  
告警规则可在**设备级别**或目标设备使用的[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}级别配置。

> **建议**：若同一规则需应用于多台设备，请在**设备配置文件**级别创建。  
便于集中管理告警逻辑、简化维护并避免配置重复。

本示例中，我们将在设备「**My New Device**」上直接配置告警规则。

<br><b><font size="4">步骤 4.1 打开设备设置</font></b>
- 进入 **实体** 下的 **设备** 页面。
- 点击 **My New Device** 打开详情。
- 切换到 **告警规则** 选项卡。
- 点击「**+**」并选择 **创建新告警规则**。

<b><font size="4">步骤 4.2 配置通用参数</font></b>

在 **通用** 部分，填写 **告警类型** —— *高温*（或您喜欢的其他名称）—— 作为告警名称和唯一标识。

<b><font size="4">步骤 4.3 添加参数</font></b>

定义告警触发条件前，需至少添加一个 **参数** —— 规则使用的数据源。

在 **参数** 部分点击 **添加参数** 并填写：
- **实体类型**：*当前实体*
- **参数类型**：*最新遥测*
- **时序键**：<span class="code-light">temperature</span>
- **参数名**：temperature
- 点击 **添加**。

这将创建告警规则条件中使用的 <span class="code-light">temperature</span> 变量。

<b><font size="4">步骤 4.4 配置告警触发条件</font></b>

在 **触发条件** 部分点击 **添加触发条件**。

- **严重程度**：*严重*
- **条件** 
  - 点击 **添加条件**。
  - 在配置窗口中点击 **添加参数过滤器** 并设置：
    - **通用** 块：
      - **参数**：temperature（之前添加的参数）
      - **值类型**：*数值*
    - **过滤器** 块：
      - 点击 **添加**
      - **操作**：*大于* 
      - **值来源**：静态
      - **值**：<span class="code-light">25</span>
    - 点击 **添加**。 
  - **类型**：*简单*
  - 点击 **保存**。

配置完成后，温度超过 **25°C** 时将立即触发告警。

<b><font size="4">保存规则</font></b>

点击 **添加** 保存新的告警创建规则。

保存后规则立即生效。

{% include images-gallery.html imageCollection="step4" %}

建议参考[告警规则配置示例](/docs/{{docsPrefix}}user-guide/alarm-rules/#examples-of-alarm-rule-configurations){:target="_blank"}

<hr>

## 步骤 5. 创建告警

告警规则已生效（见[步骤 4](#step-4-configure-alarm-rules)），需从设备发送新的遥测数据（见[步骤 2](#step-2-connect-device)）以触发告警。

> **注意**：仅当温度值超过告警创建条件中定义的 25°C 阈值时才会创建告警。

**发送遥测后将发生什么**

{% include images-gallery.html imageCollection="step5" showListImageTitles="true" %}

<hr>

## 步骤 6. 告警通知

ThingsBoard [通知中心](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"} 可向最终用户发送与设备活动、环境变化或 IoT 生态事件相关的个性化通知。
通知可通过邮件、SMS 或集成的第三方系统送达。

{% include images-gallery.html imageCollection="notification-center" %}

此外，[ThingsBoard PE 移动应用](/docs/pe/mobile/){:target="_blank"} 可直接向手机推送即时通知，帮助您随时了解关键事件。

按[此指南](/docs/pe/mobile/getting-started/){:target="_blank"} 安装 ThingsBoard 移动应用并配置通知。

欢迎继续探索 ThingsBoard！

<hr>

## 步骤 7. 与客户共享仪表板

ThingsBoard 的重要功能之一是为最终用户创建仪表板。
每位客户用户应仅能看到自己的设备，不能看到属于其他客户的设备或数据。

我们已创建设备（见[步骤 1](#step-1-provision-device)）、创建仪表板并添加部件（见[步骤 3](#step-3-create-dashboard)）。
接下来创建客户和客户用户，并确保他们能访问设备数据与仪表板。
租户管理员可通过以下两种方式向客户授予对实体（设备、仪表板、资产等）的访问权限：

* A. 将客户指定为实体的所有者。适用于确保仅该客户可访问设备及其数据（见[步骤 7.2](#step-72-change-owner-of-the-device)）。
* B. 与客户共享实体。适用于将单个仪表板共享给多个客户（见[步骤 7.3](#step-73-share-the-dashboard)）。
 
#### 步骤 7.1 创建客户

创建标题为「My New Customer」的客户，按以下说明操作：

{% include images-gallery.html imageCollection="step71" showListImageTitles="true" %}

### 步骤 7.2 更改设备所有者

将客户指定为设备所有者。同时创建设备组并将设备加入其中。

{% include images-gallery.html imageCollection="step72" showListImageTitles="true" %}

确认设备已分配给您的客户。

{% include images-gallery.html imageCollection="step72_1" showListImageTitles="true" %}

可在创建设备时直接将客户设为所有者。按以下步骤操作：

{% include images-gallery.html imageCollection="step72_2" showListImageTitles="true" %}

### 步骤 7.3 共享仪表板

将仪表板共享给客户。
在 ThingsBoard 中不能直接共享单个仪表板，只能共享包含该仪表板的仪表板组。
默认情况下，仪表板位于「全部」组。
推荐做法是创建专用仪表板组并将仪表板移入其中；为简化说明，本指南使用已有的「全部」组。

{% include images-gallery.html imageCollection="step73" showListImageTitles="true" %}

也可在创建仪表板时即与客户共享：

{% include images-gallery.html imageCollection="step73_1" showListImageTitles="true" %}

### 步骤 7.4 创建客户用户

创建属于该客户且对仪表板与设备具有 `只读` 权限的用户。
可选择性配置用户登录平台 Web 界面后直接显示该仪表板。

{% include images-gallery.html imageCollection="step74" showListImageTitles="true" %}

### 步骤 7.5 激活客户用户

最后，以客户用户身份登录 ThingsBoard。

- 将之前复制的链接粘贴到新标签页并按「Enter」。输入两次密码并点击「创建密码」完成密码设置。
- 您现在已以客户用户身份登录。由于该用户仅有只读权限，可查看设备数据与告警，但无法确认或清除告警。  
了解更多权限与基于角色的访问控制（RBAC），请点击[此处](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}。

{% include images-gallery.html imageCollection="step75" %}

<hr>

## 下一步

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 反馈

欢迎在 [GitHub](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星，帮助我们推广。  
若对本示例有疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。