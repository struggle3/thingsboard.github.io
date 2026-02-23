* TOC
{:toc}

**资产**是ThingsBoard物联网系统中的抽象实体，代表任何物理对象、空间或组织单位。
示例包括：建筑、房间、生产区域、场地、路灯、变电站或车辆。

**资产的主要特征：**
- **本身不产生遥测数据**，但可与产生遥测的设备关联。
- **可有自身属性**，如位置、类型或负责人。
- **用于分组**设备及其他实体。
- **可参与层级结构**，例如：变电站 &#10230; 线路 &#10230; 路灯。
- **参与ThingsBoard业务逻辑**，如规则链、告警和仪表板。

资产有助于以逻辑化、高效的方式组织物联网项目，便于管理和扩展。

> ThingsBoard支持通过Web界面和[REST API](/docs/{{docsPrefix}}reference/rest-api/){:target="_blank"}进行资产管理。

<br><b><font size="4">实践视频课程 🎥</font></b>

观看本实践视频课程，了解如何配置和管理ThingsBoard仪表板、资源和设备，以及如何在实际场景中使用它们。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/65SoFceFDBE" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 如何创建、编辑和删除资产

租户管理员及具有相应[权限](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}的用户可在ThingsBoard中创建、编辑或删除资产。

### 创建资产

创建新资产：
- 进入 **实体** &#10230; **资产**。{% unless docsPrefix == null %}默认显示「**全部**」资产组。{% endunless %}
- 点击右上角的「**+**」图标，在下拉菜单中选择「**添加新资产**」。
- 在资产创建表单中填写必填项：
  - **名称**——资产的唯一名称。
  - **[资产配置文件](/docs/{{docsPrefix}}user-guide/asset-profiles/){:target="_blank"}**——默认使用「**default**」配置，可按需选择其他配置。
    {% if (docsPrefix == "pe/") or (docsPrefix == "paas/") or (docsPrefix == "paas/eu/") %}
  - **所有者和分组**：便于组织和访问控制。
    - **所有者**：从下拉列表中选择所有者。资产将在该 owner’s level. By default, the field is pre-filled with the Customer or Tenant name based on where you add the asset. You can change it before confirming adding.
    - **分组**：可选。将资产加入现有资产组或在所选所有者级别创建新分组。注：每个资产会自动加入该所有者的「**全部**」组。      
  {% endif %}
- **Label**、**Description**等可选字段可按需填写。
- 点击「**添加**」。

资产创建成功后会在列表中显示。

{% include images-gallery.html imageCollection="creating-asset" %}

{% unless docsPrefix == null %}
### 创建资产组

资产可属于一个或多个[分组](/docs/{{docsPrefix}}user-guide/groups/){:target="_blank"}，便于组织和管理。

创建新资产组的步骤：
- 在**资产**页面进入**分组**标签。
- 点击右上角的「**+**」图标。
- 输入新资产组的**名称**。
- （可选）按需为客户配置对此分组的**共享访问**。
- 点击「**添加**」创建分组。

{% include images-gallery.html imageCollection="creating-asset-group" %}

### 管理资产组：添加、移动、移除

在资产页面可向分组添加资产、在分组间移动资产或从分组移除资产。

「**全部**」资产组始终包含所选所有者级别（租户或客户）下的全部资产。

**向分组添加单个资产：**
- 打开[资产详情](#asset-details)➜点击管理所有者和分组。
- 在对话框中按需调整所有者，选择要添加或移除资产的分组。
- 点击**保存**。

**向一个分组添加多个资产：**
- 在**分组**标签页打开任意资产组（如「**全部**」）。
- 通过名称左侧的复选框勾选资产。
- 点击右上角的「**添加到分组**」（加号圆圈图标）。
- 在**添加到分组**窗口选择**选择现有实体组**或**创建新实体组**。
- 选择已有分组或创建新资产组。
- 点击**添加**确认将资产加入分组。

{% capture multiple %}
**注意**：此操作会将资产加入所选分组，但不会从其他分组移除。
{% endcapture %}
{% include templates/info-banner.md content=multiple %}

**Move assets to another group:**
- Open a specific (non-**All**) group.
- Select assets and click **Move to group** (two-arrow icon).
- In "Move to group" window, choose **Select existing entity group** or **Create new entity group**.
- Select an existing or create a new asset group.
- Click **Move** to confirm.

This action removes assets from the current group and adds them to the selected group.

**Remove assets from a group:**
- Open a specific (non-**All**) group.
- Select assets and click **Remove from group** (minus-in-circle icon) in the top-right.
- Confirm removal.

{% capture difference %}
**注意**：资产不会被删除，仍保留在所有者’s 「**全部**」资产组中。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

{% endunless %}

### 编辑资产

编辑现有资产：
- 在**资产**列表中定位并点击目标资产。
- 点击右侧的「**铅笔**」（✏️ **编辑**）图标。
- 在编辑窗口中可修改以下字段：
  - **名称**
  - **标签**
  - **资产配置文件**
  - **描述**
- 修改完成后点击「**应用更改**」保存。

{% include images-gallery.html imageCollection="editing-asset" %}

### 删除资产

删除资产{% unless docsPrefix == null %} or asset group{% endunless %}:

{% include images-gallery.html imageCollection="deleting-asset" showListImageTitles="true" %}

> **注意**：删除资产**不会删除**与其关联的设备或其他实体，但**会断开所有现有关系**（如与设备、告警、仪表板等的关联）。

{% if docsPrefix == null %}
## Make asset public

You can make an asset public so that all its data is accessible to everyone. 
This is ideal for creating public demo dashboards that require access to asset data or for open data use cases.    

- Click the "**Make asset public**" icon next to the asset you want to share.
- Confirm your action in the popup dialog.

The asset is now public.

{% include images-gallery.html imageCollection="make-asset-public" %}

<br>
To revoke public access and make the asset private again:

{% include images-gallery.html imageCollection="make-asset-private" showListImageTitles="true" %}

> Once the asset is made private, it will no longer be publicly accessible, and any **public [dashboards](/docs/user-guide/dashboards/){:target="_blank"}** referencing it will lose access to its data.

## Assigning asset to customer

You can assign an asset to a specific [customer](/docs/user-guide/ui/customers/){:target="_blank"}. This ensures that only users associated with that customer will have access to the asset and its data.

> This step is crucial for ensuring data access control. Each customer user will only see their own assets and will not have access to assets or data assigned to other customers.

To assign an asset to a customer:
- Locate the desired asset in the list.
- Click the "**Assign to customer**" icon.
- Select the target customer from the dropdown list.
- Click "**Assign**" to confirm the action.

The selected customer now has access to the asset and its data.

{% include images-gallery.html imageCollection="assign-asset-to-customer" %}

<br>
You can later unassign the asset or reassign it to another customer if needed.

{% include images-gallery.html imageCollection="unassign-from-customer" showListImageTitles="true" %}
{% endif %}

## Asset details

Clicking on an asset opens a window where you can access and manage various aspects of that asset.

{% include images-gallery.html imageCollection="asset-details-page" %}

<b><font size="3">Copy asset ID</font></b>   
Allows you to quickly retrieve the asset’s unique UUID. Click Copy asset Id to copy it to your clipboard. The ID is used in API calls, integrations, and scripts.

<b><font size="3">Attributes</font></b>

This tab displays client, server, and shared [attributes](/docs/{{docsPrefix}}user-guide/attributes/){:target="_blank"} — static or semi-static key-value pairs related to the asset. Examples include location, category, configuration parameters, and other metadata.

<b><font size="3">Latest telemetry</font></b>

Shows the [latest telemetry](/docs/{{docsPrefix}}user-guide/telemetry/){:target="_blank"} values associated with the asset. Telemetry may come from linked devices or be added manually for modeling purposes.
- **Adding telemetry:** Click the "**+**" icon, enter the key name, value type, and value.
- **Deleting telemetry:** Click the trash icon, choose the deletion mode (all data, latest value, all except latest, or by time period), and confirm.

<b><font size="3">Calculated fields</font></b>   
Displays fields whose values are computed from existing attributes or telemetry using formulas. This allows you to define derived parameters without modifying the device firmware. Learn more about Calculated fields [here](/docs/{{docsPrefix}}user-guide/calculated-fields/){:target="_blank"}.

<b><font size="3">Alarm rules</font></b>   
Contains the alarm rules configured for the asset. You can review thresholds, triggering logic, and configured alarm actions that apply to this asset. Learn more about configuring alarm rules [here](/docs/{{docsPrefix}}user-guide/alarm-rules/){:target="_blank"}.

<b><font size="3">Alarms</font></b>    
Shows all active and historical [alarms](/docs/{{docsPrefix}}user-guide/alarms/){:target="_blank"} related to the asset. Allows tracking of warnings, operational issues, and critical events affecting the asset.

<b><font size="3">Events</font></b>   
Displays system events associated with the asset, such as logs, warnings, errors, and other lifecycle-related activity. Useful for diagnostics and operational analysis.

<b><font size="3">Relations</font></b>   
Shows all directed [relations](/docs/{{docsPrefix}}user-guide/entities-and-relations/#relations){:target="_blank"} between this asset and other entities, such as devices, dashboards, assets, and rule chains. Helps understand how the asset interacts within the system structure.

<b><font size="3">Audit logs</font></b>   
Provides a [record of user actions](/docs/{{docsPrefix}}user-guide/audit-log/){:target="_blank"} related to the asset — creation, updates, configuration changes, and deletions. Used for auditing and change tracking.

<b><font size="3">Version control</font></b>   
Enables exporting and restoring asset-related entities using the Git-backed [version control](/docs/{{docsPrefix}}user-guide/version-control/){:target="_blank"} service. Supports backup, collaboration, and configuration versioning.

<hr>

{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") or (docsPrefix == "paas/eu/") %}
## Manage asset owner and groups

You can change the **owner** of an asset. This ensures that only users associated with the selected customer will have access to the asset and its data.

> This step is essential for maintaining strict data [access control](/docs/{{docsPrefix}}user-guide/rbac/){:target="_blank"}. Each customer user will only see their own assigned assets and will not have visibility into assets or data belonging to other customers.

To change asset owner:
- Click the asset to open its **Asset details**.
- Click the "**Manage owner and groups**" button.
- In the **Owner** field, select [Tenant](/docs/{{docsPrefix}}user-guide/ui/tenants/){:target="_blank"} or a specific [Customer](/docs/{{docsPrefix}}user-guide/ui/customers/){:target="_blank"}.
- Add the asset to the relevant **asset groups** or [create a new group](#creating-asset-group) if needed.
- Click “**Update**” to confirm and apply the changes.

In the <b>"Customer name" column</b>, you can see the current owner of the asset.

{% capture difference %}
**Note:** Changes to group membership and ownership take effect immediately and update user access according to the [roles](/docs/{{docsPrefix}}user-guide/rbac/#roles){:target="_blank"} of the assigned groups.
{% endcapture %}
{% include templates/info-banner.md content=difference %}

A Tenant Administrator always has the right to reassign or revoke asset ownership.

{% include images-gallery.html imageCollection="manage-owner-and-groups" %}

### Include customer entities

The "**Include customer entities**" option on the "**Assets**" page determines whether assets owned by customers are shown or hidden in the list.

{% include images-gallery.html imageCollection="include-customer-assets" showListImageTitles="true" %}

## Share asset
You can share assets by adding them to an asset group and then sharing the group with a customer.

For detailed instructions, please see the section on how to [Share asset group](#share-asset-group).

## Make asset group public

You can make an asset group public to ensure that all data within it is accessible to everyone. This is ideal for:
- Creating public demo dashboards that require access to asset data.
- Supporting open data use cases.

> You cannot share an individual asset directly — only the asset group that contains it.

To make an asset group public:
- Locate the desired asset group in the list.
- Click the "**Make public**" icon next to it.
- Confirm your action in the popup dialog.

{% include images-gallery.html imageCollection="make-asset-group-public" %}

> Once public, any dashboards or external systems referencing assets in this group will have access without requiring authentication.

<br>
To make the group private again, follow the same steps using the "**Make private**" icon.

{% include images-gallery.html imageCollection="make-asset-group-private" %}

## Share asset group

You can share an asset group with one or more customers. This is useful, for example, when multiple customers need access to the same asset.

> You cannot share an individual asset — only the asset group that contains it.

To share an asset group:
- Locate the desired asset group in the list.
- Click the "**Share**" icon next to it.
- **Select the target customer** from the dropdown list.
- (Optional) Specify the **user group** within that customer to share the asset group with.
- Confirm the action by clicking "**Share**".

{% include images-gallery.html imageCollection="share-asset-group" %}

**Managing and Verifying Permissions**

After an asset group has been shared, you can view, edit, or revoke permissions at any time.

1. From the "**Asset groups**" list, click on the "**pencil**" button of the desired group to open the "**Entity group details**".

2. Navigate to the **Permissions** tab.

3. On this tab, you will see a complete list of all permissions granted for this group. Here you can:

- **Add** a new permission: Click the "**+**" icon in the top right corner of the panel. A dialog window will appear where you can select a role and a user group to grant access to.

- **Edit** an existing permission: Click the "**pencil**" icon next to the permission you want to modify.

- **Delete** a permission: Click the "**trash can**" icon to remove access for that user group.

{% endif %}

## Managing asset relations. How to add, view, edit, delete

From the Assets page, you can create, view, edit, and delete relations between an asset and other entities (assets, devices, customers, etc.). See details about [Entities and relations](/docs/{{docsPrefix}}user-guide/entities-and-relations/){:target="_blank"}.

**To manage relations between an asset and other entities for a specific asset:** 
- Open the [asset details](#asset-details) ➜ go to the **Relations** tab.

**Add a new relation:**
- In the Direction selector, choose **From** (outbound) or **To** (inbound).
- Click "**+**" icon (Add).
- In **Add relation** window, set **Relation type** (e.g., _Contains_, _Manages_) and choose the **To entity** (Entity type and target entities).
- Click **Add** to confirm.

{% capture rel_dir %}
**Note:** Relations are directional. Use "**From**" to define relations originating from the current asset, or "**To**" to show relations to this asset.
{% endcapture %}
{% include templates/info-banner.md content=rel_dir %}

**View & filter relations:**
- Switch **Direction** between "**From**" and "**To**" to see outbound/inbound relations.
- Use the **search** icon to filter by relation type or entity.

**Edit a relation:**
- In the list, click the "**pencil**" icon to change the relation type or target entity, then **Save**.

**Delete a relation:**
- Click the "**trash can**" icon next to a relation and confirm deleting.

{% capture rel_remove %}
**Note:** Deleting a relation does **not** delete the related entities; it only deletes the relation.
{% endcapture %}
{% include templates/info-banner.md content=rel_remove %}

<hr>

## Next steps

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}

<hr>

## Your feedback

Don&#39;t hesitate to star ThingsBoard on [github](https://github.com/thingsboard/thingsboard){:target="_blank"} to help us spread the word.
If you have any questions about this sample, please [contact us](/docs/contact-us/){:target="_blank"}.