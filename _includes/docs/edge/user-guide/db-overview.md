* TOC
{:toc}

## 概述

**Edge 仪表板**是用于本地监控与管理 IoT 数据的强大工具。即使未连接云端，也能实时运行并展示数据。连接恢复后可与服务器同步数据。

**Edge 仪表板**的设计方式与[平台（云端）仪表板](/docs/{{cloudDocsPrefix}}user-guide/dashboards/){: target="_blank"}相同。请参阅平台仪表板文档了解其功能。

## 仪表板配置到 ThingsBoard Edge

仪表板可在 **ThingsBoard 服务器**上创建和管理，然后[配置](/docs/{{docsPrefix}}getting-started/#step-5-provision-dashboard-to-thingsboard-edge){: target="_blank"}到 **Edge 实例**。此方式可将更改同时部署到所有 Edge 实例。

您可验证仪表板已配置： 

{% include images-gallery.html imageCollection="dashboard-provision" showListImageTitles="true" %}

## Edge 仪表板创建与管理

您也可直接在 **Edge** 上创建和管理 **仪表板**。连接后，所有更改会自动传播到平台。

在 **ThingsBoard Edge** 实例上**创建** Edge 仪表板，按以下步骤操作：

{% include images-gallery.html imageCollection="create-dashboard" showListImageTitles="true" %}
可在此了解**部件**：[此处](/docs/{{cloudDocsPrefix}}user-guide/widgets/){: target="_blank"}。

**仪表板工具栏**详见[此处](/docs/{{cloudDocsPrefix}}user-guide/dashboards/#dashboard-toolbar){: target="_blank"}。

验证更改是否已成功传播： 

{% include images-gallery.html imageCollection="changes-from-edge-to-server" showListImageTitles="true" %}

若有多个 **ThingsBoard Edge** 实例，可在其一上删除仪表板而*不影响*其他实例。若要从所有 **ThingsBoard Edge** 实例*一次性*删除 **仪表板**，需在 ThingsBoard 平台上删除。

### 分配/移除客户

在向仪表板分配客户前，请确保已先将客户分配到 **ThingsBoard Edge** 实例。客户相关说明见[此处](/docs/{{cloudDocsPrefix}}user-guide/ui/customers/){: target="_blank"}。

向 **Edge 仪表板** **分配/取消分配**客户，按以下步骤操作：

{% include images-gallery.html imageCollection="assign-customer" showListImageTitles="true" %}

## 下一步

{% include templates/edge/guides-banner-edge.md %}