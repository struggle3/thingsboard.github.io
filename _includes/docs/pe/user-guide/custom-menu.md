{% assign feature = "Custom Menu" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

在 ThingsBoard 中自定义菜单可根据需求调整导航菜单，快速访问最常用的功能和仪表板。
您可以添加新菜单项、显示或隐藏现有项。

菜单自定义选项：

- **添加新菜单项**：可为菜单添加新项，包括链接到指定仪表板或外部网页；

- **修改图标和名称**：可为每个菜单项自定义图标和名称，更好体现其功能与价值；

- **调整菜单顺序**：可拖拽并重排菜单项顺序，按工作流优化界面；

- **个性化设置**：可为每个租户、客户或其用户单独自定义菜单，提供更高层级的个性化。

&nbsp;
<div id="video">  
    <div id="video_wrapper">
        <iframe referrerpolicy="strict-origin-when-cross-origin" src="https://www.youtube.com/embed/U69PLwRoWyI" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 添加自定义菜单

在 ThingsBoard 中添加自定义菜单前，需先根据最终用户（租户或客户）确定其适用范围。

租户范围选项：
- *未分配* - 表示自定义菜单未分配给任何租户用户。适用于菜单配置阶段，之后可分配给所需租户用户；
- *所有租户用户* - 选择此项表示租户级所有用户均可访问该菜单；
- *用户列表* - 可创建有权访问该菜单的用户列表。

客户范围选项：
- *未分配* - 表示自定义菜单未分配给任何客户或客户用户。适用于菜单配置阶段，之后可分配给所需客户或客户用户；
- *所有客户用户* - 选择此项可将自定义菜单应用到所有客户及其用户；
- *用户列表* - 可将自定义菜单应用到指定客户用户或客户用户列表；
- *客户列表* - 可将自定义菜单应用到指定客户或客户列表及其用户。

**添加新自定义菜单**

添加新自定义菜单的步骤：

- 前往「白标」页面的「自定义菜单」选项卡，点击「加号」图标；
- 在新窗口中输入自定义菜单名称；
- 选择范围：租户或客户；
- 指定将此自定义菜单分配给谁；
- 完成所有设置后点击「添加」；

自定义菜单已添加。

{% assign addCustomMenu = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-1-pe.png,
        title: Go to the "Custom menu" tab of the "White labeling" page, and click the "plus" icon;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-2-pe.png,
        title: In new window, enter custom menu name, select scope, and Specify to whom exactly you are assigning this custom menu;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-3-pe.png,
        title: After all settings, click "Add";
'
%}

{% include images-gallery.liquid imageCollection=addCustomMenu %}

## 自定义菜单配置

### 添加新菜单项

可添加链接到指定仪表板或外部网页（如文档页）的菜单项。

{% capture difference %}
**请注意：**
<br>
在项目中使用 URL 前，请确认该页面允许在 iframe 中嵌入。
可检查 [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options){:target="_blank"} HTTP 头的取值。若为 DENY 或 SAMEORIGIN，表示该页面无法在其他域的 iframe 中嵌入或仅限同域。若需将您的域名列入可嵌入列表，必须在响应头中明确指定。
建议检查域名是否在响应头或内容安全策略 (CSP) 的允许列表中，以避免页面在 iframe 中显示时出现异常。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

添加新菜单项步骤：

- 点击页面底部的「添加自定义菜单项」按钮；
- 输入菜单项名称。保持项类型为「链接」，指定操作：打开仪表板或 URL，点击「添加」；
- 新菜单项将添加至列表底部。从左侧拖拽可调整上下顺序；
- 点击「保存」应用菜单更改。

点击新菜单项将打开指定仪表板或网页（以设置中配置为准）。

{% assign addNewMenuItem = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-1-pe.png,
        title: Click the "Add custom menu item" button at the bottom of the page;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-2-pe.png,
        title: Enter the name for your menu item. Leave the item type as "Link". Now, specify the action: open a dashboard or a URL. Click "Add";
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-3-pe.png,
        title: The new menu item will be added to the bottom of the list;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-4-pe.png,
        title: Drag the new item up or down by holding it from the left corner. Apply changes to the menu by clicking the "Save" button;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-5-pe.png,
        title: Click on the new menu item;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-6-pe.png,
        title: The specified dashboard or webpage will open (depending on what you have set in the settings).
'
%}

{% include images-gallery.liquid imageCollection=addNewMenuItem %}

<br>
也可在现有项之间插入新项：

- 将鼠标悬停在两个菜单项之间，点击「添加自定义菜单项」；
- 输入菜单项名称，保持项类型为「链接」，指定操作：打开仪表板或 URL，点击「添加」；
- 新菜单项将插入到现有项之间；
- 点击「保存」应用菜单更改。

点击新菜单项即可进入指定仪表板。

{% assign addCustomMenuItemBetweenExistingItems = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-7-pe.png,
        title: Hover your mouse pointer between two menu items and click "Add custom menu item";
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-8-pe.png,
        title: Enter the name for your menu item. Leave the item type as "Link". Now, specify the action: open a dashboard or a URL. Click "Add";
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-9-pe.png,
        title: A new menu item is added between existing menu items. Apply changes to the menu by clicking the "Save" button;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-10-pe.png,
        title: Click on the new menu item;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-custom-menu-item-11-pe.png,
        title: You will navigate to the specified dashboard.
'
%}

{% include images-gallery.liquid imageCollection=addCustomMenuItemBetweenExistingItems %}

#### 添加子项

可将多个菜单项归入一个分组。例如，「实体」分组包含设备、资产和实体视图。

示例：添加一个分组并在其中放置两个子项。

- 先添加分组。添加新菜单项，命名为「我的仪表板」，选择「分组」类型，点击「添加」；
- 已添加「分组」类型的自定义项。「我的仪表板」分组下出现「+ 添加子项」按钮，点击为该分组添加子项；
- 输入菜单项名称「仪表板 A」，指定对应仪表板；
- 子项已添加，已按层级归属于「我的仪表板」分组；
- 再添加一个菜单项，命名为「仪表板 B」并指定第二个仪表板，保存更改；

左侧菜单中会出现名为「我的仪表板」的分组，点击展开后可见两个指向仪表板的子项。点击「仪表板 A」菜单项可打开对应仪表板。
再点击「仪表板 B」菜单项可进入第二个仪表板。

{% assign addSubitem = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-1-pe.png,
        title: First, let&#39;s add a section. Start adding a new menu item;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-2-pe.png,
        title: Name it "My dashboards", select the "Section" item type, and click "Add";
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-3-pe.png,
        title: Custom item with "Section" type added. The "+ Add subitem" button appeared under the section "My dashboards". Click it to add a subitem to this section;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-4-pe.png,
        title: Enter "Dashboard A" as menu item name, and specify the dashboard. Click "Add";
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-5-pe.png,
        title: Subitem added. As you can see, it is located in the "My dashboards" section by hierarchy;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-6-pe.png,
        title: Add another one menu item. Name it "Dashboard B" and specify your second dashboard. Save the changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-7-pe.png,
        title: In the left menu, a section called "My dashboards" has appeared. Click on it to expand. Inside, you will find two menu subitems that link to the dashboards. Click on the "Dashboard A" menu item. The corresponding dashboard will open;
    ===
        image: /images/user-guide/white-labeling/custom-menu/add-subitem-8-pe.png,
        title: Now click on the "Dashboard B" menu item to navigate to the second dashboard.
'
%}

{% include images-gallery.liquid imageCollection=addSubitem %}

### 编辑菜单项

编辑菜单项时，点击要编辑的菜单项行中的「铅笔」图标。完成修改后点击「应用」并保存，菜单项配置即已更新。

{% assign editMenuItem = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/edit-menu-item-1-pe.png,
        title: Click the "pencil" icon in the row of the menu item you want to edit;
    ===
        image: /images/user-guide/white-labeling/custom-menu/edit-menu-item-2-pe.png,
        title: Make the necessary changes, and click "Apply". Then save changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/edit-menu-item-3-pe.png,
        title: The item configuration has been changed.
'
%}

{% include images-gallery.liquid imageCollection=editMenuItem %}

{% capture difference %}
**请注意：**
只能为自定义菜单项修改操作。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

### 恢复默认菜单

可点击「恢复默认菜单」按钮将所有更改重置为默认状态，然后点击「保存」应用更改。

{% assign resetToDefaultMenu = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/reset-to-default-menu-1-pe.png,
        title: You can reset all your changes to the default state by pressing the "Reset to default menu" button;
    ===
        image: /images/user-guide/white-labeling/custom-menu/reset-to-default-menu-2-pe.png,
        title: Apply changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/reset-to-default-menu-3-pe.png,
        title: The menu has been reset to the default state.
'
%}

{% include images-gallery.liquid imageCollection=resetToDefaultMenu %}

### 将菜单项恢复为默认

可点击菜单项行中的「扫帚」图标将该项恢复为默认，然后点击「保存」应用更改。

{% assign resetMenuItemBackToDefault = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/reset-menu-item-back-to-default-1-pe.png,
        title: You can reset a menu item to its default state by clicking the "broom" icon in the row of the menu item;
    ===
        image: /images/user-guide/white-labeling/custom-menu/reset-menu-item-back-to-default-2-pe.png,
        title: Apply changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/reset-menu-item-back-to-default-3-pe.png,
        title: The menu item has been reset to the default state.
'
%}

{% include images-gallery.liquid imageCollection=resetMenuItemBackToDefault %}

### 隐藏现有菜单项

若要在 ThingsBoard 用户界面中隐藏菜单项，在该菜单项行中将「隐藏/可见」开关切换为「隐藏」。

{% assign hideExistingMenuItems = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/hide-existing-menu-items-1-pe.png,
        title: To hide menu items in the ThingsBoard user interface, switch the "Hidden/Visible" toggle to "Hidden" in the row of the menu item you want to hide. For example, hide the "Plan and Billing" and "Dashboards" menu items. Then save the changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/hide-existing-menu-items-2-pe.png,
        title: As you can see, the menu items we marked as "Hidden" has disappeared from the left menu.
'
%}

{% include images-gallery.liquid imageCollection=hideExistingMenuItems %}

若要再次显示已隐藏的菜单项，将该菜单项行的「隐藏/可见」开关切换为「可见」并保存。

<br>
*隐藏所有菜单项*

若要从零开始配置菜单，可点击窗口顶部的「隐藏所有菜单项」按钮以隐藏所有菜单项。 

{% assign hideAllMenuItems = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/hide-all-menu-items-1-pe.png,
        title: You can hide all menu items by clicking the "Hide all menu items" button at the top of the window. Apply changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/hide-all-menu-items-2-pe.png,
        title: All menu items are hidden, except for "Home".
'
%}

{% include images-gallery.liquid imageCollection=hideAllMenuItems %}

{% capture difference %}
**请注意：**
唯一无法隐藏的菜单项是「首页」。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

*显示隐藏项*

默认情况下，自定义菜单配置窗口中会显示隐藏的菜单项。要隐藏它们，可将「显示隐藏项」开关设为「关闭」。

{% assign showHiddenItems = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/show-hidden-items-1-pe.png,
        title: By default, hidden menu items are displayed in the custom menu config window. To hide them, toggle the "Show hidden items" switch to "Off";
    ===
        image: /images/user-guide/white-labeling/custom-menu/show-hidden-items-2-pe.png,
        title: A hidden menu item is concealed from the custom menu configuration window.
'
%}

{% include images-gallery.liquid imageCollection=showHiddenItems %}

### 删除菜单项

删除自定义菜单项时，点击要移除的菜单项行中的「垃圾桶」图标，然后保存更改。

{% assign deleteMenuItem = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/delete-menu-item-1-pe.png,
        title: To delete the custom menu item, click the "trash" icon in the row of the menu item you want to remove. Then save the changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/delete-menu-item-2-pe.png,
        title: Your custom menu item has been deleted.
'
%}

{% include images-gallery.liquid imageCollection=deleteMenuItem %}

{% capture difference %}
**请注意：**
只能删除自定义项。默认项不可删除，只能[隐藏](#hide-existing-menu-items)。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

## 编辑自定义菜单名称

编辑自定义菜单名称时，点击该自定义菜单行中的「铅笔」图标，修改名称后点击「保存」。

{% assign editName = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-edit-name-1-pe.png,
        title: To edit the custom menu name, click the "pencil" icon in the row of this custom menu;
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-edit-name-2-pe.png,
        title: Change the name and click "Save";
    ===
        image: /images/user-guide/white-labeling/custom-menu/custom-menu-edit-name-3-pe.png,
        title: The custom menu name has been changed.
'
%}

{% include images-gallery.liquid imageCollection=editName %}

## 管理自定义菜单分配对象

管理分配到此自定义菜单的用户时，点击该用户菜单行中的对应图标，从下拉菜单中更改分配类型并保存。分配类型已更新。

{% assign manageCustomMenuAssignees = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/manage-custom-menu-assignees-1-pe.png,
        title: To manage the users assigned to this custom menu, click the corresponding icon in the row of this user menu;
    ===
        image: /images/user-guide/white-labeling/custom-menu/manage-custom-menu-assignees-2-pe.png,
        title: From the dropdown menu, change the assignee type and save changes;
    ===
        image: /images/user-guide/white-labeling/custom-menu/manage-custom-menu-assignees-3-pe.png,
        title: Assignee type changed.
'
%}

{% include images-gallery.liquid imageCollection=manageCustomMenuAssignees %}

## 删除自定义菜单

删除自定义菜单时，点击该用户菜单行中的对应图标，点击「是」确认删除。

{% assign deleteCustomMenu = '
    ===
        image: /images/user-guide/white-labeling/custom-menu/delete-custom-menu-1-pe.png,
        title: To delete custom menu, click the corresponding icon in the row of this user menu;
    ===
        image: /images/user-guide/white-labeling/custom-menu/delete-custom-menu-2-pe.png,
        title: Confirm the deletion by clicking "Yes".
'
%}

{% include images-gallery.liquid imageCollection=deleteCustomMenu %}

## 下一步

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}