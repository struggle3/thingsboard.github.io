{% assign addEdgePE = '
    ===
        image: /images/edge/user-guide/edge-install/1-instance-section-pe.webp ,
        title: 登录 **ThingsBoard Professional Edition 实例**，进入 **Edge Management > Instances**（边缘管理 > 实例）部分。点击右上角 **"+"** 图标，选择 **"Add new edge"** 选项。
    ===
        image: /images/edge/user-guide/edge-install/2-add-new-edge-pe.webp,
        title: 在 **"Name"** 字段输入Edge名称，点击 **"Add"** 按钮确认添加新Edge。
    ===
        image: /images/edge/user-guide/edge-install/3-done-pe.webp,
        title: 新Edge应出现在列表顶部，条目默认按创建时间排序。
'
%}

{% assign addEdgeCE = '
    ===
        image: /images/edge/user-guide/edge-install/1-instance-section.webp,
        title: 登录 **ThingsBoard社区版实例**，进入 **Edge Management > Instances**（边缘管理 > 实例）部分。点击右上角 **"+"** 图标，选择 **"Add new edge"** 选项。
    ===
        image: /images/edge/user-guide/edge-install/2-add-new-edge.webp,
        title: 在 **"Name"** 字段输入Edge名称，点击 **"Add"** 按钮确认添加新Edge。
    ===
        image: /images/edge/user-guide/edge-install/3-done.webp,
        title: 新Edge应出现在列表顶部，条目默认按创建时间排序。
'
%}


{% if page.docsPrefix == "pe/" or page.docsPrefix contains "pe/edge" or page.docsPrefix contains "paas/" or docsPrefix == "pe/" or docsPrefix contains "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=addEdgePE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=addEdgeCE %}
{% endif %}
