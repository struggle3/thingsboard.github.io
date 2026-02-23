* TOC
{:toc}

**设备**是ThingsBoard中的基础物联网实体，可**生成遥测数据**（如温度、湿度、GPS坐标等）并**传输**至ThingsBoard平台，还能响应远程过程调用(RPC)命令。
设备可以是物理对象（如传感器、控制器、追踪器）或虚拟对象（如模拟器），需具备网络连接能力，能够：
- **生成遥测数据**——发送温度、湿度、位置等测量数据。
- **通过[支持的协议](/docs/{{docsPrefix}}reference/protocols/){:target="_blank"}（MQTT、HTTP、CoAP等）将数据传至ThingsBoard平台**。
- **响应RPC命令**——接收并执行平台发送的远程过程调用。

每台设备：
- 作为独立**实体**存储。
{% unless docsPrefix == null %}- 可属于一个或多个 [device groups](/docs/{{docsPrefix}}user-guide/groups/){:target="_blank"}。{% endunless %}
- 具有定义类型、transport 设置、固件、alarm 规则等的 device profile。
- 可分配 [owner](/docs/{{docsPrefix}}user-guide/ui/devices/#manage-owner-and-groups)。
- 同时支持 [attributes](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"}（静态或半静态属性）和 [telemetry](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"}（时序数据）。

> ThingsBoard支持通过Web界面和[REST API](/docs/{{docsPrefix}}reference/rest-api/){:target="_blank"}进行设备管理。

<b><font size="4">实践视频课程 🎥</font></b>

本实践视频课程详细讲解如何在ThingsBoard中创建和管理设备。

> 课程包含实践示例，帮助您更好地理解仪表板、资源和设备的配置与使用。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/65SoFceFDBE" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

<hr>

## 如何添加、编辑和删除设备

租户管理员及具有相应权限的用户可在ThingsBoard中创建、编辑或删除设备。

### 添加新设备

添加新设备的步骤：
- 进入 **实体** &#10230; **设备**。{% unless docsPrefix == null %}默认显示「**全部**」设备组。{% endunless %}
- 点击右上角的「**+**」图标，在下拉菜单中选择「**添加新设备**」。
- 在设备创建表单中填写必填项：
  - **名称**——设备的唯一名称。
  - **[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/){:target="_blank"}**——默认使用「**default**」配置，可按需选择其他配置。
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") or (docsPrefix == "paas/eu/") %}- 如需要，可填写附加字段（如 label 或 description）、为设备指定不同 owner，并将设备加入[分组](#creating-device-group)。{% endif %}
{% if (docsPrefix == nil %}- 可选字段如 **Label** 或 **Description** 可按需填写。{% endif %}
- 点击「**Add**」。

设备创建成功后会在列表中显示。

随后会弹出窗口，可在其中[检查设备与ThingsBoard平台的连接](#check-connectivity)。
此步骤可选。可先关闭窗口，稍后再详细了解连接检查。

{% include images-gallery.html imageCollection="add-device" %}

您还会收到[通知](/docs/{{docsPrefix}}user-guide/notifications/){:target="_blank"}（铃铛图标）提示设备已添加。

{% include images-gallery.html imageCollection="add-device-notification" %}

<hr>

{% unless docsPrefix == null %}

### 创建设备组

设备可属于一个或多个[分组](/docs/{{docsPrefix}}user-guide/groups/){:target="_blank"}，便于组织和管理。

创建新设备组的步骤：

{% include images-gallery.html imageCollection="add-device-group-pe" showListImageTitles="true" %}

<hr>

### 管理设备组：添加、移动、移除

在设备页面可向分组添加设备、在分组间移动设备或从分组移除设备。

「全部」设备组始终包含所选所有者级别（租户或客户）下的所有设备。

**向分组添加单个设备：**
- 打开[设备详情](#device-details)➜点击**管理所有者和分组**。
- 在对话框中按需调整所有者，选择要添加或移除设备的分组。
- 点击**保存**。

**向一个分组添加多台设备：**
- 在**分组**标签页打开任意设备组（如「**全部**」）。
- 通过名称左侧的复选框勾选设备。
- 点击右上角的「**添加到分组**」（加号圆圈图标）。
- 在**添加到分组**窗口选择**选择现有实体组**或**创建新实体组**。
- 选择已有分组或创建新设备组。
- 点击**添加**确认将设备加入分组。

{% capture multiple %}
**注意**：此操作会将设备加入所选分组，但不会从其他分组移除。
{% endcapture %}
{% include templates/info-banner.md content=multiple %}

**将设备移至另一分组：**
- 打开特定（非 **All**）分组。
- 选中设备并点击 **Move to group**（双箭头图标）。
- 在「Move to group」窗口中选择 **Select existing entity group** 或 **Create new entity group**。
- 选择现有设备分组或创建新分组。
- 点击 **Move** 确认。

此操作会将设备从当前分组移出，并加入所选分组。

**从分组中移除设备：**
- 打开特定（非 **All**）分组。
- 选中设备并点击右上角 **Remove from group**（圆圈减号图标）。
- 确认移除。

{% capture difference %}
**注意**：设备不会被删除； 它们仍保留在 owner 的 「**All**」设备分组中。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% endunless %}

### 编辑设备

可修改设备名称、设备配置文件、标签，并分配固件和软件。
编辑设备步骤如下：

{% include images-gallery.html imageCollection="editing-device" showListImageTitles="true" %}

<hr>

### 删除设备

可通过以下任一方式删除设备：

方式一：

{% include images-gallery.html imageCollection="device-delete-1" showListImageTitles="true" %}

方式二：

{% include images-gallery.html imageCollection="device-delete-2" showListImageTitles="true" %}

## 检查连接

**检查连接**是内置功能，提供即用命令，用于通过不同通信协议测试设备与ThingsBoard的连通性。可快速验证网络访问、凭证及遥测是否被正确处理。

使用此功能可发布测试遥测（例如温度为25），并立即确认设备能与平台通信。

**验证设备连接：**
1. 点击设备打开其详情页。
2. 点击**检查连接**。
3. 选择[通信协议](/docs/{{docsPrefix}}reference/protocols/){:target="_blank"}（[MQTT](/docs/{{docsPrefix}}reference/mqtt-api){:target="_blank"}、[HTTP](/docs/{{docsPrefix}}reference/http-api){:target="_blank"}等）及您的操作系统。
4. 复制生成的命令并在终端中执行。

若连接成功：
- 设备状态由**未激活**变为**已激活**。
- **最新遥测**标签页会显示遥测数据。

{% capture difference %}
根据您的技术栈连接设备，请参阅[连接指南](/docs/guides/#AnchorIDGettingStartedGuides){:target="_blank"}。<br>
高级协议与API选项请参阅[ThingsBoard API参考](/docs/{{docsPrefix}}reference/protocols/){:target="_blank"}。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include images-gallery.html imageCollection="check-connectivity" %}

<hr>

## 管理设备凭证

支持的凭证类型：

- [Access Token](/docs/{{docsPrefix}}user-guide/access-token/){:target="_blank"}（默认）。
- [X.509](/docs/{{docsPrefix}}user-guide/certificates/){:target="_blank"} 证书。
- [MQTT Basic](/docs/{{docsPrefix}}user-guide/basic-mqtt/){:target="_blank"}。

要修改或管理凭证，请按以下步骤操作：

{% include images-gallery.html imageCollection="manage-device-credentials" showListImageTitles="true" %}

<hr>

{% if docsPrefix == null %}
## 将设备设为公开

可将设备设为公开，使其数据对所有人可见。适用于需访问设备数据的公开演示 dashboard 或开放数据场景。

{% include images-gallery.html imageCollection="make-device-public" showListImageTitles="true" %}

若要将设备恢复为私有，请按以下步骤操作：

{% include images-gallery.html imageCollection="make-device-private" showListImageTitles="true" %}

> 设备设为私有后，将不再公开可访问，任何引用该设备的 **public [dashboards](/docs/user-guide/dashboards/){:target="_blank"}** 将失去对其数据的访问权限。

<hr>

## 将设备分配给 customer

可将设备分配给特定 [customer](/docs/user-guide/ui/customers/){:target="_blank"}。这样只有与该 customer 关联的用户才能访问该设备及其数据。

> 此步骤对确保数据 [access control](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"} 至关重要。每位 customer 用户只能看到自己的设备，无法访问分配给其他 customer 的设备或数据。

{% include images-gallery.html imageCollection="assign-device-to-customer" showListImageTitles="true" %}
在 ThingsBoard Professional Edition (PE) 中，可在设备详情中通过 [“Manage owner and groups”](https://thingsboard.io/docs/pe/user-guide/ui/devices/#manage-device-owner-and-groups){:target="_blank"} 按钮分配设备。此方式不仅可分配 ownership，还可同时管理 group 成员关系。
{% endif %}

{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") or (docsPrefix == "paas/eu/") %}
## 管理设备 owner 与 groups
可更改设备的 owner（可为 Tenant 或 Customer，参见 [glossary](https://thingsboard.io/docs/{{docsPrefix}}user-guide/rbac/#glossary){:target="_blank"}）以控制谁能访问该设备及其数据。更改 owner 会将设备移至所选层级，并根据 groups 更新访问权限。

与 Community Edition (CE)仅能将设备分配给特定 customer 不同，Professional Edition (PE) 中还可通过「Manage owner and groups」按钮管理 ownership 与 group 成员关系。

操作步骤：
- 点击设备打开其 **Device details**。
- 点击「**Manage owner and groups**」按钮。
- 在 **Owner** 字段中选择 [Tenant](https://thingsboard.io/docs/{{docsPrefix}}user-guide/ui/tenants/){:target="_blank"} 或特定 [Customer](https://thingsboard.io/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"}.
- 将设备加入相应 **device groups**，或按需 [create a new group](#creating-device-group)。
- 点击「**Update**」确认并应用更改。

{% capture difference %}
**注意**：group 成员关系与 ownership 的更改会立即生效，并根据所分配 group 的 [roles](/docs/{{docsPrefix}}user-guide/rbac/#roles){:target="_blank"} 更新用户访问权限。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% include images-gallery.html imageCollection="manage-owner-and-groups-pe" %}

Tenant 管理员始终有权重新分配或撤销设备 ownership。

<hr>

### 包含 customer 实体

在「<b>Devices</b>」页面有「<b>Include customer entities</b>」选项，用于控制列表是否显示归属于 customer 的设备。

{% include images-gallery.html imageCollection="include-customer-entities" showListImageTitles="true" %}

## 共享设备
可将设备加入设备 group 后，将 group 共享给 customer。

详细步骤请参阅 [共享设备 group](#share-device-group) 一节。

{% endif %}

<hr>

{% unless docsPrefix == null %}

## 将设备 group 设为公开

可将设备 group 设为公开，使其中所有数据对所有人可访问。适用于：
- 创建需访问设备数据的公开演示 dashboard。
- 支持开放数据场景。

> 无法直接共享单个设备，只能共享包含该设备的设备 group。

将设备 group 设为公开的步骤：
- 在列表中找到目标设备 group。
- 点击其旁的「**Make public**」图标。
- 在弹出对话框中确认操作。

{% include images-gallery.html imageCollection="make-device-group-public" %}

> 设为公开后，引用该 group 中设备的 dashboard 或外部系统将无需认证即可访问。

若要恢复为私有，请使用「**Make private**」图标按相同步骤操作。

{% include images-gallery.html imageCollection="make-device-group-private" %}

## 共享设备 group

可将设备 group 共享给一个或多个 customer。例如，当多个 customer 需要访问同一设备时适用。

> 无法共享单个设备，只能共享包含该设备的设备 group。

共享设备 group 的步骤：
- 在列表中找到目标设备 group。
- 点击其旁的「**Share**」图标。
- 从下拉列表中选择目标 customer。
- （可选）指定该 customer 下的 **user group** 以共享设备 group。
- 点击「**Share**」确认操作。

{% include images-gallery.html imageCollection="share-device-group" %}

**管理与验证权限**

设备 group 共享后，可随时查看、编辑或撤销权限。

1. 在「Device groups」列表中，点击目标 group 的铅笔按钮打开「Entity group details」。

2. 进入 Permissions 选项卡。

3. 在此选项卡可查看该 group 已授予的全部权限列表。可进行：

- **Add** 新权限：点击面板右上角「+」图标。将弹出对话框，可选择 role 和 user group 以授予访问权限。

- **Edit** 已有权限：点击要修改的权限旁的铅笔图标。

- **Delete** 权限：点击垃圾桶图标以移除该 user group 的访问权限。

{% endunless %}

## 设备详情

点击设备将打开窗口，可访问并管理该设备的各项内容。

{% include images-gallery.html imageCollection="device-details-page" %}

<b><font size="3">Copy device ID</font></b>   
可快速获取设备的唯一 UUID。点击 Copy device Id 可复制到剪贴板。该 ID 用于 API 调用、集成和脚本。

<b><font size="3">Copy device credentials</font></b>   
根据认证类型，可复制：
- **Access Token**
- **MQTT Credentials**

点击对应按钮即可获取连接设备到 ThingsBoard 所需的凭证。

<b><font size="3">Attributes</font></b>   

此选项卡显示 client、server 和 shared [attributes](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"}——与设备关联的静态或半静态键值对。常见示例包括序列号、型号和固件版本。

<b><font size="3">Latest telemetry</font></b>   

显示 [latest telemetry](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"} 值，包括传感器读数、状态更新及其他实时参数。
- **添加遥测**：点击「**+**」图标，输入 key 名称、值类型和值。
- **删除遥测**：点击垃圾桶图标，选择删除模式（all data、latest value、all except latest 或按时间段），并确认操作。

<b><font size="3">Calculated fields</font></b>   
显示由已有 attributes 或 telemetry 通过公式计算得出的字段。可在不修改设备固件的情况下定义衍生参数。更多详见 [Calculated fields](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}。

<b><font size="3">Alarm rules</font></b>   
包含定义设备告警生成方式的规则。可查看条件、阈值、触发器及已配置的告警 action。更多详见 [配置 alarm rules](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}。

<b><font size="3">Alarms</font></b>    
显示与该设备相关的全部活动及历史 [alarms](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"}。用于监控设备健康、跟踪告警并识别关键事件。

<b><font size="3">Events</font></b>   
显示与该设备关联的系统事件，包括日志、警告、错误及其他生命周期相关记录。可用于诊断和活动跟踪。

<b><font size="3">Relations</font></b>   
显示该设备与其他实体之间的全部有向 [relations](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations){:target="_blank"}，如 assets、devices、dashboards 和 rule chains。提供设备在整体系统中位置的上下文。

<b><font size="3">Audit logs</font></b>   
记录与设备相关的用户操作——创建、更新、配置变更及删除。可用于安全审计和追溯。

<b><font size="3">Version control</font></b>   
支持使用内置基于 Git 的 [version control](/docs/{{docsPrefix}}user-guide/version-control/){:target="_blank"} 服务导出和恢复 ThingsBoard 实体。支持备份、协作和配置版本管理。

<hr>

## 后续步骤

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## 您的反馈

欢迎在 [github](https://github.com/thingsboard/thingsboard){:target="_blank"} 上为 ThingsBoard 加星，帮助我们推广。
若对本示例有任何疑问，请[联系我们](/docs/contact-us/){:target="_blank"}。