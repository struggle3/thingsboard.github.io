
* TOC
{:toc}

## 简介

ThingsBoard 支持开箱即用的[多租户](https://en.wikipedia.org/wiki/Multitenancy)功能。

您可以将租户视为独立的业务实体：拥有或生产设备与资产的个人或组织。

租户可拥有多名租户管理员用户、大量[客户](/docs/{{docsPrefix}}user-guide/ui/customers)，以及不限数量的[用户](/docs/{{docsPrefix}}user-guide/ui/users)、资产和设备。

## 创建新租户

**系统管理员**可以创建租户实体。

请按以下步骤添加新租户：

{% include images-gallery.html imageCollection="create-tenants-ce" showListImageTitles="true" %}

了解更多租户配置信息请参阅[此处](/docs/{{docsPrefix}}user-guide/tenant-profiles)。

<br>
在租户详情页，作为系统管理员，您可以查看属性、最新遥测数据、分配首页仪表板以及复制租户ID。

{% include images-gallery.html imageCollection="tenant-details-ce" %}

## 创建租户管理员

**系统管理员**还可以在每个租户下创建多名**具有租户管理员角色的用户**。

请按以下步骤添加用户：

{% include images-gallery.html imageCollection="create-tenant-admin-ce" showListImageTitles="true" %}

在租户详情窗口中，系统管理员可使用以下操作选项卡：

1）**禁用用户账户**。

2）**显示激活链接**：显示租户管理员用户的激活链接。

3）**重新发送激活**：重新将账户激活邮件发送到用户邮箱。

4）**以租户管理员身份登录**：在租户管理员界面中打开 ThingsBoard 平台。

5）系统管理员还可从用户详情页和租户管理员列表中**删除用户**。

{% include images-gallery.html imageCollection="user-details-ce" %}

## 编辑租户或用户

在租户详情中可以编辑所有字段。

操作步骤如下：

{% include images-gallery.html imageCollection="tenant-edit-ce" showListImageTitles="true" %}

您也可以编辑**用户**。

编辑步骤与编辑租户类似：

{% include images-gallery.html imageCollection="user-edit-ce" showListImageTitles="true" %}

## 删除租户或用户

您可以一次性删除**租户**及其所有用户。为此，请点击“垃圾桶”图标，然后在确认对话框中点击“Yes”。

{% include images-gallery.html imageCollection="tenant-delete-1-ce" %}

此外，也可通过租户详情窗口中的操作选项卡删除用户。

{% include images-gallery.html imageCollection="tenant-delete-2-ce" %}

您也可以从租户中删除任意**用户**。为此，进入租户，找到目标用户后点击“垃圾桶”图标。点击后会出现警告窗口。若确认删除，请点击“Yes”。

{% include images-gallery.html imageCollection="user-delete-ce" %}

此外，可通过租户详情窗口中的操作选项卡删除租户。

{% include images-gallery.html imageCollection="user-delete-2-ce" %}

## 以租户管理员身份登录

如需以租户身份登录，只需打开租户组，点击用户账户对面的图标即可以此租户身份登录。

{% include images-gallery.html imageCollection="tenant-login-ce" %}

租户管理员可执行以下操作：

- 配置和管理[设备](/docs/{{docsPrefix}}user-guide/ui/devices)。
- 配置和管理[资产](/docs/{{docsPrefix}}user-guide/ui/assets)。
- 创建和管理[客户](/docs/{{docsPrefix}}user-guide/ui/customers)。
- 创建和管理[仪表板](/docs/{{docsPrefix}}user-guide/ui/dashboards)。
- 配置[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)。
- 使用[部件库](/docs/{{docsPrefix}}user-guide/ui/widget-library)添加或修改默认部件。

上述操作均可通过[REST API](/docs/{{docsPrefix}}reference/rest-api/)完成。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}
