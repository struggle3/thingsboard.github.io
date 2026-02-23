* TOC
{:toc}

## 简介

ThingsBoard 支持配置多个自定义实体组。
可为设备、资产、实体视图、客户、用户、仪表板和 Edge 实例创建实体组。
每个实体可同时属于多个组。
特殊组「All」始终包含属于指定租户账户的所有实体。

针对每个实体组，ThingsBoard 用户可配置不同列以可视化特定遥测或属性值。
用户也可为每个实体定义自定义操作：如打开仪表板、发送 RPC 调用等。
还支持批量删除实体、将实体加入组或从组中移除。

## 创建新实体组

本教程以创建设备实体组为例。
以下步骤适用于各类实体。

{% include images-gallery.html imageCollection="create-entity-group-1" showListImageTitles="true" %}

创建组的过程中可共享实体组。我们再创建一个组并共享给客户。

{% include images-gallery.html imageCollection="create-entity-group-2" showListImageTitles="true" %}

## 实体组配置

### 编辑基本信息

可编辑实体组的基本信息，例如修改组名、固件和软件等。

操作步骤如下：

{% include images-gallery.html imageCollection="edit-entity-group-1" showListImageTitles="true" %}

### 列配置

可添加、删除、移动列，并修改其标题和类型。
还可为列单元格使用样式函数和内容函数。

本示例中，设备组有两个上报温度值的设备。
该组有 4 列显示设备数据：「创建时间」「名称」「设备配置」「标签」。

先**添加**一列显示每个设备的温度值。

{% include images-gallery.html imageCollection="column-configuration-add" showListImageTitles="true" %}

接着**删除**该设备组中的「标签」列。

{% include images-gallery.html imageCollection="column-configuration-delete" showListImageTitles="true" %}

再为「温度」列**设置样式函数**：温度 ≥ 45 显示橙色，< 45 显示蓝色。

{% include images-gallery.html imageCollection="column-configuration-style function" showListImageTitles="true" %}

样式函数：

```javascript
return value >= 45 ? {
    color:'rgb(255, 106, 12)',
    fontWeight: 600
} : {
    color:'rgb(0, 132, 214)',
    fontWeight: 600
}
```
{: .copy-code}

**设置内容函数**，在设备温度值后显示「℃」符号。

{% include images-gallery.html imageCollection="column-configuration-content function" showListImageTitles="true" %}

内容函数：

```javascript
return value ? value + ' ℃' : '-';
```
{: .copy-code}

也可按需**移动**列。

{% include images-gallery.html imageCollection="column-configuration-move" showListImageTitles="true" %}

### 实体组显示设置

在「设置」选项卡中，可启用或禁用：搜索实体、添加新实体、删除实体、管理实体凭证。
还可配置分页，以及选择打开实体详情的操作。

进入组设置的方法：

{% include images-gallery.html imageCollection="setting" showListImageTitles="true" %}

### 实体组操作配置

操作可快速配置跳转到指定仪表板，或创建自定义操作。
例如，创建一项操作以快速进入显示温度计完整信息的仪表板。

{% include images-gallery.html imageCollection="action-configuration" showListImageTitles="true" %}

### 组权限
使用 Permissions 选项卡定义谁可访问此组内的实体，以及可执行的操作。
权限将组角色与用户组关联，仅作用于该组内实体。
组权限是对租户级 RBAC 的补充，不会覆盖全局限制。参见 [RBAC 中的组角色](/docs/{{docsPrefix}}user-guide/rbac/#group-role){:target="_blank"}。

**如何添加组权限：**
- 打开 **实体组详情** → **Permissions** 选项卡。
- 点击「**+**」（加号图标）添加组权限。 
- 从下拉列表中选择 **角色**（组角色）。
- 选择 **用户组所有者** [Tenant](/docs/{{docsPrefix}}user-guide/ui/tenants){:target="_blank"} 或指定 [Customer](/docs/{{docsPrefix}}user-guide/ui/customers){:target="_blank"}，以及 **用户组**。
- 点击「**添加**」保存。组权限会出现在列表中。

可在 **Permissions** 选项卡中随时**编辑**或**删除**已有组权限：
- **编辑**：点击目标权限的「**编辑**」（铅笔图标）→ 修改字段 →「**保存**」。
- **删除**：点击目标权限的「**删除**」（垃圾桶图标）→「**确认**」。

更改对可访问该组的所有成员立即生效。

从[用户端](/docs/{{docsPrefix}}user-guide/ui/users/#assigning-permissions-to-user-group)查看已分配权限：打开 **用户组** 详情 → **Roles** 选项卡。

## 批量操作

对组内每个实体可执行：更改实体所有者、移至其他组、将实体加入或移出组等操作。

{% include images-gallery.html imageCollection="batch-operations" showListImageTitles="true" %}

## 共享实体组

共享组可一次性授予组内所有实体的访问权限，并创建将该实体组与所选用户组关联的权限条目。

**如何共享实体组：**
- 在 **Groups** 选项卡中，点击目标组的「**Share**」图标。
- 从下拉列表选择 [**Customer**](/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"}。
- （可选）勾选 **All users** 以授予该客户下所有用户访问权限。
- 选择权限：Read、Write 或 Other（Roles）。
- 点击「**Share**」应用。访问权限将传递到组内所有实体。

要更新或撤销访问，打开组的 [permissions](#group-permissions) 选项卡并编辑/删除相应权限。

## 将组设为公开或私有

公开组向任何人（无需登录）提供只读访问。 Use it for non-sensitive data only. When you set a group as Public, 
the platform adds permissions to that entity group for the Public customer’s "Public users" group.

**设为公开：**

- 在 **Groups** 选项卡中，点击目标组的「**Make public**」图标。

- 在对话框中确认。

该组的 Public 复选框将被启用。

{% capture public %}
**注意：** 使用设备数据的公开仪表板，要求仪表板和相关设备组均为公开。
{% endcapture %}
{% include templates/info-banner.md content=public %}

**设为私有（撤销公开访问）：**

- 在 Groups 选项卡中，点击目标组的「**Make private**」图标。

- 在对话框中确认。公开访问将被移除。

若需为指定客户或用户提供受控访问，请使用 [共享实体组](#share-entity-group) 
或在 [Permissions](#group-permissions) 选项卡中配置条目。

## 删除实体组

可通过以下任一方式删除实体组及其所有实体：

方式一：

{% include images-gallery.html imageCollection="delete-entity-group-1" showListImageTitles="true" %}

方式二：

{% include images-gallery.html imageCollection="delete-entity-group-2" showListImageTitles="true" %}

您和客户也可一次性删除多个实体组。

{% include images-gallery.html imageCollection="delete-entity-group-3" showListImageTitles="true" %}

## 视频教程

观看详细视频教程，了解如何按需配置实体组。

<br>
<div id="video">
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/RNdaEqrGhn8" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}
