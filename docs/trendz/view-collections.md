---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 视图集合
description: 视图集合说明 
---

* TOC
{:toc}

Collections是独立文件夹，用于改善导航、按用户等级限制访问和可见性，提供更便捷的视图组织和管理方式。

## Collections types

* **Your collections (root)**：默认公共文件夹，对所有用户始终可用且不可删除。作为创建所有其他子collections的根目录。
* **Subcollections**：在root collection内创建的所有文件夹。Subcollections可相互嵌套，嵌套层数不限。
* **Favourites**：您个人收藏的常用视图列表，便于快速访问。选择collection只需点击视图表中的星标图标。

![image](/images/trendz/view_collections_1.png)

## Permissions and Visibility between users
Collections和可视化有三种权限类型：

* **Full permissions (read, write, and run)**：用户可修改可视化或collection（保存）。仅创建者拥有完整权限，即tenant也无法修改其他用户（customers、subcostomers或users）创建的可视化。
* ** Limited permissions (read and run)**：用户可查看并交互使用可视化或collection，但无法保存任何修改。此权限授予非创建者的更高级别用户。例如tenant可查看customers创建的所有可视化、使用和 customize，但无法保存修改。该限制同样适用于collections。
* **No permissions**：用户在其collections中看不到该可视化。同级别用户 visibility 受限，确保隐私和数据隔离。例如customer无法访问另一customer的文件夹和可视化，subcustomer无法访问另一subcustomer的数据，user无法访问其他user的数据。

要查看低级别用户的collections和可视化，可点击"Show subcustomers collections and views"按钮启用。

![image](/images/trendz/view_collections_2.png)

**结果如下：**
更高级别用户可查看所有低级别用户的collections和可视化，但仅创建者可保存修改。
同级别用户彼此不可见collections和可视化。

## Collection and view management

### Creation
在已有collection上点击"Add new"按钮即可创建新collection，新collection将出现在其下。

![image](/images/trendz/view_collections_3.png)

创建新可视化时不会自动关联任何collection，直至保存。首次保存时会提示选择要保存到的collection。

![image](/images/trendz/view_collections_4.png)

### Sorting
Collections可按名称或日期排序。默认按collection名称。
切换为按日期排序：点击root collection旁的"Sort by date"按钮。
排序顺序不持久，刷新页面后恢复默认。

![image](/images/trendz/view_collections_5.png)

### Editing
已创建的collection（除root外）可重命名。点击"Change name"按钮。

![image](/images/trendz/view_collections_6.png)

可对可视化执行重命名、移到其他collection、复制等操作。
这些选项及删除功能通过菜单访问。点击可视化表中三圆点按钮打开菜单。

![image](/images/trendz/view_collections_7.png)

还可对多个可视化执行批量操作，如移到其他collection或删除。

![image](/images/trendz/view_collections_8.png)

### Deletion
为保证数据完整性，包含至少一个可视化或非空subcollection的collection无法删除。
要删除collection，必须先将其中所有可视化移除或移到其他collection。

![image](/images/trendz/view_collections_9.png)

## Next Steps

{% assign currentGuide = "Filtering" %}{% include templates/trndz-guides-banner.md %}
