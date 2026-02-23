
{% assign changeEntityAliasCE = '
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-1-ce.png,
        title: 打开仪表板并进入编辑模式。点击「实体别名」图标，在弹窗中点击别名旁的「编辑别名」图标。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-2-ce.png,
        title: 在编辑别名窗口的下拉列表中选择您的设备并保存实体别名。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-3-ce.png,
        title: 应用所有更改。
'
%}

{% assign changeEntityAliasPE = '
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-1-pe.png,
        title: 打开仪表板并进入编辑模式。点击「实体别名」图标，在弹窗中点击别名旁的「编辑别名」图标。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-2-pe.png,
        title: 在编辑别名窗口的下拉列表中选择您的设备并保存实体别名。
    ===
        image: /images/user-guide/dashboards/alias/dashboard-edit-alias-3-pe.png,
        title: 应用所有更改。
'
%}

打开导入的仪表板，点击进入。然后需在仪表板的实体别名中指定您的设备。

请按以下步骤操作：

{% if page.docsPrefix == "pe/" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=changeEntityAliasPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=changeEntityAliasCE %}
{% endif %}

此时应能看到设备数据。