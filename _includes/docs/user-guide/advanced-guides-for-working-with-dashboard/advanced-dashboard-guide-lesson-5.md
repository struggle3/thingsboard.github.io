* TOC
{:toc}

ThingsBoard 的重要能力之一是为终端用户创建 dashboards。
客户应仅能访问您授予的场所、设备和数据，并享受其个性化 dashboard 的全部功能。
同时不得访问其他客户的场所、设备或其它数据。
作为管理员，您始终可编辑和修改 dashboard。

Tenant Administrator 可通过两种方式向 Customer 授予对特定实体（如 Device、Dashboard、Asset 等）的访问：

- 分配所有权：使客户成为唯一可访问该实体及其数据的用户；
- 共享实体：允许多个客户访问同一实体。

We're continuing to enhance our dashboard. In the last lesson, we set up alarm rules for the Indoor Air Quality sensor and added a widget to manage alarms. If you haven’t completed that lesson yet, I suggest going through it first.

<br>
<p><a href="/docs/{{docsPrefix}}user-guide/advanced-guides-for-working-with-dashboard/advanced-dashboard-guide-lesson-4/" class="button">Lesson 4: Alarm management</a></p>

<br>

本课将添加两名客户，并为其配置对之前课程所建 dashboard 的共享访问。
本示例中，Customer 指租用您建筑内办公室并使用其中设备的个人或组织。
每位客户仅能访问其租赁的办公室及其中设备。

{% include default-carousel.liquid collectionMap = 'dashboard-lesson-5' nonActiveItemsVisibility = false %}

本课示例中，假设有两名客户：Customer A 租用 Building A 的 Office A，Customer B 租用同栋楼的 Office B。

创建这两名客户并授予必要访问权限。

## 添加客户

先添加两名客户。 

{% include images-gallery.html imageCollection="adding-customers-1" showListImageTitles="true" %}

类似地创建名为 "Customer B" 的客户，并将其加入 "Office renters" 组。

{% include images-gallery.html imageCollection="adding-customers-2" %}

## 共享 dashboard

由于两位客户都会使用该 dashboard，无法将两者都设为 owner，但可为其提供 dashboard 的共享访问。无法共享单个 dashboard，仅能共享包含该 dashboard 的 group。

{% include images-gallery.html imageCollection="share-dashboard-1" showListImageTitles="true" %}

## 变更设备 owner

接下来变更设备 owner。将 Customer A 设为 Office A 中所有设备的 owner，即 "Indoor Air Quality Sensor"、"Energy Meter" 和 "Water Flow Meter"。将 Customer B 设为 Office B 中 "IAQ Sensor" 的 owner。

{% include images-gallery.html imageCollection="change-devices-owner-1" showListImageTitles="true" %}

类似地，将 Customer A 设为 "EM-002"（Energy Meter）和 "WM-003"（Water Flow Meter）的 owner，将 Customer B 设为 "AM-307"（Indoor Air Quality Sensor）的 owner。

{% include images-gallery.html imageCollection="change-devices-owner-2" %}

<br>
Make sure that the devices are assigned to Customer A.

{% include images-gallery.html imageCollection="change-devices-owner-3" showListImageTitles="true" %}

确认设备已分配给 Customer B。

{% include images-gallery.html imageCollection="change-devices-owner-4" showListImageTitles="true" %}

## 访问 assets

由于 Office A 和 Office B 均位于 Building A，客户应对建筑有共享访问，但对办公室的访问应受限，使其仅能查看各自的办公室。操作如下：

变更 Office A 和 Office B 的 owner：

- 将 Customer A 设为 Office A 的 owner；
- 将 Customer B 设为 Office B 的 owner。

共享 Building A 的访问：

- 将 Building A 与 Customer A 和 Customer B 共享；
- 将两者权限级别设为 "Read"，使其可访问建筑共享数据但无法查看彼此办公室。

### 变更 assets 的 owner

{% include images-gallery.html imageCollection="change-assets-owner-1" showListImageTitles="true" %}

确认办公室 assets 已分配给正确客户。

{% include images-gallery.html imageCollection="change-assets-owner-2" showListImageTitles="true" %}

{% include images-gallery.html imageCollection="change-assets-owner-3" showListImageTitles="true" %}

### 共享 assets

接下来将 Building A 加入 group 并为两位客户共享访问。

{% include images-gallery.html imageCollection="share-assets-1" showListImageTitles="true" %}

我们已为所有必要客户授予访问权限。接下来添加客户用户。

## 添加客户用户

最后为每位客户创建一个 [user](/docs/{{docsPrefix}}user-guide/ui/users){:target="_blank"}。他们将能访问我们的 dashboards 及我们授予的数据。

首先为 Customer A 添加用户 Emma Johnson：

- 进入 "Customers" 页面。在客户列表中找到客户并点击 "Manage customer users" 图标；
- 进入 "Groups" 选项卡，选择 "Customer Users" 组。这是自动创建的客户用户组，已授予只读权限。更多关于权限和 [Role-Based Access Control (RBAC)](/docs/{{docsPrefix}}user-guide/rbac){:target="_blank"} 的信息请参阅相关文档；
- 点击右上角 "plus" 图标。输入用户邮箱，并填写名和姓。然后点击 "Add"；
- 复制用户激活链接并妥善保存。然后点击 "OK"；
- 新客户用户已添加。点击该用户打开详情，再点击橙色大号 "pencil" 图标进入编辑模式；
- 将我们的 "Building" dashboard 设为默认，并勾选 "Always fullscreen"。最后应用更改。

{% include images-gallery.html imageCollection="add-customer-user-1" %}

Customer A 的用户已添加完成。类似地为 Customer B 添加客户用户 Jack Smith。

{% include images-gallery.html imageCollection="add-customer-user-2" %}

## 从客户用户视角查看 dashboard

接下来激活客户用户并分别查看 dashboard 在各用户视角下的效果。

先从 Customer A 的用户 Emma Johnson 开始。

{% include images-gallery.html imageCollection="activation-customer-user-1" showListImageTitles="true" %}

<br>
dashboard 将打开，仅显示您办公室所在的建筑 —— Building A。浏览 dashboard 以确认用户仅能访问您已授予的数据。

{% include images-gallery.html imageCollection="reviewing-customer-user-dashboard-1" %}

类似地激活 Customer B 的用户。他们应能访问 Building A 中的 Office B 以及 Office B 内 IAQ Sensor 的数据。

{% include images-gallery.html imageCollection="reviewing-customer-user-dashboard-2" %}

## Conclusion

本系列中，我们已开发一个用于可视化和监控设施内连接设备数据的完整 dashboard。
我们还为客户共享了该 dashboard 的访问，每位客户仅能查看您授予权限的数据。
希望本系列对您有帮助，并激发您进一步扩展 dashboard 的能力。下次见！