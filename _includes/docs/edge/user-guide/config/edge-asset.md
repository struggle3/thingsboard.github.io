* TOC
{:toc}

## 概述

**Asset entity（资产实体）** 是帮助分组和管理物联网生态系统的抽象实体。**Assets** 表示真实世界对象（如工厂、车辆、仓库等），并建立这些对象与其他实体之间的关系层级。
**Edge Assets** 支持 Edge 实体的分组及对其发送数据的可视化。当设备或传输数据特定于某个 Edge 时，可采用此方式。

**Edge Assets** 与 **Cloud Assets** 设计相同。请参阅 [Assets documentation](/docs/{{peDocsPrefix}}user-guide/ui/assets/){:target="_blank"} 以了解其功能。

## Edge 资产管理

**Asset entity** 可与 **Cloud** 相同的方式在 **Edge** 实例上本地创建和配置。若 **Asset entity** 已在 **Cloud** 上创建，则使用前必须[分配](/docs/{{docsPrefix}}config/provision-asset/#provisioning-from-cloud){:target="_blank"}给 **Edge** 实例。

### 创建新资产

要在 **Edge** 上创建 **Asset entity**，请登录实例并进入 **Entities > Assets** 区域。

{% include images-gallery.html imageCollection="createAssetOnEdge" showListImageTitles="true" %}

### 创建关系

以下参数定义实体间的 [relation hierarchy](/docs/{{peDocsPrefix}}user-guide/entities-and-relations/#relations){:target="_blank"}：
* **Direction：** 描述实体之间的关联方式。
  * **"Outbound relation - From"：** 表示 **关系源自该实体（该实体为源）**。
  * **"Inbound relation - To"：** 表示 **关系指向该实体（该实体为接收方）**。 
* **Relation type：** 描述实体间连接的性质。
  * **"Contains"：** 表示实体 **是另一个实体的一部分**（例如 _Device A 是 Asset A 的一部分_）。
  * **"Manages"：** 表示实体 **负责管理另一个实体**（例如 _Asset A 管理 Device A_）。

要在 Asset 与另一实体（如 _device_）之间 **构建关系**，请进入 **Entities > Assets** 区域并按以下操作：

{% include images-gallery.html imageCollection="deviceToAsset" showListImageTitles="true" %}

### 在仪表板中使用关系

实体间关系建立后，可 **在仪表板上反映**。与资产相关设备传输的数据可通过 [aliases](/docs/{{peDocsPrefix}}user-guide/ui/aliases/){:target="_blank"} **按关系类型动态筛选**。

要配置 **alias**，请进入 **Dashboards** 区域，对新仪表板或现有仪表板进入 **Edit mode**。请[在此](/docs/{{docsPrefix}}user-guide/db-overview/#the-edge-dashboard-creation-and-management){: target="_blank"}了解如何创建仪表板。

{% include images-gallery.html imageCollection="alias" showListImageTitles="true" %}

继续配置部件。在 **"Edit mode"** 中，点击 **"Add widget"** 按钮添加部件。选择 **Charts > Time series chart** 部件。请[在此](/docs/{{peDocsPrefix}}user-guide/widgets/#adding-a-widget-to-the-dashboard){: target="_blank"}了解更多关于如何添加和配置新部件。

{% include images-gallery.html imageCollection="dashboard" showListImageTitles="true" %}

## 从 Cloud 配置

要从 **ThingsBoard Cloud** 将 **Asset entity** 配置到 **Edge** 实例，请登录 **Cloud** 并进入 **Edge management > Instances** 区域：

{% include images-gallery.html imageCollection="provisioning" showListImageTitles="true" %}
### 下一步

{% include templates/edge/guides-banner-edge.md %}
